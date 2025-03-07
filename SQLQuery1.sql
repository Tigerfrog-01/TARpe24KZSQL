--loome db
create database TARpe24SQL
-- db valimine
use TARpe24SQL
--tabeli loomine
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

--andmete sisestamine
insert into Gender (Id, Gender)
values (2, 'male')
insert into Gender (Id, Gender)
values (1, 'female')
insert into Gender (Id, Gender)
values (3, 'Unknown')

--vaatame tabeli sisu
select * from Gender

--teeme tabeli Person

create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)
--andmete sisestamine
insert into Person (Id, Name, Email, GenderID)
values (1, 'Napoleon', 'Na.com', 2)
insert into Person (Id, Name, Email, GenderID)
values (2, 'Alexander', 'Al.com', 2),
(3, 'Caesar', 'CS.com', 2),
(4, 'Lionheart', 'LH.com', 2),
(5, 'Friedrick', 'FR.com', 2),
(6, 'Abraham', 'AB.com', 2),
(7, 'Lennart', 'LN.com', 2),
(8, 'Laidoner', 'LR.com', 2),
(9, NULL, NULL, 2)

--soovime vaadata Person tabeli andmeid
select * from Person 

-- v��rv�tme �henduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

--kui sisestad uue rea andmeid ja ei ole sisestanud GenderId alla v��rtust
--siis see automaatslet sisestab sellele reale v��rtuse 3 e nagu meil
-- on unknown
alter table Person
add constraint DF_Persons_GenderId
default 3 for GenderId
--
insert into Person (Id, Name, Email)
values (10, 'Cleopatra', 'CL.com')

insert into Person (Id, Name, Email)
values (11, 'delete', 'del.com')

-- piirangu kustutamine
alter table person
drop constraint DF_Persons_GenderId

-- lisame uue veeru
alter table Person
add age nvarchar(10)

--lisame nr piirangu vanuse sisestamisel
alter table Person
add constraint CK_Person_Age check (Age > 0  and Age < 155)

--kustutame rea
delete from Person where Id = 9

select * from Person

--kuidas uuendada andmeid 
update Person
set Age = 30 
where Id = 4

alter table Person
add City nvarchar(50)

--k�ik kes elavad Tallinnas
select*from Person where City = 'Tallinn'
--k�ik kes ei ela Tallinnas
select*from Person where City != 'Tallinn'

--aitab teatud vanusega inimesi
select * from Person where Age = 70 or Age = 30 or Age = 20


--aitab teatud vanusevahemikus olevaid inimesi
select * from Person where (Age > 0  and Age < 50)
select * from Person where Age between 0 and 30

-- wildcard e n�itab k�ik g-t�hega linnad
select * from Person where City like 't%'
--k�ik emailid, kus on @-mrk emailis
select * from Person where Email like '%@%'

--n�itab k�iki, kellel ei ole @-m�rki emailis
select * from Person where Email not like '%@%'

-- tund 2 07.03.2025
-- n�itab kellel on emailis ees ja peale @-m�rki ainult �ks t�ht
select * from Person where Email like '_@_.com'
--k�ik kellel on nimes esimene t�ht W, A, S
select * from Person where name like '[^N]%'
select * from Person

--kes elavad Roomas ja Tallinnas
select * from Person where City = 'Rome' or City = 'Tallinn'

--k�ik, kes elavad Roomas ja Tallinnas ja on vanemad kui 29
select * from Person where City = 'Rome' or City = 'Tallinn' and (Age > 29) 

--kuvab t�hestikulises j�rjekorras inimesi ja v�tab auseks nime

select * from Person order by name

--sama p�ring, aga vastupidi j�rjestuses on nimed

select * from Person order by name desc

--v�tab kolm esimest rida

select top 3 * from Person

--kolm esimest, aga tabeli j�rjestus on Age ja siis Name

select top 3 Age, name From Person

--n�itab esimesed 50% tabelis

select top 50 percent * from Person 

--j�rjestame vanuse j�rgi isikud

select * from Person order by Age desc

--muudab Age muutuja intiks

select * from Person order by cast(Age as int)

--k�ikide isikute koondvanus

select sum(cast(Age as int)) from Person

--kuvab k�ige nooremat isikud

SELECT TOP 1 * FROM Person ORDER BY Age;

select min(cast(Age as int)) from Person

--kuvab k�ige vanemat isikut

select max(cast(Age as int)) from Person

SELECT TOP 1 * FROM Person ORDER BY Age desc;

--konkreetsetes linnades olevate isikute koondvanus
-- enne oli Age nvarchar, aga muudame selle int andmet��biks

select City, sum(Age) as totalAge from Person group by City

--kuidas saab koodiga muuta andmet��pi ja sellest pikkust

alter table Person
alter column Name nvarchar(30)

--kuvab esimes reas v�lja toodud j�rjestuses ja kuvab TotalAge-ks
-- j�rjestab City-s olevate nime j�rgi ja siis GenderId j�rgi

select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId order by City

--n�itab ridade arvu tabelis

select count(*) from Person 
Select * from Person

--n�itab tulemust, et mitu inimest on genderId v��rtusega 2 konkreetses linnas
-- arvutab vanuse kokku selles linnas

select GenderId, city, sum(Age) as TotalAge, count(Id) as [Total Person(s)]
from Person 
Where GenderId = '2'
group by GenderId, City

--loome, tabelid Employees ja Department

create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)