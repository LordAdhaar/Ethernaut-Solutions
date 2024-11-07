// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console} from "../lib/forge-std/src/Test.sol";

contract Telephone {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _owner) public {
        if (tx.origin != msg.sender) {
            console.log("TX ORIGING: ", tx.origin);
            console.log("MSG SENDER: ", msg.sender);
            owner = _owner;
        }
    }
}
