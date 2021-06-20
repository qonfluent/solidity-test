// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../lib/abstract/ERC20.sol";
import "../lib/abstract/Taxable.sol";
import "../lib/abstract/TokenWrappable.sol";

contract Crab is NamedERC20, ERC20_3, Taxable, TokenWrappable {
	constructor (
	) ERC20_3 (
		0,
		address(0)
	) NamedERC20 (
		"Crab",
		"CRAB",
		18
	) Taxable (
		25,
		10000,
		address(0)
	) TokenWrappable (
		0xc00e94Cb662C3520282E6f5717214004A7f26888
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
