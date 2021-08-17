--1
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product

--2
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE ListPrice = 0

--3
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE COLOR IS NULL

--4
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE COLOR IS NOT NULL

--5
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE COLOR IS NOT NULL AND ListPrice >= 0

--6
SELECT Name, Color
FROM Production.Product
WHERE COLOR IS NOT NULL

--7
SELECT TOP 6 Name, Color
FROM Production.Product
WHERE COLOR IS NOT NULL

--8
SELECT ProductID, Name
FROM Production.Product
WHERE ProductID BETWEEN 400 AND 500

--9
SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color IN ('BLACK','BLUE');

--10
SELECT *
FROM Production.Product
WHERE Name like 'S%'

--11
SELECT Name, ListPrice
FROM Production.Product
WHERE Name like 'S%'
ORDER BY 1

--12
SELECT Name, ListPrice
FROM Production.Product
WHERE Name like '[A,S]%' 
ORDER BY 1

--13
SELECT Name, ListPrice
FROM Production.Product
WHERE Name like 'SPO[^K]%' 
ORDER BY 1

--14
SELECT DISTINCT Color 
FROM Production.Product
ORDER BY 1 DESC

--15
SELECT DISTINCT Color, ProductSubcategoryID
FROM Production.Product
WHERE Color IS NOT NULL AND ProductSubcategoryID IS NOT NULL
ORDER BY 1 DESC

--16
SELECT ProductSubCategoryID
      , LEFT([Name],35) AS [Name]
      , Color, ListPrice 
FROM Production.Product
WHERE Color NOT IN ('Red','Black') 
	OR (ListPrice BETWEEN 1000 AND 2000 
      AND ProductSubCategoryID = 1)
ORDER BY ProductID

/*
SELECT ProductSubCategoryID
      , LEFT([Name],35) AS [Name]
      , Color, ListPrice 
FROM Production.Product
WHERE ListPrice BETWEEN 1000 AND 2000 
      AND ProductSubCategoryID = 1

ORDER BY ProductID
*/
      



