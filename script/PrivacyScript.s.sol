// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {Privacy} from "../src/Privacy.sol";

contract PrivacyScript is Script {
    Privacy public privacy;
    // Get key using $ cast storage INSTANCE_ADDRESS 5 --rpc-url $SEPOLIA_RPC_URL
    // 5 because that is where the key is stored
    // Get the key and convert it to bytes16 since it is in bytes32 format
    bytes16 public constant KEY = 0xf7032d001001c6b4bb4a200813b454e1;

    function run() public {
        privacy = Privacy(0xE64d36C768d17Cb77A7B4C0dd43486613a900F2a);
        unlock();
    }

    function unlock() public {
        vm.startBroadcast();
        privacy.unlock(KEY);
        vm.stopBroadcast();
    }
}
