// contracts/NFToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721/ERC721.sol';
import './ERC721/extensions/ERC721URIStorage.sol';
import './utils/Counters.sol';
import './utils/Ownable.sol';

contract NFToken is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721('Senitskiy', 'SD') {}

    function mint(address to) public onlyOwner {
        super._safeMint(to, _tokenIds.current());
        _tokenIds.increment();
    }

    function setTokenURI(uint256 tokenId, string memory tokenURI)
        public
        onlyOwner
    {
        super._setTokenURI(tokenId, tokenURI);
    }

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}