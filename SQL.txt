-- Pronađite EmployeeID i OrderID za sve narudžbe
SELECT EmployeeID, OrderID
FROM Orders;

-- Izradite upit koji prikazuje sve narudžbe zaposlenika
SELECT Employees.EmployeeID, Employees.FirstName,
Employees.LastName, Orders.OrderID, Orders.OrderDate
FROM Employees INNER JOIN Orders ON
Employees.EmployeeID = Orders.EmployeeID
ORDER BY Orders.OrderDate;

-- Izradite upit koji prikazuje sve narudžbe zaposlenika koristeći aliase
SELECT e.EmployeeID, e.FirstName, e.LastName,
o.OrderID, o.OrderDate
FROM Employees e INNER JOIN Orders o ON
e.EmployeeID = o.EmployeeID
ORDER BY o.OrderDate;

SELECT o.OrderID, c.CompanyName, e.FirstName, e.LastName
FROM Orders o
JOIN Employees e ON e.EmployeeID = o.EmployeeID
JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE o.ShippedDate > o.RequiredDate AND o.OrderDate > '1998-01-01'
ORDER BY c.CompanyName;

/*
Napravite upit koje prikazuje one kupce koji se nalaze u istim gradovima
kao i zaposlenici. Prikažite ime zaposlenika.
*/
SELECT DISTINCT c.CustomerId, c.CompanyName, c.ContactName, e.EmployeeID,
e.LastName, e.FirstName, c.City
FROM Customers c INNER JOIN Employees e ON
c.City = e.City
ORDER BY c.CustomerId

/*
Napravite upit koje prikazuje broj zaposlenika i kupaca iz svakog grada u
kojem postoje zaposlenici.
*/
SELECT COUNT(DISTINCT e.EmployeeID) AS numEmployees,
COUNT(DISTINCT c.CustomerID) AS numCompanies,
e.City, c.City
FROM Employees e INNER JOIN Customers c ON
e.City = c.City
GROUP BY e.City, c.City
ORDER BY numEmployees DESC;

/*
Napravite upit koje prikazuje one kupce koji se nalaze u istim gradovima
kao i zaposlenici. Prikažite ime zaposlenika.
*/
SELECT DISTINCT c.CustomerId, c.CompanyName, c.ContactName, e.EmployeeID,
e.LastName, e.FirstName,
c.City as CityCustomer, e.City as CityEmployee
FROM Customers c LEFT JOIN Employees e ON
c.City = e.City
ORDER BY c.CustomerId

/*
Napravite upit koje prikazuje broj zaposlenika i kupaca iz svakog grada u
kojem postoje zaposlenici.
*/
SELECT COUNT(DISTINCT e.EmployeeID) AS numEmployees,
COUNT(DISTINCT c.CustomerID) AS numCompanies,
e.City as CityEmployees, c.City as CityCustomers
FROM Employees e LEFT JOIN Customers c ON
(e.City = c.City)
GROUP BY e.City, c.City
ORDER BY numEmployees DESC;

/*
Izradite upit koji prikazuje broj zaposlenika i kupaca iz istog grada.
*/
SELECT COUNT(DISTINCT e.EmployeeID) AS numEmployees,
COUNT(DISTINCT c.CustomerID) AS numCompanies,
e.City, c.City
FROM Employees e FULL JOIN Customers c ON
(e.City = c.City)
GROUP BY e.City, c.City
ORDER BY numEmployees DESC;

/*
Upit koji daje brojeve telefona svih prijevoznika, kupaca i
dobavljača.
*/
SELECT CompanyName, Phone FROM Shippers
UNION
SELECT CompanyName, Phone FROM Customers
UNION
SELECT CompanyName, Phone FROM Suppliers
ORDER BY CompanyName

-- Pronađi sve jedinstvene gradove u kojima Northwind ima zaposlenike
SELECT DISTINCT City
FROM Employees
ORDER BY City

-- Pronađi u koliko različitih gradova Northwind ima zaposlenike.
SELECT COUNT(DISTINCT City) AS NumCities
FROM Employees

-- Prikaži trošarinu i njezinu zaokruženu vrijednost na jednu decimalu
SELECT Freight, ROUND(Freight,1) AS ApproxFreight
FROM Orders;

-- Odaberi jediničnu cijenu, te je pretvori u decimalni broj sa dvije
decimale
SELECT UnitPrice, CAST(UnitPrice AS Decimal(8,2))
FROM Products;

--Odaberi ime i prezime zaposlenika pisano velikim slovima
SELECT UPPER(FirstName), UPPER(LastName)
FROM Employees;

