// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

struct Student{
    uint8 age;
    uint16 score;
    string name;
}
contract School{
    uint256 totalStudents = 0;
    mapping (uint256 => Student) students;

    function addStudent(string calldata name, uint8 age, uint16 score) external {
        uint256 currentId =  totalStudents++;
        students[currentId] = Student(age,score,name);
    }
    function chanceStudentInfoStroge(uint256 Id, string calldata newName, uint8 newAge, uint16 newScore ) external {
        Student storage currentStudent = students[Id];

        currentStudent.name = newName;
        currentStudent.age = newAge;
        currentStudent.score = newScore;
    }
    function chanceStudentInfoMemory(uint256 Id, string calldata newName, uint8 newAge, uint16 newScore ) external view   {
        Student memory currentStudent = students[Id];

        currentStudent.name = newName;
        currentStudent.age = newAge;
        currentStudent.score = newScore;
    }
    function getStudent(uint256 Id) external view  returns(string memory){
        return students[Id].name;
    }
}
