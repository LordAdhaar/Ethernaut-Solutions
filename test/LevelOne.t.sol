//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {Instance} from "../src/LevelOne.sol";

contract LevelOneTest is Test {
    Instance public levelOne;
    address public USER = makeAddr("Adhaar");
    uint256 public constant USER_STARTING_BALANCE = 1 ether;

    function setUp() public {
        levelOne = new Instance("password");
        vm.deal(USER, USER_STARTING_BALANCE);
    }

    function testCheckPasswordIsCorrect() public {
        //ARRANGE
        vm.prank(USER);
        //ACT
        levelOne.authenticate("password");
        //ASSERT
        assertEq(levelOne.getCleared(), true);
    }
}
