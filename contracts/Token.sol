// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Token {
    string public tokenName = "Debee";
    string public tokenSymbol = "BEE";
    uint public total;
    address owner = msg.sender;

    mapping(address => uint) public balance;
    mapping(address => mapping(address => uint)) public allowance;

    // emmited when tokens are transferred
    event Transfer(address indexed from, address indexed to, uint value);

    // emited when owner approves the spender to spend tokens
    event Approve(address indexed owner, address indexed spender, uint value);

    constructor(uint _amountAdded) {
        total = _amountAdded * 10 ** uint(18);
        balance[msg.sender] = total;
        emit Transfer(address(0), msg.sender, total);
    }

    function transfer(address _to, uint _value) public virtual returns (bool sucess) {
        require(balance[owner] >= _value, "Insufficient funds");
        balance[owner] -= _value;
        balance[_to] += _value;
        emit Transfer(owner, _to, _value);
        return true;
    }

    function approval(
        address _spender,
        uint _value
    ) public returns (bool success) {
        allowance[owner][_spender] = _value;
        emit Approve(owner, _spender, _value);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint _value
    ) public returns (bool) {
        require(balance[_from] >= _value, "insufficient funds");
        require(allowance[_from][owner] >= _value, "too much");

        balance[_from] -= _value;
        balance[_to] += _value;
        allowance[_from][owner] -= _value;
        emit Transfer(_from, _to, _value);

        return true;
    }
}