-- Odaberi prvih 10 znakova adrese svakog kupca
SELECT SUBSTRING(Address,1,10)
FROM Customers;

-- Pronaći prije koliko godina je svaki od zaposlenika zaposlen.
SELECT LastName, BirthDate, HireDate, DATEDIFF(year,HireDate, GETDATE()) AS
HireAge
FROM Employees
ORDER BY HireDate;

-- Pronaći mjesec rođenja svakog zaposlenika
SELECT FirstName, LastName, DATENAME(month,BirthDate) AS BirthMonth
FROM Employees
ORDER BY DATEPART(month,BirthDate);

-- Nađi broj zaposlenika
SELECT COUNT(*) AS NumEmployees
FROM Employees;

-- Nađi ukupnu količinu koja je naručena za ProductID = 3
SELECT SUM(Quantity) AS TotalUnits
FROM "Order Details"
WHERE ProductID=3;

-- Nađi prosječnu jediničnu cijenu artikala
SELECT AVG(UnitPrice) AS AveragePrice
FROM Products;

-- Nađi najraniji i najnoviji datum zaposlenja zaposlenika
SELECT MIN(HireDate) AS FirstHireDate,
MAX(HireDate) AS LastHireDate
FROM Employees;

--Broj zaposlenika po svakom gradu.
SELECT City, COUNT(EmployeeID) AS NumEmployees
FROM Employees
GROUP BY City;

/* Broj zaposlenika po gradovima za one gradove koji imaju barem dva
zaposlenika */
SELECT City, COUNT(EmployeeID) AS NumEmployees
FROM Employees
GROUP BY City
HAVING COUNT(EmployeeID) > 1;

/* Pronađi broj agenata prodaje u svakom gradu koji ima barem dva agenta.
Sortiraj prema broju agenata. */
SELECT City, COUNT(EmployeeID) AS NumEmployees
FROM Employees
WHERE Title = 'Sales Representative'
GROUP BY City
HAVING COUNT(EmployeeID) > 1
ORDER BY NumEmployees;

--PROVJERA JEDNAKOSTI
SELECT Title, FirstName, LastName
FROM Employees
WHERE Title = 'Sales Representative';

--PROVJERA NEJEDNAKOSTI
SELECT FirstName, LastName
FROM Employees
WHERE Title <> 'Sales Representative';

SELECT FirstName, LastName
FROM Employees
WHERE LastName >= 'N';

--PROVJERA NULL VRIJEDNOSTI
SELECT FirstName, LastName
FROM Employees
WHERE Region IS NOT NULL;


--OPERATOR BETWEEN
SELECT FirstName, LastName
FROM Employees
WHERE LastName BETWEEN 'J' AND 'M';

SELECT FirstName, LastName
FROM Employees
WHERE LastName >= 'J' AND LastName <= 'M';


--OPERATOR IN
SELECT TitleOfCourtesy, FirstName, LastName
FROM Employees
WHERE TitleOfCourtesy IN ('Ms.','Mrs.');

SELECT TitleOfCourtesy, FirstName, LastName
FROM Employees
WHERE TitleOfCourtesy = 'Ms.' OR TitleOfCourtesy = 'Mrs.';

SELECT TitleOfCourtesy, FirstName, LastName
FROM Employees
WHERE TitleOfCourtesy LIKE 'M%';

--OPERATOR NOT
SELECT TitleOfCourtesy, FirstName, LastName
FROM Employees
WHERE NOT TitleOfCourtesy IN ('Ms.','Mrs.');

--AND
SELECT FirstName, LastName
FROM Employees
WHERE Title = 'Sales Representative'
AND TitleOfCourtesy = 'Mr.';

--OR
SELECT FirstName, LastName, City
FROM Employees
WHERE City = 'Seattle' OR City = 'Redmond';

--1. Upit koji ispisuje Id svake narudžbe (OrderID) na kojoj je prodan ProductID = 23, količinu po kojoj
--je prodan taj proizvod na stavci, te maksimalnu količinu po kojoj je prodan bilo koji proizvod.
SELECT OrderID, Quantity,
(SELECT MAX(Quantity) FROM [Order Details]) AS MaksimalnaKolicina
FROM [Order Details]
WHERE ProductID = 23


--2. Napravite upit koji ispisuje ProductId, ProductName i SupplierId za sve proizvode čiji su
--dobavljaču (Supplier) tvrtke „Exotic Liquids“ ili „Tokyo Traders“.
SELECT ProductID, ProductName, SupplierID
FROM Products
WHERE SupplierID IN
(SELECT SupplierID
FROM Suppliers
WHERE CompanyName IN ('Exotic Liquids', 'Tokyo Traders')) 

