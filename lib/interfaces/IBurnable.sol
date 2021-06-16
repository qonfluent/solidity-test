// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC20.sol";
import "./IERC173.sol";

interface IBurnableERC20 is IERC20, IERC173 {
	function burn (
		address account,
		uint256 amount
	) external;
}

