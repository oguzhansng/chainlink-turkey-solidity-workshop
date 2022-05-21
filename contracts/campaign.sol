// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract ProjectFunding {

    string public name ;
    address public owner;
    string public description;
    uint public minimumContribution;
    mapping (address => bool ) public contributer;
    uint public contributerCount;
    //address [] public contributer;

    Request [] public request;

    struct Request {
        string description;
        uint value;
        address recipient;
        bool completed;
        uint approversCount;
        mapping(address => bool) approvers; 
    

    }

    modifier onlyOwner () {
        require (owner == msg.sender,"not allowed");
        _;

    }
      


    constructor ( string memory _name, string memory  _description,  uint _minimumContribution) {
        owner = msg.sender;
        name = _name;
        description = _description;
        minimumContribution = _minimumContribution;

    }

    function contribute() public payable  {
        require(msg.value >= minimumContribution,"not min value");
        //require(contributer[msg.sender]== false, "already added");
        contributer[msg.sender] = true ;
        contributerCount ++;
        //contributer.push(msg.sender);


    }

    function createRequest (string calldata _description,uint _value, address _recipient) public onlyOwner {
        Request storage newRequest = request.push();
        newRequest.description = _description;
        newRequest.value = _value;
        newRequest.recipient = _recipient;
        newRequest.completed = false;
        newRequest.approversCount = 0;

    }

    function approveRequest (uint _index) public {
        require(contributer[msg.sender],"not funder");
        Request storage crequest = request[_index] ;
        require(crequest.approvers[msg.sender]== false && crequest.completed== false,"already approved");
        crequest.approvers[msg.sender] = true;
        crequest.approversCount;
    }


    function finilizeRequest (uint _index) public onlyOwner {
        
        Request storage crequest = request[_index] ;
        require(!crequest.completed== false,"already approved");
        require(crequest.approversCount > contributerCount/2, "not enough approve");
        crequest.completed = true ;
        
        payable (crequest.recipient).transfer(crequest.value);

    }

}