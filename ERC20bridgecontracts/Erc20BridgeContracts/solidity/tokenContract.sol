// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Remix style import
//import { ERC20 } from "@openzeppelin/contracts@4.0.0/token/ERC20/ERC20.sol";

//Brownie style import
import { ERC20 } from "OpenZeppelin/openzeppelin-contracts@4.0.0/contracts/token/ERC20/ERC20.sol";

//minting an intital supply to the mainnet

contract ImperialCredits is ERC20 {
    constructor(uint256 initialSupply) ERC20("ImperialsCredits", "ICR") { //naming the coin and creating the supply
        _mint(msg.sender, initialSupply); // mint the initial supply
    }
}