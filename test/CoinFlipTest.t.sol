//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {CoinFlip} from "../src/CoinFlip.sol";

contract CoinFlipTest is Test {
    CoinFlip public coinFlip;
    uint256 public constant FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function setUp() external {
        coinFlip = new CoinFlip();
    }

    function testOneFlip() public {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        bool guess = (blockValue / FACTOR) == 1 ? true : false;

        bool result = coinFlip.flip(guess);

        assertEq(result, true);
    }

    function testTenFlips() public {
        for (uint256 i = 0; i < 10; i++) {
            vm.roll(block.number + 1);
            uint256 blockValue = uint256(blockhash(block.number - 1));
            bool guess = (blockValue / FACTOR) == 1 ? true : false;

            bool result = coinFlip.flip(guess);

            console.log(coinFlip.consecutiveWins());
            assertEq(result, true);
        }
    }
}
