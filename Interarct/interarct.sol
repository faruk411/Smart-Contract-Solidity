// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Interarct{
    address public caller;
    mapping (address => uint256) public counts;

    function callThis() external {
        caller = msg.sender;
        counts[msg.sender]++;
    }
}

contract Pay{
    mapping (address => uint256) public userBallnaces;

    function payEth(address _pay) external payable {
        userBallnaces[_pay] +=msg.value;
    }
}

contract Caller{
    Interarct interarct;
    constructor(address _interarctContract){
        interarct = Interarct(_interarctContract);
    }
    function callInterarct() external {
        interarct.callThis();
    }
    function readCaller() external view returns(address){
        return interarct.caller();
    }
    function readCallerCount() public view returns (uint256){
        return interarct.counts(msg.sender);
    }
    function payTopay(address _payAddress) public payable {
        Pay pay = Pay(_payAddress);
        pay.payEth{value : msg.value}(msg.sender);

        //Pay(_payAddress).payEth{value : msg.value}(msg.sender);

    }
    function sendEthByTransfer() public payable {
        payable(address(interarct)).transfer(msg.value);
    }
}