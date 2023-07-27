// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployGenesisToken} from "../script/DeployGenesisToken.s.sol";
import {GenesisToken} from "../src/GenesisToken.sol";

contract GenesisTokenTest is Test {
    GenesisToken public genesisToken;
    DeployGenesisToken deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 constant STARTING_BALANCE = 1000 ether;

    function setUp() public {
        //Deploy the contract
        deployer = new DeployGenesisToken();
        genesisToken = deployer.run();

        vm.prank(msg.sender);
        genesisToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public {
        assertEq(STARTING_BALANCE, genesisToken.balanceOf(bob));
    }

    function testAllowanceWorks () public{
        uint256 initialAllowance = 1000 ether;
        uint256 transferAmount = 500 ether;

        // Bob approves Alice to spend tokens on her Behalf
        vm.prank(bob);
        genesisToken.approve(alice,initialAllowance);

        // ALice spends Bob's tokens
        vm.prank(alice);
        genesisToken.transferFrom(bob,alice,transferAmount);

        assertEq(transferAmount, genesisToken.balanceOf(bob));
        assertEq(transferAmount, genesisToken.balanceOf(alice));

    }
}
