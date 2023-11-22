// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract Veriables {

    int8 number = 8;
    address myAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    bytes32 name  = "omer";
    // dizi
    uint[] array = [1,2,3,45,6];

    mapping(uint => address) public list;

    struct Human{
        uint Id;
        string name;
        uint age;
        address adres;
    }
    mapping (uint => Human) public  list2;

    //Human public  person1;
    //person1.Id = 1;
    //person1.name = "omer";
    //person1.age = 20;

    enum trafficlight{
        RED,
        YELLOW,
        GREEN
    }

    //trafficlight.GREEN;

    string public bestclub = "hitit blockchain";
    
    function show() public view returns (string memory){
        return bestclub;
    }

    function show2() public view returns (uint){
        block.difficulty;
        block.gaslimit;
        return block.number;
    }

   


 }