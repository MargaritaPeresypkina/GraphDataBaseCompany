USE master;
DROP DATABASE IF EXISTS Company;
go
CREATE DATABASE Company;
go
USE Company;
go

CREATE TABLE Employee
(
id INT NOT NULL PRIMARY KEY,
name NVARCHAR(50) NOT NULL
) AS NODE;

CREATE TABLE City
(
id INT NOT NULL PRIMARY KEY,
name NVARCHAR(30) NOT NULL,
region NVARCHAR(30) NOT NULL
) AS NODE;

CREATE TABLE Office
(
id INT NOT NULL PRIMARY KEY,
name NVARCHAR(50) NOT NULL,
city NVARCHAR(30) NOT NULL
) AS NODE;


CREATE TABLE InProjectWith AS EDGE; 
CREATE TABLE WorkIn (workExperience INT) AS EDGE; 
CREATE TABLE LivesIn AS EDGE; 
CREATE TABLE LocatedIn AS EDGE; 

ALTER TABLE InProjectWith
ADD CONSTRAINT EC_InProjectWith CONNECTION (Employee TO Employee);
ALTER TABLE LivesIn
ADD CONSTRAINT EC_LivesIn CONNECTION (Employee TO City);
ALTER TABLE LocatedIn
ADD CONSTRAINT EC_LocatedIn CONNECTION (Office TO City);
ALTER TABLE WorkIn
ADD CONSTRAINT EC_WorkIn CONNECTION (Employee TO Office);


INSERT INTO Employee (id, name)
VALUES (1, N'Анна'),
 (2, N'София'),
 (3, N'Кирилл'),
 (4, N'Алина'),
 (5, N'Виталий'),
 (6, N'Марк'),
 (7, N'Дина'),
 (8, N'Ульяна'),
 (9, N'Андрей'),
 (10, N'Илья'),
 (11, N'Ольга'),
 (12, N'Ян');
GO
SELECT *
FROM Employee;

INSERT INTO City (id, name, region)
VALUES (1, N'Минск', N'Минская'),
 (2, N'Борисов', N'Минская'),
 (3, N'Гомель', N'Гомельская'),
 (4, N'Молодечно', N'Минская'),
 (5, N'Лида', N'Гродненская'),
 (6, N'Гродно', N'Гродненская'),
 (7, N'Витебск', N'Витебская'),
 (8, N'Брест', N'Брестская'),
 (9, N'Могилёв', N'Могилёвская'),
 (10, N'Бобруйск', N'Могилёвская ');
GO
SELECT *
FROM City;

INSERT INTO Office (id, name, city)
VALUES (1, N'Офис 1', N'Минск'),
 (2, N'Офис 2', N'Борисов'),
 (3, N'Офис 3', N'Гомель'),
 (4, N'Офис 4', N'Молодечно'),
 (5, N'Офис 5', N'Лида'),
 (6, N'Офис 6', N'Гродно'),
 (7, N'Офис 7', N'Витебск'),
 (8, N'Офис 8', N'Брест'),
 (9, N'Офис 9', N'Могилёв'),
 (10, N'Офис 10', N'Бобруйск');
GO
SELECT *
FROM Office;


INSERT INTO InProjectWith ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Employee WHERE id = 1),
 (SELECT $node_id FROM Employee WHERE id = 6)),

 ((SELECT $node_id FROM Employee WHERE id = 3),
 (SELECT $node_id FROM Employee WHERE id = 6)),

 ((SELECT $node_id FROM Employee WHERE id = 2),
 (SELECT $node_id FROM Employee WHERE id = 7)),

 ((SELECT $node_id FROM Employee WHERE id = 2),
 (SELECT $node_id FROM Employee WHERE id = 3)),

 ((SELECT $node_id FROM Employee WHERE id = 1),
 (SELECT $node_id FROM Employee WHERE id = 8)),

 ((SELECT $node_id FROM Employee WHERE id = 4),
 (SELECT $node_id FROM Employee WHERE id = 2)),

 ((SELECT $node_id FROM Employee WHERE id = 7),
 (SELECT $node_id FROM Employee WHERE id = 3)),

 ((SELECT $node_id FROM Employee WHERE id = 3),
 (SELECT $node_id FROM Employee WHERE id = 9)),

 ((SELECT $node_id FROM Employee WHERE id = 5),
 (SELECT $node_id FROM Employee WHERE id = 4)),

 ((SELECT $node_id FROM Employee WHERE id = 8),
 (SELECT $node_id FROM Employee WHERE id = 10)),

 ((SELECT $node_id FROM Employee WHERE id = 9),
 (SELECT $node_id FROM Employee WHERE id = 10)),

 ((SELECT $node_id FROM Employee WHERE id = 10),
 (SELECT $node_id FROM Employee WHERE id = 5)),

 ((SELECT $node_id FROM Employee WHERE id = 1),
 (SELECT $node_id FROM Employee WHERE id = 11)),

 ((SELECT $node_id FROM Employee WHERE id = 11),
 (SELECT $node_id FROM Employee WHERE id = 10)),

 ((SELECT $node_id FROM Employee WHERE id = 12),
 (SELECT $node_id FROM Employee WHERE id = 4));
