// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;


//Deploy contract address 
//0x5FbDB2315678afecb367f032d93F642f64180aa3s

// Uncomment this line to use console.log
import "hardhat/console.sol";

contract BuyMeACoffee {
    //Event for an memo

    event NewMemo(
        address indexed from,
        uint256 timeStamp,
        string name,
        string message
    );

    struct Memo{
        address from;
        uint256 timeStamp;
        string name;
        string message;
    }

    //list of all memos received from friends.

    Memo[] memos;

    address payable owner;

    constructor(){
        owner = payable(msg.sender);
    }

    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0,"Can't buy an coffee with 0 eth");

        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        emit NewMemo(
            msg.sender,
            block.timestamp, 
            _name,
             _message
            );
    }

    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }

}
