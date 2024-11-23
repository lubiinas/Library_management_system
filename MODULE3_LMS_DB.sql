-- Step 1: Create Database
CREATE DATABASE library;

-- Step 2: Use the Database
USE library;

-- Step 3: Create Tables

CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);

CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

CREATE TABLE Books (
    ISBN INT PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(10),
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);

CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book INT,
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 INT,
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
-- Data for Branch
INSERT INTO Branch VALUES 
(1, 101, 'Downtown, City A', '1234567890'),
(2, 102, 'Uptown, City B', '9876543210');

-- Data for Employee
INSERT INTO Employee VALUES 
(1, 'John Doe', 'Manager', 60000, 1),
(2, 'Jane Smith', 'Librarian', 45000, 1),
(3, 'Alice Brown', 'Librarian', 47000, 2);

-- Data for Books
INSERT INTO Books VALUES 
(101, 'Book A', 'Fiction', 30, 'yes', 'Author A', 'Publisher A'),
(102, 'Book B', 'History', 25, 'no', 'Author B', 'Publisher B'),
(103, 'Book C', 'Fiction', 20, 'yes', 'Author C', 'Publisher C');

-- Data for Customer
INSERT INTO Customer VALUES 
(1, 'Customer X', 'Street 1, City A', '2021-11-15'),
(2, 'Customer Y', 'Street 2, City B', '2022-03-10');

-- Data for IssueStatus
INSERT INTO IssueStatus VALUES 
(1, 1, 'Book B', '2023-06-15', 102);

-- Data for ReturnStatus
INSERT INTO ReturnStatus VALUES 
(1, 1, 'Book B', '2023-07-10', 102);

-- Retrieve available books
SELECT Book_title, Category, Rental_Price 
FROM Books 
WHERE Status = 'yes';

-- Employees and salaries in descending order
SELECT Emp_name, Salary 
FROM Employee 
ORDER BY Salary DESC;

-- Books and corresponding customers
SELECT b.Book_title, c.Customer_name 
FROM Books b 
JOIN IssueStatus i ON b.ISBN = i.Isbn_book 
JOIN Customer c ON i.Issued_cust = c.Customer_Id;

-- Count of books in each category
SELECT Category, COUNT(*) AS Total_Books 
FROM Books 
GROUP BY Category;

-- Employees earning above Rs.50,000
SELECT Emp_name, Position 
FROM Employee 
WHERE Salary > 50000;

-- Customers registered before 2022 and not issued books
SELECT c.Customer_name 
FROM Customer c 
LEFT JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust 
WHERE c.Reg_date < '2022-01-01' AND i.Issue_Id IS NULL;

-- Branch-wise employee count
SELECT Branch_no, COUNT(*) AS Total_Employees 
FROM Employee 
GROUP BY Branch_no;

-- Customers who issued books in June 2023
SELECT DISTINCT c.Customer_name 
FROM Customer c 
JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust 
WHERE MONTH(i.Issue_date) = 6 AND YEAR(i.Issue_date) = 2023;

-- Books containing 'History' in the title
SELECT Book_title 
FROM Books 
WHERE Book_title LIKE '%History%';

-- Branches with more than 5 employees
SELECT Branch_no, COUNT(*) AS Total_Employees 
FROM Employee 
GROUP BY Branch_no 
HAVING COUNT(*) > 5;

-- Managers and their branch addresses
SELECT e.Emp_name, b.Branch_address 
FROM Employee e 
JOIN Branch b ON e.Emp_Id = b.Manager_Id;

-- Customers who issued books with rental price > 25
SELECT DISTINCT c.Customer_name 
FROM Customer c 
JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust 
JOIN Books b ON i.Isbn_book = b.ISBN 
WHERE b.Rental_Price > 25;





