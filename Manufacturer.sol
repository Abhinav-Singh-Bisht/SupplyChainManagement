// SPDX-License-Identifier: MIT

pragma solidity  >=0.7.0 <0.9.0;
import "./Roles.sol";

// We will make a manufacturer contract which will hold the adding , removing of the consumer

contract Manufacturer{

    // using Roles for Role;
    using Roles for Roles.Role;
    
    event ManufacturerAdded(address indexed _account);
    event ManufacturerRemoved(address indexed _account);

    Roles.Role private manufacturer;

    // to check whether the given account is listed as a manufacturer or not
    function isManufacturer(address _account) public view returns(bool){
        return Roles.hasRole(manufacturer, _account);
    }


    // to add the given account to the manufacturer list
    function addManufacturer(address _account) public {
        Roles.addRole(manufacturer, _account);
        emit ManufacturerAdded(_account);
    } 

    //  to remove the given account from the manufacturer list
    function removeManufacturer(address _account) public{
        Roles.removeRole(manufacturer, _account);
        emit ManufacturerRemoved(_account);
    }
    
}