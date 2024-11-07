// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {Instance} from "../src/LevelOne.sol";

contract LevelOneScript is Script {
    Instance public levelOne;

    function run() external {
        interactions();
    }

    function interactions() public {
        levelOne = Instance(0x250306822518eBCf9eC56D35b7225C96Af318257);
        string memory password = levelOne.password();
        vm.startBroadcast();
        levelOne.authenticate(password);
        console.log(msg.sender);
        vm.stopBroadcast();
    }
}
