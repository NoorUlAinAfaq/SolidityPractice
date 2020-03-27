pragma solidity 0.6.0;

contract vehicle
{
    uint mileage;
    function travel() virtual public returns (string memory)
    {
        return "it can travel";
    }
    function getmileage() public returns (uint)
    {
        return mileage;
    }
    function setmileage (uint _mileage) public
    {
        mileage = _mileage;
    }
}

contract car is vehicle
{
    function travel() public override virtual returns(string memory)
    {
        return "it can travel and can take upto 5 persons";
    }
    
}
contract bus is vehicle
{
    function travel() public override virtual returns(string memory)
    {
        return "it can travel and can take upto 30 persons";
    }
    
    
}
contract truck is vehicle
{
    function travel() public override virtual returns(string memory)
    {
        return "it can travel and can carry heavy load";
    }
    
}

contract workshop 
{
    event logstring(string);
    function travel() public returns(uint)
    {
    vehicle v = new vehicle();
    car c = new car();
    bus b = new bus();
    truck t = new truck();
    
    vehicle veh = new car();
    
    emit logstring(veh.travel());
    emit logstring(b.travel());
    emit logstring(c.travel());
}
}
