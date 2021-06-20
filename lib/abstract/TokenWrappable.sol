// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../interfaces/ITokenWrapable.sol";
import "./Mintable.sol";
import "./Burnable.sol";

abstract contract TokenWrappable is ITokenWrapable, MintableERC20, BurnableERC20 {
	// -- STATE --

	address private _wrappedToken;

	// -- CONSTRUCTOR -- 
	constructor (
		address token
	) {
		_wrappedToken = token;
	}

	// -- VIEW FUNCTIONS --

	function getWrappedToken () public override view returns (address) {
		return _wrappedToken;
	}

	// -- PUBLIC FUNCTIONS --

	function wrap (
		uint256 amount
	) public override returns (uint256) {
		IERC20 token = IERC20(_wrappedToken);
		require(token.transferFrom(_msgSender(), address(this), amount), "Not enough tokens!");
		_mint(_msgSender(), amount);
		return amount;
	}

	function unwrap (
		uint256 amount
	) public override returns (uint256) {
		IERC20 token = IERC20(_wrappedToken);
		require(token.transferFrom(address(this), _msgSender(), amount), "Not enough tokens!");
		_burn(_msgSender(), amount);
		return amount;
	}
}
