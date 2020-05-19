//0x5da13a0AB1b9285827d12bC1d2F62F929B8d97B1

pragma solidity 0.6.8;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract timeLocked
{
    uint unlockDate;
    uint createdAt;
    address public owner;
    address public creator;
   event Received(address,uint);
    event withdrew(address,uint);


modifier onlyOwner
{
    require(msg.sender == owner);
    _;
}

constructor (address _owner, address _creator, uint256 _unlockDate) public
{
    creator = _creator;
    owner = _owner;
    unlockDate = _unlockDate;
    createdAt = now;
}

receive () payable external
{
   emit Received(msg.sender,msg.value);
}

function withdraw () onlyOwner public payable
{
    require(now <= unlockDate, "date is before");
    msg.sender.transfer(address(this).balance);
    emit withdrew(msg.sender,address(this).balance);
}
}
