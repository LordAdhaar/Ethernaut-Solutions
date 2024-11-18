//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {CryptoVault, DoubleEntryPoint, IDetectionBot, Forta} from "../src/DoubleEntryPoint.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DoubleEntryPointScript is Script {
    Forta public forta;
    SuspiciousTransferBot public suspiciousTransferBot;
    address public legacyTokenAddress;

    function run() external {
        forta = Forta(0x27acd06732b112da0E33165A25c1f7DA64990574);
        legacyTokenAddress = 0x142E07A021C5ecF3B6e1A8fE25991d3f6dE52f36;
        pwn();
    }

    function pwn() public {
        vm.startBroadcast();
        suspiciousTransferBot = new SuspiciousTransferBot();
        forta.setDetectionBot(address(suspiciousTransferBot));
        vm.stopBroadcast();
    }
}

contract SuspiciousTransferBot is IDetectionBot {
    address public cryptoVault = 0xB980FFCAF504b4C2A37f09c2146652A95e201dFf;
    address public suspiciousAddress =
        0xb99822596ADa5fF795af305D98818E9ee4650C63;
    Forta public forta = Forta(0x27acd06732b112da0E33165A25c1f7DA64990574);

    function handleTransaction(
        address user,
        bytes calldata msgData
    ) external override {
        (address to, uint256 value, address origSender) = abi.decode(
            msgData[4:],
            (address, uint256, address)
        );

        if (
            to == suspiciousAddress ||
            origSender == cryptoVault ||
            value >= type(uint256).max
        ) {
            forta.raiseAlert(user);
        }
    }
}
