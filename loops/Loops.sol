// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Loops{

    uint256[15] public numbers0;
    uint256[15] public numbers1;

    function listByfor() public{
        uint[15] memory nums = numbers0;
        for(uint256 i =0 ; i< nums.length ; i++){
            nums[i] = i;
        }
        numbers0 = nums;
    }
    function getAll() public view returns (uint256[15] memory){
        return numbers0;
    }

    function whileDongusu() public {
        uint256 i=0;
        
        while (i<numbers1.length){
            numbers1[i] = i;
            i++;
        }
        
    }
    function getall1() public view returns (uint256[15] memory){
        return numbers1;
    }

}