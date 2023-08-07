// SPDX-License-Identifier: MIT

pragma solidity  >=0.7.0 <0.9.0;
import "./Roles.sol";

// We will make a distributor contract which will hold the adding , removing of the consumer

contract Distributor{

    // using Roles for Role;
    using Roles for Roles.Role;
    
    event DistributorAdded(address indexed _account);
    event DistributorRemoved(address indexed _account);

    Roles.Role private distributor;

    // to check whether the given account is listed as a distributor or not
    function isDistributor(address _account) public view returns(bool){
        return Roles.hasRole(distributor, _account);
    }

    // to add the given account to the distributor list
    function addDistributor(address _account) public {
        Roles.addRole(distributor, _account);
        emit DistributorAdded(_account);
    } 

    //  to remove the given account from the distributor list
    function removeDistributor(address _account) public{
        Roles.removeRole(distributor, _account);
        emit DistributorRemoved(_account);
    }
    
}