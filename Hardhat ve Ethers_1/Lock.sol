// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Token.sol";
contract Lock {
    BEEToken Token;
    uint256 public lockerCount;
    uint256 public totalLokced;
    mapping(address => uint256) public lockers;
    
    constructor(address tokenAddress){
        Token = BEEToken(tokenAddress);

    }

    function lockTokens(uint256 amount) external {
        require(amount > 0,"Token amount must be bigger than 0 .");
        // require(Token.balanceOf(msg.sender)>=amount , "Inssufficient balance");
        // require(Token.allowance(msg.sender, address(this))>=amount,"Inssufficient allowance");

        if(!(lockers[msg.sender] > 0)) lockerCount++;
        totalLokced +=amount;
        lockers[msg.sender] += amount;
        
        bool ok = Token.transferFrom(msg.sender, address(this), amount);

        require(ok,"Transfer failed");


    }
    function withdrawTokens() external{
        require(lockers[msg.sender] > 0,"Not enough Token.");
        uint256 amount = lockers[msg.sender];
        delete(lockers[msg.sender]);
        totalLokced -=amount;
        lockerCount --;

        require(Token.transfer(msg.sender, amount),"Transfer failed");


    }

}