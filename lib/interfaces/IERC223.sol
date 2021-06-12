// SPDX-License-Identifier: MIT

// Source: https://github.com/Dexaran/ERC223-token-standard/blob/development/token/ERC223/IERC223.sol

pragma solidity ^0.8.0;

import "./IERC20.sol";

interface IERC223 is IERC20 {
	event Transfer (
		address indexed from,
		address indexed to,
		uint256 value,
		bytes _data
	);

	function transfer (
		address to,
		uint value,
		bytes _data
	) returns (bool);
}

// Source: https://github.com/Dexaran/ERC223-token-standard/blob/development/token/ERC223/IERC223Recipient.sol

interface IERC223Receiver {
	// @dev Standard ERC223 function that will handle incoming token transfers.
	//
	// @param _from  Token sender address.
	// @param _value Amount of tokens.
	// @param _data  Transaction metadata.
	function tokenFallback (
		address from,
		uint value,
		bytes memory data
	) public;
}
