//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract Function{
    
    uint x = 3;
    uint public  luckynumber = 7;
     function showNumber() public view returns (uint){

         return luckynumber; 

   }
   function setNumber(uint newNumber) public {

    luckynumber = newNumber;

   }

   function nothin() public pure returns(uint a,bool y,bool z){

    a = 8;
    y= true;
    z = false;

   }

   function setX(uint y) public view returns (uint){

    uint e = x+y;
    return e;
    

   }

   function add(uint a1,uint b1) public view returns (uint){

    return a1 + b1 + block.timestamp;

   }

    function add2(uint a, uint b) public pure returns (uint){

        return a+b;

    }
    // public : her yerden erişilebilir
    function add3(uint a, uint b) public pure returns (uint){

        return a+b;

    }

    function add4(uint c, uint d) public pure returns (uint){

        return add3(c, d);

    }
    function keyboard() public pure returns (string memory){
        
        return "bu bir fonksiyon";
        
    }
    function keyboardreturn() public pure returns (string memory){
        return keyboard();
    }
    
    // private : bu fonksiiyona sadece bu contracta ulaşılabilir , dışardan ulaşılamaz

    function privateFuntion() private pure returns (string memory){
        return "bu bir private fonksiyondur";
    }
    // internal : sadece miras alan contractlar bu fonksiyonu görebilir bunlar public fonksiyon ile ulaşılabilir
    function internalFonksiyon() internal pure returns (string memory){
        return "bu bir internal fonksiyondur";
    }
    // external : dışardan çağırabilir contract içinden çağrılamaz

    function externalFunction() external pure returns (string memory){
        return  "bu bir external fonksiyondur";
    }
}