--3. Ispišite ProductId i ProductName za sve one proizvode koji imaju jednaku cijenu kao i proizvod
--pod nazivom „Longlife Tofu“.
SELECT ProductID, ProductName
FROM Products
WHERE UnitPrice = 
(SELECT UnitPrice
FROM Products
WHERE ProductName = 'Longlife Tofu')

--4. Ispišite sve kupce koji imaju najnovije narudžbe (najkasniji datum narudžbe).
SELECT OrderID,
CustomerID
FROM Orders
WHERE OrderDate = (SELECT MAX(OrderDate)FROM Orders)

--5. Ispišite ProductId, ProductName onih proizvoda koji nisu nikada prodavani.
--Napomena: takvi proizvodi ne moraju postojati.
SELECT ProductID, ProductName
FROM Products
WHERE ProductID NOT IN
(SELECT DISTINCT ProductID
FROM [Order Details])


--Korištenjem koreliranih podupita napišite sljedeće upite:
--6. Ispišite listu kupaca i njihovih narudžbi (CustomerId, OrderId) kod kojih je ukupni iznos svih stavki
--po narudžbi > 10000.
SELECT OrderID,CustomerID
FROM Orders 
WHERE 10000 <
(SELECT SUM(UnitPrice*Quantity*(1-Discount))
FROM [Order Details]
WHERE Orders.OrderID = [Order Details].OrderID)


--Korištenjem koreliranih podupita napišite sljedeće upite:
--7. Ispišite listu svih kupaca kojima je dostavljano u Francusku (Orders.ShipCountry = 'France' ).
SELECT DISTINCT Customers.CustomerID, Customers.CompanyName
FROM Customers
WHERE EXISTS (SELECT Orders.ShipCountry FROM Orders WHERE Orders.ShipCountry = 'France')

--Pronađite CustomerID narudžbe OrderId = 10290.
SELECT CustomerID
FROM Orders
WHERE OrderID = 10290;

--Pronađite naziv tvrtke koja je naručila narudžbu OrderId = 10290.
SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID = (SELECT CustomerID
 FROM Orders
 WHERE OrderID = 10290);

--Pronađite naziv tvrtke koja je ostvarila narudžbu OrderId = 10290.ISTO ALI S JOIN
SELECT CustomerID, CompanyName
FROM Customers c INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE OrderID = 10290

-- Pronađite nazive tvrtki koja su ostvarile narudžbu 1997 g.
SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID IN (SELECT CustomerID
 FROM Orders
 WHERE OrderDate BETWEEN '1997-01-01' AND '1997-12-31');

-- Pronađite nazive tvrtki koje nisu ostvarile narudžbu 1997 g.
SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID
 FROM Orders
 WHERE OrderDate BETWEEN '1997-01-01' AND '1997-12-31');

/* Napravite upit koji daje OrderID i OrderDate zadnje narudžbe otpremljene
u Pariz.
 Takoðer ispišite datum zadnje narudžbe bez obzira na grad dostave
narudžbe.
 Ispišite razliku u danima izmeðu ta dva datuma. */

SELECT TOP 1 OrderId,
 OrderDate AS Last_Paris_Order,
 (SELECT MAX(OrderDate) FROM Northwind.dbo.Orders) Last_OrderDate,
 DATEDIFF(dd,OrderDate,(SELECT MAX(OrderDate) FROM
Northwind.dbo.Orders)) Day_Diff
 FROM Northwind.dbo.Orders
 WHERE ShipCity = 'Paris'
 ORDER BY OrderDate DESC

/*
Ispišite narudžbe i datume narudžbi svih zaposlenika iz Londona ugnjezdeni join podupit
*/
SELECT OrderId,
 Orderdate,
 FirstName,
 LastName
FROM (SELECT EmployeeId, FirstName, LastName
 FROM Employees
 WHERE city = 'London') e
JOIN Orders o
 ON o.EmployeeId = e.EmployeeId

-- Pronaðite naziv kupca koji je ostvario narudžbu OrderId = 10248
SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID = (SELECT CustomerID
 FROM Orders
 WHERE OrderId = 10248)

/*
Ispišite listu narudžbi kod kojih kupac nije kupio više od 10% prosjeène
količine prodaje za odreðeni proizvod,
u svrhu odreðivanje razloga male naručene količine.
*/
SELECT DISTINCT OrderId
 FROM "Order Details" od
WHERE Quantity > (SELECT AVG(Quantity) * .1
 FROM "Order Details"
 WHERE od.ProductID = ProductID)