GO
SELECT *
FROM InProjectWith;


INSERT INTO LivesIn ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Employee WHERE ID = 1),
 (SELECT $node_id FROM City WHERE ID = 1)),

 ((SELECT $node_id FROM Employee WHERE ID = 2),
 (SELECT $node_id FROM City WHERE ID = 2)),

 ((SELECT $node_id FROM Employee WHERE ID = 11),
 (SELECT $node_id FROM City WHERE ID = 2)),

 ((SELECT $node_id FROM Employee WHERE ID = 3),
 (SELECT $node_id FROM City WHERE ID = 3)),

 ((SELECT $node_id FROM Employee WHERE ID = 4),
 (SELECT $node_id FROM City WHERE ID = 4)),

  ((SELECT $node_id FROM Employee WHERE ID = 12),
 (SELECT $node_id FROM City WHERE ID = 4)),
 
 ((SELECT $node_id FROM Employee WHERE ID = 5),
 (SELECT $node_id FROM City WHERE ID = 5)),
 
 ((SELECT $node_id FROM Employee WHERE ID = 6),
 (SELECT $node_id FROM City WHERE ID = 6)),
 
 ((SELECT $node_id FROM Employee WHERE ID = 7),
 (SELECT $node_id FROM City WHERE ID = 7)),
 
 ((SELECT $node_id FROM Employee WHERE ID = 8),
 (SELECT $node_id FROM City WHERE ID = 8)),
 
 ((SELECT $node_id FROM Employee WHERE ID = 9),
 (SELECT $node_id FROM City WHERE ID = 9)),
 
 ((SELECT $node_id FROM Employee WHERE ID = 10),
 (SELECT $node_id FROM City WHERE ID = 10));
 GO
SELECT *
FROM LivesIn;


INSERT INTO LocatedIn ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Office WHERE ID = 1),
 (SELECT $node_id FROM City WHERE ID = 1)),

 ((SELECT $node_id FROM Office WHERE ID = 2),
 (SELECT $node_id FROM City WHERE ID = 2)),

 ((SELECT $node_id FROM Office WHERE ID = 3),
 (SELECT $node_id FROM City WHERE ID = 3)),

 ((SELECT $node_id FROM Office WHERE ID = 4),
 (SELECT $node_id FROM City WHERE ID = 4)),

 ((SELECT $node_id FROM Office WHERE ID = 5),
 (SELECT $node_id FROM City WHERE ID = 5)),

 ((SELECT $node_id FROM Office WHERE ID = 6),
 (SELECT $node_id FROM City WHERE ID = 6)),

 ((SELECT $node_id FROM Office WHERE ID = 7),
 (SELECT $node_id FROM City WHERE ID = 7)),

 ((SELECT $node_id FROM Office WHERE ID = 8),
 (SELECT $node_id FROM City WHERE ID = 8)),

 ((SELECT $node_id FROM Office WHERE ID = 9),
 (SELECT $node_id FROM City WHERE ID = 9)),

 ((SELECT $node_id FROM Office WHERE ID = 10),
 (SELECT $node_id FROM City WHERE ID = 10));
GO
SELECT *
FROM LocatedIn;


INSERT INTO WorkIn ($from_id, $to_id, workExperience)
VALUES ((SELECT $node_id FROM Employee WHERE ID = 1),
 (SELECT $node_id FROM Office WHERE ID = 1), 12),

 ((SELECT $node_id FROM Employee WHERE ID = 2),
 (SELECT $node_id FROM Office WHERE ID = 2), 7),

 ((SELECT $node_id FROM Employee WHERE ID = 11),
 (SELECT $node_id FROM Office WHERE ID = 1), 6),

 ((SELECT $node_id FROM Employee WHERE ID = 3),
 (SELECT $node_id FROM Office WHERE ID = 3), 9),

 ((SELECT $node_id FROM Employee WHERE ID = 4),
 (SELECT $node_id FROM Office WHERE ID = 4), 5),

 ((SELECT $node_id FROM Employee WHERE ID = 12),
 (SELECT $node_id FROM Office WHERE ID = 4), 15),

 ((SELECT $node_id FROM Employee WHERE ID = 5),
 (SELECT $node_id FROM Office WHERE ID = 5), 4),

 ((SELECT $node_id FROM Employee WHERE ID = 6),
 (SELECT $node_id FROM Office WHERE ID = 6), 11),

 ((SELECT $node_id FROM Employee WHERE ID = 7),
 (SELECT $node_id FROM Office WHERE ID = 7), 21),

 ((SELECT $node_id FROM Employee WHERE ID = 8),
 (SELECT $node_id FROM Office WHERE ID = 8), 6),

 ((SELECT $node_id FROM Employee WHERE ID = 9),
 (SELECT $node_id FROM Office WHERE ID = 9), 16),

 ((SELECT $node_id FROM Employee WHERE ID = 10),
 (SELECT $node_id FROM Office WHERE ID = 10), 8);

