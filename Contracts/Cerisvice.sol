//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.3;

import "./Owner.sol";

contract Certsvice is Owner {
    
    struct student{
        address issuer;
        string hash;
    }
    int private certificateId = 0;
    mapping(address => string) private universitys;
    mapping(int => student) private students;

    //reUseFunction
    function checkInuse(address _university) private view returns (bool) {
        string memory uname = universitys[_university];
        bool check = keccak256(abi.encodePacked(uname)) == keccak256(abi.encodePacked(""));
        //if check is false This address is already in use
        return check;
    }
    
    modifier isUnivesity() {
        require(!checkInuse(msg.sender), "This address  is not register");
        _;
    }
    
    //myFunction for university
    function addUniversity(address _university, string memory _universityName) public isOwner {
        require(checkInuse(_university), "This address is already in use");
        universitys[_university] = _universityName;
    }

    function deleteUniversity(address _university) public isOwner {
        delete universitys[_university];
    }

    function getUniversity(address _university) public isOwner view returns (string memory) {
        return universitys[_university];
    }
    
    
    //myFunction for add student
    function addStudent(string memory _hash) public isUnivesity returns(int){
        student memory newStudent = student(msg.sender,_hash);
        students[certificateId++] = newStudent;
        return certificateId;
    }
    function deleteStudent(int _id) public isUnivesity{
        delete students[_id];
    }
    function getStudent(int _id) public view returns (student memory){
        return  students[_id];
    }
    
}