ORDER BY OrderId
/* Ispišite listu kupaca koji su naručili više do 20 komada proizvoda
ProductID = 23 u jednoj narudžbi. */
SELECT OrderID, CustomerID
FROM Orders o
WHERE 20 < (SELECT Quantity
 FROM [Order Details] od
 WHERE o.OrderID = od.OrderID AND od.ProductID = 23)

/* Ovaj primjer koristi korelirani podupit s EXISTS ključnom riječi za
dohvaćanje liste zaposlenika koji su zaprimili narudžbe 9/2/97 */
SELECT LastName, EmployeeID
FROM Employees e
WHERE EXISTS (SELECT * FROM Orders
 WHERE e.EmployeeID = Orders.EmployeeID
 AND OrderDate = '9/5/97')

-- Dodajte novog zaposlenika
INSERT INTO Employees
(LastName, FirstName, Title, TitleOfCourtesy,
BirthDate, HireDate, Address, City, Region,
PostalCode, Country, HomePhone, Extension)
VALUES ('Dunn','Nat','Sales Representative','Mr.','19-Feb-1970',
'15-Jan-2004','4933 Jamesville Rd.','Jamesville','NY',
'13078','USA','315-555-5555','130');
-- Dodajte novu regiju
INSERT Region (RegionID, RegionDescription) VALUES (5, 'NorthWestern')


--Dodajte novu narudžbu koja je kopija narudžbe ORDERID = 10248
INSERT INTO Orders
SELECT
CustomerID
 ,EmployeeID
 ,OrderDate
 ,RequiredDate
 ,ShippedDate
 ,ShipVia
 ,Freight
 ,ShipName
 ,ShipAddress
 ,ShipCity
 ,ShipRegion
 ,ShipPostalCode
 ,ShipCountry
FROM Orders
WHERE ORDERID = 10248

-- Ažurirajte zaposlenike čije je ime Nat na način da ime postane Nathaniel
UPDATE Employees
SET FirstName = 'Nathaniel'
WHERE FirstName = 'Nat';
/* Ažurirajte kupca s CustomerID = 'ALFKI':
promijenite ContactName u 'Ann Smith', ContactTitle u 'Marketing manager'
*/
UPDATE Customers
SET ContactName = 'Ann Smith',
ContactTitle = 'Marketing manager'
WHERE CustomerID = 'ALFKI'

-- Izbrišite zaposlenike čije je ime 'Nathaniel'
DELETE FROM Employees
WHERE FirstName = 'Nathaniel';
-- Izbrišite sve narudžbe ostvarene 1995 godine
DELETE FROM [Order Details]
WHERE OrderID IN
(SELECT OrderID FROM [Orders]
WHERE YEAR(OrderDate) = 1995)

DELETE FROM [Orders]
WHERE YEAR(OrderDate) = 1995

--1. Unesite novog zaposlenika u tablicu Employees. Koristite svoje osobne podatke.

INSERT INTO Employees
(LastName, FirstName, Title, TitleOfCourtesy,
BirthDate, HireDate, Address, City, Region,
PostalCode, Country, HomePhone, Extension)
VALUES ('Josip','Barisic','Sales Representative','Mr.','1-Jan-2000',
'1-Jan-2010','4933 Jamesville Rd.','Jamesville','NY',
'13078','USA','315-555-5555','130');

--2. Unesite dvije nove narudžbe, te njihove stavke za novo kreiranog zaposlenika.

USE [Northwind]
GO

INSERT INTO [dbo].[Orders]
           ([CustomerID]
           ,[EmployeeID]
           ,[OrderDate]
           ,[RequiredDate]
           ,[ShippedDate]
           ,[ShipVia]
           ,[Freight]
           ,[ShipName]
           ,[ShipAddress]
           ,[ShipCity]
           ,[ShipRegion]
           ,[ShipPostalCode]
           ,[ShipCountry])
     VALUES
           ('ALFKI'
           ,11
           ,'2000-01-01 11:11:11.1111'
		   ,'2000-02-02 22:11:11.1111'
		   ,'2000-01-02 11:11:11.1111'
           ,2
           ,33.3333
           ,'Hanari'
           ,'Poljicka 2'
           ,'Split'
           ,'Splitsko-dalmatinska'
           ,'111'
           ,'Hrvatska'),
		   ('ALFKI'
           ,11
           ,'2001-01-01 11:11:11.1111'
		   ,'2001-02-02 22:11:11.1111'
		   ,'2001-01-02 11:11:11.1111'
           ,3
           ,44.4333
           ,'Hanari'
           ,'Poljicka 22'
           ,'Split'
           ,'Splitsko-dalmatinska'
           ,'333'
           ,'Hrvatska')
           
GO

