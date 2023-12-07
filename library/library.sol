// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Math{

    function plus(uint256 x, uint256 y ) public  pure returns (uint){
        return x+y;
    }
    function minus(uint256 x, uint256 y ) public  pure returns (uint){
        return x-y;
    }
    function multi(uint256 x, uint256 y ) public  pure returns (uint){
        return x*y;
    }
    function divide(uint256 x, uint256 y ) public  pure returns (uint){
        require(y!=0,"taban 0 olamaz !!!");
        return x/y;
    }

    function min(uint256 x, uint256 y ) public  pure returns (uint){
        if(x<=y){
            return x;
        }else{
            return y;
        }
    }
    function max(uint256 x, uint256 y ) public  pure returns (uint){
        if(x>=y){
            return x;
        }else{
            return y;
        }
    }

}

library Search{

    function indexOf(uint[] memory list, uint data) public pure returns (uint){
        for(uint i=0; i<list.length; i++){
            if(list[i]==data){
                return i;
            }
        }
        return list.length;
    }

}

library Human{

    struct Person{
        uint age;
    }

    function birthday(Person storage _person) public {
        _person.age +=1;
    }
    function show(Person storage _person) public view returns (uint){
        return _person.age;
    }
}

contract Library{

    //using Math for uint;

    function toplama(uint x, uint y) public pure returns (uint){
        return Math.plus(x,y);
    } 
    function cikarma(uint x, uint y) public pure returns (uint){
        return Math.minus(x,y);
    } 
    function carpma(uint x, uint y) public pure returns (uint){
        return Math.multi(x,y);
    } 
    function bolme(uint x, uint y) public pure returns (uint){
        return Math.divide(x,y);
    } 
    function enbuyuk(uint x, uint y) public pure returns (uint){
        return Math.max(x,y);
    } 
    function liste(uint[] memory x, uint y) public pure returns (uint){
        return Search.indexOf(x,y);
    }

}
contract HumanContract{
    mapping (uint => Human.Person) people;

    function newYear() public {
        Human.birthday(people[0]);
    }
    function showYear() public view returns(uint){
        return Human.show(people[0]);
    }
}