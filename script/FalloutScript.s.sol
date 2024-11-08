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
        fallout = Fallout(0x542F45e871C9474d5715f6f38FB621e237AABbe1);
        vm.startBroadcast();
        fallout.Fal1out{value: 0.0001 ether}();
        vm.stopBroadcast();
    }
}
