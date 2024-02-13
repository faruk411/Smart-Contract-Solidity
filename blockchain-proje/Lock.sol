// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Token.sol";
import "hardhat/console.sol";
contract Lock {
    BEEToken Token;
    uint256 public lockerCount;
    uint256 public totalLokced;
    mapping(address => uint256) public lockers;
    mapping(address => uint256) public deadline;
    
    constructor(address tokenAddress){
        Token = BEEToken(tokenAddress);

    }

    function lockTokens(uint256 amount, uint256 time) external {
        require(amount > 0,"Token amount must be bigger than 0 .");
        require(time > 0,"locking time must be bigger than 0 .");
        // require(Token.balanceOf(msg.sender)>=amount , "Inssufficient balance");
        // require(Token.allowance(msg.sender, address(this))>=amount,"Inssufficient allowance");

        if(!(lockers[msg.sender] > 0)) lockerCount++;
        totalLokced +=amount;
        lockers[msg.sender] += amount;
        deadline[msg.sender] = block.timestamp + time;
        
        bool ok = Token.transferFrom(msg.sender, address(this), amount);

        require(ok,"Transfer failed");


    }
    function withdrawTokens() external{
        require(lockers[msg.sender] > 0,"Not enough Token.");
        require(block.timestamp >= deadline[msg.sender],"Deadline is not over ");

        uint256 amount = lockers[msg.sender];
        console.log("<><><>",msg.sender, amount);

        delete(lockers[msg.sender]);
        delete(deadline[msg.sender]);
        
        totalLokced -=amount;
        lockerCount --;

        require(Token.transfer(msg.sender, amount),"Transfer failed");


    }

}