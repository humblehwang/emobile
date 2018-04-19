pragma solidity ^0.4.16;

contract Emobile {  
    
    bytes plate;      // mobile license-plate
    uint256 initialFund;     // Gogoro2 price : 60000
    uint256 timestamp;
    string driverName;
    address driverAddress;
    bool isLock;
    mapping(bytes32 => Investors) investorStructs;
    
    struct Investors {
        bytes32 name;  // (up to 32 bytes)
        uint256 amount; // check how many amount the investor send 
    }
    
    mapping(address => Investors) public investors;
    
    function setDriver(address mobile, string _driverName) public {
        driverName = driverName;
    }
    
    function getProfitValue(address mobile) public constant returns(uint) {
        // return mobiles[mobile].fund;
        return 100;
    }
    
    function getMobileInformation(address mobile) public constant returns(bytes, uint256, string, bool, uint256) {
        return (plate, initialFund, driverName, isLock, timestamp);
    }
    
    function getInvesterRatio() public constant returns(uint256) {
        return 5;
    }
    
    function repay(address mobile, address[] _investors) {
        uint totalAmount = getProfitValue(mobile);
        // determine the caller is investor or not.
        
        // repay all the money to every invenstor
        for (uint i = 0; i <  _investors.length; i++) {
            // check what ratio do the investor get.
            // investors[0] for company investors[1] for passenger, investors[2] and other are investors...
            if(i==0) {
                _investors[i].transfer(totalAmount * 5);
            } else if (i==1) {
                _investors[i].transfer(totalAmount * 45);
            } else{
                // check the investor's ratio
                _investors[i].transfer(totalAmount * 50);
            }
        }
    }
}