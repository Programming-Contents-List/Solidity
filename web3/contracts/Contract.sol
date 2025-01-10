// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Contract {
    string str = "hellow!";

    function sayHello() public view returns (string memory){
        return str;
    }
}