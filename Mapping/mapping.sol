// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract Mapping{

    mapping(address => bool) public registered;
    mapping(address => int256) public favNums;

    function register(int256 _favNums) public {
        //require(!registered[msg.sender], "kullanici daha once kayit oldu");
        require(!isRegister(),"kullanici daha once kayit oldu");
        registered[msg.sender] =true;
        favNums[msg.sender] = _favNums;

    }
    function isRegister() public view returns (bool){

        return registered[msg.sender];
    }
    function deleteRegistered() public {
        require(isRegister() , "Kullanici kayitli degii");
        delete(registered[msg.sender]);
        delete(favNums[msg.sender]);
    }

}

contract NestredMapping{

    mapping(address => mapping(address => uint256)) public debts;

    function incDebt(address _borrower, uint256 _amount) public {
        debts[msg.sender][_borrower]+=_amount;
    }
    function decDebt(address _borrower, uint256 _amount) public {
        require(debts[msg.sender][_borrower] >= _amount, "Not enought debt");
        debts[msg.sender][_borrower]-= _amount;
    }
    function getDebts(address _borrower) public view returns (uint256){
        return debts[msg.sender][_borrower];
    }
}