// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../interfaces/IERC20.sol";
import "../util/Context.sol";
import "../util/SafeMath.sol";

abstract contract FixedERC20 is Context, IERC20 {
	using SafeMath for uint256;

	// -- STATE --
	mapping (address => uint256) internal _balances;

	mapping (address => mapping (address => uint256)) internal _allowances;

	uint256 internal _totalSupply;

	// -- CONSTRUCTOR --

	constructor (
		uint256 c_totalSupply,
		address c_owner
	) {
		_balances[c_owner] = c_totalSupply;
		_totalSupply = c_totalSupply;
	}

	// -- VIEW FUNCTIONS --
	function totalSupply() public view override returns (uint256) {
		return _totalSupply;
	}

	function balanceOf(address account) public view override returns (uint256) {
		return _balances[account];
	}

	function allowance(address owner, address spender) public view virtual override returns (uint256) {
		return _allowances[owner][spender];
	}

	// -- PUBLIC FUNCTIONS --

	function approve (
		address spender,
		uint256 amount
	) public override virtual returns (bool) {
		_approve(_msgSender(), spender, amount);
		return true;
	}

	function transfer (
		address recipient,
		uint256 amount
	) public override virtual returns (bool) {
		_transfer(_msgSender(), recipient, amount);
		return true;
	}

	function transferFrom (
		address sender,
		address recipient,
		uint256 amount
	) public override virtual returns (bool) {
		_transfer(sender, recipient, amount);

		uint256 currentAllowance = _allowances[sender][_msgSender()];
		require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
		unchecked {
			_approve(sender, _msgSender(), currentAllowance - amount);
		}

		return true;
	}

	// -- INTERNAL FUNCTIONS --

	function _approve(
		address owner,
		address spender,
		uint256 amount
	) internal virtual {
		require(owner != address(0), "ERC20: approve from the zero address");
		require(spender != address(0), "ERC20: approve to the zero address");

		// Set allowance for (owner to spender) to amount
		_allowances[owner][spender] = amount;
		emit Approval(owner, spender, amount);
	}

	function _transfer(
		address sender,
		address recipient,
		uint256 amount
	) internal virtual {
		require(sender != address(0), "ERC20: transfer from the zero address");
		require(recipient != address(0), "ERC20: transfer to the zero address");

		uint256 senderBalance = _balances[sender];
		require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");
		unchecked {
			_balances[sender] = senderBalance - amount;
		}
		_balances[recipient] += amount;

		emit Transfer(sender, recipient, amount);
	}

}

abstract contract FixedERC20_2 is FixedERC20, IERC20_2 {
	using SafeMath for uint256;

	// -- CONSTRUCTOR --

	constructor (
		uint256 c_totalSupply,
		address c_owner
	) FixedERC20 (
		c_totalSupply,
		c_owner
	) {}

	// -- PUBLIC FUNCTIONS --

	function approve (
		address spender,
		uint256 currentAmount,
		uint256 newAmount
	) public override virtual returns (bool success) {
		require(allowance(_msgSender(), spender) == currentAmount, "Current amount doesn't match");
		_approve(_msgSender(), spender, newAmount);
		emit Approval(_msgSender(), spender, currentAmount, newAmount);
		return true;
	}

	function transferFrom (
		address sender,
		address recipient,
		uint256 amount
	) public override(IERC20, FixedERC20) virtual returns (bool) {
		_transfer(sender, recipient, amount);

		uint256 currentAllowance = _allowances[sender][_msgSender()];
		require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
		unchecked {
			_approve(sender, _msgSender(), currentAllowance - amount);
		}

		emit Transfer(_msgSender(), sender, recipient, amount);

		return true;
	}
}

abstract contract FixedERC20_3 is FixedERC20, IERC20_3 {
	using SafeMath for uint256;	

	// -- CONSTRUCTOR --

	constructor (
		uint256 c_totalSupply,
		address c_owner
	) FixedERC20 (
		c_totalSupply,
		c_owner
	) {}

	// -- PUBLIC FUNCTIONS --

	function increaseAllowance (
		address spender,
		uint256 addedValue
	) public override virtual returns (bool) {
		_approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
		return true;
	}

	function decreaseAllowance (
		address spender,
		uint256 subtractedValue
	) public override virtual returns (bool) {
		_approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
		return true;
	}
}


abstract contract NamedERC20 is INamedERC20 {
	using SafeMath for uint256;

	// -- STATE --

	string private _name;
	string private _symbol;
	uint8 private _decimals;

	// -- CONSTRUCTOR --

	constructor (
		string memory c_name,
		string memory c_symbol,
		uint8 c_decimals
	) {
		_name = c_name;
		_symbol = c_symbol;
		_decimals = c_decimals;
	}

	// -- VIEW FUNCTIONS--

	function name () public override view returns (string memory) {
		return _name;
	}

	function symbol () public override view returns (string memory) {
		return _symbol;
	}

	function decimals () public override view returns (uint8) {
		return _decimals;
	}
}

abstract contract NamedFixedERC20 is NamedERC20, FixedERC20 {
	// -- CONSTRUCTOR --

	constructor (
		string memory c_name,
		string memory c_symbol,
		uint8 c_decimals,

		uint256 c_totalSupply,
		address c_owner
	) NamedERC20 (
		c_name,
		c_symbol,
		c_decimals
	) FixedERC20 (
		c_totalSupply,
		c_owner
	) {}
}

abstract contract NamedFixedERC20_2 is NamedERC20, FixedERC20_2 {
	// -- CONSTRUCTOR --

	constructor (
		string memory c_name,
		string memory c_symbol,
		uint8 c_decimals,

		uint256 c_totalSupply,
		address c_owner
	) NamedERC20 (
		c_name,
		c_symbol,
		c_decimals
	) FixedERC20_2 (
		c_totalSupply,
		c_owner
	) {}
}

abstract contract NamedFixedERC20_3 is NamedERC20, FixedERC20_3 {
	// -- CONSTRUCTOR --

	constructor (
		string memory c_name,
		string memory c_symbol,
		uint8 c_decimals,

		uint256 c_totalSupply,
		address c_owner
	) NamedERC20 (
		c_name,
		c_symbol,
		c_decimals
	) FixedERC20_3 (
		c_totalSupply,
		c_owner
	) {}
}
