// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../interfaces/ITaxable.sol";
import "../abstract/ERC20.sol";
import "../abstract/ERC173.sol";

abstract contract Taxable is ITaxable, ERC20, ERC173 {
	// -- STATE --

	uint256 internal _feeNumerator;
	uint256 internal _feeDenominator;

	address internal _feeTarget;

	// -- CONSTRUCTOR --

	constructor (
		uint256 numerator,
		uint256 denominator,
		address target
	) {
		_feeNumerator = numerator;
		_feeDenominator = denominator;
		_feeTarget = target;
	}

	// -- VIEW FUNCTIONS --

	function getFee () public override view returns (uint256, uint256) {
		return (_feeNumerator, _feeDenominator);
	}

	function getFeeTarget () public override view returns (address) {
		return _feeTarget;
	}

	// -- PUBLIC FUNCTIONS --

	function setFee (
		uint256 numerator,
		uint256 denominator
	) public override onlyOwner returns (bool) {
		require(denominator != 0, "Divide by zero");
		require(numerator < denominator, "Fee greater than 100%");

		_feeNumerator = numerator;
		_feeDenominator = denominator;

		return true;
	}

	function setFeeTarget (
		address target
	) public override onlyOwner returns (bool) {
		require(target != address(0), "Fee target can't be the zero address");

		_feeTarget = target;

		return true;
	}

	// -- INTERNAL FUNCTIONS --

	function _transfer (
		address sender,
		address recipient,
		uint256 amount
	) internal override virtual {
		require(sender != address(0), "ERC20: transfer from the zero address");
		require(recipient != address(0), "ERC20: transfer to the zero address");

		uint256 fees = (amount * _feeNumerator) / _feeDenominator;
		require(fees > 1, "Fee:Unpayable");

		uint256 receivable = amount - fees;
		assert(fees + receivable == amount);

		uint256 senderBalance = _balances[sender];
		require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");
		unchecked {
			_balances[sender] = senderBalance - amount;
		}
		_balances[recipient] += receivable;
		_balances[_feeTarget] += fees;

		emit Transfer(sender, recipient, receivable);
		emit Transfer(sender, _feeTarget, fees);
	}
}
