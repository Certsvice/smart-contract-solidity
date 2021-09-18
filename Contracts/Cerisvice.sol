//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.3;

import "./Owner.sol";

contract Certsvice is Owner{
    
    struct certificate{
        string hash;
    }

    
  mapping(address => string) private university;
  mapping(string => certificate) private student;

  
  function addUniversity(address _university,string memory _universityName) public isOwner{
      require(checkInuse(_university),"This address is already in use");
      university[_university] = _universityName;
  }
  
  function deleteUniversity(address _university) public isOwner{
      delete university[_university];
  }
  
  function getUniversity(address _university) public view returns(string memory){
      require(!checkInuse(_university),"This address has been delete or added yet");
      return university[_university];
  }
  
  function checkInuse(address _university) private view returns(bool){
      string memory uname = university[_university];
      bool check = keccak256(abi.encodePacked(uname)) == keccak256(abi.encodePacked(""));
      return check;
  }
  
  function addStudent(string memory id,string memory hash) public{
      
  }
}