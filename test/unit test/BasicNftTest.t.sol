// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicnft;
    address public USER = makeAddr("USER");
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() external {
        deployer = new DeployBasicNft();
        basicnft = deployer.run();
    }

    function testNameIsCorrect() external view {
        string memory expectedName = "Dogie";
        string memory actualName = basicnft.name();
        //assert(keccak256(bytes(expectedName)) == keccak256(bytes(actualName)));
        //we can do the above method and its correct
        //or we can use abi.encodedPacked() to get the bytes value and take its hash
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function testCanMintAndHaveBalance() external {
        vm.prank(USER);
        basicnft.mintNFT(PUG);
        assert(basicnft.balanceOf(USER) == 1);
        //balanceof function gives the number of nft'son that id
        assert(keccak256(abi.encodePacked(PUG)) == keccak256(abi.encodePacked(basicnft.tokenURI(0))));
    }
}
