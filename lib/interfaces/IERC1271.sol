// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IERC1271 {
	// bytes4 constant MAGICVALUE = bytes4(keccak256("isValidSignature(bytes32,bytes)"));

	/**
	 * @dev Should return whether the signature provided is valid for the provided data
	 * @param _hash      Hash of the data to be signed
	 * @param _signature Signature byte array associated with _data
	 *
	 * MUST return the bytes4 magic value 0x1626ba7e when function passes.
	 * MUST NOT modify state (using STATICCALL for solc < 0.5, view modifier for solc > 0.5)
	 * MUST allow external calls
	 */ 
	function isValidSignature (
		bytes32 _hash, 
		bytes memory _signature
	) external view returns (bytes4 magicValue);
}
