// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Chainlink1 {

    //variables
    string public word = "Hello";
    bytes32 public word1  = "Hello Byte";
    bytes2  public word2 = "Hi";

    uint8 public number=5;
    uint64 public bigNumber=55;
    address public myAddress ;

    bool data = false;
    uint[] public list = [1,2,3];
    string[] public stringList = ["Hello","world"];

    mapping(string => uint) public map;
    mapping(string => bool) public mapBool;

    address public sender;
    


    struct person  {
        string name;
        string lastname;
        uint8 age;

    }
    
    uint public balance = address(this).balance;

    address public owner;

    modifier onlyOwner () {
        require (owner == msg.sender,"not allowed");
        _;

    }

    constructor() {
        number = 10;
        owner = msg.sender;

    }

   
    uint8 public num = 255; //255 den fazla değer atayamayız (2^n)
    
    function increment () public {
        require(number<15,"number lower that 10");
        sender = msg.sender;
        number +=1;
        bigNumber +=1;

    }

    //function set (uint8 _number) public  returns(uint8) {
    //   bigNumber = _number;
    //    return _number;
        
    // }

    function addBalance () public payable onlyOwner {
        
        balance += msg.value;
    }

}