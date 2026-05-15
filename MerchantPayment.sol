// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MerchantPayment {
    address public merchant;
    
    struct Transaction {
        address customer;
        uint256 amount;
        uint256 timestamp;
        string orderId;
    }

    Transaction[] public transactions;

    event PaymentSent(address indexed customer, uint256 amount, string orderId);

    constructor() {
        // The person who deploys the contract is the merchant
        merchant = msg.sender;
    }

    // Function to pay the merchant
    function pay(string memory _orderId) public payable {
        require(msg.value > 0, "Payment must be greater than 0");
        
        // This line sends the money to the merchant
        payable(merchant).transfer(msg.value);

        // This line records the receipt
        transactions.push(Transaction({
            customer: msg.sender,
            amount: msg.value,
            timestamp: block.timestamp,
            orderId: _orderId
        }));

        emit PaymentSent(msg.sender, msg.value, _orderId);
    }
// ...

        emit PaymentSent(msg.sender, msg.value, _orderId);
    }

    // Function to check total transactions
    function getTransactionCount() public view returns (uint256) {
        return transactions.length;
    }
}