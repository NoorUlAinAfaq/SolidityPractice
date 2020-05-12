pragma solidity 0.6.6;

import "./token.sol";
//0x51924eec444757366ddfa62d2c230bcec5c88c0b
contract mintableToken is ERC20Basic 
{
    using SafeMath for uint256;
    
   
    uint256 _cap ;
    
    
    constructor (uint256 cap) public {
       
        _cap = cap;
    }
    
    function mint(address receiver, uint amount) public payable
    {
        totalSupply_ = totalSupply_.add(amount);
        balances[receiver] = balances[receiver].add(amount);
        uint256 _balance = balances[receiver];
        require(totalSupply_ <= _cap,"limit exceeded");
        
        
      
    }
    
}

