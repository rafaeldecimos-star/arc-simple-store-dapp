// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleStore {
    string private message;
    address public owner;

    event MessageUpdated(address indexed sender, string newMessage);

    constructor(string memory initialMessage) {
        owner = msg.sender;
        message = initialMessage;
    }

    // Função para ler a mensagem salva
    function getMessage() public view returns (string memory) {
        return message;
    }

    // Função para atualizar a mensagem na blockchain
    function setMessage(string memory newMessage) public {
        message = newMessage;
        emit MessageUpdated(msg.sender, newMessage);
    }
}
