// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

// Unlike functions, state variables cannot be overridden by re-declaring it in the child contract.

contract A {
    string public name = "Contract A";

    function getName() public view returns (string memory) {
        return name;
    }
}

// This will not compile
// contract B is A {
//     string public name = "Contract B";
// }

contract C is A {
    // This is the correct way to override inherited state variables.
    constructor() {
        name = "Contract C";
    }

    // C.getName returns "Contract C"
}
