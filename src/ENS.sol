// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ENS {
    struct User {
        address account;
        bytes32 name;
        string image;
    }
    mapping(address => User) user;
    mapping(bytes32 => User) userB;
    mapping(bytes32 => bool) isRegisteredName;
    mapping(address => bool) isRegisteredAddress;

    User[] userArray;

    event Registeration(
        address indexed sender,
        bytes32 indexed username,
        string image
    );
    event ManageAccount(bytes32 indexed username, string image, bool);

    function registarUser(
        bytes32 _name,
        string calldata _img
    ) public returns (bool successful) {
        require(!isRegisteredName[_name], "username already exist");

        User storage acct = user[msg.sender];

        User storage mapName = userB[_name];

        acct.name = _name;
        acct.account = msg.sender;
        acct.image = _img;

        mapName.name = _name;
        mapName.account = msg.sender;
        mapName.image = _img;
        isRegisteredName[_name] = true;
        isRegisteredAddress[msg.sender] = true;
        successful = true;

        userArray.push(acct);

        emit Registeration(msg.sender, _name, _img);
    }

    function getAllUsers()view external returns(User[]memory) {
        return userArray;
        
    }

    function manageAccount(
        bytes32 _OldName,
        bytes32 _newName,
        string calldata _img
    ) external {
        require(isRegisteredName[_OldName], "User does not exist");

        User storage mapName = userB[_newName];
        User storage acct = user[msg.sender];
        require(msg.sender == acct.account, "Not your account");

        acct.name = _newName;
        acct.image = _img;
        acct.account = msg.sender;

        mapName.name = _newName;
        mapName.image = _img;
        mapName.account = msg.sender;

        emit ManageAccount(_newName, _img, true);
    }

    function getUserByName(bytes32 _name) public view returns (User memory) {
        require(
            isRegisteredName[_name],
            "User not found, check for any typo-error"
        );
        User memory mapName = userB[_name];

        return mapName;
    }

    function getUserByAddress(
        address account
    ) public view returns (User memory) {
        require(account != address(0), "No zero address call");
        User memory acct = user[account];

        return acct;
    }

    function getIsRgisteredAddress() external view returns(bool){
        return isRegisteredAddress[msg.sender];
    }
}