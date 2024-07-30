--12
SELECT LastName, FirstName
FROM Employees
WHERE BirthDate BETWEEN '1950' AND '1960'
--13
SELECT SuppliersID
FROM Suppliers
WHERE CompanyName ='Exotic Liquids' OR CompanyName='Grandma Kelly''s Homestead' OR CompanyName='Tokyo Traders'

SELECT ProductName, SupplierID 
FROM Products
WHERE SupplierID IN (1,2,3)
--14
SELECT ShipPostalCode, OrderID, OrderDate
FROM Orders
WHERE ShipPostalCode LIKE '02389%'
--15
SELECT ContactName, ContactTitle, CompanyName
FROM Customers
WHERE ContactTitle NOT LIKE '%sales%'
--16
SELECT LastName, FirstName, City 
FROM Employees
WHERE City <>'Seattle'