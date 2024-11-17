// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {Test, console} from "../lib/forge-std/src/Test.sol";

interface Buyer {
    function price() external view returns (uint256);
}

contract Shop {
    uint256 public price = 100;
    bool public isSold;

    function buy() public {
        Buyer _buyer = Buyer(msg.sender);
        console.log(_buyer.price());
        if (_buyer.price() >= price && !isSold) {
            isSold = true;
            price = _buyer.price();
        }
    }

    function getPrice() external view returns (uint256) {
        return price;
    }
}
