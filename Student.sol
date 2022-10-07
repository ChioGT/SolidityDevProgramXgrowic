// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.13;

contract Student {
    
    //struct of students details
    struct studentDetails {
        address studentID;
        uint256 percentage;
        uint256 totalMarks;
    }

    address public owner;
    mapping (address => studentDetails) studentsList;

    //constructor
    constructor () {
        owner = msg.sender;
    }

    //modifier onlyOwner
    modifier onlyOwner {
      require(msg.sender == owner, 'The sender is not the owner');
      _;
    }

    // modifier Make sure that student cannot register twice
    modifier notRegisterTwice(address _id) {
        if (getStudentDetails(_id).studentID != address(0)) {
            revert('Already, the student is register');
        }
        _;
    }
   
    // get student detail
    function getStudentDetails(address _id) public view returns (studentDetails memory)
    {
        return studentsList[_id];
    }

    //register student
    function register( address _studentID, uint256 _percentage, uint256 _totalMarks) public onlyOwner notRegisterTwice(_studentID) 
    {
        studentDetails memory newStudent = studentDetails(_studentID, _percentage, _totalMarks);
        studentsList[_studentID] = newStudent;
    }

}
