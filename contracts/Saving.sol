// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./Token.sol";

abstract contract Savings is Token {
    mapping(address => uint256) public savedBalance;

    event TokensSaved(address indexed user, uint256 amount);
    event TokensWithdrawn(address indexed user, uint256 amount);

    function saveTokens(uint256 _amount) public {
        // require(balance[msg.sender] >= _amount, "Insufficient balance");
        
        balance[msg.sender] -= _amount;
        savedBalance[msg.sender] += _amount;
        emit TokensSaved(msg.sender, _amount);
    }

    function withdrawTokens(uint256 _amount) public {
        // require(savedBalance[msg.sender] >= _amount, "Insufficient saved balance");
        savedBalance[msg.sender] -= _amount;
        balance[msg.sender] += _amount;
        emit TokensWithdrawn(msg.sender, _amount);
    }
}