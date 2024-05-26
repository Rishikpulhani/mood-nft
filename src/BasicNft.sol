// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIDtoURI;

    constructor() ERC721("Dogie", "DOG") {
        s_tokenCounter = 0;
    }

    function mintNFT(string memory tokenuri) public {
        s_tokenIDtoURI[s_tokenCounter] = tokenuri;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
        //here what is happening is we are allowing the user to put his own token uri which defines how the nft looks so the owner or the minter of the nft is changing how it looks
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        //when this function is called it returns how the nft looks
        return s_tokenIDtoURI[tokenId];
    }

    function getTokenCounter() external view returns (uint256) {
        return s_tokenCounter;
    }
}
