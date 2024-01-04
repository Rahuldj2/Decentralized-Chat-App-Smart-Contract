// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedChat {
    address public owner;
    mapping(address => string) public usernames;
    mapping(address => mapping(address => string[])) public messages;

    event MessageSent(address indexed sender, address indexed receiver, string message);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function setUsername(string memory _username) external {
        usernames[msg.sender] = _username;
    }

    function sendMessage(address _receiver, string memory _message) external {
        require(bytes(usernames[msg.sender]).length > 0, "You need to set a username first");
        require(bytes(usernames[_receiver]).length > 0, "The receiver needs to set a username first");

        messages[msg.sender][_receiver].push(_message);
        emit MessageSent(msg.sender, _receiver, _message);
    }

    function getMessages(address _sender, address _receiver) external view returns (string[] memory) {
        return messages[_sender][_receiver];
    }
}
