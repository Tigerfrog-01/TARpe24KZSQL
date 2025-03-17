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


--loome tabeli

insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male', 4000, 1),
(2, 'Pam', 'Female', 3000, 3),
(3, 'John', 'Male', 3500, 1),
(4, 'Sam', 'Male', 4500, 2),
(5, 'Todd', 'Male', 2800, 2),
(6, 'Ben', 'Male', 7000, 1),
(7, 'Sara', 'Female', 4800, 3),
(8, 'Valarie', 'Female', 5500, 1),
(9, 'James', 'Male', 6500, NULL),
(10, 'Russell', 'Male', 8800, NULL)

--andmete sisestamine Department tabelisse
insert into Department(Id, DepartmentName, Location, DepartmentHead)
values 
(1, 'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cindrella')

--tabeli andmete vaatamine
select * from Employees
select * from Department

-- teeme left join p�ringu
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

--arvutab k�ikide palgad kokku
select sum(cast(Salary as int)) from Employees
-- tahame teada saada min palga saajat
select min(cast(Salary as int)) from Employees

select Location, sum(cast(Salary as int)) as TotalSalary
from Employees
left join Department
on Employees.DepartmentId = Department.Id
group by Location --�he kuu palgafond linnade l�ikes

alter table Employees
add City nvarchar(30)
select * from Employees
select * from Department

--n�eme palkasid ja eristame linnades soo j�rgi
select City, Gender, sum(cast(Salary as int)) as TotalSalary 
from Employees group by City, Gender
--samasugune nagu eelmine p�ring, aga linnad paneb t�hestikulises j�rjekorras
select City, Gender, sum(cast(Salary as int)) as TotalSalary 
from Employees group by City, Gender
order by City

--mitu t��tajat on soo ja linna kaupa selles firmas
select Gender , City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City

--loeb �ra tabelis olevate ridade arvu (Employees)
select count(*) from Employees

-- kuvab ainult mehede linnade kaupa
select Gender , City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
where Gender = 'Male'
group by Gender, City

--samasugune p�ring, aga kasutame having ning k]ik naised
select Gender , City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City
having Gender = 'Female'

-- k]ik, kes teenivad palka �le 4000, siin on viga sees
select * from Employees where sum(cast(Salary as int)) > 4000
-- korrektne p�ring
select * from Employees where Salary > 4000

--kasutame having, et teha samasugune p�ring
select Gender , City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees group by Gender, City
having sum(cast(Salary as int)) > 4000
-- see on vigane p�ring
select Gender , City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees group by Gender, City
having Salary > 4000

-- loome tabeli, milles hakatakse automaatselt Id-d nummerdama
create table Test1
(
Id int identity(1,1),
Value nvarchar(20)
)
--sisestan andmed ja Id nummerdatakse automaatselt
insert into Test1 values('X')
select * from Test1

-- kustutame veeru nimega City tabelist Employees
alter table Employees
drop column City

-- inner join 
-- kuvab neid, kellel on Departmentname all olemas v��rtus
select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.Id

-- left join
-- kuidas saada k�ik andmed Employees-t k�tte saada
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

-- right join 
-- kuidas saada DepartmentName alla uus nimetus e antud juhul Other Department
select Name, Gender, Salary, DepartmentName
from Employees
RIGHT JOIN Department --v]ib kasutada ka RIGHT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

-- kuidas saada k�ikide tabelite v��rtused �hte p�ringusse
--outer join
select Name, Gender, Salary, DepartmentName
from Employees
full outer JOIN Department
on Employees.DepartmentId = Department.Id

-- cross join
select Name, Gender, Salary, DepartmentName
from Employees
cross join Department

-- p�ringu sisu
Select ColumnList
from LeftTable
joinType RightTable
on JoinCondition

--inner join
select Name, Gender, Salary, DepartmentName
from Employees
inner JOIN Department
on Employees.DepartmentId = Department.Id

-- kuidas kuvada ainult need isikud, kellel on DepartmentName NULL
--left joini kasutada
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

-- teine variant
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Department.Id is null

--- kuidas saame Department tabelis oleva rea, kus on NULL
--right joini tuleb kasutada
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
or Department.Id is null

select * from Department

--saame muuta tabeli nimetust, alguses vana tabeli nimi ja siis uus soovitud
sp_rename 'Department1' , 'Department'

--kasutame Employees tabeli asemel muutujat E ja M
select E.Name as Employee, M.Name as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

alter table Employees
add ManagerId int


