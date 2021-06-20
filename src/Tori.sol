// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../lib/abstract/ERC20.sol";
import "../lib/abstract/Taxable.sol";
import "../lib/abstract/GovernanceTokenWrappable.sol";

contract Tori is NamedERC20, ERC20_3, Taxable, GovernanceTokenWrappable {
	constructor (
	) ERC20_3 (
		0,
		address(0)
	) NamedERC20 (
		"Tori",
		"TORI",
		18
	) Taxable (
		25,
		10000,
		address(0)
	) GovernanceTokenWrappable (
		0xfC1E690f61EFd961294b3e1Ce3313fBD8aa4f85d
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
