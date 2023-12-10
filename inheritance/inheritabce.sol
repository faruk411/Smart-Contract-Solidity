// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract A{
    uint public x;
    uint public y;

    //virtual
    function setX(uint _x) virtual  public {
        x= _x;
    }
    function setY(uint _y) public {
        y=_y;
    }
}

//override

contract B is A{
    uint public z;

    function setZ(uint _z) public {
        z = _z;
    }
    function setX(uint _x) override public {
        x = _x + 2;
    }
}

contract Human{
    function sayHello() public pure virtual returns(string memory){
        return "hititBlockchain.com adresi uzerinden klube uye olabilirsiniz ";
    }
}
contract superHuman is Human{
    function sayHello() public pure override returns(string memory){
        return "selamlar hitit uyesi nasilsin";
    }
    function welcomeMsg(bool isMember) public pure returns(string memory){
        return isMember ? sayHello() : Human.sayHello();
    }
}

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Wallet is Ownable {
    constructor() Ownable(msg.sender) { }
    fallback() external payable { }
    function sendEther(address payable to, uint amount) onlyOwnerr public {
        to.transfer(amount);
    }
    function showBallance() public view returns(uint){
        return address(this).balance;
    }
    modifier onlyOwnerr(){
        require(owner() == _msgSender(), "Ownable : caller is not the owner");
        _;
    }
}