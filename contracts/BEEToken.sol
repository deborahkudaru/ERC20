// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract BEEToken {
    
    string public name = "Debee";
    string public symbol = "BEE";
    uint8 public decimals = 18; 
    uint public totalSupply;
    address public owner;

    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);

    constructor(uint _initialSupply) {
        owner = msg.sender;
        totalSupply = _initialSupply * (10 ** uint(decimals));
        balanceOf[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    function transfer(address _to, uint _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Insufficient funds");

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint _value) public returns (bool success) {

        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint _value) public returns (bool success) {
        require(balanceOf[_from] >= _value, "Insufficient funds");
        require(allowance[_from][msg.sender] >= _value, "Allowance exceeded");

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);

        return true;
    }
}
