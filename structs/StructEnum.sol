// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StructEnum{

    enum Status{
        Taken,//0
        Preparing,//1
        Boxed,//2
        Shipped//3
    }
     struct Order{
        address customer;
        string zipCode;
        uint256[] product;
        Status status;
     }
    Order[] public orders;

    address public owner;

    constructor(){
        owner = msg.sender;
    }

    function creatOrder(string memory _zipCode, uint256[] memory _products) external  returns (uint256){
        require(_products.length > 0 , "No products");

        Order memory order;
        order.customer = msg.sender;
        order.zipCode  = _zipCode;
        order.product  = _products;
        order.status   = Status.Taken;
        orders.push(order);

        // orders.push(
        //     Order({
        //         customer : msg.sender,
        //         zipCode  : _zipCode,
        //         product  : _products,
        //         status   : Status.Taken
        //     })
        // );

        //orders.push(Order(msg.sender, _zipCode, _products, Status.Taken));

        return orders.length -1; 
    } 
    function advencerOrder(uint256 _orderId) external    {

        require(owner == msg.sender, " you are not authorized");
        require(_orderId < orders.length, "Not a valid order id");

        Order storage order = orders[_orderId];
        require(order.status != Status.Shipped, "Order is already shipped");

        if(order.status == Status.Taken){
            order.status = Status.Preparing;
        }else if(order.status == Status.Preparing){
            order.status = Status.Boxed;
        }else if(order.status == Status.Boxed){
            order.status = Status.Shipped;
        }


    }
    function getOrder(uint256 _orderId) external  view returns (Order memory){

        require(_orderId < orders.length, "Not a valid order id");
        return orders[_orderId];

    }
    function updateZip(uint256 _orderId, string memory _zip) external  {
        require(_orderId < orders.length, "Not a valid order id");
        Order storage order = orders[_orderId];
        require(order.customer == msg.sender, " you are not the owner");
        order.zipCode = _zip;
    }

}