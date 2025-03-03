// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

// Constants are variables that cannot be modified. Their value is hard coded and using constants can save gas cost.
contract Constants {
    // coding convention to uppercase constant variables
    address public constant MY_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
    uint256 public constant MY_UINT = 123;
}

contract Immutable {
    address public immutable myAddr;
    uint256 public immutable myUint;

    constructor(uint256 _myUint) {
        myAddr = msg.sender;
        myUint = _myUint;
    }
}

/**
 * Constants:-
 * Assignment: The value of a constant variable must be assigned at the time of declaration and cannot be changed later.
 * Storage Location: constant variables are typically stored in the bytecode of the contract, meaning they are hardcoded into the contract. Because they are hardcoded, the values are available at compile time.
 * Gas Cost: Since constant variables are embedded into the bytecode, accessing them doesn't incur a gas cost (because they are evaluated at compile time).
 *
 * Immutable:-
 * Assignment: The value of an immutable variable must be assigned during contract deployment (in the constructor). Once assigned, the value cannot be changed
 * Storage Location: immutable variables are stored in storage, like regular state variables, and not in bytecode. However, since their value is fixed after deployment, they still have similar performance benefits when compared to constant in terms of gas costs during execution.
 * Gas Cost: Accessing an immutable variable also does not incur a gas cost for reading it once set, but it is stored in storage, so it's slightly more costly to deploy than constant variables. However, it's cheaper to set during deployment than a non-immutable state variable that must be updated multiple times.
 * When to use: You should use immutable when the value of the variable is set during contract deployment and should remain unchanged throughout the contract's lifetime. This allows for flexibility compared to constant, which is limited to values known at compile time.
 */
