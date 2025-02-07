// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./BEEToken.sol";

contract BEESaving is BEEToken {
    mapping(address => uint) public savingsBalance;

    event Deposited(address indexed user, uint amount);
    event Withdrawn(address indexed user, uint amount);

    constructor(uint _initialSupply) BEEToken(_initialSupply) {}

    function deposit(uint _amount) external {
        require(_amount > 0, "Deposit must be greater than zero");
        require(balanceOf[msg.sender] >= _amount, "Insufficient funds");
        balanceOf[msg.sender] -= _amount;
        savingsBalance[msg.sender] += _amount;

        emit Deposited(msg.sender, _amount);
    }

    function withdraw(uint _amount) external {
        require(_amount > 0, "Withdraw must be greater than zero");
        require(savingsBalance[msg.sender] >= _amount, "Insufficient savings");
        savingsBalance[msg.sender] -= _amount;
        balanceOf[msg.sender] += _amount;

        emit Withdrawn(msg.sender, _amount);
    }

    function checkSavings(address _user) external view returns (uint) {
        return savingsBalance[_user];
    }
}