SELECT *
FROM Orders
WHERE EmployeeID = 10

--3. Ažurirajte novo unesenog zaposlenika tako da dodate vrijednosti u sva ne unesena polja.

UPDATE [dbo].[Employees]
SET [HomePhone] = '(12) 345-6789'
WHERE EmployeeID = 10
SELECT * FROM Employees

--4. Promijenite ID novo unesenog zaposlenika na novu vrijednost, te ažurirajte s njim povezane novo
--unesene zapise. (NE MORAMO)

--5. Izbrišite novog zaposlenika i s njim povezane zapise u svim tablicama.
--Ukoliko je moguæe, koristite ugniježðene upite umjesto eksplicitnog navoðenja atributa s ID-om
--zapisa) .

DELETE FROM Orders
WHERE EmployeeID = 10

DELETE FROM Employees
WHERE EmployeeID = 10

SELECT *
FROM Employees


/*Kreirajte sljedeće korisničke funkcije, te SELECT izraz koji ih poziva.
1. Funkciju fnIznosStavke koja računa iznos stavke narudžbe.
Ispišite sve stavke narudžbi te ukupan iznos svake od njih korištenjem prethodno definirane
funkcije.
2. Funkciju koja vraća one stavke narudžbi čiji je ukupan iznos veći od vrijednosti proslijeđene
kao argument funkcije. Napravite SELECT izraz koji poziva tako definiranu funkciju.
3. Napišite SQL izraze koji brišu prethodno kreirane objekte.
Izradite sljedeće pohranjene procedure, te pozive procedura:
1. Proceduru spSelectAllProducts koja ispisuje sadržaj tablice Products.
2. Proceduru spSelectProduct koja ispisuje podatke o artiklu, za točno određeni artikl. Id artikla
treba proslijediti kao parametar procedure.
3. Proceduru UpdateProductPrice koja određenom artiklu mijenja cijene u novu vrijednosti.
4. Proceduru spSalesReport koja daje ime, prezime broj narudžbi i ukupan iznos narudžbi
određenog zaposlenika unutar određenog vremenskog perioda.
Procedura prima 4 parametra
 @startOrderDate
 @endOrderDate
 @firstName
 @lastName
5. Napišite SQL izraze koji brišu prethodno kreirane pohranjene procedure*/


----1.1
--CREATE FUNCTION fnIznosStavke (@UnitPrice DECIMAL, @Quantity INT, @Discount DECIMAL)
--RETURNS DECIMAL
--AS
--BEGIN
--RETURN (@UnitPrice*@Quantity)-(@UnitPrice*@Quantity*@Discount)
--END
--GO

--SELECT * FROM dbo.fnIznosStavke (500.00,2,5.5)

----1.2
--CREATE FUNCTION fnStavkeVeceOd (@UkupanIznos DECIMAL)
--RETURNS TABLE
--AS
--RETURN
--(
--SELECT *, dbo.fnIznosStavke(UnitPrice,Quantity,Discount) AS Ukupno
--FROM "Order Details"
--WHERE dbo.fnIznosStavke(UnitPrice,Quantity,Discount) > @UkupanIznos
--)
--GO

--SELECT *
--FROM dbo.fnStavkeVeceOd (500.0)

----1.3
--DROP FUNCTION fnStavkeVeceOd

--DROP FUNCTION fnIznosStavke

----2.1
--CREATE PROCEDURE spSelectAllProducts
--AS
--SELECT *
--FROM Products

--EXEC spSelectAllProducts

----2.2
--CREATE PROCEDURE spSelectProduct @ProductID INT
--AS
--SELECT *
--FROM Products
--WHERE ProductID = @ProductID

--EXEC spSelectProduct '7'

----2.3
--CREATE PROCEDURE UpdateProductPrice @ProductID INT, @NewPrice DECIMAL (10,2)
--AS
--UPDATE Products
--SET UnitPrice = @NewPrice

--EXEC UpdateProductPrice '7','35.00'

----2.4
--CREATE PROCEDURE spSalesReport (@StartOrderDate datetime, @EndOrderDate datetime,@FirstName NVARCHAR(10),@LastName NVARCHAR(10))
--AS
--SELECT e.EmployeeID,FirstName,LastName,COUNT(*) AS OrderTotal
--FROM Orders o INNER JOIN Employees e
--ON o.EmployeeID = e.EmployeeID
--WHERE FirstName = @FirstName
--AND LastName = @LastName
--AND OrderDate BETWEEN @StartOrderDate AND @EndOrderDate
--GROUP BY e.EmployeeID,FirstName,LastName

