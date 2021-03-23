pragma solidity ^0.5.5;

import "@openzeppelin/contracts/GSN/Context.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/introspection/ERC165.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./interface/IERC908Combinable.sol";

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
            require(tokenId!=ids[i],"the compound id is self");
            

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
