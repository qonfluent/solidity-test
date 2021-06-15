// SPDX-License-Identifier: MIT
// Source: @ensdomains/ens/contracts/ENS.sol

pragma solidity ^0.8.0;

import "./IERC165.sol";

interface IERC137 is IERC165 {
	// Logged when the owner of a node assigns a new owner to a subnode.
	event NewOwner (
		bytes32 indexed node,
		bytes32 indexed label,
		address owner
	);

	// Logged when the owner of a node transfers ownership to a new account.
	event Transfer (
		bytes32 indexed node,
		address owner
	);

	// Logged when the resolver for a node changes.
	event NewResolver (
		bytes32 indexed node,
		address resolver
	);

	// Logged when the TTL of a node changes
	event NewTTL (
		bytes32 indexed node,
		uint64 ttl
	);

	function owner (
		bytes32 node
	) external view returns (address);

	function setOwner (
		bytes32 node,
		address newOwner
	) external;

	function resolver (
		bytes32 node
	) external view returns (address);

	function ttl (
		bytes32 node
	) external view returns (uint64);

	function setSubnodeOwner (
		bytes32 node,
		bytes32 label,
		address newOwner
	) external returns(bytes32);

	function setResolver (
		bytes32 node,
		address newResolver
	) external;

	function setTTL (
		bytes32 node,
		uint64 newTTL
	) external;
}
