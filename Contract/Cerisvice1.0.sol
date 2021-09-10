//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.3;

import "./Owner.sol";

contract Certsvice is Owner{
    
    struct universityName{
        string name;
        bool isAvailable;
    }
    
    struct certificate{
        string hash;
    }

    
  mapping(address => universityName) private university;
  mapping(string => certificate) private student;

  
  function addUniversity(address _university,string memory _universityName) public isOwner{
      string memory uname = university[_university].name;
      bool status = university[_university].isAvailable;
      bool checkDelete = keccak256(abi.encodePacked(uname)) != keccak256(abi.encodePacked("_deleted"));
      require(checkDelete,"This address has been delete");
      require(status == false,"this address is already in use");
      university[_university] = universityName(_universityName,true);
  }
  
  function deleteUniversity(address _university) public isOwner{
      require(university[_university].isAvailable == true,"This university not registry");
      university[_university] = universityName("_deleted",false);
  }
  
  function getUniversity(address _university) public view returns(string memory){
      require(university[_university].isAvailable == true,"This university not registry");
      return university[_university].name;
  }
  
  function addStudent(string memory id,string memory hash) public{
      
  }
}