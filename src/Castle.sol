// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../lib/abstract/ERC20.sol";
import "../lib/abstract/TokenWrappable.sol";
import "../lib/util/SafeMath.sol";

contract Castle is NamedERC20, ERC20_3, TokenWrappable {
	using SafeMath for uint256;

	// -- STATE --

	struct Candidate {
		uint256 votes;
		address prev;
		address next;
	}

	mapping (address => Candidate) _votes;
	mapping (address => uint256) _delegated;

	// -- CONSTRUCTOR --

	constructor (
	) ERC20_3 (
		0,
		address(0)
	) NamedERC20 (
		"Castle",
		"CASTLE",
		18
	) TokenWrappable (
		0x30BCd71b8d21FE830e493b30e90befbA29de9114
	) {
	}

	// -- PUBLIC FUNCTIONS --

	function delegate (
		address prev,
		address next,
		address who,
		uint256 amount
	) public {
		uint256 delegated = _delegated[_msgSender()];
		require(_balances[_msgSender()] >= delegated + amount, "Not enough castle");

		// Check that delegation is valid
		Candidate memory prev_value = _votes[prev];
		Candidate memory next_value = _votes[next];
		Candidate memory who_value = _votes[who];

		who_value.votes += amount;

		require(prev_value.votes > who_value.votes && who_value.votes > next_value.votes, "Violates total order");

		// Remove who from list if they're already in the list
		if (who_value.prev != address(0)) {
			_votes[who_value.prev].next = who_value.next;
		}

		if (who_value.next != address(0)) {
			_votes[who_value.next].prev = who_value.prev;
		}

		// Insert who to their new place in the list
		who_value.prev = prev;
		who_value.next = next;
		_votes[who] = who_value;

		// Update balances and delegated values
		_delegated[_msgSender()] = delegated + amount;
	}
}
