// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
contract DeployMoodNft is Script{
    string public sadSvg = vm.readFile("./img/sad.svg");
    string public happySvg = vm.readFile("./img/happy.svg");
    function run() external returns(MoodNft){
        vm.startBroadcast();
        MoodNft moodnft = new MoodNft(
            svgToImageURI(sadSvg),
            svgToImageURI(happySvg)
        );
        vm.stopBroadcast();
        return moodnft;
    }
    function svgToImageURI(string memory svg) public pure returns(string memory){
        string memory baseUrl = "data:image/svg+xml;base64,";
        string memory svgbase64encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));
        /*console.log(abi.encodePacked(svg));
        console.log(string(abi.encodePacked(svg)));
        console.log(bytes(string(abi.encodePacked(svg))));
        console.log(Base64.encode(abi.encodePacked(svg)));
        console.log(Base64.encode(bytes(string(abi.encodePacked(svg)))));*/
        return string(abi.encodePacked(baseUrl,svgbase64encoded));
        //can do string.concat also


    }
}