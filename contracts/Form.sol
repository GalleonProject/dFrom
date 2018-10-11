pragma solidity ^0.4.24;
pragma experimental ABIEncoderV2;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";


contract Form is Ownable {
    event NewApplicationRegistered(uint applicationID);

    enum ApplicationState {
        OPEN,
        DONE
    }

    struct Application {
        string body;
        string email;
        address sender;
        ApplicationState state;
        uint createdAt;
    }

    uint public applicationsCount;
    Application[] private applications;
    uint[] private applicationIDs;
    mapping (address => uint) private applicationIDsIndexedBySender;

    function sendApplication(string _body, string _email) external {
        uint _applicationID = applicationsCount;
        applicationsCount = applications.push(Application({
            body: _body,
            email: _email,
            sender: msg.sender,
            state: ApplicationState.OPEN,
            createdAt: now
        }));
        applicationIDs.push(_applicationID);
        applicationIDsIndexedBySender[msg.sender] = _applicationID;
        emit NewApplicationRegistered(_applicationID);
    }

    function getMyApplication() 
        public view 
        returns (
            string _body, 
            string _email, 
            ApplicationState _state, 
            uint _createdAt
            ) 
        {
        require(applicationIDsIndexedBySender[msg.sender] != 0, "Your application is not found.");
        uint _applicationID = applicationIDsIndexedBySender[msg.sender];
        Application memory _application = applications[_applicationID];
        _body = _application.body;
        _email = _application.email;
        _state = _application.state;
        _createdAt = _application.createdAt;
    }

    function getApplicationIDs() public onlyOwner view returns (uint[]) {
        return applicationIDs;
    }

    function getApplication(uint _applicationID) 
        public onlyOwner view 
        returns (
            string _body, 
            string _email, 
            address _sender, 
            ApplicationState _state, 
            uint _createdAt
            ) 
        {
        Application memory _application = applications[_applicationID];
        _body = _application.body;
        _email = _application.email;
        _sender = _application.sender;
        _state = _application.state;
        _createdAt = _application.createdAt;
    }
}