--EXEC spSalesReport '1996-07-04 00:00:00.000', '1998-05-06 00:00:00.000', 'Andrew', 'Fuller'


----2.5
--DROP PROCEDURE spSalesReport
--DROP PROCEDURE spSelectProduct
--DROP PROCEDURE spSelectAllProduc

/* Kreirai korisničku funkciju koja odreðuje je li potrebno ponovno
naručiti proizvod. */
CREATE FUNCTION fnNeedToReorder (@nReorderLevel INT, @nUnitsInStock INT,
 @nUnitsOnOrder INT)
 RETURNS VARCHAR(3)
AS
BEGIN
 DECLARE @sReturnValue VARCHAR(3)
 IF ((@nUnitsInStock + @nUnitsOnOrder) - @nReorderLevel) < 0
SET @sReturnValue = 'Yes'
 ELSE
 SET @sReturnValue = 'No'
 RETURN @sReturnValue
END
GO
SELECT ProductID,
 ReorderLevel,
 UnitsInStock,
 UnitsOnOrder,
 dbo.fnNeedToReorder(ReorderLevel, UnitsInStock, UnitsOnOrder) AS
needToReorder
 FROM Products

Korisničke inline funkcije mogu se referirati odnosno povezivati poput tablica, jer vraćaju skup zapisa
preko podatkovnog tipa TABLE.
/* Izraditi funkciju koja vraća sve zaposlenike iz određenog grada */
CREATE FUNCTION fnGetEmployeesByCity (@sCity VARCHAR(30))
 RETURNS TABLE
AS
RETURN
 (
 SELECT FirstName, LastName, Address
 FROM Employees
 WHERE City = @sCity
 )
GO
SELECT * FROM fnGetEmployeesByCity('seattle')

Multistatement korisničke funkcije eksplicitno definiraju strukturu tablice koju vraćaju, preko naziva
atributa i tipova podataka odmah nakon RETURNS izraza.
/* Izraditi funkciju koja vraæa sve zaposlenike iz odreðenog grada.
Ukoliko za poslenici ne postoje, ispisati: Nije pronaðen niti jedan
zaposlenik u danom gradu.*/
CREATE FUNCTION fnGetEmployeesByCity3 (@sCity VARCHAR(30))
 RETURNS @tblMyEmployees TABLE
 (
 FirstName VARCHAR(20),
 LastName VARCHAR(40),
 Address VARCHAR(120)
 )
AS
BEGIN
 INSERT @tblMyEmployees
 SELECT FirstName, LastName, Address
 FROM Employees
 WHERE City = @sCity
 ORDER BY LastName
 IF NOT EXISTS (SELECT * FROM @tblMyEmployees)
 INSERT @tblMyEmployees (Address)
 VALUES ('Nije pronaðen niti jedan zaposlenik u danom gradu.')

 RETURN
END
SELECT * FROM fnGetEmployeesByCity3('Split')

Ukoliko je postojeću funkciju potrebno izmijeniti, jednostavno zamjenjujemo ključnu riječ CREATE sa
ključnom riječju ALTER .
ALTER FUNCTION fnNeedToReorder (@nReorderLevel INT, @nUnitsInStock INT,
 @nUnitsOnOrder INT)
 RETURNS VARCHAR(3)
AS
BEGIN
 DECLARE @sReturnValue VARCHAR(3)
 IF ((@nUnitsInStock + @nUnitsOnOrder) - @nReorderLevel) < 0
 SET @sReturnValue = 'Yes'
 ELSE
 SET @sReturnValue = 'No'
 RETURN @sReturnValue
END



DROP FUNCTION fnNeedToReorder


ALTER PROCEDURE InsertEmployee
(@fname NVARCHAR(10), @lname NVARCHAR(20),@title NVARCHAR(30),@country
NVARCHAR(15))
AS
INSERT INTO Employees (FirstName, LastName, Title, COUNTRY)
VALUES (@fname, @lname, @title, @country)
RETURN @@IDENTITY


--- u tablicu Region dodati zapis u kojem æe polje RegionDescription imati vrijednost “ISEA”
--INSERT INTO dbo.Region (RegionID,RegionDescription)
--VALUES (5,'ISEA');

--ovako imamo provjeru prije mjenjanja podataka, mozemo provjeriti koji je zadnji TerritoryID jer dupliciranje IDeva nije dozvoljeno
--SELECT *
--FROM dbo.Territories
--ORDER BY TerritoryID

--u tablicu Territories dodati zapise koji za TeritoryDescription imaju vrijednosti “Grèka”,
--“Slovenija”, “Italija” te trebaju pripadati regiji “ISEA”

