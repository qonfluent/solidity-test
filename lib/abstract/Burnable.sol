// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../interfaces/IBurnable.sol";
import "../abstract/ERC20.sol";

abstract contract BurnableERC20 is IBurnableERC20, ERC20 {
	constructor () {}

	function _burn (
		address account,
		uint256 amount
	) internal virtual {
		require(account != address(0), "ERC20: burn from the zero address");

		uint256 accountBalance = _balances[account];
		require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
		unchecked {
			_balances[account] = accountBalance - amount;
		}
		_totalSupply -= amount;

		emit Transfer(account, address(0), amount);
	}
}