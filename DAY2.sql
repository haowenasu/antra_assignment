--1
--Result set is a set of data returned by either a SELECT statement or a stored procedure
--it could be empty or not
--it is saved in RAM or displayed on screen

--2
--Union and union all can both be used to combine two queries into one result set
--union all will have all the duplicate values, but union don't

--3
--Union(all), intersect, exclude

--4
--Union is to combine results horizontically, new rows will be added. It removes duplicates and requires data type to the the same.
--Join is to combine results into columns according to the condition statements

--5
--Inner join will only returned results matched in both tables.
--Full join will include all the results as long as it occured in either of the two tables. Null value will be returned if it can't be found at the other table.

--6
--Two types of join: inner or outer
--Left join, right join, full join are the three types of outer join

--7
--It returns the Cartesian product rows from the two tables
--It combines each row from the first table with the second table

--8
--1. having is a filter on the whole group, where is a filter on individual rows
--2. where executed before aggregation, having goes after the aggregation
--3. where can be used with select/update, having is select only

--9
--yes, a group by can contain 2 or more columns



--1
SELECT COUNT(ProductID)
FROM Production.Product

--2
SELECT COUNT(ProductID)
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL

--3
SELECT ProductSubcategoryID, COUNT(ProductID)
FROM Production.Product
GROUP BY ProductSubcategoryID


--4
SELECT ProductSubcategoryID, COUNT(ProductID)
FROM Production.Product
WHERE ProductSubcategoryID IS NULL
GROUP BY ProductSubcategoryID

--5
SELECT SUM(Quantity)
FROM Production.ProductInventory

--6
SELECT ProductID, SUM(Quantity) as TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY ProductID
HAVING SUM(Quantity) < 100

--7
SELECT Shelf, ProductID, SUM(Quantity) as TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY Shelf, ProductID
HAVING SUM(Quantity) < 100

--8
SELECT ProductID, AVG(Quantity) as TheAvg
FROM Production.ProductInventory
WHERE LocationID = 10
GROUP BY ProductID

--9
SELECT ProductID, Shelf, AVG(Quantity) as TheAvg
FROM Production.ProductInventory
GROUP BY Shelf, ProductID

--10
SELECT ProductID, Shelf, AVG(Quantity) as TheAvg
FROM Production.ProductInventory
WHERE Shelf != 'N/A'
GROUP BY Shelf, ProductID

--11
SELECT Color, Class, COUNT(ProductID) as TheCount, AVG(ListPrice) as AvgPrice
FROM Production.Product
WHERE Color IS NOT NULL AND Class IS NOT NULL
GROUP BY Color, Class

--12
SELECT cr.Name as Country, sp.Name as Province
FROM PERSON.CountryRegion cr Inner Join Person.StateProvince sp on cr.CountryRegionCode = sp.CountryRegionCode
ORDER BY 1

--13
SELECT cr.Name as Country, sp.Name as Province
FROM PERSON.CountryRegion cr Inner Join Person.StateProvince sp on cr.CountryRegionCode = sp.CountryRegionCode
WHERE cr.Name != 'Germany' AND cr.Name != 'Canada'
ORDER BY 1

--14
SELECT p.ProductID, p.ProductID, o.OrderDate
FROM dbo.Products p, dbo.Orders o, dbo.[Order Details] od
WHERE p.ProductID = od.ProductID AND od.OrderID = o.OrderID AND Year(o.OrderDate) >=1996

--15
SELECT TOP 5 o.ShipPostalCode, SUM(od.Quantity) as [Total Sale]
FROM dbo.Orders o, dbo.[Order Details] od
WHERE o.OrderID = od.OrderID AND o.ShipPostalCode is not null
GROUP BY o.ShipPostalCode
ORDER BY 2 DESC

--16
SELECT TOP 5 o.ShipPostalCode, SUM(od.Quantity) as [Total Sale]
FROM dbo.Orders o, dbo.[Order Details] od
WHERE o.OrderID = od.OrderID AND o.ShipPostalCode is not null AND Year(o.OrderDate) >=1996
GROUP BY o.ShipPostalCode
ORDER BY 2 DESC

--17
SELECT c.City, COUNT(c.CustomerID) as [Total Customer]
FROM dbo.Customers c
GROUP BY c.City

--18
SELECT c.City, COUNT(c.CustomerID) as [Total Customer]
FROM dbo.Customers c
GROUP BY c.City
HAVING COUNT(c.CustomerID) >= 2

--19
SELECT DISTINCT	C.ContactName
FROM DBO.CUSTOMERS C, DBO.ORDERS O
WHERE O.CustomerID = C.CustomerID AND Year(o.OrderDate) >=1998

--20
SELECT DISTINCT C.ContactName, O.OrderDate
FROM DBO.CUSTOMERS C, DBO.ORDERS O
WHERE O.CustomerID = C.CustomerID 
ORDER BY O.OrderDate DESC

--21
SELECT C.CONTACTNAME, COUNT(OD.Quantity) AS [Total Sale]
FROM DBO.CUSTOMERS C, DBO.ORDERS O, DBO.[Order Details] OD
WHERE O.CustomerID = C.CustomerID AND OD.OrderID = O.OrderID
GROUP BY C.ContactName

--22
SELECT C.CustomerID, COUNT(OD.Quantity) AS [Total Sale]
FROM DBO.CUSTOMERS C, DBO.ORDERS O, DBO.[Order Details] OD
WHERE O.CustomerID = C.CustomerID AND OD.OrderID = O.OrderID
GROUP BY C.CustomerID
Having COUNT(OD.Quantity)>100

--23
SELECT s.CompanyName as [Supplier Company Name] , shi.CompanyName as [Shipping Company Name]
FROM dbo.Suppliers s full outer join dbo.Shippers shi on 1=1
--can use cross join as well

--24
SELECT o.OrderDate, p.ProductName
FROM dbo.Products p, dbo.Orders o, dbo.[Order Details] od
WHERE o.OrderID = od.OrderID AND od.ProductID = p.ProductID
ORDER BY 1

--25
SELECT e1.FirstName + ' ' + e1.LastName as Employee1, e2.FirstName + ' ' + e2.LastName as Employee2
FROM dbo.Employees e1 join dbo.Employees e2 on ( e1.Title = e2.Title and e1.EmployeeID != e2.EmployeeID )

--26
SELECT e1.FirstName + ' ' + e1.LastName as Manager, e1.Title
FROM dbo.Employees e1
WHERE
	(SELECT COUNT(*)
	FROM dbo.Employees e2
	WHERE e1.EmployeeID = e2.ReportsTo
	GROUP BY e2.ReportsTo) >=2
	
--27
SELECT *
FROM dbo.Customers c, dbo.Suppliers s
WHERE c.City = s.City



--28
/*
SELECT *
FROM T1 inner join T2 ON T1.F1= T2.F2
*/
--RESULT 2 2
--       3 3


--29
/*
SELECT *
FROM T1 left outer join T2 ON T1.F1= T2.F2
*/
--RESULT 1,NULL
--       2,2
--		 3,3
		 

