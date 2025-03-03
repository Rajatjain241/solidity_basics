// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract Receiver {
    event Received(address caller, uint256 amount, string message);

    fallback() external payable {
        emit Received(msg.sender, msg.value, "Fallback was called");
    }

    receive() external payable {}

    function foo(string memory _message, uint256 _x) public payable returns (uint256) {
        emit Received(msg.sender, msg.value, _message);

        return _x + 1;
    }
}

contract Caller {
    event Response(bool success, bytes data);

    // Let's imagine that contract Caller does not have the source code for the
    // contract Receiver, but we do know the address of contract Receiver and the function to call.
    function testCallFoo(address payable _addr) public payable {
        // You can send ether and specify a custom gas amount
        (bool success, bytes memory data) =
            _addr.call{value: msg.value, gas: 5000}(abi.encodeWithSignature("foo(string,uint256)", "call foo", 123));

        emit Response(success, data);
    }

    // Calling a function that does not exist triggers the fallback function.
    function testCallDoesNotExist(address payable _addr) public payable {
        (bool success, bytes memory data) = _addr.call{value: msg.value}(abi.encodeWithSignature("doesNotExist()"));

        emit Response(success, data);
    }
}

/**
 * Why call is Not Recommended for Regular Function Calls
 * 1. Reverts are not bubbled up:
 *    * When you call a function on another contract using a regular function call (i.e., via the function signature), if something goes wrong (e.g., the contract reverts), the error is "bubbled up," meaning it propagates to the calling contract and can be caught by require or assert statements.
 *    * In contrast, when you use call, if the called contract reverts, the revert error won’t be automatically propagated to the calling contract. You have to manually check the success and handle the error accordingly. This can lead to situations where a transaction silently fails without notifying you about the error.
 *    * In this example, even though the function doesNotExist() doesn’t exist in the target contract, the contract won’t produce a compile-time error. Instead, it would fail silently at runtime, and the require(success) will catch the failure.
 *
 * 2. Type checks are bypassed:
 *    * When you use a regular function call in Solidity (such as target.someFunction()), the compiler checks that the function exists, has the correct arguments, and returns the expected data types. This helps ensure that your contract interacts with other contracts in a type-safe way.
 *    * With call, there is no such type checking. You are responsible for ensuring that the data you're sending is formatted correctly, and the target contract has the right function with the right signature. If the function signature is incorrect or the arguments don't match, you won't be warned at compile-time, which can lead to runtime errors.
 *
 * Conclusion: You should only use call when absolutely necessary, such as when interacting with contracts whose interface you don't know in advance or when sending Ether to a contract that only implements a fallback function. For most use cases, it’s better to use regular function calls to ensure type safety, better error handling, and more readable, secure code.
 */
