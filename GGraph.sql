USE MASTER
GO
DROP DATABASE IF EXISTS GGraph
GO
CREATE DATABASE GGraph
GO
USE GGraph
GO

-- Создание таблицы Поставщик
CREATE TABLE Suppliers (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(100),
    ContactPerson VARCHAR(100),
    ContactNumber VARCHAR(20)
) AS NODE;

-- Создание таблицы Производитель
CREATE TABLE Manufacturers (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(100),
    ContactPerson VARCHAR(100),
    ContactNumber VARCHAR(20)
) AS NODE;

-- Создание таблицы Потребитель
CREATE TABLE Consumers (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(100),
    ContactPerson VARCHAR(100),
    ContactNumber VARCHAR(20)
) AS NODE

CREATE TABLE Delivering AS EDGE;
CREATE TABLE Supplying AS EDGE;
CREATE TABLE Working AS EDGE;

-- Заполнение таблицы Поставщик
INSERT INTO Suppliers (ID, Name, Location, ContactPerson, ContactNumber)
VALUES
    (1, 'Supplier A', 'Location A', 'John Smith', '123-456-7890'),
    (2, 'Supplier B', 'Location B', 'Jane Doe', '987-654-3210'),
    (3, 'Supplier C', 'Location C', 'Mike Johnson', '456-789-0123'),
    (4, 'Supplier D', 'Location D', 'Emily Brown', '789-012-3456'),
    (5, 'Supplier E', 'Location E', 'Chris Wilson', '321-654-0987'),
    (6, 'Supplier F', 'Location F', 'Sarah Lee', '654-321-9870'),
    (7, 'Supplier G', 'Location G', 'Alex Clark', '012-345-6789'),
    (8, 'Supplier H', 'Location H', 'Emma Taylor', '654-987-0123'),
    (9, 'Supplier I', 'Location I', 'Daniel Martinez', '987-012-3456'),
    (10, 'Supplier J', 'Location J', 'Olivia Garcia', '345-678-9012');

-- Заполнение таблицы Производитель
INSERT INTO Manufacturers (ID, Name, Location, ContactPerson, ContactNumber)
VALUES
    (1, 'Manufacturer X', 'Location X', 'Andrew Johnson', '234-567-8901'),
    (2, 'Manufacturer Y', 'Location Y', 'Jessica Brown', '567-890-1234'),
    (3, 'Manufacturer Z', 'Location Z', 'Ryan Wilson', '890-123-4567'),
    (4, 'Manufacturer W', 'Location W', 'Sophia Martinez', '123-456-7890'),
    (5, 'Manufacturer V', 'Location V', 'David Garcia', '456-789-0123'),
    (6, 'Manufacturer U', 'Location U', 'Isabella Clark', '789-012-3456'),
    (7, 'Manufacturer T', 'Location T', 'Ethan Taylor', '012-345-6789'),
    (8, 'Manufacturer S', 'Location S', 'Mia Lee', '345-678-9012'),
    (9, 'Manufacturer R', 'Location R', 'Michael Miller', '678-901-2345'),
    (10, 'Manufacturer Q', 'Location Q', 'Sophie Hernandez', '901-234-5678');

