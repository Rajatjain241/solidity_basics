// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract PiggyBank {
    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);

    address public owner = msg.sender;

    receive() external payable {
        emit Deposit(msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner, "not owner");
        selfdestruct(payable(msg.sender));
        emit Withdraw(address(this).balance);
    }
}
