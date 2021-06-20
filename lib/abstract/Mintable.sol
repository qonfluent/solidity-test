// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../interfaces/IMintable.sol";
import "../abstract/ERC20.sol";
import "../abstract/ERC173.sol";

abstract contract MintableERC20 is IMintableERC20, ERC20, ERC173 {
	constructor () {}

	function mint (
		address account,
		uint256 amount
	) public override onlyOwner {
		_mint(account, amount);
	}

	function _mint (
		address account,
		uint256 amount
	) internal virtual {
		require(account != address(0), "ERC20: mint to the zero address");

		_totalSupply += amount;
		_balances[account] += amount;
		emit Transfer(address(0), account, amount);
	}
}
