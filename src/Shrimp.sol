// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../lib/abstract/ERC20.sol";
import "../lib/abstract/Taxable.sol";
import "../lib/abstract/TokenWrappable.sol";

contract Shrimp is NamedERC20, ERC20_3, Taxable, TokenWrappable {
	constructor (
	) ERC20_3 (
		0,
		address(0)
	) NamedERC20 (
		"Shrimp",
		"SHRIMP",
		18
	) Taxable (
		25,
		10000,
		address(0)
	) TokenWrappable (
		0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984
	) {
	}

	function _transfer (
		address sender,
		address recipient,
		uint256 amount
	) internal override(ERC20, Taxable) virtual {
		Taxable._transfer(sender, recipient, amount);
	}
}
