pragma solidity ^0.6.6;
//0x3de42fc186dfe96dabd245dda5be8f65273f8872
contract ERC20Basic {

    string public constant name = "PAKCOIN";
    string public constant symbol = "PKC";
    uint8 public constant decimals = 4;  

    address public creator;
    address public owner;
    uint public unlockDate;
    uint public createdAt;
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Received(address _from, uint _amount);
    event Withdrew(address _to, uint _amount, string message);
   

    mapping(address => uint256) balances;

    mapping(address => mapping (address => uint256)) allowed;
    
    uint256 totalSupply_;

    using SafeMath for uint256;


   constructor() public {  
	totalSupply_ = 1000000 *(10**uint256(decimals));
	balances[msg.sender] = totalSupply_;
    }  
    
    function TimeLockedWallet(address _owner, uint _unlockDate) public 
    {
   
    owner = _owner;
    unlockDate = _unlockDate;
}
receive() payable external { 
  emit Received(msg.sender, msg.value);
}
modifier onlyOwner {
  require(msg.sender == owner);
  _;
}

function withdraw() onlyOwner public {
   require( now <= unlockDate);
   msg.sender.transfer(address(this).balance);
   Withdrew(msg.sender, address(this).balance,"transferred");
}




    function totalSupply() public view returns (uint256) {
	return totalSupply_;
    }
    
    function balanceOf(address tokenOwner) public view returns (uint) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint numTokens) payable public returns (bool) {
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender].sub(numTokens);
        balances[receiver] = balances[receiver].add(numTokens);
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

    function approve(address delegate, uint numTokens) public returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function allowance(address owner, address delegate) public view returns (uint) {
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint numTokens) payable public returns (bool) {
        require(numTokens <= balances[owner]);    
        require(numTokens <= allowed[owner][msg.sender]);
    
        balances[owner] = balances[owner].sub(numTokens);
        allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(numTokens);
        balances[buyer] = balances[buyer].add(numTokens);
        Transfer(owner, buyer, numTokens);
        return true;
    }

 
    }

library SafeMath { 
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
      assert(b <= a);
      return a - b;
    }
    
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
      uint256 c = a + b;
      assert(c >= a);
      return c;
    }
}
