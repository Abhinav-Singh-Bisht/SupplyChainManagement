// SPDX-License-Identifier: MIT

pragma solidity  >=0.7.0 <0.9.0;
import "./Roles.sol";

// We will make a consumer contract which will hold the adding , removing of the consumer

contract Customer{

    // using Roles for Role;
    using Roles for Roles.Role;
    
    event CustomerAdded(address indexed _account);
    event CustomerRemoved(address indexed _account);

    Roles.Role private customer;

    // to check whether the given account is listed as a customer or not
    function isCustomer(address _account) public view returns(bool){
        return Roles.hasRole(customer, _account);
    }


    // to add the given account to the customer list
    function addCustomer(address _account) public {
        Roles.addRole(customer, _account);
        emit CustomerAdded(msg.sender);
    } 

    //  to remove the given account from the customer list
    function removeCustomer(address _account) public{
        Roles.removeRole(customer, _account);
        emit CustomerRemoved(_account);
    }
    
}
