// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract LoanContract {
    struct Loan {
        address borrower;
        address lender;
        uint amount;
        uint interest;
        uint deadline;
        bool repaid;
    }

    Loan[] public loans;

    function createLoan(uint _amount, uint _interest, uint _deadline) external {
        loans.push(Loan(msg.sender, address(0), _amount, _interest, _deadline, false));
    }

    function fundLoan(uint index) external payable {
        Loan storage loan = loans[index];
        require(loan.lender == address(0), "Already funded");
        require(msg.value == loan.amount, "Incorrect amount");

        loan.lender = msg.sender;
        payable(loan.borrower).transfer(loan.amount);
    }

    function repayLoan(uint index) external payable {
        Loan storage loan = loans[index];
        require(msg.sender == loan.borrower, "Only borrower");
        require(!loan.repaid, "Already repaid");

        uint repayAmount = loan.amount + ((loan.amount * loan.interest) / 100);
        require(msg.value >= repayAmount, "Insufficient repayment");

        loan.repaid = true;
        payable(loan.lender).transfer(msg.value);
    }

    function getLoans() external view returns (Loan[] memory) {
        return loans;
    }
}
