// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Errors{

    uint256 public totalBalance;
    mapping (address=>uint256 ) public userBalance;

    error ExceeddingAmount(address user , uint256 exceeddingAmount);
    error Deny(string reason);

    receive() external payable { 
        revert Deny("No direct payments.");
    }
    fallback() external payable {
        revert Deny("No direct payments.");
    }

    function pay() noZero(msg.value) external payable {
        require(msg.value == 1 ether,"Only payments in 1 ether");

        totalBalance +=1;
        userBalance[msg.sender] +=1 ether;

    }
    function withdraw(uint256 _amount) noZero(_amount)   external {
        uint256 initialBalance = totalBalance;
        //require(userBalance[msg.sender]>=_amount,"Insifficient balance ");
        if(userBalance[msg.sender] < _amount){
            //revert("Insifficient balance");
            revert ExceeddingAmount(msg.sender, _amount-userBalance[msg.sender]);
        }
        totalBalance -= _amount;
        userBalance[msg.sender] -= _amount;
        // address => address payable
        payable(msg.sender).transfer(_amount);

        assert(totalBalance < initialBalance);

    }
    modifier noZero (uint256 _amount){
        require(_amount !=0);
        _;
    }

}