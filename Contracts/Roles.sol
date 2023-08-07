// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

library Roles{

    struct Role{
        mapping(address => bool) list;
    }

    // to check if the given account has a role in the given list or not
    function hasRole(Role storage  _role,address _account) internal view returns(bool) {
        return _role.list[_account];
    }

    // The list of role they have sent , we added the given account from it now 
    //  this account have a role in this list
    function addRole(Role storage _role,address _account) internal {
        require(!hasRole(_role,_account));
        _role.list[_account] = true;
    }

    // The list of role they have sent , we removed the given account from it now 
    //  this account does not have a role in this list
    function removeRole(Role storage _role,address _account) internal{
        require(hasRole(_role,_account));
        _role.list[_account] = false;
    }
}