-- Заполнение таблицы Потребитель
INSERT INTO Consumers (ID, Name, Location, ContactPerson, ContactNumber)
VALUES
    (1, 'Consumer Alpha', 'Location Alpha', 'Liam Wilson', '321-654-9870'),
    (2, 'Consumer Beta', 'Location Beta', 'Olivia Taylor', '654-987-0123'),
    (3, 'Consumer Gamma', 'Location Gamma', 'Noah Lee', '987-012-3456'),
    (4, 'Consumer Delta', 'Location Delta', 'Emma Hernandez', '012-345-6789'),
    (5, 'Consumer Epsilon', 'Location Epsilon', 'William Clark', '345-678-9012'),
    (6, 'Consumer Zeta', 'Location Zeta', 'Sophia Garcia', '678-901-2345'),
    (7, 'Consumer Eta', 'Location Eta', 'James Martinez', '901-234-5678'),
    (8, 'Consumer Theta', 'Location Theta', 'Ava Brown', '234-567-8901'),
    (9, 'Consumer Iota', 'Location Iota', 'Alexander Johnson', '567-890-1234'),
    (10, 'Consumer Kappa', 'Location Kappa', 'Mia Wilson', '890-123-4567');

	INSERT INTO Working ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Suppliers WHERE id = 1),
 (SELECT $node_id FROM Suppliers WHERE id = 2)),
 ((SELECT $node_id FROM Suppliers WHERE id = 10),
 (SELECT $node_id FROM Suppliers WHERE id = 5)),
 ((SELECT $node_id FROM Suppliers WHERE id = 2),
 (SELECT $node_id FROM Suppliers WHERE id = 9)),
 ((SELECT $node_id FROM Suppliers WHERE id = 3),
 (SELECT $node_id FROM Suppliers WHERE id = 1)),
 ((SELECT $node_id FROM Suppliers WHERE id = 3),
 (SELECT $node_id FROM Suppliers WHERE id = 6)),
 ((SELECT $node_id FROM Suppliers WHERE id = 4),
 (SELECT $node_id FROM Suppliers WHERE id = 2)),
 ((SELECT $node_id FROM Suppliers WHERE id = 5),
 (SELECT $node_id FROM Suppliers WHERE id = 4)),
 ((SELECT $node_id FROM Suppliers WHERE id = 6),
 (SELECT $node_id FROM Suppliers WHERE id = 7)),
 ((SELECT $node_id FROM Suppliers WHERE id = 6),
 (SELECT $node_id FROM Suppliers WHERE id = 8)),
 ((SELECT $node_id FROM Suppliers WHERE id = 8),
 (SELECT $node_id FROM Suppliers WHERE id = 3));
GO
SELECT *
FROM Working;

INSERT INTO Supplying ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Manufacturers WHERE ID = 1),
 (SELECT $node_id FROM Suppliers WHERE ID = 1)),
 ((SELECT $node_id FROM Manufacturers WHERE ID = 5),
 (SELECT $node_id FROM Suppliers WHERE ID = 1)),
 ((SELECT $node_id FROM Manufacturers WHERE ID = 8),
 (SELECT $node_id FROM Suppliers WHERE ID = 1)),
 ((SELECT $node_id FROM Manufacturers WHERE ID = 2),
 (SELECT $node_id FROM Suppliers WHERE ID = 2)),
 ((SELECT $node_id FROM Manufacturers WHERE ID = 3),
 (SELECT $node_id FROM Suppliers WHERE ID = 3)),
 ((SELECT $node_id FROM Manufacturers WHERE ID = 4),
 (SELECT $node_id FROM Suppliers WHERE ID = 3)),
 ((SELECT $node_id FROM Manufacturers WHERE ID = 6),
 (SELECT $node_id FROM Suppliers WHERE ID = 4)),
 ((SELECT $node_id FROM Manufacturers WHERE ID = 7),
 (SELECT $node_id FROM Suppliers WHERE ID = 4)),
 ((SELECT $node_id FROM Manufacturers WHERE ID = 1),
 (SELECT $node_id FROM Suppliers WHERE ID = 9)),
 ((SELECT $node_id FROM Manufacturers WHERE ID = 9),
 (SELECT $node_id FROM Suppliers WHERE ID = 4)),
 ((SELECT $node_id FROM Manufacturers WHERE ID = 10),
 (SELECT $node_id FROM Suppliers WHERE ID = 9));
 GO
SELECT *
FROM Supplying;

