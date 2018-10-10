pragma solidity ^0.4.24;
pragma experimental ABIEncoderV2;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";


contract Form is Ownable {
    struct Message {
        string body;
        string email;
        address sender;
        uint createdAt;
    }

    uint public messagesIndex;
    Message[] private messages;

    function sendApplication(string _body, string _email) external {
        messages[messagesIndex] = Message({
            body: _body,
            email: _email,
            sender: msg.sender,
            createdAt: now
        });
        messagesIndex++;
    }

    function getMessages() public onlyOwner view returns (Message[]) {
        return messages;
    }

    function getMessage(uint _messagesIndex) public onlyOwner view returns (Message) {
        return messages[_messagesIndex];
    }
}