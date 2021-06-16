// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../util/Context.sol";
import "../interfaces/IERC173.sol";

abstract contract ERC173 is Context, IERC173 {
	// -- STATE --

	address private _owner;

	// -- CONSTRUCTOR --

	constructor() {
		address msgSender = _msgSender();
		_owner = msgSender;
		emit OwnershipTransferred(address(0), msgSender);
	}

	// -- PUBLIC FUNCTIONS --

	function owner() public view override returns (address) {
		return _owner;
	}

	modifier onlyOwner() override {
		require(owner() == _msgSender(), "ERC173: not owner");
		_;
	}

	// -- OWNER ONLY FUNCTIONS --

	function transferOwnership (
		address newOwner
	) public override onlyOwner {
		emit OwnershipTransferred(_owner, newOwner);
		_owner = newOwner;
	}
}