--INSERT INTO dbo.Territories (TerritoryID,TerritoryDescription,RegionID)
--VALUES (98105,'Grèka',5),(98106,'Slovenija',5),(98107,'Italija',5)

--2. Napisati izraz koji æe za sve zapise u tablici Teritories koji pripadaju regiji “ISEA” ažurirati na
--postojeæe ime s dodanim sufiksom “_ISEA” npr. “Grèka”->”Grèka_ISEA” (5%)

SELECT *
FROM dbo.Territories
ORDER BY TerritoryID

--NA SET LINIJI MOZEMO na isti naèin s plusom spojiti ime i prezime ako to bude u zadatku na obrani
--Trim necemo koristiti na obrani

--UPDATE dbo.Territories
--SET TerritoryDescription = RTRIM(TerritoryDescription) + '_ISEA'
--WHERE RegionID = 5

--3. Napisati izraz koji æe izbrisati podatke iz tablice Territories koji su u regiji “ISEA” (koristiti
--podupit za pronalazak RegionID) (10%)

----s podupitom
--DELETE FROM Territories 
--WHERE RegionID = (
--    SELECT RegionID 
--    FROM Region 
--    WHERE RegionDescription = 'ISEA'
--);
----bez podupita
--DELETE t
--FROM Territories t
--JOIN Region r ON t.RegionID = r.RegionID AND r.RegionDescription = 'ISEA';

--4. Izraditi proceduru sp_DodajPrijevoznika koja æe dodati jedan novi zapis u tablicu Shippers.
--Sve potrebne vrijednosti poslati kao ulazne parametre.
--Napisati sql naredbu kojom se izvršava procedura. (10%)

--sa "@" oznacavamo sve sto je poslano funkciji kao parametar, obavezno pozvat funkciju nakon izraza
--script table as -> insert to -> enter; ovdje cemo provjerit tip podatka koji mjenjamo npr "@CompanyName nvarchar(40), @Phone nvarchar(24)"

--GO
--CREATE PROCEDURE sp_DodajPrijevoznika
--    @CompanyName nvarchar(40),
--    @Phone nvarchar(24)
--AS
--BEGIN
--    INSERT INTO Shippers (CompanyName, Phone)
--    VALUES (@CompanyName, @Phone);
--END;

--EXEC sp_DodajPrijevoznika 'JOZO Shipping', '(666) 123-4567';

----neobavezno ali brisanje procedure
--DROP PROCEDURE sp_DodajPrijevoznika;

SELECT *
FROM Shippers

--5. Izraditi proceduru sp_DodajNarudzbu koja dodaje jednu novu narudžbu u tablicu Orders
--dodati redak sa istim vrijednostima kao i ORDERID = 11077 osim vrijednosti Shipper-a
--(ShipVia) koji treba biti proslijeðen kao parametar u proceduru.
--Napisati sql naredbu kojom se izvršava procedura. (10%)

--GO
--CREATE PROCEDURE sp_DodajNarudzbu
--    @ShipperID int
--AS
--BEGIN
--    INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
--    SELECT CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, @ShipperID, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry
--    FROM Orders
--    WHERE OrderID = 11077;
--END;

--EXEC sp_DodajNarudzbu @ShipperID = 3;

--DROP PROCEDURE sp_DodajNarudzbu
--Ova pohranjena procedura ima jedan ulazni parametar: @ShipperID.
--Kada se procedura izvrši, ona æe dodati novu narudžbu u tablicu Orders s vrijednostima koje su jednake onima u retku s ORDERID-om 11077,
--osim vrijednosti Shipper-a koji æe biti postavljen na vrijednost proslijeðenu kao ulazni parametar.

SELECT * 
FROM Orders

--6. Izraditi proceduru sp_AzurirajProizvode koja æe ažurirati sve zapise iz tablice Products na
--naèin da se polje ReorderLevel ažurira za onoliko puta koliko definira parametar procedure.
--Napisati sql naredbu kojom se izvršava procedura. (15%)

--GO
--CREATE PROCEDURE sp_AzurirajProizvode (@BrojPonavljanja int)
--AS
--BEGIN
--    UPDATE Products
--    SET ReorderLevel = ReorderLevel * @BrojPonavljanja;
--END;

--EXEC sp_AzurirajProizvode @BrojPonavljanja = 2;

--DROP PROCEDURE sp_AzurirajProizvode;

--Ova pohranjena procedura ima jedan ulazni parametar: @BrojPonavljanja.
--Kada se procedura izvrši, ona æe ažurirati sva polja ReorderLevel u tablici Products tako da
--se vrijednosti pomnože s vrijednošæu proslijeðenom kao ulazni parametar.

