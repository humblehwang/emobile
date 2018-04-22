pragma solidity ^0.4.16;
import "./Emobile.sol";

contract Send {

   function payCoinForDriver(address _emobile, uint256 _price) payable returns(bool) {
        address emobile = _emobile;
        // check whether the passenger has enough ether or not.
        require(msg.value > 0);
        // input the mobile and passenger's address
        // and caculated the milage and get price
        bool res = emobile.send(_price);
        return res;
    }
    
    function investForDriver(address _emobile, bytes32 _investorName, uint256 _fund) payable returns(bool) {
        // msg.sender, william, 10
        Emobile emobile= new Emobile();
        
        // delegate the specific emobile contract address, and then saving the investors information.
        // need record what fund the investor send.
        emobile.setInvestors(msg.sender, _investorName, _fund);
        // send to specific emobile address.
        bool res = _emobile.send(_fund);
        return res;
    }
}