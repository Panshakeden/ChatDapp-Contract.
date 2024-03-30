// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {ChatAppilcation} from "../src/ChatAppilcation.sol";
import {ENS} from "../src/ENS.sol";

contract Chat is Test {
    ChatAppilcation public chat;
    ENS public ens;

    address A = address(0xa);
    address B = address(0xb);

    string img = "img-url";
    bytes Name = abi.encodePacked("paul");
    bytes Name2 = abi.encodePacked("peter");
    string imgUrl =string(img);

    function setUp() public {
        ens = new ENS();

        chat = new ChatAppilcation(address(ens));

        A = mkaddr("user a");
        B = mkaddr("user b");
    }

    function test()public{
        ens.registarUser(bytes32("javis"),"img");
        assertEq(ens.getIsRgisteredAddress(),true);
    }

    // function test_ensRegisteration() public {
    //     ens.registarUser(bytes32(Name), string(imgUrl));
    //     assert(true);
    // }

    // function test_revertCase_manageAccount() public {
    //     vm.expectRevert("User does not exist");
    //     ens.manageAccount(bytes32(Name), bytes32(Name2), string(imgUrl));
    // }

    // function test_changeOn_manageAccount() public {
    //     switchSigner(A);
    //     ens.registarUser(bytes32(Name), string(imgUrl));
    //     ens.manageAccount(bytes32(Name), bytes32(Name2), string(imgUrl));

    //     assertEq(ens.getUserByAddress(address(A)).name, bytes32(Name2));
    // }

    // function test_revertCase_getUserByName() public {
    //     ens.registarUser(bytes32(Name), string(imgUrl));
    //     vm.expectRevert("User not found, check for any typo-error");
    //     ens.getUserByName(bytes32(Name2));
    // }

    // function test_UserByNameEqualGetUserAddress() public {
    //     ens.registarUser(bytes32(Name), string(imgUrl));
    //     address account = ens.getUserByName(bytes32(Name)).account;

    //     assertEq(
    //         ens.getUserByAddress(account).name,
    //         ens.getUserByName(bytes32(Name)).name
    //     );
    // }

    // function test_chatRevertCase2_registeration() public {
    //     switchSigner(A);
    //     ens.registarUser(bytes32(Name), string(imgUrl));
    //     chat.registeration(bytes32(Name));
    //     switchSigner(B);
    //     vm.expectRevert("Username already exist");
    //     chat.registeration(bytes32(Name));
    // }

    // function test_sendMessage() public {
    //     switchSigner(A);
    //     ens.registarUser(bytes32(Name), string(imgUrl));
    //     chat.registeration(bytes32(Name));

    //     switchSigner(B);
    //     ens.registarUser(bytes32(Name2), string(imgUrl));
    //     chat.registeration(bytes32(Name2));
    //     chat.sendMessage(bytes32(Name), "Hi");

    //     switchSigner(A);
    //     chat.sendMessage(bytes32(Name2), "Hello");

    //     chat.getChatHistory(bytes32(Name2));
    //     assertEq(chat.getChatHistory(bytes32(Name2))[0].sentMessage, "Hello");
    //     assertEq(chat.getChatHistory(bytes32(Name2))[0].receiveMessage, "Hi");
    // }


    //    function testFail_sendMessage() public {
    //     switchSigner(A);
    //     ens.registarUser(bytes32(Name), string(imgUrl));
    //     chat.registeration(bytes32(Name));

    //     switchSigner(B);
    //     ens.registarUser(bytes32(Name2), string(imgUrl));
    //     chat.registeration(bytes32(Name2));
    //     chat.sendMessage(bytes32(Name), "Hi");

    //     switchSigner(A);
    //     chat.sendMessage(bytes32(Name2), "Hello");

    //     chat.getChatHistory(bytes32(Name2));
    //     assertEq(chat.getChatHistory(bytes32(Name2))[0].sentMessage, "Hello");
    //     assertEq(chat.getChatHistory(bytes32(Name2))[0].receiveMessage, "H");
    // }

    function mkaddr(string memory nam) public returns (address) {
        address addr = address(
            uint160(uint256(keccak256(abi.encodePacked(nam))))
        );
        vm.label(addr, nam);
        return addr;
    }

    function switchSigner(address _newSigner) public {
        address foundrySigner = 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38;
        if (msg.sender == foundrySigner) {
            vm.startPrank(_newSigner);
        } else {
            vm.stopPrank();
            vm.startPrank(_newSigner);
        }
    }
}