GO
SELECT *
FROM WorkIn; 


--Найти всех сотрудников, которые состоят в проекте, где Анна является руководителем
SELECT Employee1.name
 , Employee2.name AS [names of employees in the project]
FROM Employee AS Employee1
 , InProjectWith
 , Employee AS Employee2
WHERE MATCH(Employee1-(InProjectWith)->Employee2)
 AND Employee1.name = N'Анна';

 --Найти всех сотрудников, где руководителем проекта является сотрудник, который состоит в другом проекте, руководителем которого является Анна
 SELECT employee1.name + N' состоит в одном проекте с ' + employee2.name AS Level1
 , employee2.name + N' состоит в одном проекте с ' + employee3.name AS Level2
FROM Employee AS employee1
 , InProjectWith AS projectEmployee1
 , Employee AS employee2
 , InProjectWith AS projectEmployee2
 , Employee AS employee3
WHERE MATCH(employee1-(projectEmployee1)->employee2-(projectEmployee2)->employee3)
 AND employee1.name = N'Анна';


 --В каких офисах работают сотрудники, которые состоят в проекте, где Анна является руководителем
 SELECT employee2.name AS employee
 , Office.name AS office
FROM Employee AS employee1
 , Employee AS employee2
 , WorkIn
 , InProjectWith
 , Office
WHERE MATCH(employee1-(InProjectWith)->employee2-(WorkIn)->Office)
 AND employee1.name = N'Анна';


 --Какой стаж у сотрудников в офисах городов, в которых они живут
 SELECT Employee.name AS employee
 , Office.name AS office
 , WorkIn.workExperience
 , City.name AS city
FROM Employee
 , WorkIn
 , Office
 , LivesIn
 , City
 , LocatedIn
WHERE MATCH (Employee-(WorkIn)->Office-(LocatedIn)->City
 AND Employee-(LivesIn)->City)



  --Какой стаж у сотрудников в офисах городов, в которых они не живут
 SELECT Employee.name AS employee
 , City.name AS [Город проживания]
 , Office.name AS office
 , WorkIn.workExperience
 , City2.name AS [Город размещения офиса]
FROM Employee
 , WorkIn
 , Office
 , LivesIn
 , City
 , City AS City2
 , LocatedIn
WHERE MATCH (City<-(LivesIn)-Employee-(WorkIn)->Office-(LocatedIn)->City2)
 AND City.name <> City2.name


 --Ян хочет пригласить Кирилла в свой проект, для этого ему нужно найти кратчайший путь, чтобы связаться с ним
 --Кратчайший путь от Яна до Кирилла 
DECLARE @EmployeeFrom AS NVARCHAR(30) = N'Ян';
DECLARE @EmployeeTo AS NVARCHAR(30) = N'Кирилл';
WITH T1 AS
(
SELECT Employee1.name AS EmployeeName
 , STRING_AGG(Employee2.name, '->') WITHIN GROUP (GRAPH PATH)
AS RequireEmployee
 , LAST_VALUE(Employee2.name) WITHIN GROUP (GRAPH PATH) AS
LastNode
FROM Employee AS Employee1
 , InProjectWith FOR PATH AS ipw
 , Employee FOR PATH AS Employee2
WHERE MATCH(SHORTEST_PATH(Employee1(-(ipw)->Employee2)+))
 AND Employee1.name = @EmployeeFrom
)
SELECT EmployeeName, RequireEmployee
FROM T1
WHERE LastNode = @EmployeeTo;


--Найти всех сотрудников в радиусе 3 руководителей проектов от Софии
SELECT Employee1.name AS EmployeeName
 , STRING_AGG(Employee2.name, '->') WITHIN GROUP (GRAPH PATH)
AS Employees
FROM Employee AS Employee1
 , InProjectWith FOR PATH AS ipw
 , Employee FOR PATH AS Employee2
WHERE MATCH(SHORTEST_PATH(Employee1(-(ipw)->Employee2){1,3}))
 AND Employee1.name = N'София';