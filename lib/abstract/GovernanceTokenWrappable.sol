// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../interfaces/IGovernanceToken.sol";
import "../interfaces/IGovernanceTokenWrappable.sol";
import "./TokenWrappable.sol";

abstract contract GovernanceTokenWrappable is IGovernanceTokenWrappable, TokenWrappable {
	// -- PUBLIC FUNCTIONS --

	function setDelegation (
		address who
	) external override {
		IGovernanceToken token = IGovernanceToken(_wrappedToken);
		token.delegate(who);
		emit ChangedDelegate(who);
	}
}
