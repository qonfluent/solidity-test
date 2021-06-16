// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC165.sol";
import "./IERC173.sol";
import "./IERC1271.sol";

interface IERC725X is IERC165, IERC173 {
	event ContractCreated (
		address indexed contractAddress
	);

	event Executed (
		uint256 indexed operation,
		address indexed to,
		uint256 indexed  value,
		bytes data
	);

	function execute (
		uint256 operationType,
		address to,
		uint256 value,
		bytes memory data
	) external;
}

interface IERC725Y is IERC165, IERC173 {
	event DataChanged(bytes32 indexed key, bytes value);

	function getData(bytes32 key) external view returns (bytes memory value);
	function setData(bytes32 key, bytes memory value) external;
}

interface IERC725 is IERC725X, IERC725Y {}

interface IERC725Account is IERC725, IERC1271 {
	event ValueReceived (
		address indexed sender,
		uint256 indexed value
	);
}
