// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract GoodContract {
    mapping(address => uint256) public balances;

    // Update the `balances` mapping to include the new ETH deposited by msg.sender
    function addBalance() public payable {
        // Adding balance to the address through the mapping
        balances[msg.sender] += msg.value;
    }

    // Send ETH worth `balances[msg.sender]` back to msg.sender
    function withdraw() public {
        // Checking balance of sender
        require(balances[msg.sender] > 0);
        // Sending ETH back to sender
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        // Checking if sent !!
        require(sent, "Failed to send ether");
        // THis codes becomes unreachable because the contract's balance is drained
        // before user's balance could have been set to 0
        balances[msg.sender] = 0;
    }
}
