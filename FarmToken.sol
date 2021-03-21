pragma solidity ^0.6.0;
//create a dai farm token for staking/farming
//contract state with basic details about the token
contract FarmCoin {
    string public name = "Farm Coin";         //token name for display
    string public symbol = "FarmC";             //token symbol for display
    uint256 public totalSupply_ = 1600000000;      //total supply of token
    uint8 public decimal = 18;

//triggers the trasfer of tokens from developer to other wallets
event Transfer(
    address indexed_from,
    address indexed_to,
    uint256 _value
);

event Approval(
    address indexed_creator,
    address indexed_spender,
    uint256 _value
);
mapping(address => uint256) public balances;
mapping(address => mapping(address => uint256)) public allowed;

//assigns owner 
constructor() public {
    balances[msg.sender] = totalSupply_;
}
//function that returns total amount of tokens
function totalSupply() public view returns (uint256) {
    return totalSupply_;
}
//shows address which balance will retrieved and returns balance
function balanceOf(address _creator) public view returns (uint256) {
    return balances[_creator];
}
//triggers the following commands
//send a certain value of token from developer
//recipient address
//amount of tokrns to be transferred
//endpoint of the transaction
function transfer(address _to, uint256 _value) public returns (bool success) {
    require(balances[msg.sender] >= _value);
    balances[msg.sender] -=_value;
    balances[_to] +=_value;
    emit Transfer(msg.sender,_to,_value);
    return true;
}
//triggers the following commands
//deployer(msg.sender) approves address to send a certain value of token to
//shows address of developer
//address of recipient
//amount of token to be transfered 
//endpoint of transaction
function approve(address _creator, uint256 _value) public returns (bool success) {
    allowed[msg.sender][_creator] = _value;
    emit Approval(msg.sender, _creator, _value);
    return true;
}
//sets a condition that a certain amount of token is transfered only when it is approved by sender
function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
    require(_value <= balances[_from]);
    require(_value <= allowed[_from][msg.sender]);
    balances[_from] -= _value;
    balances[_to] += _value;
    allowed[_from][msg.sender] -= _value;
    emit Transfer(_from, _to, _value);
    return true;
}
//details of developer address
function allowance(address _creator, address _spender) public view returns (uint256 remaining) {
    return allowed[_creator][_spender];
}
}