// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC20.sol";

interface IEtherWrapable is IERC20 {
	// -- EVENTS --

	event Deposit (
		address indexed owner,
		uint256 amount
	);

	event Withdrawal (
		address indexed owner,
		uint256 amount
	);

	// -- PAYABLE FUNCTIONS --

	function deposit() external payable;

	// -- EXTERNAL FUNCTIONS --

	function withdraw (
		uint256 amount
	) external;
}
