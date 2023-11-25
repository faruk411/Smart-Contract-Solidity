// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IFelse {

    bytes32 private hashedPassword;
    uint256 private loginCount;

    constructor(string memory _password){
        hashedPassword = keccak256(abi.encode(_password));
    }
    function login(string memory _password) public  returns (bool){
        if(hashedPassword == keccak256(abi.encode(_password))){
            loginCount +=1;
            return true;
        }else{
            return false;
        }

        // return hashedPassword == keccak256(abi.encode(_password)));
    

    }
    function login2(string memory _password) public view  returns (uint){
      
        if(hashedPassword == keccak256(abi.encode(_password))){
            return 1;
        }
        else{
            return 0;
        }
        
        // return hashedPassword == keccak256(abi.encode(_password)) ? 1:0);
    }
    function loginStatus() public view returns (uint256){
        if(loginCount==0){
            return 0;
        }else if(loginCount > 0 && loginCount!=1){
            return 1;

        }else if(loginCount == 1){

            return 2;
        }else{
            return 3;
        }
    }

}