// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../lib/abstract/ERC20.sol";
import "../lib/abstract/Burnable.sol";
import "../lib/abstract/Mintable.sol";

contract Fish is NamedERC20, ERC20_3, MintableERC20, BurnableERC20 {
	constructor (
	) ERC20_3 (
		0,
		address(0)
	) NamedERC20 (
		"Fish",
		"🐟",
		18
	) MintableERC20 (
	) BurnableERC20 (
	) {
	}
}
