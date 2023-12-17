// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VaultFactory{

    mapping(address => Vault[]) public UserVaults;

    function CreateVault() external {
        Vault vault = new Vault(msg.sender);
        UserVaults[msg.sender].push(vault);
    }
    function createVaultWithPayment() external payable {
        Vault vault = (new Vault){value:msg.value}(msg.sender);
        UserVaults[msg.sender].push(vault);
    }
}

contract Vault {
    address public owner;
    uint256 private  balance;

    constructor(address _owner) payable {
        owner = _owner;
        balance +=msg.value;
    }
    fallback() external payable {
        balance += msg.value;
     }
    receive() external payable  {
        balance += msg.value;
     }


    function deposit() external payable {
        balance += msg.value;
    }

    function getBalance() external view returns(uint256){
        return balance;
    }

    function withdraw(uint256 _amount) external {
        require(msg.sender == owner, "you are not authorized");
        balance -= _amount;
        payable(owner).transfer(_amount);
    }
}