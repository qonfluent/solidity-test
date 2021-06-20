// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC20.sol";

interface IGovernanceToken is IERC20 {
	function delegate (
		address delegatee
	) external;
}
