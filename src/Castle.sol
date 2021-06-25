// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../lib/abstract/ERC20.sol";
import "../lib/abstract/TokenWrappable.sol";
import "../lib/util/SafeMath.sol";

contract Castle is NamedERC20, ERC20_3, TokenWrappable {
	using SafeMath for uint256;

	// -- EVENTS --

	event VoteTotal (
		address indexed delegate,
		uint256 votes
	);

	// -- STATE --

	struct Candidate {
		uint256 votes;
		address prev;
		address next;
	}

	mapping (address => Candidate) private _votes;
	mapping (address => uint256) private _delegated;

	address[] private _senateMembers;
	uint256 private _nextSenateSize = 1;

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
		_votes[address(this)].votes = type(uint256).max;
	}


	// -- VIEW FUNCTIONS --

	function getVotes (
		address who
	) public view returns (uint256) {
		return _votes[who].votes;
	}

	function getSenateMembers () public view returns (address[] memory) {
		return _senateMembers;
	}

	// -- PUBLIC FUNCTIONS --

	function castVote (
		address old_prev,
		address new_prev,
		address who,
		uint256 amount
	) public {
		// Ensure arguments are valid
		require(who != address(0), "Can't vote for nobody");
		require(who != address(this), "Can't vote for the contract");

		// Ensure sender has enough undelegated balance to cast this many votes
		address sender = _msgSender();
		uint256 delegated = _delegated[sender];
		uint256 balance = _balances[sender];
		uint256 new_delegated = delegated + amount;
		require(balance >= new_delegated, "Not enough castle");

		// Update who value to include new votes
		uint256 new_votes = _votes[who].votes + amount;

		// Ensure total order property is maintained
		uint256 prev_value = _votes[new_prev].votes;
		address prev_next = _votes[new_prev].next;
		uint256 next_value = _votes[prev_next].votes;
		require(prev_value > new_votes, "Total order violated on the left");
		require(new_votes > next_value, "Total order violated on the right");

		// Ensure user is where they should be currently
		if (old_prev == address(0)) {
			require(_votes[who].votes == 0, "Missing old_prev");
		} else {
			require(_votes[old_prev].next == who, "Mismatch with old_prev");
	
			// Remove who from the list
			_votes[old_prev].next = _votes[who].next;
		}

		// Update list
		_votes[new_prev].next = who;
		_votes[who].votes = new_votes;
		_votes[who].next = prev_next;

		// Update the sender's delegate count
		_delegated[sender] = new_delegated;

		emit VoteTotal(who, new_votes);
	}

	function countVotes () public {
		// Clear current senate list
		delete _senateMembers;

		// Iterate the vote list to collect the senate
		address ptr = address(this);

		for (uint256 i = 0; i < _nextSenateSize && ptr != address(0); i++) {
			ptr = _votes[ptr].next;
			_senateMembers.push() = ptr;
		}
	}
}
