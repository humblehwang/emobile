pragma solidity ^0.4.16;
import "./Math.sol";

// Every mobile has their own contract name !
contract Emobile {  
    bytes plate;      // mobile license-plate
    uint256 initialFund;     // Gogoro2 price : 60000
    uint256 timestamp;
    string driverName;
    address driverAddress;
    bool isLock;

    struct Investors {
        bytes32 name;  // (up to 32 bytes)
        uint256 funds; // check how many amount the investor send 
    }
    
    mapping(address => Investors) public investorsStruct;
    address[] investorsList; // list of question keys so we can enumerate them

    
    function setDriver(string _driverName) public {
        driverName = _driverName;
    }
    
    function setInvestors(address _investor, bytes32 _investorName, uint256 _fund) public returns(bool) {
        investorsList.push(_investor);
        investorsStruct[_investor].name = _investorName;
        investorsStruct[_investor].funds = _fund;
        
        return true;
    }
    
    function getProfitValue() public constant returns(uint) {
        // return the profit of contract of emobile.
        return address(this).balance;
    }
    
    function getMobileInformation(address mobile) public constant returns(bytes, uint256, string, bool, uint256) {
        return (plate, initialFund, driverName, isLock, timestamp);
    }
    
    function repay(address[] _investors) {
        uint totalAmount = getProfitValue();
        // determine the caller is investor or not.
        
        // repay all the money to every invenstor
        for (uint i = 0; i <  _investors.length; i++) {
            // check what ratio do the investor get.
            // investors[0] for company investors[1] for passenger, investors[2] and other are investors...
            
            if(i==0) {
                _investors[i].transfer(Math.mul(totalAmount, Math.div(5, 100)));

            } else if (i==1) {
                _investors[i].transfer(Math.mul(totalAmount, Math.div(45, 100)));
            } else{
                // check the investor's ratio
                uint ratio = Math.div(investorsStruct[_investors[i]].funds, initialFund);
                _investors[i].transfer(Math.mul(totalAmount, ratio));
            }
        }
    }
    
    function () payable {
    }
}