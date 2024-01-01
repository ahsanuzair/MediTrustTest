// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Campaign{

    struct Request{
        string description;
        uint value;
        address recipient;
        bool complete;
    }

//create instance of Request struct for use in contract
    Request[] public requsts;

    address public manager;
    uint public minimumContribution;

    address[] public approvers;

//modifier to check the manager address
    modifier restricted(){
        require(msg.sender == manager);
        _;
    }

//set address of manager and mincontribution value is passed on deploy time
    constructor (uint minimum)  {
        minimumContribution = minimum;
        manager = msg.sender;
    }

//when someone wants to send money to our contract
    function contribute() public payable {
        require(msg.value >= minimumContribution);

        approvers.push(msg.sender);
    }

// create request for donation, checks its only by manager, and add it to reuests array
    function createRequest(string memory description, uint value, address recipient) public restricted {
        Request memory newRequest = Request({
            description: description,
            value: value,
            recipient: recipient,
            complete: false
        });

        requsts.push(newRequest);

    }
}
