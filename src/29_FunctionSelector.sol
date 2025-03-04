// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

/**
 * When a function is called, the first 4 bytes of calldata specifies which function to call. This 4 bytes is called a function selector.
 * The rest of the data is the parameters to pass to the function.
 */
contract FunctionSelector {
    /*
    "transfer(address,uint256)"
    0xa9059cbb
    "transferFrom(address,address,uint256)"
    0x23b872dd
    */
    function getSelector(string calldata _func) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }
}

// Note: We could have also used abi.encode(_func) inside keccak256 but then we would have to extract the data from the structured bytes.
// The main difference between abi.encode and bytes is that- abi.encode gives bytes according to the Ethereum abi specifications, while bytes just convert the string.
// But both abi.encode & bytes convert the data string same.
