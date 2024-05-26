// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";


contract MoodNft is ERC721 {
    uint256 private s_tokenCounter;
    string private s_sadsvgImageUri;
    string private s_happysvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private s_tokenIdToMood;
    
    error MoodNft__CannotChangeMoodAsNotOwner();

    constructor(string memory sadsvgImageUri, string memory happysvgImageUri) ERC721("Mood Nft", "MN") {
        s_tokenCounter = 0;
        s_happysvgImageUri = happysvgImageUri;
        s_sadsvgImageUri = sadsvgImageUri;
        //here we are passing the image uri and the token uri
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,"; //as here working on a json object not svg
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageURI;
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = s_happysvgImageUri;
        } else {
            imageURI = s_sadsvgImageUri;
        }

        string memory tokenMetadata = string.concat(
            '{"name":',
            name(),
            '"description" : "An NFT that reflects the owners mood", "attributes" : [{"trait_type": "moodiness", "value": 100}],"image":',
            imageURI,
            '"}'
        );

        return string(abi.encodePacked(_baseURI(), Base64.encode(bytes(abi.encodePacked(tokenMetadata)))));
    }
    function flipMood(uint256 tokenId) public {
        //in all functions follow the CEI architecture 
        //checks
        if(ownerOf(tokenId) != msg.sender){
            revert MoodNft__CannotChangeMoodAsNotOwner();
        }
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY){
            s_tokenIdToMood[tokenId] == Mood.SAD;
        }
        else{
            s_tokenIdToMood[tokenId] == Mood.HAPPY;
        }
    }
}
