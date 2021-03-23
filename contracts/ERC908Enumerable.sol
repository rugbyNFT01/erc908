pragma solidity ^0.5.0;

import "@openzeppelin/contracts/introspection/ERC165.sol";
import "./ERC908Usership.sol";
import "./interface/IERC908Enumerable.sol";


contract ERC908Enumerable is Context, ERC165, ERC908Usership, IERC908Enumerable{

    // Mapping from usership to list of owned token IDs
    mapping(address => uint256[] ) public _usershipTokens;
    // Mapping from token ID to index of the usership tokens list
    mapping(uint256 => uint256) public _usershipTokensIndex;

    /*
     * => 0xb060f823 ^ 0x518d1c3b  == 0xe1ede418
     */
    bytes4 private constant _INTERFACE_ID_ERC908_ENUMERABLE = 0xe1ede418;

    /**
     * @dev Constructor function.
     */
    constructor () public {
        // register the supported interface to conform to ERC908Enumerable via ERC165
        _registerInterface(_INTERFACE_ID_ERC908_ENUMERABLE);
    }

    /**
     * @dev Gets the token ID at a given index of the tokens list of the requested owner.
     * @param user address owning the tokens list to be accessed
     * @param index uint256 representing the index to be accessed of the requested tokens list
     * @return uint256 token ID at the given index of the tokens list owned by the requested address
     */
    function tokenOfUsershipByIndex(address user, uint256 index) public view returns (uint256) {
        require(index < balanceOfUsership(user), "ERC908Enumerable: owner index out of bounds");
        return _usershipTokens[user][index];
    }

    /**
     * @dev Internal function to transfer ownership of a given token ID to another address.
     * As opposed to transferFrom, this imposes no restrictions on msg.sender.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _usershipTransfer(address from, address to, uint256 tokenId) internal {
        super._usershipTransfer(from, to, tokenId);
    }

    /**
     * @dev Gets the list of token IDs of the requested user.
     * @param user address owning the tokens
     * @return uint256[] List of token IDs owned by the requested address
     */
    function tokenOfUsership(address user) public view returns (uint256[] memory) {
        return _usershipTokens[user];
    }

    /**
     * @dev Private function to add a token to this extension's ownership-tracking data structures.
     * @param to address representing the new user of the given token ID
     * @param tokenId uint256 ID of the token to be added to the tokens list of the given address
     */
    function _addTokenToUsershipEnumeration(address to, uint256 tokenId) internal {
        _usershipTokensIndex[tokenId] = _usershipTokens[to].length;
        _usershipTokens[to].push(tokenId);
    }

    /**
     * @dev Private function to remove a token from this extension's ownership-tracking data structures. Note that
     * while the token is not assigned a new usership, the `_ownedTokensIndex` mapping is _not_ updated: this allows for
     * gas optimizations e.g. when performing a transfer operation (avoiding double writes).
     * This has O(1) time complexity, but alters the order of the _ownedTokens array.
     * @param from address representing the previous usership of the given token ID
     * @param tokenId uint256 ID of the token to be removed from the tokens list of the given address
     */
    function _removeTokenFromUsershipEnumeration(address from, uint256 tokenId) internal {
        // To prevent a gap in from's tokens array, we store the last token in the index of the token to delete, and
        // then delete the last slot (swap and pop).

        uint256 lastTokenIndex = _usershipTokens[from].length.sub(1);
        uint256 tokenIndex = _usershipTokensIndex[tokenId];

        // When the token to delete is the last token, the swap operation is unnecessary
        if (tokenIndex != lastTokenIndex) {
            uint256 lastTokenId = _usershipTokens[from][lastTokenIndex];

            _usershipTokens[from][tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
            _usershipTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index
        }

        // This also deletes the contents at the last position of the array
        _usershipTokens[from].length--;

        // Note that _ownedTokensIndex[tokenId] hasn't been cleared: it still points to the old slot (now occupied by
        // lastTokenId, or just over the end of the array if the token was the last one).
    }

}
