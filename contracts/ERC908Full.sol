pragma solidity ^0.5.0;

import "./ERC908.sol";
import "./ERC908Combinable.sol";
import "./ERC908Enumerable.sol";
import "./ERC908Metadata.sol";

import "./interface/IERC908Full.sol";

contract ERC908Full is ERC908,ERC908Combinable, ERC908Enumerable,ERC908Metadata,IERC908Full{

    /*
    *=> 0x40c10f19^0x42966c68^0x32eb29be^0x563b2675^0x3d45e8df^0x36c6aeb4^0x487facb6==0x257b8667
    */
    //bytes4 private constant _INTERFACE_ID_ERC908_FULL= 0x257b8667;
    constructor (string memory name, string memory symbol) public ERC908Metadata(name, symbol) {
        //_registerInterface(_INTERFACE_ID_ERC908_FULL);
    }

    //
    function isOwnerLock(uint256 tokenId) view public returns (bool)   {
        require( _isApprovedOrOwner(msg.sender,tokenId),"isApprovedOrOwner false!");
        require(usershipOf(tokenId)==address(0x0),"token has a usership!");
        require(_parrent[tokenId]==0,"token has a parrent!");

        return true;
    }

   //
    function isChildLock(uint256 tokenId) view public returns (bool)   {
        require( _isApprovedOrOwner(msg.sender,tokenId),"isApprovedOrOwner false!");
        require(usershipOf(tokenId)==address(0x0),"token has a usership!");
        return true;
    }


    function usershipReclaim(uint256 tokenId,bytes memory data) 
        public 
        
    {
        require( _isApprovedOrOwner(msg.sender,tokenId),"invalid usership onwer!" );

        _removeTokenFromUsershipEnumeration(usershipOf(tokenId),tokenId);

        super._usershipReclaim(tokenId,data);

    }

    function usershipIssue(uint256 tokenId, address to, uint256 period) 
        public 
        
    {
        isOwnerLock(tokenId);

        super._usershipIssue(tokenId, to, period);

        _addTokenToUsershipEnumeration(to,tokenId);

    }

    function usershipReturn(uint256 tokenId) 
        public
    {
        require( _isApprovedOrUsership(msg.sender,tokenId),"invalid usership!" );

        _removeTokenFromUsershipEnumeration(usershipOf(tokenId),tokenId);

        super._usershipReturn(msg.sender,tokenId);

    }

    function compound(uint256 tokenId, uint256[] memory ids) 
        public
    {
        isOwnerLock(tokenId);

        for(uint256 i=0; i<ids.length; i++ ){
            isOwnerLock(ids[i]);
        }

        super.compound(tokenId, ids);
    }

    function decompose(uint256 tokenId) 
        public
    {
        isChildLock(tokenId);
        super.decompose(tokenId);
    }

    function mint(address to, uint256 tokenId) public returns (bool) {

        _mint(to, tokenId);

        _setTokenURI(tokenId, _uintToString(tokenId));

        _usershipInitialize(tokenId);

        return true;
    }

    function burn(uint256 tokenId) 
        public 
    {
        isOwnerLock(tokenId);
        _burn(tokenId);
    }

    function compoundMint(address to,uint256 tokenId, uint256[] memory ids) 
        public
    {
        mint(to, tokenId);
        compound(tokenId,ids);
        emit CompoundMint(to,tokenId,ownerOf(tokenId),ids);
    }

    function decomposeBurn(uint256 tokenId) 
        public
    {
        isOwnerLock(tokenId);
        super.decompose(tokenId);
        _burn(tokenId);
        emit DecomposeBurn(tokenId,ownerOf(tokenId),_children[tokenId]);
    }

    function _uintToString(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len - 1;
        while (_i != 0) {
            bstr[k--] = byte(uint8(48 + _i % 10));
            _i /= 10;
        }
        return string(bstr);
    }

    function transferFrom(address from, address to, uint256 tokenId) public {
        
        uint256[] memory children= getChildren(tokenId);
        for(uint256 i=0; i<children.length; i++ )
        {
            if(_isApprovedOrUsership(msg.sender, children[i])){
                _usershipTransfer(from, to, children[i]);
            }
            else{
                isChildLock(children[i]);
                _transferFrom(from, to, children[i]);
            }
        }
        if(_isApprovedOrUsership(msg.sender, tokenId)){
            _usershipTransfer(from, to, tokenId);
        }
        else{
            isOwnerLock(tokenId);
            _transferFrom(from, to, tokenId);
        }
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public {
        uint256[] memory children= getChildren(tokenId);
        for(uint256 i=0; i<children.length; i++ )
        {
            if(_isApprovedOrUsership(msg.sender, children[i])){
                usershipSafeTransfer(from, to, children[i]);
            }
            else{
                isChildLock(children[i]);
                _safeTransferFrom(from, to, children[i],"");
            }
        }

        if(_isApprovedOrUsership(msg.sender, tokenId)){
            usershipSafeTransfer(from, to, tokenId);
        }
        else{
            isOwnerLock(tokenId);
            _safeTransferFrom(from, to, tokenId,"");
        }
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public {
        uint256[] memory children= getChildren(tokenId);
        for(uint256 i=0; i<children.length; i++ )
        {
            if(_isApprovedOrUsership(msg.sender, children[i])){
                usershipSafeTransfer(from, to, children[i], data);
            }
            else{
                isChildLock(children[i]);
                _safeTransferFrom(from, to, children[i], data);
            }
        }

        if(_isApprovedOrUsership(msg.sender, tokenId)){
            usershipSafeTransfer(from, to, tokenId, data);
        }
        else{
            isOwnerLock(tokenId);
            _safeTransferFrom(from, to, tokenId, data);
        }
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
     * @param data Additional data with no specified format, MUST be sent unaltered in call to the `ERC1155TokenReceiver` hook(s) on `_to`
    */
    function safeBatchTransferFrom(address from, address to, uint256[] memory ids, bytes memory data ) public
    {
        for (uint256 k = 0; k < ids.length; k++) {
            uint256[] memory children= getChildren(ids[k]);
            for(uint256 i=0; i<children.length; i++ )
            {
                safeTransferFrom(from, to, children[i],data);
            }
            safeTransferFrom(from, to, ids[k], data);
        }
        emit TransferBatch(from, to, ids);
    }


}