INSERT INTO Delivering ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Suppliers WHERE ID = 1),
 (SELECT $node_id FROM Consumers WHERE ID = 6)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 5),
 (SELECT $node_id FROM Consumers WHERE ID = 1)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 8),
 (SELECT $node_id FROM Consumers WHERE ID = 7)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 2),
 (SELECT $node_id FROM Consumers WHERE ID = 2)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 3),
 (SELECT $node_id FROM Consumers WHERE ID = 5)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 4),
 (SELECT $node_id FROM Consumers WHERE ID = 3)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 6),
 (SELECT $node_id FROM Consumers WHERE ID = 4)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 7),
 (SELECT $node_id FROM Consumers WHERE ID = 2)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 1),
 (SELECT $node_id FROM Consumers WHERE ID = 9)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 9),
 (SELECT $node_id FROM Consumers WHERE ID = 8)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 10),
 (SELECT $node_id FROM Consumers WHERE ID = 9));
 GO
SELECT *
FROM Delivering;

SELECT Supplier1.name, Supplier2.name
FROM Suppliers AS Supplier1
	, Working
	, Suppliers AS Supplier2
WHERE MATCH(Supplier1-(Working)->Supplier2)
	AND Supplier1.name = 'Supplier C';

SELECT s.name, c.name
FROM Suppliers AS s
	, Delivering AS d
	, Consumers as c
WHERE MATCH(s-(d)->c)
AND s.name = 'Supplier A';

SELECT s.name, m.name
FROM Suppliers AS s
	, Supplying AS sp
	, Manufacturers as m
WHERE MATCH(m-(sp)->s)
AND s.name = 'Supplier A';

SELECT Supplier1.name, Supplier2.name
FROM Suppliers AS Supplier1
	, Working
	, Suppliers AS Supplier2
WHERE MATCH(Supplier1-(Working)->Supplier2)
	AND Supplier1.name = 'Supplier F';

SELECT s.name, w.name
FROM Suppliers AS s
	, Supplying AS sp
	, Manufacturers as w
WHERE MATCH(w-(sp)->s)
AND w.name = 'Manufacturer X';

SELECT Supplier1.name
	, STRING_AGG(Supplier2.name, '->') WITHIN GROUP (GRAPH PATH)
FROM Suppliers AS Supplier1
	, Working FOR PATH AS w
	, Suppliers FOR PATH AS Supplier2
WHERE MATCH(SHORTEST_PATH(Supplier1(-(w)->Supplier2)+))
	AND Supplier1.name = 'Supplier F';

	SELECT Supplier1.name
	, STRING_AGG(Supplier2.name, '->') WITHIN GROUP (GRAPH PATH)
FROM Suppliers AS Supplier1
	, Working FOR PATH AS w
	, Suppliers FOR PATH AS Supplier2
WHERE MATCH(SHORTEST_PATH(Supplier1(-(w)->Supplier2){1,3}))
	AND Supplier1.name = 'Supplier F';

SELECT Supplier1.ID AS IdFirst
	, Supplier1.name AS First
	, CONCAT(N'supplier', Supplier1.id) AS [First image name]
	, Supplier2.ID AS IdSecond
	, Supplier2.name AS Second
	, CONCAT(N'supplier', Supplier2.id) AS [Second image name]
FROM Suppliers AS Supplier1
	, Working AS w
	, Suppliers AS Supplier2
WHERE MATCH(Supplier1-(w)->Supplier2);

SELECT s.id AS IdFirst
	, s.name AS First
	, CONCAT(N'supplier', s.id) AS [First image name]
	, c.id AS IdSecond
	, c.name AS Second
	, CONCAT(N'consumer', c.id) AS [Second image name]
FROM Suppliers AS s
	, Delivering AS d
	, Consumers AS c
WHERE MATCH(s-(d)->c);

SELECT s.id AS IdFirst
	, s.name AS First
	, CONCAT(N'supplier', s.id) AS [First image name]
	, m.id AS IdSecond
	, m.name AS Second
	, CONCAT(N'manufacturer', m.id) AS [Second image name]
FROM Suppliers AS s
	, Supplying AS sp
	, Manufacturers AS m
WHERE MATCH(m-(sp)->s);

select @@servername