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

// File: @openzeppelin/contracts/token/ERC721/IERC721.sol

pragma solidity ^0.5.0;


/**
 * @dev Required interface of an ERC721 compliant contract.
 */
contract IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of NFTs in `owner`'s account.
     */
    function balanceOf(address owner) public view returns (uint256 balance);

    /**
     * @dev Returns the owner of the NFT specified by `tokenId`.
     */
    function ownerOf(uint256 tokenId) public view returns (address owner);

    /**
     * @dev Transfers a specific NFT (`tokenId`) from one account (`from`) to
     * another (`to`).
     *
     *
     *
     * Requirements:
     * - `from`, `to` cannot be zero.
     * - `tokenId` must be owned by `from`.
     * - If the caller is not `from`, it must be have been allowed to move this
     * NFT by either {approve} or {setApprovalForAll}.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) public;
    /**
     * @dev Transfers a specific NFT (`tokenId`) from one account (`from`) to
     * another (`to`).
     *
     * Requirements:
     * - If the caller is not `from`, it must be approved to move this NFT by
     * either {approve} or {setApprovalForAll}.
     */
    function transferFrom(address from, address to, uint256 tokenId) public;
    function approve(address to, uint256 tokenId) public;
    function getApproved(uint256 tokenId) public view returns (address operator);

    function setApprovalForAll(address operator, bool _approved) public;
    function isApprovedForAll(address owner, address operator) public view returns (bool);


    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public;
}

// File: @openzeppelin/contracts/token/ERC721/IERC721Enumerable.sol

pragma solidity ^0.5.0;


/**
 * @title ERC-721 Non-Fungible Token Standard, optional enumeration extension
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
contract IERC721Enumerable is IERC721 {
    function totalSupply() public view returns (uint256);
    function tokenOfOwnerByIndex(address owner, uint256 index) public view returns (uint256 tokenId);

    function tokenByIndex(uint256 index) public view returns (uint256);
}

// File: @openzeppelin/contracts/token/ERC721/IERC721Receiver.sol

pragma solidity ^0.5.0;

/**
 * @title ERC721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC721 asset contracts.
 */
