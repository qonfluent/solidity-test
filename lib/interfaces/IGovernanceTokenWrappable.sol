// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ITokenWrappable.sol";

interface IGovernanceTokenWrappable is ITokenWrappable {
	// -- EVENTS --

	event ChangedDelegate (
		address delegate
	);

	// -- EXTERNAL FUNCTIONS --

	function setDelegation (
		address delegate
	) external;
}
