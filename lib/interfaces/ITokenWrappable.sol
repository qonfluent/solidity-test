// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC20.sol";

interface ITokenWrappable is IERC20 {
	// -- EVENTS --

	event Wrap (
		address indexed owner,
		uint256 amount
	);

	event Unwrap (
		address indexed owner,
		uint256 amount
	);

	// -- VIEW FUNCTIONS --

	function getWrappedToken () external view returns (address);

	// -- EXTERNAL FUNCTIONS --

	function wrap (
		uint256 amount
	) external returns (uint256);

	function unwrap (
		uint256 amount
	) external returns (uint256);
}
