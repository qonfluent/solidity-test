// SPDX-License-Identifier: MIT
// File: https://eips.ethereum.org/EIPS/eip-2771

pragma solidity ^0.8.0;

interface ERC2771 {
	function isTrustedForwarder(address forwarder) external returns(bool);
}
