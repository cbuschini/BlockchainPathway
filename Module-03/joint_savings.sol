// Joint Savings Account

pragma solidity ^0.5.0;

// Define a new contract named `JointSavings`
contract JointSavings {

    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;
    
    // Withdraw function
    function withdraw(uint amount, address payable recipient) public {
        
        // Only owners can withdraw && Enough fund required in contract to withdraw
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");
        require(address(this).balance >= amount, "Insufficient funds!");

        // Save last withdrawal recipient
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }

        // Call the `transfer` function of the `recipient` and pass it the `amount` to transfer as an argument.
        recipient.transfer(amount);

        // Set  `lastWithdrawAmount` equal to `amount`
        lastWithdrawAmount = amount;

        // Update contract balance
        contractBalance = address(this).balance;
    }

    // Deposit function
    function deposit() public payable {

        // Update contract balance
        contractBalance = address(this).balance;
    }

    // Set Account function
    function setAccounts(address payable account1, address payable account2) public {

        // Set the values of `accountOne` and `accountTwo` to `account1` and `account2` respectively.
        accountOne = account1;
        accountTwo = account2;
    }

    // Fallback function
    function() external payable {}
}
