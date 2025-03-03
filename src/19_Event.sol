// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract Event {
    // Event declaration
    // Up to 3 parameters can be indexed.
    // Indexed parameters help you filter the logs by the indexed parameter
    event Log(address indexed sender, string message);
    event AnotherLog();

    function test() public {
        emit Log(msg.sender, "Hello World!");
        emit Log(msg.sender, "Hello EVM!");
        emit AnotherLog();
    }
}

/**
 * Events in Solidity are a powerful tool that enables various advanced functionalities and architectures. Some advanced use cases for events include:
 * Event filtering and monitoring for real-time updates and analytics
 * Event log analysis and decoding for data extraction and processing
 * Event-driven architectures for decentralized applications (dApps)
 * Event subscriptions for real-time notifications and updates
 */
