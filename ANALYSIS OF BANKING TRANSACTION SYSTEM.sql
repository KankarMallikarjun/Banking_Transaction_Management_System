-- create and use Database
CREATE DATABASE Banking_Transaction_Management_System;

USE Banking_Transaction_Management_System;

-- Create the Customers table
CREATE TABLE Customers (
  customer_id INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  address VARCHAR(100)
);

-- Create the Accounts table
CREATE TABLE Accounts (
  account_id INT PRIMARY KEY,
  customer_id INT,
  account_number VARCHAR(20),
  balance DECIMAL(10,2),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Create the Transactions table
CREATE TABLE Transactions (
  transaction_id INT PRIMARY KEY,
  account_id INT,
  transaction_date DATE,
  transaction_type VARCHAR(20),
  amount DECIMAL(10,2),
  FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

-- Insert sample data into the tables
INSERT INTO Customers (customer_id, name, email, address)
VALUES
  (1, 'John Doe', 'john.doe@example.com', '123 Main St'),
  (2, 'Jane Smith', 'jane.smith@example.com', '456 Elm St'),
  (3, 'Michael Johnson', 'michael.johnson@example.com', '789 Oak St'),
  (4, 'Emily Davis', 'emily.davis@example.com', '321 Pine St'),
  (5, 'David Wilson', 'david.wilson@example.com', '654 Maple St');

INSERT INTO Accounts (account_id, customer_id, account_number, balance)
VALUES
  (1, 1, 'A123456', 1000.00),
  (2, 2, 'B789012', 500.00),
  (3, 3, 'C345678', 2000.00),
  (4, 1, 'D901234', 1500.00),
  (5, 4, 'E567890', 3000.00);

INSERT INTO Transactions (transaction_id, account_id, transaction_date, transaction_type, amount)
VALUES
  (1, 1, '2023-05-01', 'Deposit', 500.00),
  (2, 2, '2023-05-02', 'Withdrawal', 100.00),
  (3, 3, '2023-05-02', 'Deposit', 1000.00),
  (4, 1, '2023-05-03', 'Withdrawal', 200.00),
  (5, 4, '2023-05-04', 'Deposit', 800.00);

-- Sample questions

-- 1. Retrieve all customers and their account information.
SELECT Customers.name, Accounts.account_number, Accounts.balance
FROM Customers
JOIN Accounts ON Customers.customer_id = Accounts.customer_id;

-- 2. Calculate the total balance for each account.
SELECT Accounts.account_number, SUM(Accounts.balance) AS total_balance
FROM Accounts
GROUP BY Accounts.account_number;

-- 3. Retrieve all transactions for a specific account.
SELECT Transactions.transaction_id, Transactions.transaction_date, Transactions.transaction_type, Transactions.amount
FROM Transactions
JOIN Accounts ON Transactions.account_id = Accounts.account_id
WHERE Accounts.account_number = 'A123456';

-- 4. Calculate the average transaction amount for each account.
SELECT Accounts.account_number, AVG(Transactions.amount) AS average_transaction_amount
FROM Accounts
JOIN Transactions ON Accounts.account_id = Transactions.account_id
GROUP BY Accounts.account_number;

-- 5. Retrieve the account with the highest balance.
SELECT Accounts.account_number, Accounts.balance
FROM Accounts
ORDER BY Accounts.balance DESC
LIMIT 1;

-- 6. Retrieve all customers who have made a withdrawal.
SELECT Customers.name
FROM Customers
JOIN Accounts ON Customers.customer_id = Accounts.customer_id
JOIN Transactions ON Accounts.account_id = Transactions.account_id
WHERE Transactions.transaction_type = 'Withdrawal';

-- 7. Calculate the total deposits and withdrawals for each account.
SELECT Accounts.account_number, 
       SUM(CASE WHEN Transactions.transaction_type = 'Deposit' THEN Transactions.amount ELSE 0 END) AS total_deposits,
       SUM(CASE WHEN Transactions.transaction_type = 'Withdrawal' THEN Transactions.amount ELSE 0 END) AS total_withdrawals
FROM Accounts
JOIN Transactions ON Accounts.account_id = Transactions.account_id
GROUP BY Accounts.account_number;

-- 8. Retrieve the customers with the highest total balance across all their accounts.
SELECT Customers.name, SUM(Accounts.balance) AS total_balance
FROM Customers
JOIN Accounts ON Customers.customer_id = Accounts.customer_id
GROUP BY Customers.name
ORDER BY total_balance DESC
LIMIT 1;

-- 9. Retrieve all transactions made on a specific date.
SELECT Transactions.transaction_id, Transactions.transaction_date, Transactions.transaction_type, Transactions.amount
FROM Transactions
WHERE Transactions.transaction_date = '2023-05-02';

-- 10. Retrieve the customers who have not made any transactions.
SELECT Customers.name
FROM Customers
LEFT JOIN Accounts ON Customers.customer_id = Accounts.customer_id
LEFT JOIN Transactions ON Accounts.account_id = Transactions.account_id
WHERE Transactions.transaction_id IS NULL;

-- 11. Calculate the average balance for all accounts.
SELECT AVG(Accounts.balance) AS average_balance
FROM Accounts;

-- 12. Retrieve the accounts with a negative balance.
SELECT Accounts.account_number, Accounts.balance
FROM Accounts
WHERE Accounts.balance < 0;

-- 13. Calculate the total number of transactions for each account.
SELECT Accounts.account_number, COUNT(Transactions.transaction_id) AS total_transactions
FROM Accounts
LEFT JOIN Transactions ON Accounts.account_id = Transactions.account_id
GROUP BY Accounts.account_number;

-- 14. Retrieve the transactions with the highest amount.
SELECT Transactions.transaction_id, Transactions.transaction_date, Transactions.transaction_type, Transactions.amount
FROM Transactions
ORDER BY Transactions.amount DESC
LIMIT 1;

-- 15. Retrieve the accounts with the lowest balance.
SELECT Accounts.account_number, Accounts.balance
FROM Accounts
ORDER BY Accounts.balance ASC
LIMIT 1;

-- 16. Calculate the average transaction amount for all transactions.
SELECT AVG(Transactions.amount) AS average_transaction_amount
FROM Transactions;

-- 17. Retrieve the customers who have made more than 3 transactions.
SELECT Customers.name
FROM Customers
JOIN Accounts ON Customers.customer_id = Accounts.customer_id
JOIN Transactions ON Accounts.account_id = Transactions.account_id
GROUP BY Customers.name
HAVING COUNT(Transactions.transaction_id) > 3;

-- 18. Retrieve the transactions made by a specific customer.
SELECT Transactions.transaction_id, Transactions.transaction_date, Transactions.transaction_type, Transactions.amount
FROM Transactions
JOIN Accounts ON Transactions.account_id = Accounts.account_id
JOIN Customers ON Accounts.customer_id = Customers.customer_id
WHERE Customers.name = 'John Doe';

-- 19. Calculate the total deposits and withdrawals for each customer.
SELECT Customers.name, 
       SUM(CASE WHEN Transactions.transaction_type = 'Deposit' THEN Transactions.amount ELSE 0 END) AS total_deposits,
       SUM(CASE WHEN Transactions.transaction_type = 'Withdrawal' THEN Transactions.amount ELSE 0 END) AS total_withdrawals
FROM Customers
JOIN Accounts ON Customers.customer_id = Accounts.customer_id
JOIN Transactions ON Accounts.account_id = Transactions.account_id
GROUP BY Customers.name;

-- 20. Retrieve the customers with a balance greater than $2000.
SELECT Customers.name
FROM Customers
JOIN Accounts ON Customers.customer_id = Accounts.customer_id
WHERE Accounts.balance > 2000;
