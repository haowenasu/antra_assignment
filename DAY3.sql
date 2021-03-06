--1
--I would prefer subquery. It is easier to understand and maintain. Though it may have worse performance than join.
--Also, we can only write join in FROM statement, but we can write subquery almost anywhere.

--2
--It is called common table expression, which is a temporary table and can be used by the closest select statement.
--We can use it for spliting complex queries, as well as writing recursive queries.

--3
--They are variables that hold rows of data.
--Table variables are out of scope at the end of batch.
--They are stored in tempdb database.

--4
/*
1. delete is DML, truncate is DDL
2. delete used to delete specified rows with where clause, truncate delete all the rows
3. delete locks on tuple and removes and save log one by one, truncate locks on datapage and directly deallocate the datapage used to store data .
4. truncate is faster, see 3.
5. truncate reset the identidy to seed value, and cannot be used with indexed rows
6. truncate can't be rolled back and don't activate trigger to fire

*/


--5
--Identity column is made up of values generated by database. (Differ from prime key, which is matained on server)
--Truncate will reset to seed value , delete retains that.

--6
-- see 4.


--1
SELECT DISTINCT c.City
FROM dbo.Customers c, dbo.Employees e
WHERE c.City = e.City

--2
--a
SELECT DISTINCT c.city
FROM dbo.Customers c
WHERE c.city not in ( SELECT e.city FROM dbo.Employees e )

--b
SELECT DISTINCT c.city
FROM dbo.Customers c
EXCEPT
SELECT DISTINCT e.city
FROM dbo.Employees e


--3
SELECT p.ProductName, SUM(od.Quantity) as [Total Order Quantity]
FROM dbo.Products p, dbo.Orders o, dbo.[Order Details] od
WHERE p.ProductID = od.ProductID AND o.OrderID = od.OrderID
GROUP BY p.ProductName

--4
SELECT c.City, SUM(od.Quantity) as [Total Order Quantity by City]
FROM dbo.Customers c, dbo.[Order Details] od, dbo.Orders o
WHERE c.City = o.ShipCity AND od.OrderID = o.OrderID
GROUP BY c.city

--5
--a
SELECT c.city
FROM dbo.Customers c
GROUP BY c.City
HAVING COUNT(c.CustomerID)=2
UNION 
SELECT c1.city
FROM dbo.Customers c1
GROUP BY c1.City
HAVING COUNT(c1.CustomerID)>2

--b
SELECT DISTINCT c.city
FROM dbo.Customers c
WHERE c.city in (SELECT c2.City FROM dbo.Customers c2 
				GROUP BY c2.City
				HAVING COUNT(c2.CustomerID)>=2 )


--6
SELECT DISTINCT c1.City, COUNT(od.ProductID) as ProductType
FROM dbo.Customers c1, dbo.[Order Details] od, dbo.Orders o
WHERE c1.City = o.ShipCity AND o.OrderID = od.OrderID 
Group BY c1.City
Having COUNT(od.ProductID)>=2

--7
SELECT DISTINCT c.ContactName
FROM dbo.Customers c, dbo.Orders o
WHERE c.CustomerID = o.CustomerID AND c.City != o.ShipCity

--8

SELECT TOP 5 p.ProductName, SUM(od.Quantity) as [Total Order Quantity], SUM(od.UnitPrice*od.Quantity*(1-od.Discount))/SUM(od.UnitPrice) as [Average Price], o.ShipCity as [Top ordered City]
FROM dbo.Products p, dbo.Orders o, dbo.[Order Details] od join (SELECT TOP 1 o1.ShipCity 
	FROM dbo.[Order Details] od1, dbo.Orders o1
	WHERE od1.OrderID = o1.OrderID 
	Group by o1.ShipCity
	ORDER BY SUM(od1.quantity)) dt on Shipcity = dt.Shipcity
WHERE p.ProductID = od.ProductID AND o.OrderID = od.OrderID  

/*AND c.City in
(
	SELECT TOP 1 o1.ShipCity 
	FROM dbo.[Order Details] od1, dbo.Orders o1
	WHERE od1.OrderID = o1.OrderID 
	Group by o1.ShipCity
	ORDER BY SUM(od1.quantity)
)*/
GROUP BY p.ProductName, O.ShipCity
ORDER BY 2 DESC

--9
--a
SELECT e.City
FROM dbo.Employees e
WHERE e.City not in
(
	SELECT o.ShipCity
	FROM dbo.Orders o 
)

--b
SELECT e.City
FROM dbo.Employees e
EXCEPT
SELECT o.ShipCity
FROM dbo.Orders o


--10
SELECT o.ShipCity ,COUNT(o.OrderID)
FROM dbo.Orders o INNER JOIN 
(SELECT TOP 1 o1.ShipCity
FROM dbo.Orders o1, dbo.[Order Details] od
Where o1.OrderID = od.OrderID
Group by o1.ShipCity
Order by SUM(od.Quantity) desc) DT ON o.ShipCity = dt.ShipCity
Group by o.ShipCity
Order by COUNT(o.OrderID) desc







--11
/*
Two ways:
first, use group by and MAX()
delete those not in the MAX id of each duplicate group

second, use CTE and Row_NUMBER()
create Row number over the paritition of duplicate rows, so a new column will be generated based on the counts of duplicates
delete those row_number > 1, keep only the first one


*/

--12
create table Employee (empid integer, mgrid integer, deptid integer, salary money)
create table Dept (deptid integer, deptname varchar(20))

SELECT *
FROM Employee
WHERE empid not in
(
	SELECT mgrid
	FROM Employee
)

--13
SELECT d.deptname, COUNT(e.empid) AS [COUNT OF EMPLOYEE]
FROM Dept d,Employee e
WHERE e.deptid = d.deptid 
GROUP BY d.deptname
ORDER BY 2 DESC

--14
/*
SELECT D.deptname, E.empid, E.salary, RANK() OVER (PARTITION BY D.deptname ORDER BY E.salary DESC ) AS RNK
FROM Dept D, Employee E
WHERE D.deptid = E.deptid 
*/
--GROUP BY D.deptname

SELECT DQ.deptname, EQ.empid, EQ.salary
FROM Dept DQ, Employee EQ join (
SELECT D.deptname, E.empid, E.salary, RANK() OVER (PARTITION BY D.deptname ORDER BY E.salary DESC ) AS RNK
FROM Dept D JOIN Employee E ON D.deptid = E.deptid 
) dt on deptname = dt.deptname
WHERE RNK<=3
