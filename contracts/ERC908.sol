pragma solidity ^0.5.0;


import "@openzeppelin/contracts/token/ERC721/ERC721Enumerable.sol";
import "./interface/IERC908.sol";



contract ERC908 is ERC721Enumerable,IERC908{

     
    bytes4 private constant _INTERFACE_ID_ERC908 = 0x28cfbd46;

    constructor () public {
        // register the supported interfaces to conform to ERC908 via ERC165
        _registerInterface(_INTERFACE_ID_ERC908);
    }

    /**
     * @dev Safely batch transfers the ownership of a given token IDs to another address
     * If the target address is a contract, it must implement {IERC721Receiver-onERC721Received},
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg.sender to be the owner, user, approved, or operator
     * @param from current owner or user of the token
     * @param to address to receive the ownership of the given token ID
     * @param ids uint256 ID array of the tokens to be transferred
     * @param data    Additional data with no specified format, MUST be sent unaltered in call to the `ERC1155TokenReceiver` hook(s) on `_to`
    */
    function safeBatchTransferFrom(address from, address to, uint256[] memory ids, bytes memory data ) public
    {
        for (uint256 i = 0; i < ids.length; ++i) {
            safeTransferFrom(from, to,ids[i],data);
        }
        emit TransferBatch(from, to, ids);
    }


}
