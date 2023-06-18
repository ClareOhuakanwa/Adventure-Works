SELECT * FROM  PERSON.Person WHERE MiddleName IS NULL; 

SELECT 
	COUNT(BusinessEntityID) AS Persons_without_middlename
FROM 
	PERSON.PERSON 
WHERE 
	MIDDLENAME IS NULL;
-- 8,499

--Email addresses not like adventure-works.com

SELECT 
   COUNT(EmailAddressID) 
FROM 
   PERSON.EmailAddress 
WHERE 
   EmailAddress NOT LIKE '%adventure-works.com';
-- 0 Email addresses

--States with most sales between 2010-2011

SELECT * FROM SALES.SalesOrderHeader
SELECT * FROM SALES.SalesTerritory

SELECT 
   SALESORDERID, YEAR( ORDERDATE) AS ORDER_YEAR, NAME, COUNTRYREGIONCODE,  SUBTOTAL, TAXAMT, FREIGHT, TOTALDUE 
FROM 
   SALES.SalesOrderHeader AS t1
   INNER JOIN SALES.SalesTerritory As t2 
	ON t1.TerritoryID = t2.TerritoryID
WHERE 
   YEAR( ORDERDATE) BETWEEN 2010 AND 2011
ORDER BY 
   TotalDue DESC;

--Customers that got the email promotion from tickets escalation

SELECT * FROM PERSON.Person 

SELECT 
   BUSINESSENTITYID, CONCAT_WS (' ', ' ',FirstName, MiddleName, LastName ) AS FULLNAME, EmailPromotion 
FROM 
   PERSON.Person 
WHERE 
   EmailPromotion NOT LIKE 0
ORDER BY
   FULLNAME ASC;

--A list of the different types of contacts and how many of them exist in the database. 
-- Only ContactTypes that have 100 contacts or more.
SELECT * FROM PERSON.ContactType
SELECT * FROM PERSON.BusinessEntityContact

SELECT 
  t2.ContactTypeID, 
  COUNT(t2.PersonID) as person_count
FROM 
   PERSON.ContactType as t1
  JOIN PERSON.BusinessEntityContact as t2 
		ON t1.ContacttypeID = t2.ContacttypeID 
GROUP BY 
  t2.ContactTypeID
  having COUNT(t2.PersonID) >= 100 


--list of all contacts which are 'Purchasing Manager' and their names 
SELECT * FROM PERSON.ContactType
SELECT * FROM PERSON.Person
SELECT * FROM PERSON.BusinessEntityContact

SELECT
   t3.BusinessEntityID, CONCAT_WS (' ', ' ',FirstName, MiddleName, LastName ) AS FULL_NAME, NAME
FROM
   PERSON.BusinessEntityContact AS t1 
   JOIN PERSON.ContactType AS t2  
		ON t2.ContactTypeID = t1.CONTACTTYPEID 
   JOIN PERSON.Person AS t3 
		ON t3.BusinessEntityID = t1.PersonID
WHERE 
   NAME = 'Purchasing Manager'
ORDER BY
   FirstName ASC

--OrderQty, the Name and the ListPrice of the order made by CustomerID 635
SELECT * from production.Product
SELECT * FROM SALES.SalesOrderHeader
SELECT * FROM SALES.SalesOrderDetail
SELECT * FROM SALES.Customer

select 
  t3.customerid, t2.productid, name, orderqty,listprice 
from 
   production.Product as t1
   join sales.SalesOrderDetail as t2 
		on t2.ProductID = t1.ProductID
   join sales.SalesOrderHeader as t3 
		on t3.SalesOrderID = t2.SalesOrderID
   join sales.customer as t4 
		on t4.CustomerID = t3.CustomerID
where 
   t3.CustomerID = 726;


--SalesOrderID and the UnitPrice for every Single Item Order.
SELECT 
   SalesOrderID, OrderQty, UnitPrice
FROM 
   SALES.SalesOrderDetail
WHERE 
   OrderQty = 1 
--group by SalesOrderID, OrderQty, UnitPrice


--Best-selling item by value.
SELECT * 
FROM SALES.SalesOrderDetail

SELECT 
   SOD.PRODUCTID, SOD.UNITPRICE, SOD.ORDERQTY, SOD.LineTotal 
FROM 
   SALES.SalesOrderDetail AS SOD
ORDER BY
   SOD.LineTotal DESC;
