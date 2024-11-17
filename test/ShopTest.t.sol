//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {Shop} from "../src/Shop.sol";

interface Buyer {
    function price() external view returns (uint256);
}

contract BuyerDude is Buyer {
    Shop public shop;

    constructor(address shopAddress) {
        shop = Shop(shopAddress);
    }

    uint256 public counter = 0;

    function price() external view returns (uint256) {
        if (shop.isSold()) {
            return 10;
        }

        return 100;
    }
}

contract ShopTest is Test {
    Shop public shop;
    BuyerDude public buyer;
    address public bob = makeAddr("BOOOB");

    function setUp() external {
        shop = new Shop();
        buyer = new BuyerDude(address(shop));
    }

    function testBuyerPrice() public {
        vm.prank(address(buyer));
        shop.buy();

        assertEq(shop.isSold(), true);
        assertEq(shop.price(), 10);
    }
}
