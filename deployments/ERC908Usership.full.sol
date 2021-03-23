/***

 * https://rugby.show
                                  
* MIT License
* ===========
*
* Copyright (c) 2020 rugby
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
*/
// File: @openzeppelin/contracts/GSN/Context.sol

pragma solidity ^0.5.0;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.
    constructor () internal { }
    // solhint-disable-previous-line no-empty-blocks

    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

// File: @openzeppelin/contracts/math/SafeMath.sol

pragma solidity ^0.5.0;

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     *
     * _Available since v2.4.0._
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

// File: @openzeppelin/contracts/utils/Address.sol

pragma solidity ^0.5.5;

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following 
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly { codehash := extcodehash(account) }
        return (codehash != accountHash && codehash != 0x0);
    }

    /**
     * @dev Converts an `address` into `address payable`. Note that this is
     * simply a type cast: the actual underlying value is not changed.
     *
     * _Available since v2.4.0._
     */
    function toPayable(address account) internal pure returns (address payable) {
        return address(uint160(account));
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     *
     * _Available since v2.4.0._
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-call-value
        (bool success, ) = recipient.call.value(amount)("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }
}

// File: @openzeppelin/contracts/drafts/Counters.sol

pragma solidity ^0.5.0;


/**
 * @title Counters
 * @author Matt Condon (@shrugs)
 * @dev Provides counters that can only be incremented or decremented by one. This can be used e.g. to track the number
 * of elements in a mapping, issuing ERC721 ids, or counting request ids.
 *
 * Include with `using Counters for Counters.Counter;`
 * Since it is not possible to overflow a 256 bit integer with increments of one, `increment` can skip the {SafeMath}
 * overflow check, thereby saving gas. This does assume however correct usage, in that the underlying `_value` is never
 * directly accessed.
 */
library Counters {
    using SafeMath for uint256;

    struct Counter {
        // This variable should never be directly accessed by users of the library: interactions must be restricted to
        // the library's function. As of Solidity v0.5.2, this cannot be enforced, though there is a proposal to add
        // this feature: see https://github.com/ethereum/solidity/issues/4637
        uint256 _value; // default: 0
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        // The {SafeMath} overflow check can be skipped here, see the comment at the top
        counter._value += 1;
    }

    function decrement(Counter storage counter) internal {
        counter._value = counter._value.sub(1);
    }
}

// File: @openzeppelin/contracts/introspection/IERC165.sol

pragma solidity ^0.5.0;

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

// File: @openzeppelin/contracts/introspection/ERC165.sol

pragma solidity ^0.5.0;


/**
 * @dev Implementation of the {IERC165} interface.
 *
 * Contracts may inherit from this and call {_registerInterface} to declare
 * their support of an interface.
 */
contract ERC165 is IERC165 {
    /*
     * bytes4(keccak256('supportsInterface(bytes4)')) == 0x01ffc9a7
     */
    bytes4 private constant _INTERFACE_ID_ERC165 = 0x01ffc9a7;

    /**
     * @dev Mapping of interface ids to whether or not it's supported.
     */
    mapping(bytes4 => bool) private _supportedInterfaces;

    constructor () internal {
        // Derived contracts need only register support for their own interfaces,
        // we register support for ERC165 itself here
        _registerInterface(_INTERFACE_ID_ERC165);
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     *
     * Time complexity O(1), guaranteed to always use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return _supportedInterfaces[interfaceId];
    }

    /**
     * @dev Registers the contract as an implementer of the interface defined by
     * `interfaceId`. Support of the actual ERC165 interface is automatic and
     * registering its interface id is not required.
     *
     * See {IERC165-supportsInterface}.
     *
     * Requirements:
     *
     * - `interfaceId` cannot be the ERC165 invalid interface (`0xffffffff`).
     */
    function _registerInterface(bytes4 interfaceId) internal {
        require(interfaceId != 0xffffffff, "ERC165: invalid interface id");
        _supportedInterfaces[interfaceId] = true;
    }
}

// File: contracts/interface/IERC908Usership.sol

pragma solidity ^0.5.0;



pragma experimental ABIEncoderV2;



contract IERC908Usership is IERC165 {

    struct UsershipInfo
    {
        address user;
        uint256 start;
        uint256 period;
    }

    event UsershipIssue(uint256 indexed tokenId,address indexed from,uint256  start, uint256  period);
    event UsershipReturn(uint256 indexed tokenId,address indexed from,uint256  start, uint256  period);
    event UsershipReclaim(uint256 indexed tokenId,address indexed from,uint256  start, uint256  period);

    event UsershipTransfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event UsershipApproval(address indexed from, address indexed approved, uint256 indexed tokenId);
    event UsershipApprovalForAll(address indexed from, address indexed operator, bool approved);

    //
    function balanceOfUsership(address user) public view returns (uint256 balance);

    function getUsershipInfo(uint256 tokenId) public view returns (UsershipInfo memory) ;

    function usershipOf(uint256 tokenId) public view returns (address) ;

    // function usershipIssue(uint256 tokenId, address to, uint256 period) public ;

    // function usershipReturn(uint256 tokenId) public;

    // function usershipReclaim(uint256 tokenId,bytes memory data) public;

    //
    function usershipApprove(address to, uint256 tokenId) public ;

    function getUsershipApproved(uint256 tokenId) public view returns (address) ;

    function setUsershipApprovalForAll(address to, bool approved) public ;

    function isUsershipApprovedForAll(address user, address operator) public view returns (bool) ;

    //
    function usershipTransfer(address from, address to, uint256 tokenId) public ;

    function usershipSafeTransfer(address from, address to, uint256 tokenId) public ;

    function usershipSafeTransfer(address from, address to, uint256 tokenId, bytes memory data) public ;
}


// contract Selector {
//     function calculateSelector() public pure returns (bytes4,bytes4,bytes4,bytes4,bytes4,bytes4,bytes4,bytes4,bytes4,bytes4) {
//         IERC908Usership i;
//         return 
//         (
//         i.balanceOfUsership.selector , 
//         i.getUsershipInfo.selector , 
//         i.usershipOf.selector ,
//         i.usershipApprove.selector,
//         i.getUsershipApproved.selector , 
//         i.setUsershipApprovalForAll.selector , 
//         i.isUsershipApprovedForAll.selector ,
//         i.usershipTransfer.selector,
//         bytes4(keccak256('usershipSafeTransfer(address,addres,uint256)')),
//         bytes4(keccak256('usershipSafeTransfer(address,addres,uint256,bytes)'))
//         );
//     }
//         function calculateAllSelector() public pure returns (bytes4) {
//         IERC908Usership i;
//         return 
//         (
//         i.balanceOfUsership.selector^
//         i.getUsershipInfo.selector^
//         i.usershipOf.selector^
//         i.usershipApprove.selector^
//         i.getUsershipApproved.selector^
//         i.setUsershipApprovalForAll.selector^
//         i.isUsershipApprovedForAll.selector^
//         i.usershipTransfer.selector^
//         bytes4(keccak256('usershipSafeTransfer(address,addres,uint256)'))^
//         bytes4(keccak256('usershipSafeTransfer(address,addres,uint256,bytes)'))
//         );
//     }
// }

// File: contracts/interface/IERC908Receiver.sol

pragma solidity ^0.5.0;

/**
 * @title ERC908 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC908 asset contracts.
 */
contract IERC908Receiver {
    /**
     * @notice Handle the receipt of an NFT
     * @dev The ERC908 smart contract calls this function on the recipient
     * after a {IERC908-safeLeaseTransfer or safeTransferFrom }. This function MUST return the function selector,
     * otherwise the caller will revert the transaction. The selector to be
     * returned can be obtained as `this.onERC908Received.selector`. This
     * function MAY throw to revert and reject the transfer.
     * Note: the ERC908 contract address is always the message sender.
     * @param operator The address which called `safeLeaseTransfer or safeTransferFrom` function
     * @param from The address which previously owned the token
     * @param tokenId The NFT identifier which is being transferred
     * @param data Additional data with no specified format
     * @return bytes4 `bytes4(keccak256("onERC908Received(address,address,uint256,bytes)"))`
     */
    function onERC908Received(address operator, address from, uint256 tokenId, bytes memory data)
    public returns (bytes4);

    /**
     * @notice Handle the receipt of an NFT
     * @dev The ERC908 smart contract calls this function on the recipient
     * after a {IERC908-usershipReclaim}. This function MUST return the function selector,
     * otherwise the caller will revert the transaction. The selector to be
     * returned can be obtained as `this.onERC908LeaseEnd.selector`. This
     * function MAY throw to revert and reject the transfer.
     * Note: the ERC908 contract address is always the message sender.
     * @param operator The address which called `usershipReclaim` function
     * @param from The address which previously owned the token
     * @param tokenId The NFT identifier which is being transferred
     * @param data Additional data with no specified format
     * @return bytes4 `bytes4(keccak256("onERC908LeaseEnd(address,address,uint256,bytes)"))`
     */
    function onERC908UsershipReclaim(address operator, address from, uint256 tokenId, bytes memory data)
    public returns (bytes4);

}



// contract Selector {
//     function calculateSelector() public pure returns (bytes4,bytes4,bytes4) {
//         IERC908Receiver i;
//         return 
//         (
//         i.onERC908Received.selector , 
//         i.onERC908UsershipReclaim.selector , 
//         i.onERC908Received.selector^
//         i.onERC908UsershipReclaim.selector
//         );
//     }
// }

// //0x4e8dce34^0x200c873e==0x6e81490a

// File: contracts/ERC908Usership.sol

pragma solidity ^0.5.5;








//import "@openzeppelin/contracts/token/ERC721/ERC721.sol";



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
