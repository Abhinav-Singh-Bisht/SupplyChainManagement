// SPDX-License-Identifier: MIT

pragma solidity  >=0.7.0 <0.9.0;
import "./Roles.sol";

// We will make a retailer contract which will hold the adding , removing of the consumer

contract Retailer{

    // using Roles for Role;
    using Roles for Roles.Role;
    
    event RetailerAdded(address indexed _account);
    event RetailerRemoved(address indexed _account);

    Roles.Role private retailer;

    // to check whether the given account is listed as a retailer or not
    function isRetailer(address _account) public view returns(bool){
        return Roles.hasRole(retailer, _account);
    }


    // to add the given account to the retailer list
    function addRetailer(address _account) public {
        Roles.addRole(retailer, _account);
        emit RetailerAdded(_account);
    } 

    //  to remove the given account from the retailer list
    function removeRetailer(address _account) public{
        Roles.removeRole(retailer, _account);
        emit RetailerRemoved(_account);
    }
    
}