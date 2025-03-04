// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

// self destruct
// - delete contract
// - force send ether to any address
contract Kill {
    constructor() payable {}

    function kill() external {
        selfdestruct(payable(msg.sender));
    }

    function testCall() external pure returns (uint256) {
        return 123;
    }
}

contract Helper {
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function kill(Kill _kill) external {
        _kill.kill();
    }
}

/**
 * Note: "selfdestruct" has been deprecated. Note that, starting from the Cancun hard fork, the
 * underlying opcode no longer deletes the code and data associated with an account and only
 * transfers its Ether to the beneficiary, unless executed in the same transaction in which the
 * contract was created (see EIP-6780). Any use in newly deployed contracts is strongly discouraged
 * even if the new behavior is taken into account. Future changes to the EVM might further reduce the
 * functionality of the opcode.
 */
