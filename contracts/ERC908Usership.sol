pragma solidity ^0.5.5;

import "@openzeppelin/contracts/GSN/Context.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/drafts/Counters.sol";
import "@openzeppelin/contracts/introspection/ERC165.sol";



//import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./interface/IERC908Usership.sol";
import "./interface/IERC908Receiver.sol";

contract ERC908Usership is Context, ERC165, IERC908Usership {

    using SafeMath for uint256;
    using Address for address;
    using Counters for Counters.Counter;

    // Equals to `bytes4(keccak256("onERC908Received(address,address,uint256,bytes)"))`
    bytes4 private constant _ERC908_RECEIVED = 0x4e8dce34;
    // Equals to `bytes4(keccak256("onERC908UsershipReclaim(address,address,uint256,bytes)"))`
    bytes4 private constant _ERC908_RECLAIMED = 0x200c873e;

    //for usership
    mapping(uint256 => UsershipInfo ) internal _usershipInfo;

    // Mapping from owner to number of owned token
    mapping (address => Counters.Counter) private _usershipTokensCount;

    // Mapping from token ID to usership approved address
    mapping (uint256 => address) private _usershipTokenApprovals;

    // Mapping from usership to operator approvals
    mapping (address => mapping (address => bool)) private _usershipOperatorApprovals;


    /*
     *     => 0xde01ba66^0x8e006e05^0x3e5aedb2^0xb2c818d0^0xa3dc3cd9^0xf6fc46c2^0x70f7988a^0xcc6be08d^0x3c060c58^0xefe2fda4
           == 0xe6cbd2e1
     */


    bytes4 private constant _INTERFACE_ID_ERC908 = 0xe6cbd2e1;

    constructor () public {
        // register the supported interfaces to conform to ERC908 via ERC165
        _registerInterface(_INTERFACE_ID_ERC908);
    }

    /**
     * @dev Gets the balance of the specified address.
     * @param user address to query the balance of
     * @return uint256 representing the amount usership by the passed address
     */
    function balanceOfUsership(address user) public view returns (uint256) {
        require(user != address(0), "ERC908: balance query for the zero address");
        return _usershipTokensCount[user].current();
    }

    /**
     * @dev Gets the usership of the specified token ID.
     * @param tokenId uint256 ID of the token to query the usership of
     * @return address currently marked as the usership of the given token ID
     */
    function usershipOf(uint256 tokenId) public view returns (address) {
        return _usershipInfo[tokenId].user;
    }
    
    /**
     * @dev Gets the usership info of the specified token ID.
     * @param tokenId uint256 ID of the token to query the usership of
     * @return address currently marked as the usership of the given token ID
     */
    function getUsershipInfo(uint256 tokenId) public view returns (UsershipInfo memory) {
        return _usershipInfo[tokenId];
    }

    /**
     * @dev Approves another address to transfer the given token ID
     * The zero address indicates there is no approved address.
     * There can only be one approved address per token at a given time.
     * Can only be called by the token usership or an approved operator.
     * @param to address to be approved for the given token ID
     * @param tokenId uint256 ID of the token to be approved
     */
    function usershipApprove(address to, uint256 tokenId) public {
        address user = usershipOf(tokenId);
        require(to != user, "ERC908: usershipApprove to current user");

        require(msg.sender == user || isUsershipApprovedForAll(user, msg.sender),
            "ERC908: usershipApprove caller is not usership nor approved for all"
        );

        _usershipTokenApprovals[tokenId] = to;
        emit UsershipApproval(user, to, tokenId);
    }

    /**
     * @dev Gets the approved address for a token ID, or zero if no address set
     * Reverts if the token ID does not exist.
     * @param tokenId uint256 ID of the token to query the approval of
     * @return address currently approved for the given token ID
     */
    function getUsershipApproved(uint256 tokenId) public view returns (address) {
        require(_isHasUsership(tokenId), "ERC908: approved query for nonexistent token");
        return _usershipTokenApprovals[tokenId];
    }

    /**
     * @dev Sets or unsets the approval of a given operator
     * An operator is allowed to usershiptransfer all tokens of the sender on their behalf.
     * @param to operator address to set the approval
     * @param approved representing the status of the approval to be set
     */
    function setUsershipApprovalForAll(address to, bool approved) public {
        require(to != msg.sender, "ERC908: approve to caller");

        _usershipOperatorApprovals[msg.sender][to] = approved;
        emit UsershipApprovalForAll(msg.sender, to, approved);
    }

    /**
     * @dev Tells whether an operator is approved by a given usership.
     * @param user usership address which you want to query the approval of
     * @param operator operator address which you want to query the approval of
     * @return bool whether the given operator is approved by the given usership
     */
    function isUsershipApprovedForAll(address user, address operator) public view returns (bool) {
        return _usershipOperatorApprovals[user][operator];
    }

    /**
     * @dev Transfers the ownership of a given token ID to another address.
     * Usage of this method is discouraged, use {usershipTransfer} whenever possible.
     * Requires the msg.sender to be the owner, approved, or operator.
     * @param from current owner or usership of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred by owner or usership
     */

    function usershipTransfer(address from, address to, uint256 tokenId) public {
        require(_isApprovedOrUsership(msg.sender, tokenId),"ERC908: transfer caller is not owner nor approved");
        _usershipTransfer(from, to, tokenId);
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement {IERC908Receiver-onERC908Received},
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC908Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg.sender to be the owner, usership, approved, or operator
     * @param from current owner or usership of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function usershipSafeTransfer(address from, address to, uint256 tokenId) public {
        usershipSafeTransfer(from, to, tokenId, "");
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement {IERC908Receiver-onERC908Received},
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC908Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
      * Requires the msg.sender to be the owner, usership, approved, or operator
     * @param from current owner or usership of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     * @param data bytes data to send along with a safe transfer check
     */
    function usershipSafeTransfer(address from, address to, uint256 tokenId, bytes memory data) public {
        usershipTransfer(from,to,tokenId);
        require(_checkOnERC908Received(from, to, tokenId, data), "ERC908: transfer to non ERC908Receiver implementer");
    }

    /**
     * @dev Returns whether the specified token has usership
     * @param tokenId uint256 ID of the token to query the usership of
     * @return bool whether the token has usership
     */
    function _isHasUsership(uint256 tokenId) internal view returns (bool) {
        address user = _usershipInfo[tokenId].user;
        return user != address(0);
    }

    /**
     * @dev Returns whether the given spender can transfer a given token ID.
     * @param spender address of the spender to query
     * @param tokenId uint256 ID of the token to be transferred
     * @return bool whether the msg.sender is approved for the given token ID,
     * is an operator of the usership, or is the usership of the token
     */
    function _isApprovedOrUsership(address spender, uint256 tokenId) internal view returns (bool) {
        //require(_isHasUsership(tokenId), "ERC908: operator query for nonexistent token");
        if(_isHasUsership(tokenId)==false){
            return false;
        }
        address user = usershipOf(tokenId);
        return (spender == user || getUsershipApproved(tokenId) == spender || isUsershipApprovedForAll(user, spender));
    }


    /**
     * @dev public function to issue usership to a new token.
     * Reverts if the given token ID already exists.
     * @param to The address that will recevie the usership
     * @param tokenId uint256 ID of the token to issue usership
     */
    function _usershipIssue(uint256 tokenId, address to, uint256 period) internal {
        require(to != address(0), "ERC908: mint to the zero address");
        require(!_isHasUsership(tokenId), "ERC908: token has usership");

        _usershipInfo[tokenId].user = to;
        _usershipInfo[tokenId].period = period;
        _usershipInfo[tokenId].start = now;

        _usershipTokensCount[to].increment();

        emit UsershipIssue(tokenId, to, _usershipInfo[tokenId].start,_usershipInfo[tokenId].period );
    }

    /**
     * @dev public function to _terminate a specific token.
     * Reverts if the token does not exist.
     * Deprecated, use {_terminate} instead.
     * @param user user of the token to return
     * @param tokenId uint256 ID of the token being return
     */
    function _usershipReturn(address user, uint256 tokenId) internal {

        require(usershipOf(tokenId) == user, "ERC908: token has not usership");

        //uint256  left = now.sub(_usershipInfo[tokenId].start);
        //require(left>_usershipInfo[tokenId].period , "ERC908: The usership period has not yet arrived ");

        _clearUsershipApproval(tokenId);

        emit UsershipReturn(tokenId, user,  _usershipInfo[tokenId].start,  _usershipInfo[tokenId].period );

        _usershipTokensCount[user].decrement();

        _usershipInfo[tokenId].user = address(0);
        _usershipInfo[tokenId].start = 0;
        _usershipInfo[tokenId].period = 0;
    }



     function _usershipReclaim(uint256 tokenId,bytes memory data) internal
     {
        if(data.length !=0 ){
            require(_checkOnERC908UsershipReclaim(tokenId, data), "ERC908: usership end to non ERC908Receiver implementer");
        }

        _clearUsershipApproval(tokenId);
        address user = _usershipInfo[tokenId].user;
        emit UsershipReclaim(tokenId, user,  _usershipInfo[tokenId].start,  _usershipInfo[tokenId].period );

        _usershipTokensCount[user].decrement();

        _usershipInfo[tokenId].user = address(0);
        _usershipInfo[tokenId].start = 0;
        _usershipInfo[tokenId].period = 0;
     }


    /**
     * @dev internal function to initialize usership info of a given token ID. 
     * @param tokenId uint256 ID of the token to be initialize
     */
    function _usershipInitialize(uint256 tokenId) internal {

        _usershipInfo[tokenId].user =address(0);
        _usershipInfo[tokenId].start =0;
        _usershipInfo[tokenId].period =0;
    }

    /**
     * @dev Internal function to transfer ownership of a given token ID to another address.
     * As opposed to {transferFrom}, this imposes no restrictions on msg.sender.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred by usership
     */
    function _usershipTransfer(address from, address to, uint256 tokenId) internal {

        require(usershipOf(tokenId) == from, "ERC908: transfer of token that is not own");
        require(to != address(0), "ERC908: transfer to the zero address");

        _clearUsershipApproval(tokenId);

        _usershipTokensCount[from].decrement();
        _usershipTokensCount[to].increment();
        _usershipInfo[tokenId].user = to;

        emit UsershipTransfer(from, to, tokenId);
    }


    /**
     * @dev Private function to clear current approval of a given token ID.
     * @param tokenId uint256 ID of the token to be transferred by usership
     */
    function _clearUsershipApproval(uint256 tokenId) private {
        if (_usershipTokenApprovals[tokenId] != address(0)) {
            _usershipTokenApprovals[tokenId] = address(0);
        }
    }

    /**
     * @dev Internal function to invoke {IERC908Receiver-onERC908Received} on a target address.
     * The call is not executed if the target address is not a contract.
     *
     * This is an internal detail of the `ERC908` contract and its use is deprecated.
     * @param from address representing the previous owner of the given token ID
     * @param to target address that will receive the tokens
     * @param tokenId uint256 ID of the token to be transferred
     * @param data bytes optional data to send along with the call
     * @return bool whether the call correctly returned the expected magic value
     */
    function _checkOnERC908Received(address from, address to, uint256 tokenId, bytes memory data)
        internal returns (bool)
    {
        if (!to.isContract()) {
            return true;
        }
        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = to.call(abi.encodeWithSelector(
            IERC908Receiver(to).onERC908Received.selector,
            _msgSender(),
            from,
            tokenId,
            data
        ));
        if (!success) {
            if (returndata.length > 0) {
                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert("ERC908: transfer to non ERC908Receiver implementer");
            }
        } else {
            bytes4 retval = abi.decode(returndata, (bytes4));
            return (retval == _ERC908_RECEIVED);
        }
    }


    /**
     * @dev Internal function to invoke {IERC908Receiver-onERC908Received} on a target address.
     * The call is not executed if the target address is not a contract.
     *
     * This is an internal detail of the `ERC908` contract and its use is deprecated.
     * @param tokenId uint256 ID of the token to be transferred
     * @param data bytes optional data to send along with the call
     * @return bool whether the call correctly returned the expected magic value
     */
    function _checkOnERC908UsershipReclaim(uint256 tokenId, bytes memory data)
        internal returns (bool)
    {
        address user = _usershipInfo[tokenId].user;
        if (!user.isContract()) {
            return true;
        }

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = user.call(abi.encodeWithSelector(
            IERC908Receiver(user).onERC908UsershipReclaim.selector,
            _msgSender(),
            user,
            tokenId,
            data
        ));
        if (!success) {
            if (returndata.length > 0) {
                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert("ERC908: lease end to non ERC908Receiver implementer");
            }
        } else {
            bytes4 retval = abi.decode(returndata, (bytes4));
            return (retval == _ERC908_RECLAIMED);
        }
    }

}
