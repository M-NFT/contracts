// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (token/ERC721/extensions/ERC721URIStorage.sol)

pragma solidity ^0.8.0;

import "../ERC721.sol";

/**
 * @dev ERC721 token with storage based token URI management.
 */
 abstract contract ERC721URIStorage is ERC721 {
    using Strings for uint256;

    // Optional mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;
    // mapping(uint256 => mapping(string => string)) internal _tokenURIs_M;

    struct MyStruct {
        string _tokenURI_origin;
        string _tokenURI_modified;
        uint64 _timeStart;
        uint64 _timeStop;
    }  

    mapping(uint256 => MyStruct) private _tokenURIs_M;


    // function uri(uint256 _id) public view returns (string memory) {
    //     MyStruct memory _tokenURI_M = _tokenURIs_M[_id];
    //     string memory base = _baseURI();
        
    //     // if ((bytes(base).length != 0) &&
    //     //             (block.timestamp < _tokenURI_M._timeStart + 2 minutes)) {
    //     //     return _tokenURI_M._tokenURI_origin;
    //     // } else if ((bytes(base).length == 0) && 
    //     //             (block.timestamp >= _tokenURI_M._timeStart + 2 minutes)) {
    //     //     return _tokenURI_M._tokenURI_modified;
    //     // }

    //     if (bytes(_tokenURI_M._tokenURI_origin).length > 0 &&
    //                 block.timestamp >= _tokenURI_M._timeStop) {
    //         return string(abi.encodePacked(base, _tokenURI_M._tokenURI_origin));

    //     } else if (bytes(_tokenURI_M._tokenURI_origin).length > 0 &&
    //                 block.timestamp >= _tokenURI_M._timeStart  &&
    //                 block.timestamp < _tokenURI_M._timeStop)
    //     {
    //         return string(abi.encodePacked(base, _tokenURI_M._tokenURI_modified));                    
    //     }
    //     // return templateURI;
    //     // return tokenURI(tokenId);
    // }

    /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721URIStorage: URI query for nonexistent token");

        MyStruct memory _tokenURI_M = _tokenURIs_M[tokenId];
        string memory base = _baseURI();

        // If there is no base URI, return the token URI.
        if ((bytes(base).length == 0) &&
                    block.timestamp < _tokenURI_M._timeStart &&
                    (block.timestamp >= _tokenURI_M._timeStop)) {
            return _tokenURI_M._tokenURI_origin;
        } else if ((bytes(base).length == 0) && 
                    block.timestamp >= _tokenURI_M._timeStart &&
                    block.timestamp < _tokenURI_M._timeStop) {
            return _tokenURI_M._tokenURI_modified;
        }

        // If there is no base URI, return the token URI.
        // if (block.timestamp < _tokenURI_M._timeStart &&
        //             (block.timestamp >= _tokenURI_M._timeStop)) {
        //     return _tokenURI_M._tokenURI_origin;
        // } else if (block.timestamp >= _tokenURI_M._timeStart &&
        //             block.timestamp < _tokenURI_M._timeStop) {
        //     return _tokenURI_M._tokenURI_modified;
        // }

        // if (_tokenURI_M._timeStart  ) {}    


        // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
        if (bytes(_tokenURI_M._tokenURI_origin).length > 0 &&
                    ((block.timestamp < _tokenURI_M._timeStart) ||
                    (block.timestamp >= _tokenURI_M._timeStop)))  {
            return string(abi.encodePacked(base, _tokenURI_M._tokenURI_origin));
        } else if (bytes(_tokenURI_M._tokenURI_modified).length > 0 &&
                    block.timestamp >= _tokenURI_M._timeStart  &&
                    block.timestamp < _tokenURI_M._timeStop)
        {
            return string(abi.encodePacked(base, _tokenURI_M._tokenURI_modified));                    
        }

        return super.tokenURI(tokenId);
    }

    /**
     * @dev Sets `_tokenURI` as the tokenURI of `tokenId`.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    // function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
    //     require(_exists(tokenId), "ERC721URIStorage: URI set of nonexistent token");
    //     _tokenURIs[tokenId] = _tokenURI;
    // }


    function _setTokenURI_M(uint256 tokenId, string memory _tokenURI, string memory _tokenURI_M, uint64 _timeStart, uint64 _timeStop) internal virtual {
        require(_exists(tokenId), "ERC721URIStorage: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;

        _tokenURIs_M[tokenId] = MyStruct(_tokenURI, _tokenURI_M, _timeStart, _timeStop);

        // _tokenURIs_M[tokenId][_tokenURI] = _tokenURI_M;
    }

    function _changeTokenURI_M(uint256 tokenId, string memory _tokenURI_M, uint64 _timeStart, uint64 _timeStop) internal virtual {
        require(_exists(tokenId), "ERC721URIStorage: URI set of nonexistent token");
        // _tokenURIs[tokenId] = _tokenURI;

        MyStruct memory currentToken = _tokenURIs_M[tokenId]; // = MyStruct(, _tokenURI_M, _timeStart, _timeStop);

        // currentToken._tokenURI_origin;

        // currentToken._tokenURI_modified = _tokenURI_M;
        // currentToken._timeStart = _timeStart;
        // currentToken._timeStop = _timeStop;

        _tokenURIs_M[tokenId] = MyStruct(currentToken._tokenURI_origin, _tokenURI_M, _timeStart, _timeStop);

        // _tokenURIs_M[tokenId][_tokenURI] = _tokenURI_M;
    }

    /**
     * @dev Destroys `tokenId`.
     * The approval is cleared when the token is burned.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     *
     * Emits a {Transfer} event.
     */
    function _burn(uint256 tokenId) internal virtual override {
        super._burn(tokenId);

        if (bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }
    }
}