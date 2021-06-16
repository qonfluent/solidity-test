// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../interfaces/IEtherWrapable.sol";

import "./Burnable.sol";
import "./Mintable.sol";

abstract contract EtherWrapable is IEtherWrapable, MintableERC20, BurnableERC20 {
	// -- PAYABLE FUNCTIONS --

	function deposit () external override payable {
		address sender = _msgSender();
		_mint(sender, msg.value);
	        emit Deposit(sender, msg.value);
	}

	// -- PUBLIC FUNCTIONS --

	function withdraw (
		uint256 amount
	) public override {
		address sender = _msgSender();
		_burn(sender, amount);

		payable(sender).transfer(amount);
		emit Withdrawal(sender, amount);
	}
}
