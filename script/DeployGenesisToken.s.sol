// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {GenesisToken} from "../src/GenesisToken.sol";

contract DeployGenesisToken is Script {
    uint256 public constant INITIAL_SUPPLY = 10000 ether;

    GenesisToken genesisToken;

    function run() external returns (GenesisToken) {
        vm.startBroadcast();
        genesisToken = new GenesisToken(INITIAL_SUPPLY);
        vm.stopBroadcast();

        return genesisToken;
    }
}