contract IERC721Receiver {
    /**
     * @notice Handle the receipt of an NFT
     * @dev The ERC721 smart contract calls this function on the recipient
     * after a {IERC721-safeTransferFrom}. This function MUST return the function selector,
     * otherwise the caller will revert the transaction. The selector to be
     * returned can be obtained as `this.onERC721Received.selector`. This
     * function MAY throw to revert and reject the transfer.
     * Note: the ERC721 contract address is always the message sender.
     * @param operator The address which called `safeTransferFrom` function
     * @param from The address which previously owned the token
     * @param tokenId The NFT identifier which is being transferred
     * @param data Additional data with no specified format
     * @return bytes4 `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
     */
    function onERC721Received(address operator, address from, uint256 tokenId, bytes memory data)
    public returns (bytes4);
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

// File: @openzeppelin/contracts/token/ERC721/ERC721.sol

pragma solidity ^0.5.0;








/**
 * @title ERC721 Non-Fungible Token Standard basic implementation
 * @dev see https://eips.ethereum.org/EIPS/eip-721
 */
contract ERC721 is Context, ERC165, IERC721 {
    using SafeMath for uint256;
    using Address for address;
    using Counters for Counters.Counter;

    // Equals to `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
    // which can be also obtained as `IERC721Receiver(0).onERC721Received.selector`
    bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;

    // Mapping from token ID to owner
    mapping (uint256 => address) private _tokenOwner;

    // Mapping from token ID to approved address
    mapping (uint256 => address) private _tokenApprovals;

    // Mapping from owner to number of owned token
    mapping (address => Counters.Counter) private _ownedTokensCount;

    // Mapping from owner to operator approvals
    mapping (address => mapping (address => bool)) private _operatorApprovals;

    /*
     *     bytes4(keccak256('balanceOf(address)')) == 0x70a08231
     *     bytes4(keccak256('ownerOf(uint256)')) == 0x6352211e
     *     bytes4(keccak256('approve(address,uint256)')) == 0x095ea7b3
     *     bytes4(keccak256('getApproved(uint256)')) == 0x081812fc
     *     bytes4(keccak256('setApprovalForAll(address,bool)')) == 0xa22cb465
     *     bytes4(keccak256('isApprovedForAll(address,address)')) == 0xe985e9c5
     *     bytes4(keccak256('transferFrom(address,address,uint256)')) == 0x23b872dd
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256)')) == 0x42842e0e
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256,bytes)')) == 0xb88d4fde
     *
     *     => 0x70a08231 ^ 0x6352211e ^ 0x095ea7b3 ^ 0x081812fc ^
     *        0xa22cb465 ^ 0xe985e9c ^ 0x23b872dd ^ 0x42842e0e ^ 0xb88d4fde == 0x80ac58cd
     */
    bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;

    constructor () public {
        // register the supported interfaces to conform to ERC721 via ERC165
        _registerInterface(_INTERFACE_ID_ERC721);
    }

    /**
     * @dev Gets the balance of the specified address.
     * @param owner address to query the balance of
     * @return uint256 representing the amount owned by the passed address
     */
    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "ERC721: balance query for the zero address");

        return _ownedTokensCount[owner].current();
    }

    /**
     * @dev Gets the owner of the specified token ID.
     * @param tokenId uint256 ID of the token to query the owner of
     * @return address currently marked as the owner of the given token ID
     */
    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _tokenOwner[tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");

        return owner;
    }

    /**
     * @dev Approves another address to transfer the given token ID
     * The zero address indicates there is no approved address.
     * There can only be one approved address per token at a given time.
     * Can only be called by the token owner or an approved operator.
     * @param to address to be approved for the given token ID
     * @param tokenId uint256 ID of the token to be approved
     */
    function approve(address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(to != owner, "ERC721: approval to current owner");

        require(_msgSender() == owner || isApprovedForAll(owner, _msgSender()),
            "ERC721: approve caller is not owner nor approved for all"
        );

        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    /**
     * @dev Gets the approved address for a token ID, or zero if no address set
     * Reverts if the token ID does not exist.
     * @param tokenId uint256 ID of the token to query the approval of
     * @return address currently approved for the given token ID
     */
    function getApproved(uint256 tokenId) public view returns (address) {
        require(_exists(tokenId), "ERC721: approved query for nonexistent token");

        return _tokenApprovals[tokenId];
    }

    /**
     * @dev Sets or unsets the approval of a given operator
     * An operator is allowed to transfer all tokens of the sender on their behalf.
     * @param to operator address to set the approval
     * @param approved representing the status of the approval to be set
     */
    function setApprovalForAll(address to, bool approved) public {
        require(to != _msgSender(), "ERC721: approve to caller");

        _operatorApprovals[_msgSender()][to] = approved;
        emit ApprovalForAll(_msgSender(), to, approved);
    }

    /**
     * @dev Tells whether an operator is approved by a given owner.
     * @param owner owner address which you want to query the approval of
     * @param operator operator address which you want to query the approval of
     * @return bool whether the given operator is approved by the given owner
     */
    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    /**
     * @dev Transfers the ownership of a given token ID to another address.
     * Usage of this method is discouraged, use {safeTransferFrom} whenever possible.
     * Requires the msg.sender to be the owner, approved, or operator.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function transferFrom(address from, address to, uint256 tokenId) public {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");

        _transferFrom(from, to, tokenId);
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement {IERC721Receiver-onERC721Received},
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg.sender to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) public {
        safeTransferFrom(from, to, tokenId, "");
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement {IERC721Receiver-onERC721Received},
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the _msgSender() to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes data to send along with a safe transfer check
     */
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");
        _safeTransferFrom(from, to, tokenId, _data);
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement `onERC721Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg.sender to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes data to send along with a safe transfer check
     */
    function _safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) internal {
        _transferFrom(from, to, tokenId);
        require(_checkOnERC721Received(from, to, tokenId, _data), "ERC721: transfer to non ERC721Receiver implementer");
    }

    /**
     * @dev Returns whether the specified token exists.
     * @param tokenId uint256 ID of the token to query the existence of
     * @return bool whether the token exists
     */
    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    /**
     * @dev Returns whether the given spender can transfer a given token ID.
     * @param spender address of the spender to query
     * @param tokenId uint256 ID of the token to be transferred
     * @return bool whether the msg.sender is approved for the given token ID,
     * is an operator of the owner, or is the owner of the token
     */
    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
        require(_exists(tokenId), "ERC721: operator query for nonexistent token");
        address owner = ownerOf(tokenId);
        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }

    /**
     * @dev Internal function to safely mint a new token.
     * Reverts if the given token ID already exists.
     * If the target address is a contract, it must implement `onERC721Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * @param to The address that will own the minted token
     * @param tokenId uint256 ID of the token to be minted
     */
    function _safeMint(address to, uint256 tokenId) internal {
        _safeMint(to, tokenId, "");
    }

    /**
     * @dev Internal function to safely mint a new token.
     * Reverts if the given token ID already exists.
     * If the target address is a contract, it must implement `onERC721Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * @param to The address that will own the minted token
     * @param tokenId uint256 ID of the token to be minted
     * @param _data bytes data to send along with a safe transfer check
     */
    function _safeMint(address to, uint256 tokenId, bytes memory _data) internal {
        _mint(to, tokenId);
        require(_checkOnERC721Received(address(0), to, tokenId, _data), "ERC721: transfer to non ERC721Receiver implementer");
    }

    /**
     * @dev Internal function to mint a new token.
     * Reverts if the given token ID already exists.
     * @param to The address that will own the minted token
     * @param tokenId uint256 ID of the token to be minted
     */
    function _mint(address to, uint256 tokenId) internal {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(tokenId), "ERC721: token already minted");

        _tokenOwner[tokenId] = to;
        _ownedTokensCount[to].increment();

        emit Transfer(address(0), to, tokenId);
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * Deprecated, use {_burn} instead.
     * @param owner owner of the token to burn
     * @param tokenId uint256 ID of the token being burned
     */
    function _burn(address owner, uint256 tokenId) internal {
        require(ownerOf(tokenId) == owner, "ERC721: burn of token that is not own");

        _clearApproval(tokenId);

        _ownedTokensCount[owner].decrement();
        _tokenOwner[tokenId] = address(0);

        emit Transfer(owner, address(0), tokenId);
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * @param tokenId uint256 ID of the token being burned
     */
    function _burn(uint256 tokenId) internal {
        _burn(ownerOf(tokenId), tokenId);
    }

    /**
     * @dev Internal function to transfer ownership of a given token ID to another address.
     * As opposed to {transferFrom}, this imposes no restrictions on msg.sender.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _transferFrom(address from, address to, uint256 tokenId) internal {
        require(ownerOf(tokenId) == from, "ERC721: transfer of token that is not own");
        require(to != address(0), "ERC721: transfer to the zero address");

        _clearApproval(tokenId);

        _ownedTokensCount[from].decrement();
        _ownedTokensCount[to].increment();

        _tokenOwner[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

    /**
     * @dev Internal function to invoke {IERC721Receiver-onERC721Received} on a target address.
     * The call is not executed if the target address is not a contract.
     *
     * This is an internal detail of the `ERC721` contract and its use is deprecated.
     * @param from address representing the previous owner of the given token ID
     * @param to target address that will receive the tokens
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes optional data to send along with the call
     * @return bool whether the call correctly returned the expected magic value
     */
    function _checkOnERC721Received(address from, address to, uint256 tokenId, bytes memory _data)
        internal returns (bool)
    {
        if (!to.isContract()) {
            return true;
        }
        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = to.call(abi.encodeWithSelector(
            IERC721Receiver(to).onERC721Received.selector,
            _msgSender(),
            from,
            tokenId,
            _data
        ));
        if (!success) {
            if (returndata.length > 0) {
                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert("ERC721: transfer to non ERC721Receiver implementer");
            }
        } else {
            bytes4 retval = abi.decode(returndata, (bytes4));
            return (retval == _ERC721_RECEIVED);
        }
    }

    /**
     * @dev Private function to clear current approval of a given token ID.
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _clearApproval(uint256 tokenId) private {
        if (_tokenApprovals[tokenId] != address(0)) {
            _tokenApprovals[tokenId] = address(0);
        }
    }
}

// File: @openzeppelin/contracts/token/ERC721/ERC721Enumerable.sol

pragma solidity ^0.5.0;





/**
 * @title ERC-721 Non-Fungible Token with optional enumeration extension logic
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
contract ERC721Enumerable is Context, ERC165, ERC721, IERC721Enumerable {
    // Mapping from owner to list of owned token IDs
    mapping(address => uint256[]) private _ownedTokens;

    // Mapping from token ID to index of the owner tokens list
    mapping(uint256 => uint256) private _ownedTokensIndex;

    // Array with all token ids, used for enumeration
    uint256[] private _allTokens;

    // Mapping from token id to position in the allTokens array
    mapping(uint256 => uint256) private _allTokensIndex;

    /*
     *     bytes4(keccak256('totalSupply()')) == 0x18160ddd
     *     bytes4(keccak256('tokenOfOwnerByIndex(address,uint256)')) == 0x2f745c59
     *     bytes4(keccak256('tokenByIndex(uint256)')) == 0x4f6ccce7
     *
     *     => 0x18160ddd ^ 0x2f745c59 ^ 0x4f6ccce7 == 0x780e9d63
     */
    bytes4 private constant _INTERFACE_ID_ERC721_ENUMERABLE = 0x780e9d63;

    /**
     * @dev Constructor function.
     */
    constructor () public {
        // register the supported interface to conform to ERC721Enumerable via ERC165
        _registerInterface(_INTERFACE_ID_ERC721_ENUMERABLE);
    }

    /**
     * @dev Gets the token ID at a given index of the tokens list of the requested owner.
     * @param owner address owning the tokens list to be accessed
     * @param index uint256 representing the index to be accessed of the requested tokens list
     * @return uint256 token ID at the given index of the tokens list owned by the requested address
     */
    function tokenOfOwnerByIndex(address owner, uint256 index) public view returns (uint256) {
        require(index < balanceOf(owner), "ERC721Enumerable: owner index out of bounds");
        return _ownedTokens[owner][index];
    }

    /**
     * @dev Gets the total amount of tokens stored by the contract.
     * @return uint256 representing the total amount of tokens
     */
    function totalSupply() public view returns (uint256) {
        return _allTokens.length;
    }

    /**
     * @dev Gets the token ID at a given index of all the tokens in this contract
     * Reverts if the index is greater or equal to the total number of tokens.
     * @param index uint256 representing the index to be accessed of the tokens list
     * @return uint256 token ID at the given index of the tokens list
     */
    function tokenByIndex(uint256 index) public view returns (uint256) {
        require(index < totalSupply(), "ERC721Enumerable: global index out of bounds");
        return _allTokens[index];
    }

    /**
     * @dev Internal function to transfer ownership of a given token ID to another address.
     * As opposed to transferFrom, this imposes no restrictions on msg.sender.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _transferFrom(address from, address to, uint256 tokenId) internal {
        super._transferFrom(from, to, tokenId);

        _removeTokenFromOwnerEnumeration(from, tokenId);

        _addTokenToOwnerEnumeration(to, tokenId);
    }

    /**
     * @dev Internal function to mint a new token.
     * Reverts if the given token ID already exists.
     * @param to address the beneficiary that will own the minted token
     * @param tokenId uint256 ID of the token to be minted
     */
    function _mint(address to, uint256 tokenId) internal {
        super._mint(to, tokenId);

        _addTokenToOwnerEnumeration(to, tokenId);

        _addTokenToAllTokensEnumeration(tokenId);
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * Deprecated, use {ERC721-_burn} instead.
     * @param owner owner of the token to burn
     * @param tokenId uint256 ID of the token being burned
     */
    function _burn(address owner, uint256 tokenId) internal {
        super._burn(owner, tokenId);

        _removeTokenFromOwnerEnumeration(owner, tokenId);
        // Since tokenId will be deleted, we can clear its slot in _ownedTokensIndex to trigger a gas refund
        _ownedTokensIndex[tokenId] = 0;

        _removeTokenFromAllTokensEnumeration(tokenId);
    }

    /**
     * @dev Gets the list of token IDs of the requested owner.
     * @param owner address owning the tokens
     * @return uint256[] List of token IDs owned by the requested address
     */
    function _tokensOfOwner(address owner) internal view returns (uint256[] storage) {
        return _ownedTokens[owner];
    }

    /**
     * @dev Private function to add a token to this extension's ownership-tracking data structures.
     * @param to address representing the new owner of the given token ID
     * @param tokenId uint256 ID of the token to be added to the tokens list of the given address
     */
    function _addTokenToOwnerEnumeration(address to, uint256 tokenId) private {
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }

    /**
     * @dev Private function to add a token to this extension's token tracking data structures.
     * @param tokenId uint256 ID of the token to be added to the tokens list
     */
    function _addTokenToAllTokensEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    /**
     * @dev Private function to remove a token from this extension's ownership-tracking data structures. Note that
     * while the token is not assigned a new owner, the `_ownedTokensIndex` mapping is _not_ updated: this allows for
     * gas optimizations e.g. when performing a transfer operation (avoiding double writes).
     * This has O(1) time complexity, but alters the order of the _ownedTokens array.
     * @param from address representing the previous owner of the given token ID
     * @param tokenId uint256 ID of the token to be removed from the tokens list of the given address
     */
    function _removeTokenFromOwnerEnumeration(address from, uint256 tokenId) private {
        // To prevent a gap in from's tokens array, we store the last token in the index of the token to delete, and
        // then delete the last slot (swap and pop).

        uint256 lastTokenIndex = _ownedTokens[from].length.sub(1);
        uint256 tokenIndex = _ownedTokensIndex[tokenId];

        // When the token to delete is the last token, the swap operation is unnecessary
        if (tokenIndex != lastTokenIndex) {
            uint256 lastTokenId = _ownedTokens[from][lastTokenIndex];

            _ownedTokens[from][tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
            _ownedTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index
        }

        // This also deletes the contents at the last position of the array
        _ownedTokens[from].length--;

        // Note that _ownedTokensIndex[tokenId] hasn't been cleared: it still points to the old slot (now occupied by
        // lastTokenId, or just over the end of the array if the token was the last one).
    }

    /**
     * @dev Private function to remove a token from this extension's token tracking data structures.
     * This has O(1) time complexity, but alters the order of the _allTokens array.
     * @param tokenId uint256 ID of the token to be removed from the tokens list
     */
    function _removeTokenFromAllTokensEnumeration(uint256 tokenId) private {
        // To prevent a gap in the tokens array, we store the last token in the index of the token to delete, and
        // then delete the last slot (swap and pop).

        uint256 lastTokenIndex = _allTokens.length.sub(1);
        uint256 tokenIndex = _allTokensIndex[tokenId];

        // When the token to delete is the last token, the swap operation is unnecessary. However, since this occurs so
        // rarely (when the last minted token is burnt) that we still do the swap here to avoid the gas cost of adding
        // an 'if' statement (like in _removeTokenFromOwnerEnumeration)
        uint256 lastTokenId = _allTokens[lastTokenIndex];

        _allTokens[tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
        _allTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index

        // This also deletes the contents at the last position of the array
        _allTokens.length--;
        _allTokensIndex[tokenId] = 0;
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

// File: contracts/interface/IERC908Combinable.sol

pragma solidity ^0.5.0;


contract IERC908Combinable is IERC165 {
 
    event Compound(uint256 indexed tokenId, uint256[] indexed ids);
    event Decompose(uint256 indexed tokenId, uint256[] indexed ids);

    function getChildren(uint256 tokenId) public view returns (uint256[] memory) ;

    function getParrent(uint256 tokenId) public view returns (uint256) ;

    function compound(uint256 tokenId, uint256[] memory ids) public;

    function decompose(uint256 tokenId) public;
}


// contract Selector {
//     function calculateSelector() public pure returns (bytes4,bytes4,bytes4,bytes4,bytes4) {
//         IERC908Combinable i;
//         return 
//         (i.getChildren.selector , i.getParrent.selector , i.compound.selector , i.decompose.selector,
//         i.getChildren.selector ^ i.getParrent.selector ^ i.compound.selector ^ i.decompose.selector);
//     }
// }

// File: contracts/interface/IERC908Enumerable.sol

pragma solidity ^0.5.0;


contract IERC908Enumerable is IERC908Usership  {

    function tokenOfUsershipByIndex(address user, uint256 index) public view returns (uint256 tokenId);

    function tokenOfUsership(address user) public view returns (uint256[] memory);
}

// contract Selector {
//     function calculateSelector() public pure returns (bytes4,bytes4,bytes4) {
//         IERC908Enumerable i;
//         return 
//         (i.tokenOfUsershipByIndex.selector , i.tokenOfUsership.selector , 
//         i.tokenOfUsershipByIndex.selector ^ i.tokenOfUsership.selector );
//     }
// }

// File: contracts/interface/IERC908.sol

pragma solidity ^0.5.0;





contract IERC908 is  IERC721 {
    event TransferBatch(address indexed from, address indexed to, uint256[]  ids);
    
    function safeBatchTransferFrom(address from, address to, uint256[] memory ids , bytes memory data) public;

}

// contract Selector {
//     function calculateSelector() public pure returns (bytes4) {
//         IERC908 i;
//         return 
//         (i.safeBatchTransferFrom.selector);
//     }
// }

// File: contracts/ERC908.sol

pragma solidity ^0.5.0;





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

// File: contracts/ERC908Combinable.sol

pragma solidity ^0.5.5;







contract ERC908Combinable is Context, ERC165, IERC908Combinable {
    
    using SafeMath for uint256;
    using Address for address;
    
    uint256 internal _maxChildrenCount   = 10;

    mapping(uint256 => uint256[] ) public _children;

    mapping(uint256 => uint256 ) public _parrent;

    /*
     *=> 0x49ae8dc3 ^ 0x9fdbee8a ^ 0x64e0e60d ^ 0xd40e985d == 0x669b1d19
     */
     
    bytes4 private constant _INTERFACE_ID_ERC908_COMBINABLE = 0x669b1d19;

    constructor () public {
        // register the supported interfaces to conform to ERC908 via ERC165
        _registerInterface(_INTERFACE_ID_ERC908_COMBINABLE);
    }

    function getChildren(uint256 tokenId) public view returns (uint256[] memory) {
        uint256[] memory children = new uint256[](_children[tokenId].length);
        children = _children[tokenId];
        return children;
    }
    
    function getParrent(uint256 tokenId) public view returns (uint256) {
        return _parrent[tokenId];
    }

    function compound(uint256 tokenId, uint256[] memory ids) public
    {
        uint256 leftCount = _maxChildrenCount.sub(_children[tokenId].length);
        require(ids.length>0 &&  ids.length <= leftCount ,"invalid compound tokens count!");

        for(uint256 i=0; i<ids.length; i++ ){

            require(_parrent[ids[i]]==0,"the compound id already has parrent");
            require(_children[ids[i]].length==0,"the child id already has children");

            _children[tokenId].push(ids[i]);

            _parrent[ids[i]]=tokenId;
        }

        emit Compound(tokenId,ids);
    }

    function decompose(uint256 tokenId) public
    {
        emit Decompose(tokenId,_children[tokenId]);

        uint256 parrent = _parrent[tokenId];
         uint256 childId = 0;
        if(parrent !=0 ){
            //remove from the parrent children array
            uint256 length = _children[parrent].length;
            uint256 parrentTail = length.sub(1);
            for(uint256 i=0; i<length; i++ ){
                childId = _children[parrent][i];
                if(tokenId == childId){
                    _children[parrent][i] = _children[parrent][parrentTail];
                    break;
                }
            }
            _children[parrent].length=length.sub(1);
            _parrent[tokenId]=0;
        }

        //remove from the parrent and clear self children array
        for(uint256 i=0; i<_children[tokenId].length; i++ ){
            childId = _children[tokenId][i];
            _parrent[childId]=0;
        }
        _children[tokenId].length = 0;
    }
    
}

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

// File: contracts/ERC908Enumerable.sol

pragma solidity ^0.5.0;





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

// File: @openzeppelin/contracts/token/ERC721/IERC721Metadata.sol

pragma solidity ^0.5.0;


/**
 * @title ERC-721 Non-Fungible Token Standard, optional metadata extension
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
contract IERC721Metadata is IERC721 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function tokenURI(uint256 tokenId) external view returns (string memory);
}

// File: contracts/ERC908Metadata.sol

pragma solidity ^0.5.0;







contract ERC908Metadata is Context, ERC165, ERC721, IERC721Metadata {
    // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // Base URI
    string private _baseURI;

    // Optional mapping for token URIs
    mapping(uint256 => string) public _tokenURIs;

    // Optional mapping for app URIs
    mapping(string => string ) public _appBaseURIs;

    /*
     *     bytes4(keccak256('name()')) == 0x06fdde03
     *     bytes4(keccak256('symbol()')) == 0x95d89b41
     *     bytes4(keccak256('tokenURI(uint256)')) == 0xc87b56dd
     *
     *     => 0x06fdde03 ^ 0x95d89b41 ^ 0xc87b56dd == 0x5b5e139f
     */
    bytes4 private constant _INTERFACE_ID_ERC908_METADATA = 0x5b5e139f;

    /**
     * @dev Constructor function
     */
    constructor (string memory name, string memory symbol) public {
        _name = name;
        _symbol = symbol;

        // register the supported interfaces to conform to ERC721 via ERC165
        _registerInterface(_INTERFACE_ID_ERC908_METADATA);
    }

    /**
     * @dev Gets the token name.
     * @return string representing the token name
     */
    function name() external view returns (string memory) {
        return _name;
    }

    /**
     * @dev Gets the token symbol.
     * @return string representing the token symbol
     */
    function symbol() external view returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the URI for a given token ID. May return an empty string.
     *
     * If the token's URI is non-empty and a base URI was set (via
     * {_setBaseURI}), it will be added to the token ID's URI as a prefix.
     *
     * Reverts if the token ID does not exist.
     */
    function tokenURI(uint256 tokenId) external view returns (string memory) {
        require(_exists(tokenId), "ERC908Metadata: URI query for nonexistent token");

        string memory _tokenURI = _tokenURIs[tokenId];

        // Even if there is a base URI, it is only appended to non-empty token-specific URIs
        if (bytes(_tokenURI).length == 0) {
            return "";
        } else {
            // abi.encodePacked is being used to concatenate strings
            return string(abi.encodePacked(_baseURI, _tokenURI));
        }
    }

    /**
     * @dev Returns the URI for a given token ID. May return an empty string.
     *
     * If the token's URI is non-empty and a base URI was set (via
     * {_setBaseURI}), it will be added to the token ID's URI as a prefix.
     *
     * Reverts if the token ID does not exist.
     */
    function tokenAppURI(uint256 tokenId, string calldata appName) external view returns (string memory) {
        require(_exists(tokenId), "ERC908Metadata: URI query for nonexistent token");

        string memory _tokenURI = _tokenURIs[tokenId];

        // Even if there is a base URI, it is only appended to non-empty token-specific URIs
        if (bytes(_tokenURI).length == 0) {
            return "";
        } else {
            // abi.encodePacked is being used to concatenate strings
            string memory appBaseURI = _appBaseURIs[appName];
            return string(abi.encodePacked(appBaseURI, _tokenURI));
        }
    }

    /**
     * @dev Internal function to set the token URI for a given token.
     *
     * Reverts if the token ID does not exist.
     *
     * TIP: if all token IDs share a prefix (e.g. if your URIs look like
     * `http://api.myproject.com/token/<id>`), use {_setBaseURI} to store
     * it and save gas.
     */
    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal {
        require(_exists(tokenId), "ERC908Metadata: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }

    /**
     * @dev Internal function to set the base URI for all token IDs. It is
     * automatically added as a prefix to the value returned in {tokenURI}.
     *
     * _Available since v2.5.0._
     */
    function _setBaseURI(string memory baseURI) internal {
        _baseURI = baseURI;
    }

    /**
     * @dev Internal function to set the app URI for all token IDs. 
     */
    function _setAppBaseURI(string memory appName, string memory appBaseURI) internal{
        _appBaseURIs[appName] = appBaseURI;
    }

    /**
    * @dev Returns the base URI set via {_setBaseURI}. This will be
    * automatically added as a preffix in {tokenURI} to each token's URI, when
    * they are non-empty.
    *
    * _Available since v2.5.0._
    */
    function baseURI() external view returns (string memory) {
        return _baseURI;
    }

    //
    function appBaseURI(string calldata appName) external view returns (string memory) {
        return _appBaseURIs[appName];
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * Deprecated, use _burn(uint256) instead.
     * @param owner owner of the token to burn
     * @param tokenId uint256 ID of the token being burned by the msg.sender
     */
    function _burn(address owner, uint256 tokenId) internal {
        super._burn(owner, tokenId);

        // Clear metadata (if any)
        if (bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }
    }
}

// File: contracts/interface/IERC908Full.sol

pragma solidity ^0.5.0;


pragma experimental ABIEncoderV2;




contract IERC908Full is IERC908Combinable,IERC908Enumerable,IERC908 {

    event CompoundMint(address indexed to,uint256 indexed tokenId,address indexed owner,uint256[] ids);
    event DecomposeBurn(uint256 indexed tokenId,address indexed owner,uint256[]  ids);
    event TransferBatch(address indexed from, address indexed to, uint256[]  ids);

    function mint(address to, uint256 tokenId) public returns (bool) ;

    function burn(uint256 tokenId) public ;

    function compoundMint(address to, uint256 tokenId, uint256[] memory ids) public;

    function decomposeBurn(uint256 tokenId) public;

    function usershipIssue(uint256 tokenId, address to, uint256 period) public ;

    function usershipReturn(uint256 tokenId) public;

    function usershipReclaim(uint256 tokenId, bytes memory data) public;
    
}

// contract Selector {
//     function calculateSelector() public pure returns (bytes4,bytes4,bytes4,bytes4,bytes4,bytes4,bytes4,bytes4) {
//         IERC908Full i;
//         return 
//         (
//         i.mint.selector , 
//         i.burn.selector , 
//         i.compoundMint.selector ,
//         i.decomposeBurn.selector,
//         i.usershipIssue.selector , 
//         i.usershipReturn.selector , 
//         i.usershipReclaim.selector ,
//         i.mint.selector ^
//         i.burn.selector ^
//         i.compoundMint.selector ^
//         i.decomposeBurn.selector ^
//         i.usershipIssue.selector ^
//         i.usershipReturn.selector ^
//         i.usershipReclaim.selector
//         );
//     }
// }

// File: contracts/ERC908Full.sol

pragma solidity ^0.5.0;






contract ERC908Full is ERC908,ERC908Combinable, ERC908Enumerable,ERC908Metadata,ERC165,IERC908Full{

    /*
    *=> 0x40c10f19^0x42966c68^0x32eb29be^0x563b2675^0x3d45e8df^0x36c6aeb4^0x487facb6==0x257b8667
    */
    //bytes4 private constant _INTERFACE_ID_ERC908_FULL= 0x257b8667;

    constructor (string memory name, string memory symbol) public ERC908Metadata(name, symbol) {
        _registerInterface(_INTERFACE_ID_ERC908_FULL);
    }

    //
    function isOwnerLock(uint256 tokenId) view public returns (bool)   {
        require( _isApprovedOrOwner(msg.sender,tokenId));
        require(usershipOf(tokenId)==address(0x0),"token has a usership!");
        require(_parrent[tokenId]==0,"token has a parrent!");

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
        isOwnerLock(tokenId);
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
                isOwnerLock(children[i]);
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
                isOwnerLock(children[i]);
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
                isOwnerLock(children[i]);
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