--inner join
-- kuvab ainult ManagerId all olevate isikute v��rtuseid
select E.Name as employee, M.Name as Manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id

-- k�ik saavad k�ikide �lemused olla
select E.Name as employee, M.Name as Manager
from Employees E
cross join Employees M

--uus tund

select isnull('Asd', 'NO manager') as Manager

--NULL asemel kuvab No manager

select coalesce(NULL, 'No Manager') as Manager

--kui Expression on �ige, siis paneb v��rtuse,
--mida soovid v�i m�ne teise v��rtuse
case when Expression Then '' else '' end

--neil kellel ei ole �lemust, siis paneb neile No Manager
select E.Name as Employees, isnull(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--teeme p�ringu kus kasutame case-i
select E.Name as Employee, case when M.Name is null then 'No Manager'
else M.Name end as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--lisame tabelisse uued veerud
alter table Employees
add MiddleName nvarchar(30)
alter table Employees
add LastName nvarchar(30)

select * from Employees

--muudame veeru nime
sp_rename 'Employees.Name', 'FirstName'

--muudame ja lisame andmeid
update Employees
set FirstName = 'Sara', MiddleName = NULL , LastName = 'Connor'
Where Id = 7

--igast reast v�tab esimesena t�idetud lahtri ja kuvab ainult seda
select Id, coalesce(FirstName,MiddleName, LastName) as Name
from Employees

--loome kaks tabelit
create table UKCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

select * from UKCustomers
select * from IndianCustomers

--sisestame tabellise andmeid
insert into UKCustomers (Name, Email)
values ('Ben', 'B@B.com'),
('Sam', 'S@S.Com')

--kasutame union all, n�itab k�iki ridu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers
--korduvate v��rtusetga read pannakse �hte ja ei korrata
select Id, Name, Email from IndianCustomers
union 
select Id, Name, Email from UKCustomers

--kuidas tulemust sorteerida nime j�rgi ja kasutada union all-i

select Id, Name, Email from IndianCustomers 
union all
select Id, Name, Email from UKCustomers
order by name

--stored procedure
create procedure spGetEmployees
as begin
 select FirstName, Gender from Employees
 end
 --n��d saab kasutada selle nimelist sp-d
 spGetEmployees
 exec spGetEmployees
 execute spGetEmployees

 select * from Employees

 create proc spGetEmployeesByGenderAndDepartment
 @Gender nvarchar(20),
 @DepartmentId int
 as begin
    select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
 end
 
 spGetEmployeesByGenderAndDepartment 'Male',1

 --soov vaadata sp sisu

 sp_helptext spGetEmployeesByGenderAndDepartment 
  
 --kuidas muuta sp-d ja pane kr�pteeringu peale, et keegi teine peale teid ei saaks muuta
 alter proc spGetEmployeesByGenderAndDepartment
 @Gender nvarchar(20),
 @DepartmentID int
 with encryption
 as begin
 select FirstName, Gender, DepartmentID from Employees where Gender = @Gender
 and DepartmentId = @DepartmentID
 end

 sp_helptext spGetEmployeesByGenderAndDepartment

 --sp tegemine
 create proc spGetEmployeeCountByGender
 @Gender nvarchar(20),
 @EmployeeCount int output
 as begin
 select @EmployeeCount = count(Id) from Employees where Gender = @Gender
 end
 --annab tulemuse, kus loendab �ra n�uetele vastavad read
 --prindib tulemuse konsooli
 declare @TotalCount int
 execute spGetEmployeeCountByGender 'Female',@TotalCount out
 if(@TotalCount = 0)
 print 'TotalCount is null'
 else
 print '@Total is not null'
 print @TotalCount

--n�itab �ra, et mitu rida vastab n�utele
declare @TotalCount int 
exec spGetEmployeeCountByGender @EmployeeCount = @TotalCount out, @Gender = 'Male'
print @TotalCount

--sp sisu vaatamine??

sp_help spGetEmployeeCountByGender

--tabeli info
sp_help Employees


--kui soovid sp teksti n�ha
sp_helptext spGetEmployeeCountByGender

--vaatame, millest see sp s�ltub
sp_depends spGetEmployeeCountByGender
--vaatame tabelit
sp_depends Employees



--
create proc spGetnameById
@Id int,
@Name nvarchar(20) output
as begin
    select @Id = Id, @Name = FirstName from Employees
end

select * from Employees

 declare @FirstName nvarchar(50)
 execute spGetnameById 1, @FirstName out
print 'Name of the emploee = ' + @FirstName

--mis id all on keegi nime j�rgi

create proc SpGetNameById1
@Id int,
@firstName nvarchar(50) output
as begin
select @FirstName = FirstName from Employees where Id = @Id
end

 declare @FirstName nvarchar(50)
 execute spGetnameById1 4, @FirstName out
print 'Name of the emploee = ' + @FirstName

sp_help spGetNameById1

---
create proc spGetNameById2
@Id int 
as begin
return (select FirstName from Employees where Id = @Id)
end

 declare @FirstName nvarchar(50)
 execute @FirstName = spGetNameById2 1
print 'Name of the emploee = ' + @FirstName


--ei saa convertida nvarchar mille v��rtus on Tom , int t��bi v��rtusele

--sisse ehitatud string funktsioonid
-- see konverteerib ASCII t�he v��rtuse numbriks
select ascii('a')
--kuvab A-t�he
select char (65)
--prindime kogu t�hestiku v�lja
declare @Start int
set @Start = 97
while (@Start <=122)
begin
select char (@Start)
set @Start = @Start + 1
end

--eemaldame t�hjad kohad sulgudes
select ltrim('                     Hello')

--t�hikute eemaldamine veerust
select ltrim(FirstName) as FirstName, MiddleName, LastName from Employees

select * from Employees 

--paremalt poolt t�hjad stringid l�ikab �ra
select rtrim('              Hello        ')
--keerab kooloni sees olevad andmed vastupidiseks
--vastavalt upper ja lower-ga saan muuta m�rkide suurust
--reverse funktsioon p��rab k�i �mber

select REVERSE(UPPER(ltrim(FirstName))) as FirstName, MiddleName, lower(LastName), 
rtrim(ltrim(FirstName)) + '' +	MiddleName + '' + LastName as FullName
from Employees

--n�eb, mitu t�hte on s�nal ja loeb t�hikud sisse
select FirstName, len(FirstName) as [Total Characters] from Employees

--n�eb, mitu t�hte on s�nal ja ei loe t�hikuid sisse
select (FirstName), len(ltrim(FirstName)) as [Total Characters] from Employees

--left, right ja substring 
-- vasakult poolt neli esimest t�hte
select left('ABCDEF',4)
--paremalt poolt kolm t�hte
select right('ABCDEF',3 )

--kuvab @-t�hem�rgi asetust
select charindex('@', 'sara@aaa.com')

--esimene nr peale komakohta n�itab, et mitmendat alustab ja siis mitu nr peale 
-- seda kuvada 
select SUBSTRING('pam@bb.com', 5, 2)

--@-m�rgist kuvab kolm t�hem�rki. viimase numbirga saab m��rata pikkust
select substring('pam@bbb.com', charindex('@', 'pam@bbb.com') + 1, 3)

--peale @-m�rki reguleerin t�hem�rkide pikkuse n�itamist
select substring('pam@bbb.com', charindex('@', 'pam@bbb.com') + 1,
len('pam@bbb.com') - CHARINDEX('@', 'pam@bb.com'))


select * from Employees

--vaja teha uus veerg nimega Email, nvarchar (20)

alter table Employees
add Email nvarchar(20)

update Employees set Email =  'Tom@aaa.com' where Id = 1
update Employees set Email =  'Pam@aaa.com' where Id = 2
update Employees set Email =  'John@ccc.com' where Id = 3
update Employees set Email =  'Sam@bbb.com' where Id = 4
update Employees set Email =  'Todd@aaa.com' where Id = 5
update Employees set Email =  'Ben@ccc.com' where Id = 6
update Employees set Email =  'Sara@bbb.com' where Id = 7
update Employees set Email =  'Valarie@ccc.com' where Id = 8
update Employees set Email =  'James@bbb.com' where Id = 9
update Employees set Email =  'Russel@bbb.com' where Id = 10

---lisame t�rni *-m�rgi alates teatud kohast
select FirstName, LastName, 
substring(Email, 1, 2) + REPLICATE('*', 5) + 
SUBSTRING(Email, CHARINDEX('@', Email), len(Email) - charindex('@', Email)+1) as Email
from Employees

---kolm korda n�itab stringis olevat v��rtust

SELECT REPLICATE(Email, 3)
FROM Employees;

--kuidas sisestada t�hikut kahe nime vahele
select space(5)

--Employee tabelist teed p�ringu kahe nime osas (FirstName, LastName)
--kahe nime vahel on 25 t�hikut
select FirstName + space(25) + LastName as FullName
from Employees
