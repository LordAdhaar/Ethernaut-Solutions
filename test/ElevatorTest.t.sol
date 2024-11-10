//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {Elevator, Building} from "../src/Elevator.sol";

contract Apartment is Building {
    uint256 public counter;

    function isLastFloor(uint256) external returns (bool) {
        if (counter == 0) {
            counter += 1;
            return false;
        } else {
            return true;
        }
    }
}

contract ElevatorTest is Test {
    Elevator public elevator;
    Apartment public apartment;
    address public USER = makeAddr("USER");
    uint256 public constant USER_STARTING_BALANCE = 10 ether;

    function setUp() public {
        elevator = new Elevator();
        apartment = new Apartment();
        vm.deal(USER, USER_STARTING_BALANCE);
    }

    function testTopAndFloorValues() public {
        vm.prank(address(apartment));
        elevator.goTo(10);
    }
}
