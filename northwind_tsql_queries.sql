USE Northwind;

GO

-- 1. Retrieve all columns in the Region table
SELECT * FROM Region;


-- 2. Select the FirstName and LastName columns from the Employees table.
SELECT FirstName, LastName
FROM Employees;

-- 3. Select the FirstName and LastName columns from the Employees table.
-- Sort by LastName.
SELECT FirstName, LastName
FROM Employees
ORDER BY LastName;

-- 4. Create a report showing Northwind's orders sorted by Freight from most expensive to
-- cheapest. Show OrderID, OrderDate, ShippedDate, CustomerID, and Freight.
SELECT OrderId, OrderDate, ShippedDate, CustomerId, Freight
FROM Orders
ORDER BY Freight DESC;

-- 5. Create a report showing the title and the first and last name of all sales representatives.
SELECT Title, FirstName, LastName
FROM Employees
WHERE Title = 'Sales Representative';

-- 6. Create a report showing the first and last names of all employees who have a region specified.
SELECT FirstName, LastName
FROM Employees
WHERE Region is NOT NULL;

-- 7. Create a report showing the first and last name of all employees whose last names start
-- with a letter in the last half of the alphabet. Sort by LastName in descending order.
SELECT FirstName, LastName
FROM Employees
WHERE LastName LIKE '[M-Z]%'
ORDER BY LastName;

-- 8. Create a report showing the title of courtesy and the first and last name of all employees
-- whose title of courtesy begins with "M".
SELECT TitleOfCourtesy, FirstName, LastName
FROM Employees
WHERE TitleOfCourtesy LIKE 'M%';

-- 9. Create a report showing the first and last name of all sales representatives who are from
-- Seattle or Redmond.
SELECT FirstName, LastName, Title, City
FROM Employees
WHERE Title = 'Sales Representative'
    AND (City = 'Seattle' OR City = 'Redmond'); 

-- 10. Create a report that shows the company name, contact title, city and country of all
-- customers in Mexico or in any city in Spain except Madrid.
SELECT CompanyName, ContactName, ContactTitle, City, Country
FROM Customers
WHERE Country = 'Mexico' 
	OR (Country = 'Spain' AND City <> 'Madrid');

-- 11. If the cost of freight is greater than or equal to $500.00, it will now be taxed by 10%.
-- Create a report that shows the order id, freight cost, freight cost with this tax for all orders of
-- $500 or more.
SELECT OrderId, 
       Freight, 
       CAST(Freight * 1.1 AS DECIMAL(18, 2)) AS [Freight With Tax]
FROM Orders
WHERE Freight >= 500;

-- 12. Find the Total Number of Units Ordered of Product ID 3
SELECT SUM(Quantity) AS [Total Units Ordered]
FROM [Order Details]
WHERE ProductID = 3;

-- 13. Retrieve the number of employees in each city
SELECT City, COUNT(*) AS NumberOfEmployees
FROM Employees
GROUP BY City;

-- 14. Find the number of sales representatives in each city that contains at least 2 sales
-- representatives. Order by the number of employees.
SELECT City, COUNT(*) AS NumberOfSalesRepresentatives
FROM Employees
WHERE Title = 'Sales Representative'
GROUP BY City
HAVING COUNT(*) >= 2
ORDER BY NumberOfSalesRepresentatives DESC;

-- 15. Find the Companies (the CompanyName) that placed orders in 1997
SELECT DISTINCT CompanyName
FROM Customers INNER JOIN Orders
	ON Orders.CustomerId = Customers.CustomerId
WHERE OrderDate >= '1997-01-01' AND OrderDate < '1998-01-01';

-- 16. Create a report showing employee orders.
SELECT 
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    o.OrderID,
	c.CompanyName,
	FORMAT(o.OrderDate, 'yyyy-MM-dd') AS OrderDate,
    od.ProductID,
    p.ProductName,
    od.Quantity,
    od.UnitPrice,
	od.Discount,
    CAST(od.Quantity * od.UnitPrice * (1 - od.Discount) AS DECIMAL(18, 2)) AS TotalPrice
FROM Employees e
INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID
INNER JOIN Customers c ON c.CustomerId = o.CustomerId
ORDER BY e.EmployeeID, o.OrderID, OrderDate, od.ProductID;

-- 17. Create a report showing the Order ID, the name of the company that placed the order,
-- and the first and last name of the associated employee.
-- Only show orders placed after January 1, 1998 that shipped after they were required.
-- Sort by Company Name.
SELECT 
    o.OrderID,
    c.CompanyName,
    e.FirstName + ' ' + e.LastName AS EmployeeName
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE 
    o.OrderDate >= '1998-01-01'
    AND o.ShippedDate > o.RequiredDate
ORDER BY c.CompanyName;

-- 18. Create a report that shows the total quantity of products (from the Order_Details table)
-- ordered. Only show records for products for which the quantity ordered is fewer than 200.
-- The report should return the following 5 rows.
SELECT od.ProductId, SUM(od.Quantity) AS TotalQuantity
FROM [Order Details] od
GROUP BY od.ProductId
HAVING SUM(od.Quantity) < 200;






