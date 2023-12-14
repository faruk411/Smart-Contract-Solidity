// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EthSend{
    function _send(address payable to, uint256 amount) private {
        to.transfer(amount);
    }
    function sendWithStrategy(address strategyAddress) external {
        (address payable to,uint256 amount) = IStrategy(strategyAddress).getAddressAndAmount();
        _send(to,amount);
    }

    receive() external payable { }
}
abstract contract Strategy{
    function getAddressAndAmount() external virtual  pure returns (address payable , uint256); 
    
}

interface IStrategy {
    function getAddressAndAmount() external view  returns (address payable , uint256);
}

contract AddresStrategy1{
    uint256 constant ETHER_AMOUNT = 0.1 ether;
    function getAddressAndAmount() external pure returns(address payable , uint256){
        return(payable (0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2),ETHER_AMOUNT);
    }
}
contract AddresStrategy2{
    uint256 constant ETHER_AMOUNT = 0.1 ether;

    function getAddressAndAmount() external pure returns(address payable , uint256){
        uint256 amount = ETHER_AMOUNT*5;
        return(payable (0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2),amount);
    }
}
contract AddresStrategy3 is Strategy{

    uint256 constant ETHER_AMOUNT = 0.1 ether;

    function getAddressAndAmount() external pure override  returns(address payable , uint256){
        uint256 amount = ETHER_AMOUNT*5;
        return(payable (0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2),amount);
    }
}