--7. Izraditi funciju fn_TimesSold koja æe u obliku tablice (ProductId, ProductName,
--BrojPutaProdan) ispisati podatke o onim proizvodima koji su do sada prodani više puta od
--broja koji se proslijeðuje kao parametar funkcije.
--Napisati naredbu kojom se izvršava funkcija. (15%)

--GO
--CREATE FUNCTION fn_TimesSold (@BrojPutaProdan int)
--RETURNS TABLE
--AS
--RETURN
--(
--    SELECT p.ProductID, p.ProductName, COUNT(od.OrderID) AS BrojPutaProdan
--    FROM Products p
--    JOIN [Order Details] od ON p.ProductID = od.ProductID
--    GROUP BY p.ProductID, p.ProductName
--    HAVING COUNT(od.OrderID) > @BrojPutaProdan
--)

SELECT * FROM fn_TimesSold(5);

--DROP FUNCTION fn_TimesSold;


--Ova funkcija ima jedan ulazni parametar: @BrojPutaProdan. 
--Funkcija æe vratiti tablicu s tri stupca: ProductID, ProductName i BrojPutaProdan. 
--U ovoj tablici bit æe prikazani samo oni proizvodi koji su prodani više puta nego što je navedeno u ulaznom parametru.



--Query that displays the Id of each order (OrderID) on which the ProductID = 23 was sold, the quantity by which that product was sold on the item, and the maximum quantity by which any product was sold.


SELECT OrderID, Quantity,
(SELECT MAX(Quantity) FROM [Order Details]) AS MaksimalnaKolicina
FROM [Order Details]
WHERE ProductID = 23
Query that displays the ProductId, ProductName, and SupplierId for all products whose supplier (Supplier) is "Exotic Liquids" or "Tokyo Traders".


SELECT ProductID, ProductName, SupplierID
FROM Products
WHERE SupplierID IN
(SELECT SupplierID
FROM Suppliers
WHERE CompanyName IN ('Exotic Liquids', 'Tokyo Traders'))
Query that displays the ProductId and ProductName for all products that have the same price as the product named "Longlife Tofu".

SELECT ProductID, ProductName
FROM Products
WHERE UnitPrice =
(SELECT UnitPrice
FROM Products
WHERE ProductName = 'Longlife Tofu')
Query that displays all customers who have the latest orders (the latest order date).

SELECT OrderID, CustomerID
FROM Orders
WHERE OrderDate = (SELECT MAX(OrderDate)FROM Orders)
Query that displays the ProductId, ProductName of those products that have never been sold. Note: such products may not exist.

SELECT ProductID, ProductName
FROM Products
WHERE ProductID NOT IN
(SELECT DISTINCT ProductID
FROM [Order Details])
Query that displays a list of customers and their orders (CustomerId, OrderId) for which the total amount of all items per order is > 10000.

SELECT OrderID, CustomerID
FROM Orders 
WHERE 10000 <
(SELECT SUM(UnitPrice*Quantity*(1-Discount))
FROM [Order Details]
WHERE Orders.OrderID = [Order Details].OrderID)
Query that displays a list of all customers who have had deliveries to France (Orders.ShipCountry = 'France').

SELECT DISTINCT Customers.CustomerID, Customers.CompanyName
FROM Customers
WHERE EXISTS (SELECT Orders.ShipCountry FROM Orders WHERE Orders.ShipCountry = 'France')
Query to find the CustomerID of order OrderId = 10290.

SELECT CustomerID
FROM Orders
WHERE OrderID = 10290;
Query to find the company name that ordered the order OrderId = 10290.

SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID = (SELECT CustomerID
 FROM Orders
 WHERE OrderID = 10290);
Query to find the company name that placed the order OrderId = 10290. (using INNER JOIN)

SELECT CustomerID, CompanyName
FROM Customers c INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE OrderID = 10290
Query to find the names of companies that placed orders in 1997.

SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID IN (SELECT CustomerID
 FROM Orders
 WHERE OrderDate BETWEEN '1997-01-01' AND '1997-12-31');
Query to find the names of companies that did not place orders in 1997.

SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID
 FROM Orders
 WHERE OrderDate BETWEEN '1997-01-0


--function takes a ProductID as input and returns the UnitPrice of that product
CREATE FUNCTION dbo.fn_GetProductPrice(@ProductId INT)
RETURNS MONEY
AS
BEGIN
    DECLARE @Price MONEY
    
    SELECT @Price = UnitPrice
    FROM Products
    WHERE ProductID = @ProductId
    
    RETURN @Price
END

SELECT ProductName, dbo.fn_GetProductPrice(ProductID) AS Price
FROM Products




