// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC20.sol";
import "./IERC173.sol";

interface ITaxable is IERC20, IERC173 {
	// -- EVENTS --

	event FeeChange (
		uint256 numerator,
		uint256 denominator
	);

	event FeeTargetChange (
		address target
	);

	// -- VIEW FUNCTIONS --

	function getFee () external view returns (uint256, uint256);

	function getFeeTarget () external view returns (address);

	// -- EXTERNAL FUNCTIONS --

	function setFee (
		uint256 numerator,
		uint256 denominator
	) external returns (bool);

	function setFeeTarget (
		address target
	) external returns (bool);
}
