// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {Vault} from "../src/Vault.sol";

// Get the value from contract storage using cast command
// cast storage --rpc-url $SEPOLIA_RPC_URL INSTANCEADDRESS 1

contract VaultScript is Script {
    Vault public vault;

    function run() public {
        vault = Vault(0xed300D4eEF35E2E9d34A4332099ff9D7bBbFdbb2);
        unlockVault();
    }

    function unlockVault() public {
        vm.startBroadcast();
        vault.unlock(
            0x412076657279207374726f6e67207365637265742070617373776f7264203a29
        );
        vm.stopBroadcast();
    }
}
