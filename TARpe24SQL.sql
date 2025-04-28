--tund 1 03.03.2025
--loome db
create database TARpe24SQL

-- db valimine 
use TARpe24SQL

-- db kustutamine
drop database TARpe24SQL

-- tabeli loomine
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

--andmete sisestamine
insert into Gender (Id, Gender)
values (2, 'Male')
insert into Gender (Id, Gender)
values (1, 'Female')
insert into Gender (Id, Gender)
values (3, 'Unknown')

-- vaatame tabeli sisu
select * from Gender

-- teeme tabeli Person
create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)

--andmete sisestamine
insert into Person (Id, Name, Email, GenderId)
values (1, 'Superman', 's@s.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (2, 'Wonderwoman', 'w@w.com', 1),
(3, 'Batman', 'b@b.com', 2),
(4, 'Aquaman', 'a@a.com', 2),
(5, 'Catwoman', 'c@c.com', 1),
(6, 'Antman', 'ant"ant.com', 2),
(7, 'Spiderman', 'spider@s.com', 2),
(9, NULL, NULL, 2)

--soovime vaadata Person tabeli andmeid
select * from Person

--v��rv�tme �henduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

-- kui sisestad uue rea andmeid ja ei ele sisestanud GenderId alla v��rtust,
-- siis see automaatselt sisestab sellele reale v��rtuse 3 e nagu meil
-- on unknown
alter table Person
add constraint DF_Persons_GenderId
default 3 for GenderId

--
insert into Person (Id, Name, Email)
values (11, 'Kalevipoeg', 'k@k.com')

-- piirangu kustutamine
alter table person
drop constraint DF_Persons_GenderId

-- lisame uue veeru
alter table Person
add Age nvarchar(10)

--lisame nr piirangu vanuse sisestamisel
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

--kustutame rea
delete from Person where Id = 11

select * from Person

--kuidas uuendada andmeid
update Person
set Age = 50
where Id = 4


alter table Person
add City nvarchar(50)

--k]ik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'
--k]ik, kes ei ela Gothamis
select * from Person where City != 'Gotham'
--variant nr 2
select * from Person where City <> 'Gotham'

-- n'itab teatud vanusega inimesi
select * from Person where Age = 100 or Age = 35 or Age = 27
select * from Person where Age in (100, 35, 25)

-- n'itab teatud vanusevahemikus olevaid inimesi
select * from Person where Age between 22 and 50

-- wildcard e n�itab k�ik g-t�hega linnad
select * from Person where City like 'g%'
-- k]ik emailid, kus on @-m�rk emailis
select * from Person where Email like '%@%'

--n�itab k�iki, kellel ei ole @-m�rki emailis
select * from Person where Email not like '%@%'

--tund 2 07.03.2025

--n�itab, kellel on emailis ees ja peale @-m�rki ainult �ks t�ht
select * from Person where Email like '_@_.com'

--k�ik, kellel on nimes t�ht W, A, S
select * from Person where Name like '[^WAS]%'
select * from Person

--kes elavad Gothamis ja New Yorkis
select * from Person where City = 'Gotham' or City = 'New York'

--- k�ik, kes elavad Gothami ja New Yorki linnas ja on vanemad, kui 29
select * from Person where (City = 'Gotham' or City = 'New York') and Age >=30

--kuvab t�hestikulises j�rjekorras inimesi ja v�tab auseks nime
select * from Person order by Name
--sama p�ring, aga vastupidises j�rjestuses on nimed
select * from Person order by Name desc

-- v�tab kolm esimest rida
select top 3 * from Person

--kolm esimest, aga tabeli j�rjestus on Age ja siis Name
select top 3 Age, Name from Person

--n�itab esimesed 50% tabelis
select top 50 percent * from Person

--j�rjestab vanuse j�rgi isikud
select * from Person order by Age desc

-- muudab Age muutuja intiks ja n�itab vanuselises j�rjestuses
select * from Person order by cast(Age as int)

--k�ikide isikute koondvanus
select sum(cast(Age as int)) from Person

-- kuvab k�ige nooremat isikut
select min(cast(Age as int)) from Person
-- kuvab k�ige vanemat isikut
select max(cast(Age as int)) from Person

-- konkreetsetes linnades olevate isikute koondvanus
-- enne oli Age nvarchar, aga muudame selle int andmet��biks
select City, sum(Age) as totalAge from Person group by City

-- kuidas saab koodiga muuta andmet��pi ja selle pikkust
alter table Person
alter column Name nvarchar(25)

--kuvab esimeses reas v�lja toodud j�rjestuses ja kuvab Age TotalAge-ks
-- j�rjestab City-s olevate nimede j�rgi ja siis GenderId j�rgi
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId order by City

--n�itab ridade arvu tabelis
select count(*) from Person
select * from Person

--n�itab tulemust, et mitu inimest on genderId v��rtusega 2 konkreetses linnas
-- arvutab vanuse kokku selles linnas
select GenderId, City, sum(Age) as TotalAge, count(Id) as [Total Person(s)]
from Person
where GenderId = '2'
group by GenderId, City

--- loome, tabelid Employees ja Department

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

--rida 208
-- 3tund 10.03.2025

--andmete sisestamine Employees tabelisse
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

--rida 411
--- 4tund 14.03.2025

select isnull('Asd', 'No manager') as Manager

-- NULL asemel kuvab No manager
select coalesce(NULL, 'No Manager') as Manager

-- kui Expression on �ige, siis p�neb v��rtuse,
-- mida soovid v�i m�ne teise v��rtuse
case when Expression Then '' else '' end

-- neil kellel ei ole �lemust, siis paneb neile No Manager teksti
select E.Name as Employees, isnull(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--- teeme p'ringu, kus kasutame case-i
select E.Name as Employee, case when M.Name is null then 'No Manager'
else M.Name end as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

-- lisame tabelisse uued veerud
alter table Employees
add MiddleName nvarchar(30)
alter table Employees
add LastName nvarchar(30)

select * from Employees

-- muudame veru nime
sp_rename 'Employees.Name', 'FirstName'

-- muudame ja lisame andmeid
update Employees
set FirstName = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
where Id = 1

update Employees
set FirstName = 'Pam', MiddleName = NULL, LastName = 'Anderson'
where Id = 2

update Employees
set FirstName = 'John', MiddleName = NULL, LastName = NULL
where Id = 3

update Employees
set FirstName = 'Sam', MiddleName = NULL, LastName = 'Smith'
where Id = 4

update Employees
set FirstName = NULL, MiddleName = 'Todd', LastName = 'Someone'
where Id = 5

update Employees
set FirstName = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
where Id = 6

update Employees
set FirstName = 'Sara', MiddleName = NULL, LastName = 'Connor'
where Id = 7

update Employees
set FirstName = 'Valarie', MiddleName = 'Balerine', LastName = NULL
where Id = 8

update Employees
set FirstName = 'James', MiddleName = '007', LastName = 'Bond'
where Id = 9

update Employees
set FirstName = NULL, MiddleName = NULL, LastName = 'Crowe'
where Id = 10

select * from Employees

---igast reast v�tab esimesena t�idetud lahtri ja kuvab ainult seda
select Id, coalesce(FirstName, MiddleName, LastName) as Name
from Employees

--loome kaks tabelit
create table IndianCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

create table UKCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

--sisestame tabelisse andmeid
insert into IndianCustomers (Name, Email)
values ('Raj', 'R@R.com'),
('Sam', 'S@S.com')

insert into UKCustomers (Name, Email)
values ('Ben', 'B@B.com'),
('Sam', 'S@S.com')

select * from IndianCustomers
select * from UKCustomers

-- kasutame union all, n�itab k�iki ridu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers

-- korduvate v��rtustega read pannakse �hte ja ei korrata
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers

--- kuidas tulemust sorteerida nime j�rgi ja kasutada union all-i
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers
order by Name

--- stored procedure
create procedure spGetEmployees
as begin
	select FirstName, Gender from Employees
end

-- n��d saab kasutada selle nimelist sp-d
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

--see k�sklus n�uab, et antakse Gender parameeter
spGetEmployeesByGenderAndDepartment
-- �ige variant
spGetEmployeesByGenderAndDepartment 'Male', 1

--- niimoodi saab j'rjekorda muuta p�ringul, kui ise paned muutuja paika
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'

-- soov vaadata sp sisu
sp_helptext spGetEmployeesByGenderAndDepartment

--- 5tund 17.03.2025

--- kuidas muuta sp-d ja pane kr�pteeringu peale, et keegi teine peale teid ei saaks muuta
alter proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
with encryption --kr�pteerimine
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

sp_helptext spGetEmployeesByGenderAndDepartment

-- sp tegemine
create proc spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmployeeCount int output
as begin
	select @EmployeeCount = count(Id) from Employees where Gender = @Gender
end

-- annab tulemuse, kus loendab �ra n�uetele vastavad read
-- prindib tulemuse konsooli
declare @TotalCount int
execute spGetEmployeeCountByGender 'Female', @TotalCount out
if(@TotalCount = 0)
	print 'TotalCount is null'
else
	print '@Total is not null'
print @TotalCount

-- n�itab �ra, et mitu rid vastab n�uetele
declare @TotalCount int
execute spGetEmployeeCountByGender @EmployeeCount = @TotalCount out, @Gender = 'Male'
print @TotalCount

-- sp sisu vaatamine
sp_help spGetEmployeeCountByGender
-- tabeli info
sp_help Employees
-- kui soovid sp tektsi n�ha
sp_helptext spGetEmployeeCountByGender

-- vaatame , millest see sp s�ltub
sp_depends spGetEmployeeCountByGender
-- vaatame tabelit
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
execute spGetnameById 2, @FirstName output
print 'Name of the employee = ' + @FirstName

-- mis id all on keegi nime j'rgi
create proc spGetNameById1
@Id int,
@FirstName nvarchar(50) output
as begin
	select @FirstName = FirstName from Employees where Id = @Id
end

declare @FirstName nvarchar(50)
execute spGetNameById1 4, @FirstName output
print 'Name of the employee = ' + @FirstName

sp_help spGetNameById1

---
create proc spGetNameById2
@Id int
as begin
	return (select FirstName from Employees where Id = @Id)
end

-- tuleb veateade kuna kutsusime v�lja int-i, aga Tom on string
declare @FirstName nvarchar(50)
execute @FirstName = spGetNameById2 1
print 'Name of the employee = ' + @FirstName
--

--- sisseehitatud string funktsioonid
-- see konverteerib ASCII t�he v��rtuse numbriks
select ascii('a')
-- kuvab A-t�he
select char (66)

--prindime kogu t�hestiku v�lja
declare @Start int
set @Start = 97
while (@Start <= 122)
begin
	select char (@Start)
	set @Start = @Start + 1
end

-- eemaldame t�hjad kohad sulgudes
select ltrim('        Hello')

-- t�hikute eemaldamine veerust
select ltrim(FirstName) as FirstName, MiddleName, LastName from Employees

select * from Employees

--paremalt poolt t�hjad stringid l�ikab �ra
select rtrim('      Hello          ')

--keerab kooloni sees olevad andmed vastupidiseks
-- vastavalt upper ja lower-ga saan muuta m�rkide suurust
-- reverse funktsioon p��rab k�ik �mber
select REVERSE(UPPER(ltrim(FirstName))) as FirstName, MiddleName, lower(LastName),
rtrim(ltrim(FirstName)) + ' ' + MiddleName + ' ' + LastName as FullName
from Employees

--n�eb, mitu t�hte on s�nal ja loeb t�hikud sisse
select FirstName, len(FirstName) as [Total Characters] from Employees

--- n�eb, mitu t�hte on s�nal ja ei loe tyhikuid sisse
select FirstName, len(ltrim(FirstName)) as [Total Characters] from Employees

-- left, right ja substring
--- vasakult poolt neli esimest t�hte
select left('ABCDEF', 4)
-- paremalt poolt kolm t�hte
select right('ABCDEF', 3)

--kuvab @-t�hem�rgi asetust e mitmes on @ m�rk
select charindex('@', 'sara@aaa.com')

--- esimene nr peale komakohta n�itab, et mitmendast alustab ja siis mitu nr peale
-- seda kuvada
select SUBSTRING('pam@btbb.com', 5, 2)

--- @-m�rgist kuvab kolm t�hem�rki. Viimase numriga saab m��rata pikkust
select substring('pam@bb.com', charindex('@', 'pam@bb.com') + 1, 3)

--- peale @-m�rki reguleerin t�hem�rkide pikkuse n�itamist
select substring('pam@bb.com', charindex('@', 'pam@bb.com') + 1, 
len('pam@bb.com') - CHARINDEX('@', 'pam@bb.com'))

select * from Employees

-- vaja teha uus veerg nimega Email, nvarchar (20)
alter table Employees
add Email nvarchar(20)

update Employees set Email = 'Tom@aaa.com' where Id = 1
update Employees set Email = 'Pam@bbb.com' where Id = 2
update Employees set Email = 'John@aaa.com' where Id = 3
update Employees set Email = 'Sam@bbb.com' where Id = 4
update Employees set Email = 'Todd@bbb.com' where Id = 5
update Employees set Email = 'Ben@ccc.com' where Id = 6
update Employees set Email = 'Sara@ccc.com' where Id = 7
update Employees set Email = 'Valarie@aaa.com' where Id = 8
update Employees set Email = 'James@bbb.com' where Id = 9
update Employees set Email = 'Russel@bbb.com' where Id = 10

select * from Employees

--- lisame *-m�rgi alates teatud kohast
select FirstName, LastName,
	substring(Email, 1, 2) + REPLICATE('*', 5) + --peale teist t�hem�rki paneb viis t�rni
	SUBSTRING(Email, CHARINDEX('@', Email), len(Email) - charindex('@', Email)+1) as Email
from Employees

--- kolm korda n�itab stringis olevat v��rtust
select replicate(FirstName, 3)
from Employees

select replicate('asd', 3)

-- kuidas sisestada tyhikut kahe nime vahele
select space(5)

--Employees tabelist teed p�ringu kahe nime osas (FirstName ja LastName)
--kahe nime vahel on 25 t�hikut
select FirstName + space(25) + LastName as FullName
from Employees


---- 6 tund 24.03.2025

-- PATINDEX
-- sama, mis charIndex, aga d�naamilisem ja saab kasutada wildcardi
select Email, PATINDEX('%@aaa.com', Email) as FirstOccurence
from Employees
where PATINDEX('%@aaa.com', Email) > 0  --leian k]ik selle domeeni esindajad ja
--- alates mitmendast m�rgist algab @

-- k�ik .com-d asendatakse .net-ga
select Email, REPLACE(Email, '.com', '.net') as ConvertedEmail
from Employees

--- soovin asnedada peale esimest m�rki kolm t�hte viie t�rniga
select FirstName, LastName, Email,
	stuff(Email, 2, 3, '*****') as StuffedEmail
from Employees

---ajat��bid
create table DateTime
(
c_time time,
c_date date,
c_smalldatetime smalldatetime,
c_datetime datetime,
c_datetime2 datetime2,
c_datetimeoffset datetimeoffset
)

select * from DateTime

--- masina kellaaja teada saamine
select GETDATE(), 'GETDATE()'

insert into DateTime
values (getdate(), getdate(), getdate(), getdate(), getdate(), getdate())

select * from DateTime

update DateTime set c_datetimeoffset = '2025-04-08 10:59:29.1933333 + 10:00'
where c_datetimeoffset = '2025-03-24 09:01:40.2766667 +00:00'

select CURRENT_TIMESTAMP, 'CURRENT_TIMESTAMP' -- aja p'ring
select SYSDATETIME()  -- veel t�psem ajap�ring
select SYSDATETIMEOFFSET() -- t�pne aeg koos ajalise nihkega UTC suhtes
select GETUTCDATE()  --UTC aeg

select isdate('asd') --tagastab 0 kuna string ei ole date e aeg
select ISDATE(getdate()) --tagastab 1 kuna on kp
select isdate('2025-03-24 09:19:01.1490061') --tagastab 0 kuna max kolm komakohta v�ib olla
select isdate('2025-03-24 09:19:01.149') ---tagastab 1
select day(getdate()) --annab t�nase p�eva nr
select day('02/28/2025') --annab stringis oleva p�eva nr
select month(getdate()) --annab t�nase kuu nr
select month('02/28/2025') --annab stringis oleva kuu nr
select year(getdate()) --annab t�nase aasta nr
select year('02/28/2025') --annab stringis oleva aasta nr

select datename(day, '2025-03-24 09:19:01.149') --annab stringis oleva p�eva nr
select Datename(WEEKDAY, '2025-03-25 09:19:01.149')  -- annab stringis oleva p�eva s�nana
select datename(MONTH, '2025-03-24 09:19:01.149') -- annab stringis oleva kuu s�nana
select datename(dayofYEAR, '2025-03-24 09:19:01.149') 

create table EmployeesWithDates
(
Id nvarchar(2),
Name nvarchar(20),
DateOfBirth datetime
)

INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (1, 'Sam', '1980-12-30 00:00:00.000');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (2, 'Pam', '1982-09-01 12:02:36.260');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (3, 'John', '1985-08-22 12:03:30.370');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (4, 'Sara', '1979-11-29 12:59:30.670');

--- kuidas v�tta �hest veerust andmeid ja selle abil luua uued veerud
--vaatab DoB veerust p�eva ja kuvab p�eva nimetuse s�nana
select Name, DateOfBirth, DATENAME(weekday, DateOfBirth) as [Day], 
--vaatab DoB veerust kp-d ja kuvab kuu nr
	MONTH(DateOfBirth) as MonthNumber,
-- vaatab DoB veerust kuud ja kuvab s�nana
	DateName(MONTH, DateOfBirth) as [MonthName],
-- v]tab Dob veerust aasta
	YEAR(DateOfBirth) as [Year]
from EmployeesWithDates

select DATEPART(weekday, '2025-01-30 12:22:56.401') --kuvab 1 kuna USA n�dal algab p�hap�evaga
select DATEPART(MONTH, '2025-03-24 12:22:56.401') --kuvab kuu nr
select DATEADD(DAY, 20, '2025-03-24 12:22:56.401') --liidab stringis olevale kp 20 p�eva juurde
select DATEADD(DAY, -20, '2025-03-24 12:22:56.401') --lahutab 20 p�eva maha
select datediff(MONTH, '11/30/2024', '03/24/2025')  --kuvab kahe stringi kuudevahelist aega nr-na
select datediff(year, '11/30/2022', '03/24/2025') --n�itab aastatevahelist aega nr-na

-- funktsiooni tegemine
create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
	declare @tempdate datetime, @years int, @months int, @days int
		select @tempdate = @DOB

		select @years = datediff(year, @tempdate, getdate()) - case when (month(@DOB) > month(GETDATE())) or (MONTH(@DOB)
		= month (getdate()) and day(@DOB) > DAY(getdate())) then 1 else 0 end
		select @tempdate = dateadd(year, @years, @tempdate)

		select @months = datediff(month, @tempdate, getdate()) - case when day(@DOB) > day(getdate()) then 1 else 0 end
		select @tempdate = dateadd(MONTH, @months, @tempdate)

		select @days = datediff(day, @tempdate, getdate())

	declare @Age nvarchar(50)
		set @Age = cast(@years as nvarchar(4)) + ' Years ' + cast(@months as nvarchar(2)) + 
		' Months ' + cast(@days as nvarchar(2)) + ' Days old'
	return @Age
end

--- saame vaadata kasutajate vanust
select Id, Name, DateOfBirth, dbo.fnComputeAge(DateOfBirth) 
as Age from EmployeesWithDates

--- kui kasutame seda funktsiooni, siis saame teada t�nase 
--- p�eva vahet stringis v�lja tooduga
select dbo.fnComputeAge('11/11/2010')

-- nr peale DOB muutujat n�itab, et mismoodi kuvada DOB-d
select Id, Name, DateOfBirth,
convert(nvarchar, DateOfBirth, 109) as ConvertedDOB
from EmployeesWithDates

select Id, Name, Name + ' - ' + cast(Id as nvarchar) as [Name-Id] 
from EmployeesWithDates

select cast(getdate() as date) --t�nane kp
select convert(date, GETDATE()) -- t�nane kp

--matemaatilised funktsioonid
select abs(-101.5) --- abs on absoluutne nr ja tulemuseks saame positiivse v��rtuse
select CEILING(15.2) -- tagastab 16 ja suurendab suurema t�isarvu suunas
select CEILING(-15.2) -- tagastab -15 ja suurendab suurema positiivse t�isarvu suunas
select floor(15.2) --�mardab v�iksema arvu suunas
select floor(-15.2) --�mardab negatiivsema nr poole
select power(2,4) --hakkab korrutama 2x2x2x2 e 2 astmes 4, esimene nr on korrutatav
select SQUARE(9) --antud juhul 9 ruudus
select SQRT(81)    ---annab vastuse 9, ruutjuur

select rand()  --annab suvalise nr
select floor(rand() * 100)  --oleks t�isarvud, aga kasutad rand-i

--- iga kord n�itab 10 suvalist nr-t
declare @counter int
set @counter = 1
while (@counter <= 10)
begin
	print floor(rand() * 1000)
	set @counter = @counter + 1
end
--rida 938
--- 7tund 28.03.2025

select Round(850.556, 2) --�mardab kaks kohta peale komat, tulemus 850.560
select round(850.556, 2, 1) --�mardab allapoole, tulemus 850.550
select round(850.556, 1) --�mardab �lespoole ja v�tab ainult esimest nr peale koma arvesse
select round(850.556, 0) --�mardab t�isarvuni
select round(850.556, -2) --�mardab sajalise t�psusega
select round(850.556, -1) --�mardab t�isnumber allapoole

---
create function dbo.CalculateAge(@DOB date)
returns int
as begin
declare @Age int

set @Age = DATEDIFF(YEAR, @DOB, GETDATE()) -
	case
		when (MONTH(@DOB) > MONTH(getdate())) or
			 (MONTH(@DOB) > MONTH(GETDATE()) and DAY(@DOB) > day(GETDATE()))
		then 1
		else 0
		end
	return @Age
end

execute CalculateAge '10/08/2020'

select Id, dbo.CalculateAge(DateOfBirth) as Age from EmployeesWithDates
where dbo.CalculateAge(DateOfBirth) > 36

INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (1, 'Sam', '1980-12-30 00:00:00.000');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (2, 'Pam', '1982-09-01 12:02:36.260');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (3, 'John', '1985-08-22 12:03:30.370');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (4, 'Sara', '1979-11-29 12:59:30.670');

select * from EmployeesWithDates

-- inline table valued functions
alter table EmployeesWithDates
add DepartmentId int
alter table EmployeesWithDates
add Gender nvarchar(10)

update EmployeesWithDates set Gender = 'Male', DepartmentId = 1
where Id = 1
update EmployeesWithDates set Gender = 'Female', DepartmentId = 2
where Id = 2
update EmployeesWithDates set Gender = 'Male', DepartmentId = 1
where Id = 3
update EmployeesWithDates set Gender = 'Female', DepartmentId = 3
where Id = 4
insert into EmployeesWithDates (Id, Name, DateOfBirth, DepartmentId, Gender)
values (5, 'Todd', '1978-11-29 12:59:30.670', 1, 'Male')

select * from EmployeesWithDates

-- scalare function annab mingis vahemikus olevaid andmeid,
-- inline table values ei kasuta begin ja end funktsioone
-- scalar annab v��rtused ja inline annab tabeli
create function fn_EmployeesByGender(@Gender nvarchar(10))
returns table
as
return (select Id, Name, DateOfBirth, DepartmentId, Gender
		from EmployeesWithDates
		where Gender = @Gender)

-- k�ik female t��tajad
select * from fn_EmployeesByGender('Female')

select * from fn_EmployeesByGender('Female')
where Name = 'Pam'  --where abil saab otsingut t�psustada

select * from Department

--kahest erinevast tabelist andmete v�tmine ja koos kuvamine
-- esimene on funktsioon ja teine tabel, 
--kasutage fn_EmployeesByGender ja tabelit Department, join p�ring
select Name, Gender, DepartmentName
from fn_EmployeesByGender('Male') E
join Department D
on D.Id = E.DepartmentId

-- multi-tabel statment

-- inline funktsioon
create function fn_GetEmployees()
returns table as
return (Select Id, Name, cast(DateOfBirth as date)
		as DOB
		from EmployeesWithDates)

select * from fn_GetEmployees()

--multi-state puhul peab defineerima uue tabeli veerud koos muutujatega
create function fn_MS_GetEmployees()
returns @Table Table (Id int, Name nvarchar(20), DOB date)
as begin
	insert into @Table
	select Id, Name, Cast(DateOfBirth as Date) from EmployeesWithDates

	return
end

select * from fn_MS_GetEmployees()
-- mis vahe on inline funktsiooni ja multi-statement vahel???
--- inline tabeli funktsioonid on paremini t��tamas kuna k�sitletakse vaatena
--- multi puhul on pm tegemist stored proceduriga ja kulutab ressurssi rohkem

--muutke andmeid, Sam muutub Sam1
update fn_GetEmployees() set Name = 'Sam1' where Id = 1 --saab muuta andmeid
update fn_MS_GetEmployees() set Name = 'Sam' where Id = 1 --ei saa muuta multistate puhul

-- 8 tund 04.07.2025

--deterministic and non-deterministic

select count(*) from EmployeesWithDates
select square(3) --k�ik tehtem�rgid on deterministlikud funktsioonid, sinna kuuluvad veel sum, avg ja square

-- non-deterministic
select getdate()
select CURRENT_TIMESTAMP

select rand() --see funktsioon saab olla m�lemas kategoorias, k�ik oleneb sellest, 
-- kas sulgudes on 1 v�i ei ole

--loome funktsiooni
create function fn_GetNameById(@id int)
returns nvarchar(30)
as begin
	return (select Name from EmployeesWithDates where Id = @id)
end

select fn_GetNameById(4)

drop table EmployeesWithDates

create table EmployeesWithDates
(
Id int primary key,
Name nvarchar(50) NULL,
DateOfBirth datetime NULL,
Gender nvarchar(10) NULL,
DepartmentId int NULL
)

select * from EmployeesWithDates

create function fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
as begin
	return (select Name from EmployeesWithDates where Id = @Id)
end

sp_helptext fn_GetEmployeeNameById

select dbo.fn_GetEmployeeNameById(3)

--kr[pteerige funktsioon fn_GetEmployeeNameById
alter function fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
with encryption
as begin
	return (select Name from EmployeesWithDates where Id = @Id)
end
--uuesti vataame sisu
sp_helptext fn_GetEmployeeNameById

--muudame �levalpool olevat funktsiooni, kindlasti tabeli ette panna dbo.Tabelinimi
alter function fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
with schemabinding
as begin
	return (select Name from EmployeesWithDates where Id = @Id)
end

drop table dbo.EmployeesWithDates

drop function fn_GetEmployeeNameById

-- temporary tables

--- #-m�rgi ette panemisel saame aru, et tegemist on temp tabeliga
--- seda tabelit saab ainult selles p�ringus avdada
create table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails values(1, 'Mike')
insert into #PersonDetails values(2, 'John')
insert into #PersonDetails values(3, 'Todd')

select * from #PersonDetails
--kuhu tekkis #PersonDetails tabel

--saab vaadata k]iki tabeleid, mis on s�steemis olemas v�i on loodud kasutaja poolt
select Name from sysobjects
where Name like 'Gender'

--kustutame temp tabeli
drop table #PersonDetails

create proc spCreateLocalTempTable
as begin
create table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails values(1, 'Mike')
insert into #PersonDetails values(2, 'John')
insert into #PersonDetails values(3, 'Todd')

select * from #PersonDetails
end

exec spCreateLocalTempTable

--Erinevused lokaalse ja globaalse ajutise tabeli osas:
--1. Lokaalsed ajutised tabelid on �he # m�rgiga, aga globaalsel on kaks t�kki.
--2. SQL server lisab suvalisi numbreid lokaalse ajutise tabeli nimesse, 
--aga globaalse puhul seda ei ole.
--3. Lokaalsed on n�htavad ainult selles sessioonis, mis on selle loonud, 
--aga globaalsed on n�htavad k�ikides sessioonides.
--4. Lokaalsed ajutised tabelid on automaatselt kustutatud, 
--kui selle loonud sessioon on kinni pandud, aga globaalsed 
--ajutised tabelid l�petatakse viimane viitav �hendus on kinni pandud.


--globaalse temp tabeli tegemine e paned kaks # tabeli nime ette
create table ##PersonDetails(Id int, Name nvarchar(20))

--index
create table EmployeeWithSalary
(
Id int primary key,
Name nvarchar(25),
Salary int,
Gender nvarchar(10)
)

select * from EmployeeWithSalary

select * from EmployeeWithSalary
where Salary > 5000 and Salary < 7000

--loome indeksi, mis asetab palga kahanevasse j�rjestusse
create index IX_Employee_Salary
on EmployeeWithSalary (Salary asc)

-- saame teada, et mis on selle tabeli primaarv�ti ja index
exec sys.sp_helpindex @objname = 'EmployeeWithSalary'

select * from EmployeeWithSalary
with (index(IX_Employee_Salary))

--saame vaadata tabelit koos selle sisuga alates v�ga detailsest infost
select 
	TableName = t.name,
	IndexName = ind.name,
	IndexId = ind.index_id,
	ColumnId = ic.index_column_id,
	ColumnName = col.name,
	ind.*,
	ic.*,
	col.*
from
	sys.indexes ind
inner join
	sys.index_columns ic on ind.object_id = ic.object_id and ind.index_id = ic.index_id
inner join
	sys.columns col on ic.object_id = col.object_id and ic.column_id = col.column_id
inner join
	sys.tables t on ind.object_id = t.object_id
where
	ind.is_primary_key = 0
	and ind.is_unique = 0
	and ind.is_unique_constraint = 0
	and t.is_ms_shipped = 0
order by
	t.name, ind.name, ind.index_id, ic.is_included_column, ic.key_ordinal;

--indeksi kustutamine
drop index EmployeeWithSalary.IX_Employee_Salary

---- indeksi t��bid:
--1. Klastrites olevad
--2. Mitte-klastris olevad
--3. Unikaalsed
--4. Filtreeritud
--5. XML
--6. T�istekst
--7. Ruumiline
--8. Veerus�ilitav
--9. Veergude indeksid
--10. V�lja arvatud veergudega indeksid

-- klastris olev indeks m��rab �ra tabelis oleva f��silise j�rjestuse 
-- ja selle tulemusel saab tabelis olla ainult �ks klastris olev indeks

create table EmployeeCity
(
Id int primary key,
Name nvarchar(50),
Salary int,
Gender nvarchar(10),
City nvarchar(50)
)

exec sp_helpindex EmployeeCity

-- andmete �ige j�rjestuse loovad klastris olevad indeksid ja kasutab selleks Id nr-t
-- p�hjus, miks antud juhul kasutab Id-d, tuleneb primaarv�tmest
insert into EmployeeCity values(3, 'John', 4500, 'Male', 'New York')
insert into EmployeeCity values(1, 'Sam', 2500, 'Male', 'London')
insert into EmployeeCity values(4, 'Sara', 5500, 'Female', 'Tokyo')
insert into EmployeeCity values(5, 'Todd', 3100, 'Male', 'Toronto')
insert into EmployeeCity values(2, 'Pam', 6500, 'Male', 'Sydney')

-- klastris olevad indeksid dikteerivad s�ilitatud andmete j�rjestuse tabelis 
-- ja seda saab klastrite puhul olla ainult �ks

select * from EmployeeCity

create clustered index IX_EmployeeCity_Name
on EmployeeCity(Name)

--- annab veateate, et tabelis saab olla ainult �ks klastris olev indeks
--- kui soovid, uut indeksit luua, siis kustuta olemasolev

--- saame luua ainult �he klastris oleva indeksi tabeli peale
--- klastris olev indeks on analoogne telefoni suunakoodile

-- loome composite indeksi
-- enne tuleb k�ik teised klastris olevad indeksid �ra kustutada
create clustered index IX_Employee_Gender_Salary
on EmployeeCity(Gender desc, Salary asc)
--index on eemaldatud ja n��d k�ivitame selle uuesti

select * from EmployeeCity

--- erinevused kahe indeksi vahel
--- 1. ainult �ks klastris olev indeks saab olla tabeli peale, 
--- mitte-klastris olevaid indekseid saab olla mitu
--- 2. klastris olevad indeksid on kiiremad kuna indeks peab tagasi viitama tabelile
--- Juhul, kui selekteeritud veerg ei ole olemas indeksis
--- 3. Klastris olev indeks m��ratleb �ra tabeli ridade salvestusj�rjestuse
--- ja ei n�ua kettal lisa ruumi. Samas mitte klastris olevad indeksid on 
--- salvestatud tabelist eraldi ja n�uab lisa ruumi

create table EmployeeFirstName
(
	Id int primary key,
	FirstName nvarchar(50),
	LastName nvarchar(50),
	Salary int,
	Gender nvarchar(10),
	City nvarchar(50)
)

exec sp_helpindex EmployeeFirstName
--- ei saa sisestada kahte samasuguse Id v��rtusega rida
insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values(1, 'John', 'Menco', 2500, 'Male', 'London')

--
drop index EmployeeFirstName.PK__Employee__3214EC075E817DE7
--- kui k�ivitad �levalpool oleva koodi, siis tuleb veateade
--- et SQL server kasutab UNIQUE indeksit j�ustamaks v��rtuste unikaalsust 
--- ja primaarv�tit
--- koodiga Unikaalseid Indekseid ei saa kustutada, aga k�sitsi saab

--sisestame uuesti kaks koodirida
insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values(1, 'John', 'Menco', 2500, 'Male', 'London')
--- unikaalset indeksid kasutatakse kindlustamaks
--- v��rtuste unikaalsust (sh primaarv�tme oma)
-- m�lemat t��pi indeksid saavad olla unikaalsed

---9 tund 14.04.2025

--lisame piirangu, mis n]uab, et veerus ei oleks dublikaate,
-- aga selles veerus on ja siis ei saa seda rakendada
alter table EmployeeFirstName
add constraint UQ_EmployeeFirstName_City
unique nonclustered(City)

update EmployeeFirstName
set City = 'Los Angeles'
where City = 'New york'

delete EmployeeFirstName
where Id = 1

select * from EmployeeFirstName

insert into EmployeeFirstName values(3, 'John', 'Menco', 3500, 'Male', 'Berlin')

----Index

exec sp_helpconstraint EmployeeFirstName
-- 1.Vaikimisi primaarv�ti loob unikaalse klastris oleva indeksi, samas unikaalne piirang
-- loob unikaalse mitte-klastris oleva indeksi
-- 2. Unikaalset indeksit v�i piirangut ei saa luua olemasolevasse tabelisse, kui tabel 
-- juba sisaldab v��rtusi v�tmeveerus
-- 3. Vaikimisi korduvaid v��rtusied ei ole veerus lubatud,
-- kui peaks olema unikaalne indeks v�i piirang. Nt, kui tahad sisestada 10 rida andmeid,
-- millest 5 sisaldavad korduviad andmeid, siis k�ik 10 l�katakse tagasi. Kui soovin ainult 5
-- rea tagasi l�kkamist ja �lej��nud 5 rea sisestamist, siis selleks kasutatakse IGNORE_DUP_KEY

create unique index IX_EmployeeFirstName
on EmployeeFirstName(City)
with ignore_dup_key

insert into EmployeeFirstName values(3, 'John', 'Menco', 3512, 'Male', 'Madrid')
insert into EmployeeFirstName values(4, 'John', 'Menco', 3523, 'Male', 'London1')
insert into EmployeeFirstName values(4, 'John', 'Menco', 3520, 'Male', 'London1')

select * from EmployeeFirstName

---view 
---view on salvestatud SQL-i p�ring. Saab k�sitleda ka visrtuaalse tabelina.

select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

--loome view
create view vEmployeesByDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

--- view p�ringu esile kutsumine
select * from vEmployeesByDepartment

-- view ei salvesta andmeid vaikimisi
-- seda tasub v�tta, kui salvestatud virtuaalse tabelina

-- milleks vaja:
-- saab kasutada andmebaasi skeemi keerukuse lihtsutamiseks,
-- mitte IT-inimesele
-- piiratud ligip��s andmetele, ei n�e k�iki veerge

-- teeme view, kus n�eb ainult IT-t��tajaid
-- view nimi on vITEmployeesInDepartment
create view vITEmployeesInDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id
where Department.DepartmentName = 'IT'
-- �levalpool olevat p�ringut saab liigitada reataseme turvalisuse alla
-- tahan ainult n�idata IT osakonna t��tajaid

select * from vITEmployeesInDepartment

-- veeru taseme turvalisus
-- peale selecti m��ratled veergude n�itamise �ra
create view vEmployeesInDepartmentSalaryNoShow
as
select FirstName, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

select * from vEmployeesInDepartmentSalaryNoShow

-- saab kasutada koondandmete esitlemist ja �ksikasjalike andmeid
-- view, mis tagastab summeeritud andmeid
create view vEmployeesCountByDepartment
as
select DepartmentName, count(Employees.Id) as TotalEmployees
from Employees
join Department
on Employees.DepartmentId = Department.Id
group by DepartmentName

select * from vEmployeesCountByDepartment

-- kui soovid vaadata view sisu
sp_helptext vEmployeesCountByDepartment
-- muuta saab alter k'suga
-- kustutada saab drop k�suga

--view, mida kasutame andmete uuendamiseks
create view vEmployeesDataExceptSalary
as
select Id, FirstName, Gender, DepartmentId
from Employees

--kasutame seda view-d, et uuendada andmeid
--muuta Id 2 all olev eesnimi Tom-ks
update vEmployeesDataExceptSalary
set FirstName = 'Tom' where Id = 2

--
alter view vEmployeesDataExceptSalary
as
select Id, FirstName, Gender, DepartmentId
from Employees

-- kustutame andmeid ja kasutame seda viewd: vEmployeesDataExceptSalary
-- Id 2 all olevad andmed
delete vEmployeesDataExceptSalary where Id = 2
--n[[d lisame andmed
insert into vEmployeesDataExceptSalary (Id, Gender, DepartmentId, FirstName)
values(2, 'Female', 2, 'Pam')

-- indekseeritud view
-- MS SQL-s on indekseeritud view nime all ja 
-- Oracle-s materjaliseeritud view
create table product
(
Id int primary key,
Name nvarchar(20),
UnitPrice int
)

insert into Product values (1, 'Books', 20)
insert into Product values (2, 'Pens', 14)
insert into Product values (3, 'Pencils', 11)
insert into Product values (4, 'Clips', 10)

create table ProductSales
(
Id int,
QuantitySold int
)

insert into ProductSales values(1, 10),
(3, 23),
(4, 21),
(2, 12),
(1, 13),
(3, 12),
(4, 13),
(1, 11),
(2, 12),
(1, 14)

--loome view, mis annab meile veerud TotalSales ja TotalTransaction
create view vTotalSalesByProduct
with schemabinding
as
select Name,
sum(isnull((QuantitySold * UnitPrice), 0)) as TotalSales,
COUNT_BIG(*) as TotalTransactions
from dbo.ProductSales
join dbo.Product
on dbo.Product.Id = ProductSales.Id
group by Name

--- kui soovid luua indeksi view sisse, siis peab j�rgima teatud reegleid
-- 1. view tuleb luua koos schemabinding-ga
-- 2. kui lisafunktsioon select list viitab v�ljendile ja selle tulemuseks
-- v�ib olla NULL, siis asendusv��rtus peaks olema t�psustatud. 
-- Antud juhul kasutasime ISNULL funktsiooni asendamaks NULL v��rtust
-- 3. kui GroupBy on t�psustatud, siis view select list peab
-- sisaldama COUNT_BIG(*) v�ljendit
-- 4. Baastabelis peaksid view-d olema viidatud kaheosalise nimega
-- e antud juhul dbo.Product ja dbo.ProductSales.

select * from vTotalSalesByProduct

create unique clustered index UIX_TotalSalesByProduct_Name
on vTotalSalesByProduct(Name)

-- rida 1517
-- tund 10  21.04.2025

--view piirangud

create view vEmployeeDetails
@Gender nvarchar(20)
as
select Id, FirstName, Gender, DepartmentId
from Employees
where Gender = @Gender
--view-sse ei saa kaasa panna parameetreid e antud juhul Gender

--tuleb teha funktsioon, kus parameetriks on gender
--fnEmployeeDetails

create function fnEmployeeDetails(@Gender nvarchar(20))
returns table
as return
(select Id, FirstName, Gender, DepartmentId
from Employees where Gender = @Gender)

--funktsiooni esile kutsumine koos parameetritega
select * from fnEmployeeDetails('male')

--order by kasutamine
create view vEmployeeDetailsSorted
as
select Id, FirstName, Gender, DepartmentId
from Employees
order by Id
--order by-d ei saa kasutada view 

--temp table kasutamine view-s

create table ##TestTempTable(Id int, FirstName nvarchar(20), Gender nvarchar(10))

--sisestame andmed
insert into ##TestTempTable values(101, 'Martin', 'Male')
insert into ##TestTempTable values(102, 'Joe', 'Female')
insert into ##TestTempTable values(103, 'Pam', 'Female')
insert into ##TestTempTable values(104, 'James', 'Male')

create view vOnTempTable
as
select Id, FirstName, Gender
from ##TestTempTable
-- temp table-s ei saa kasutada view-d


----TRIGGER
-- kokku on kolme t��pi triggereid: DML, DDL ja LOGON

--- trigger on stored procedure eriliik, mis automaatselt k�ivitub, kui mingi tegevus 
--- peaks andmebaasis aset leidma

--- DML - data manipulation language
--- DML-i p�hilised k�sklused: insert, update ja delete

-- DML triggereid saab klasifitseerida  kahte t��pi:
-- 1. After trigger (kutsutakse ka FOR triggeriks)
-- 2. Instead of trigger (selmet trigger e selle asemel trigger)

--- after trigger k�ivitub peale s�ndmust, kui kuskil on tehtud insert, 
--- update ja delete

--loome uue tabeli
create table EmployeeAudit
(
Id int identity(1, 1) primary key,
AuditData nvarchar(1000)
)

-- peale iga t��taja sisestamist tahame teada saada t��taja Id-d, 
-- p�eva ja aega(millal sisestati)
-- k�ik andmed tulevad EmployeeAudit tabelisse
create trigger trEmployeeForInsert
on Employees
for insert
as begin
Declare @Id int
select @Id = Id from inserted
insert into EmployeeAudit
values ('New employee with Id = ' + CAST(@Id as nvarchar(5)) + ' is added at '
+ CAST(getdate() as nvarchar(20)))
end

select * from Employees

insert into Employees 
values (11, 'Bob', 'Blob', 'Bomb', 'Male', 3000, 1, 3, 'bob@bomb.com')

select * from EmployeeAudit

-- update trigger

alter trigger trEmployeeForUpdate
on Employees
for update
as begin
	--muutujate deklareerimine
	declare @Id int
	declare @OldGender nvarchar(20), @NewGender nvarchar(20)
	declare @OldSalary int, @NewSalary int
	declare @OldDepartmentId int, @NewDepartmentId int
	declare @OldManagerId int, @NewManagerId int
	declare @OldFirstName nvarchar(20), @NewFirstName nvarchar(20)
	declare @OldMiddleName nvarchar(20), @NewMiddleName nvarchar(20)
	declare @OldLastName nvarchar(20), @NewLastName nvarchar(20)
	declare @OldEmail nvarchar(20), @NewEmail nvarchar(20)

	---muutuja, kuhu l�heb l�pptekst
	declare @AuditString nvarchar(1000)

	--laeb k�ik uuendatud andmed temp table alla
	select * into #TempTable
	from inserted

	--k�ib l�bi k�ik andmed temp table-s
	while(exists(select Id from #TempTable))
	begin
		set @AuditString = ''
		--selekteerib esimese rea andmed temp tabel-st
		select top 1 @Id = Id, @NewGender = Gender,
		@NewSalary = Salary, @NewDepartmentId = DepartmentId,
		@NewManagerId = ManagerId, @NewFirstName = FirstName,
		@NewMiddleName = MiddleName, @NewLastName = LastName,
		@NewEmail = Email
		from #TempTable
		-- v�tab vanad andmed kustutatud tabelist
		select @OldGender = Gender,
		@OldSalary = Salary, @OldDepartmentId = DepartmentId,
		@OldManagerId = ManagerId, @OldFirstName = FirstName,
		@OldMiddleName = MiddleName, @OldLastName = LastName,
		@OldEmail = Email
		from deleted where Id = @Id

		--loob auditi stringi d�naamiliselt
		set @AuditString = 'Employee with Id = ' + cast(@Id as nvarchar(4)) + ' changed '
		if(@OldGender <> @NewGender)
			set @AuditString = @AuditString + ', Gender from ' + @OldGender + ' to ' +
			@NewGender

		if(@OldSalary <> @NewSalary)
			set @AuditString = @AuditString + ', Salary from ' + cast(@OldSalary as nvarchar(20)) 
			+ ' to ' + cast(@NewSalary as nvarchar(10))

		if(@OldDepartmentId <> @NewDepartmentId)
			set @AuditString = @AuditString + ', DepartmentId from ' + cast(@OldDepartmentId as nvarchar(20)) 
			+ ' to ' + cast(@NewDepartmentId as nvarchar(10))

		if(@OldManagerId <> @NewManagerId)
			set @AuditString = @AuditString + ', Manager from ' + cast(@OldManagerId as nvarchar(20)) 
			+ ' to ' + cast(@NewManagerId as nvarchar(10))

		if(@OldFirstName <> @NewFirstName)
			set @AuditString = @AuditString + ', Firstname from ' + @OldFirstName + ' to ' +
			@NewFirstName

		if(@OldMiddleName <> @NewMiddleName)
			set @AuditString = @AuditString + ', Middlename from ' + @OldMiddleName + ' to ' +
			@NewMiddleName

		if(@OldLastName <> @NewLastName)
			set @AuditString = @AuditString + ', Lastname from ' + @OldLastName + ' to ' +
			@NewLastName

		if(@OldEmail <> @NewEmail)
			set @AuditString = @AuditString + ', Email from ' + @OldEmail + ' to ' +
			@NewEmail

		insert into dbo.EmployeeAudit values (@AuditString)
		-- kustutab temp table-st rea, et saaksime liikuda uue rea juurde
		delete from #TempTable where Id = @Id
	end
end

update Employees set FirstName = 'test890', Salary = 4120, MiddleName = 'testXXXXXXX'
where Id = 11

select * from Employees
select * from EmployeeAudit

---instead of trigger
create table Employee
(
Id int primary key,
Name nvarchar(30),
Gender nvarchar(10),
DepartmentId int
)

create table Department
(
Id int primary key,
DepartmentName nvarchar(20)
)

--teeme view
create view vEmployeeDetails
as
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Department
on Employee.DepartmentId = Department.Id

select * from vEmployeeDetails

insert into vEmployeeDetails values(7, 'Valarie', 'Female', 'IT')
--tuleb  veateade
-- n��d vaatame, et kuidas saab instead of triggeriga seda probleemi lahendada

create trigger tr_vEmployeeDetails_InsteadOfInsert
on vEmployeeDetails
instead of insert
as begin
	declare @DeptId int

	select @DeptId = dbo.Department.Id
	from Department
	join inserted
	on inserted.DepartmentName = Department.DepartmentName

	if(@DeptId is null)
		begin
		raiserror('Invalid department name. Statement terminated ', 16, 1)
		return
	end

	insert into dbo.Employee(Id, Name, Gender, DepartmentId)
	select Id, Name, Gender, @DeptId
	from inserted
end

--- raiserror funktsioon
-- selle eesm�rk on tuua v�lja veateade, kui DepartmentName veerus ei ole v��rtust
-- ja ei klapi uue sisestatud v��rtusega. 
-- Esimene parameeter on veateate sisu, teine on veataseme nr 
-- (nr 16 t�hendab �ldiseid vigu),
-- kolmas on olek

select * from Employee

delete from Employee where Id = 6

update vEmployeeDetails
set Name = 'Johny', DepartmentName = 'IT'
where Id = 1
--ei saa uuendada andmeid kuna mitu tabelit on sellest m�jutatud

update vEmployeeDetails
set DepartmentName = 'IT'
where Id = 1
--n��d saab uuendada kuna kuna ainult �hes tabelis tahame muuta andmeid

select * from vEmployeeDetails

create trigger tr_vEmployeeDetails_InsteadOfUpdate
on vEmployeeDetails
instead of update
as begin

	if(update(Id))
	begin
		raiserror('Id cannot be changed', 16, 1)
		return
	end

	if(update(DepartmentName))
	begin
		declare @DeptId int
		select @DeptId = Department.Id
		from Department
		join inserted
		on inserted.DepartmentName = Department.DepartmentName

		if(@DeptId is null)
		begin
			raiserror('Invalid Department Name', 16, 1)
			return
		end

		update Employee set DepartmentId = @DeptId
		from inserted
		join Employee
		on Employee.Id = inserted.id
	end

	if(update(Gender))
	begin
		update Employee set Gender = inserted.Gender
		from inserted
		join Employee
		on Employee.Id = inserted.id
	end

	if(update(Name))
	begin
		update Employee set Name = inserted.Name
		from inserted
		join Employee
		on Employee.Id = inserted.id
	end
end

--n��d saame mitmes tabelis korraga muuta andmeid
update Employee set Name = 'John123', Gender = 'Male', DepartmentId = 3
where Id = 1

select * from vEmployeeDetails

--rida 1856
--tund 11
--delete trigger

create view VEmployeeCount
as
select DepartmentId, DepartmentName, count(*) as TotalEmployees
from Employee
join Department
on	Employee.DepartmentId = Department.Id
group by DepartmentName, DepartmentId

select * from  VEmployeeCount

--n�itab �ra osakonnad kus t��tajad 2tki v�i rohkem

select * from VEmployeeCount where TotalEmployees >= 2

Select DepartmentName, DepartmentId, count(*) as TotalEmployees
into #TempEmployeeCount
from Employee
join Department
on Employee.DepartmentId = Department.Id
group by DepartmentName, DepartmentId

select * from #TempEmployeeCount

select * from #TempEmployeeCount where TotalEmployees >= 2

create view vEmployeeDetails
as
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Department
on Employee.DepartmentId = Department.Id

--kustutada 

create trigger trEmployeeDetails_InsteadOfDelete
on VEmployeeDetails
instead of delete
as begin
delete Employee
from Employee
Join deleted
on Employee.Id = deleted.Id
end

delete from vEmployeeDetails where Id = 2

---
select * from Employee

--p�ritud tabelid ja CTE
--CTE t�hendab common table expression

insert into Employee values(2, 'Mike', 'Male', 2)
--CTE
--CTE-d v�ivad sarnaneda temp table-ga
--sarnane p�ritud tabelile ja ei ole salvestatud objektina
--ning kestab p�ringu ulatuses

with EmployeeCount(DepartmentName, DepartmentId, TotalEmployees)
as 
(
select DepartmentName, DepartmentId ,count(*) as TotalEmployees
from Employee
join Department
on Employee.DepartmentId = Department.Id
group by DepartmentName,DepartmentId
)
select DepartmentName, TotalEmployees
from EmployeeCount
where TotalEmployees >= 2

--mitu CTED-d j�rjest

with EmployeeCountBy_Payroll_IT_Dept(DepartmentName, Total)
as
(
select DepartmentName, count(Employee.Id) as TotalEmployees
from Employee
join Department
on Employee.DepartmentId = Department.Id
where DepartmentName in('Payroll', 'IT')
group by DepartmentName
),
--peale koma panemist saad uue CTE juurde kirjutada
EmployeeCountBy_HR_Admin_Dept(DepartmentName, Total)
as
(
select DepartmentName, count (Employee.ID) as TotalEmployees
from Employee
join Department
on Employee.DepartmentId = Department.Id
group by DepartmentName
)
--kui on kaks CTE-d, siis unioni abil �hendada p�ringud
select * from EmployeeCountBy_HR_Admin_Dept
union
select * from EmployeeCountBy_Payroll_IT_Dept
---
With EmployeeCount(DepartmentId, TotalEmployees)
as
(
select DepartmentId,Count(*) as TotalEmployees
from Employee
group by DepartmentId
)
--peale CTE-d peab kohe tulema k�sklus SELECT, INSERT, UPDATE v�i DELETE
--kui proovid midagi muud, siis tuleb veateade
select DepartmentName, TotalEmployees
from Department
join EmployeeCount
on Department.Id = Employee.DepartmentId
order by TotalEmployees

--uuendamine CTE-s
--Loome lihtsalt CTE
with Employe_Name_Gender as

(
select Id, Name, Gender from Employee
)
select * from Employe_Name_Gender

--uuendame andmeid l�bi CTE

with Employe_Name_Gender 
as

(
select Id , Name, Gender from Employee
)
update Employee_Name_Gender
set Gender = 'Female'
where Id = 1

--kasutame joini CTE tegemisel
with EmployeesByDepartment
as
(
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Department
on Department.Id = Employee.DepartmentId
)
select * from EmployeesByDepartment

--kasutame joini ja muudame [�hes tabelis andmeid]
with EmployeesByDepartment
as
(
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Department
on Department.Id = Employee.DepartmentId
)
update EmployeesByDepartment
set Gender = 'Female'
where Id = 1

--kasutame joini ja muudame m�lemas tabelis andmeid
with EmployeesByDepartment
as
(
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Department
on Department.Id = Employee.DepartmentId
)
update EmployeesByDepartment
set 
DepartmentName = 'HR'
where Id = 1
---kokkuv�tte CTE-st
-- 1. kui CTE baseruub �hel tabelil, siis uuendus t��tab
-- 2. kui CTE baseruub mitmel tabelil, siis tuleb veateade
-- 3. kui CTE baseruub mitmel tabelil ja tahama muuta ainult �hte tabelut, siis 
-- uuendus saab tehtud

--korduv CTE
-- CTE, mis iseendlale viitab, kutsutakse korduvaks CTE-ks
-- kui tahad andmeid n�idata hierarhiliselt

select * from Employee

--kustutame k�ik andmed tabelist Employee


truncate table Employee

--kustutada �ra veerg nimega gender

alter table Employee
drop column gender 

insert into Employee (Id, Name, DepartmentId)
values (1, 'Tom', 2),
 (2, 'Josh', NULL),
 (3, 'Mike', 2),
 (4, 'John', 3),
 (5, 'Pam', 1),
 (6, 'Mary', 3),
 (7, 'James', 1),
 (8, 'Sam', 5),
 (9, 'Simon', 1)

 select Emp.Name as [Employe Name],
 isnull(Manager.Name, 'Super boss') as [Manager Name]
 from dbo.Employee Emp
 left join Employee Manager
 on Emp.ManagerId = Manager.Id

 --muudke DepartmetnID veerg ManagerId nimeks

 exec sp_rename 'Employee.DepartmentId', 'ManagerId'

 with EmployeesCTE(Id,Name,ManagerId, [Level])
 as
 (
 select Employee.Id, Name, Managerid, 1
 from Employee
 where ManagerId is null

 union all

 select Employee.Id, Employee.Name,
 Employee.ManagerId, EmployeesCTE.[Level] + 1
 from  Employee
 join EmployeesCTE
 on Employee.ManagerId = EmployeesCTE.Id
 )
 select EmpCTE.Name as Employee, ISNULL(MgrCTE.Name, 'Super Boss') as Manager,
 EmpCTE.[Level]
 from EmployeesCTE EmpCTE
 left join EmployeesCTE MgrCTE
 on EmpCTE.ManagerId = MgrCTE.Id
 
 --PIVOT

create table ProductSales
(
SalesAgent nvarchar(50),
SalesCountry nvarchar(50),
SalesAmount int
)

insert into ProductSales(SalesAgent, SalesCountry,SalesAmount)
values ('Tom', 'UK' , 200),
('John', 'US' , 180),
('John', 'UK' , 260),
('David', 'India' , 450),
('Tom', 'India' , 350),
('David', 'US' , 200),
('Tom', 'US' , 130),
('John', 'India' , 540),
('John', 'UK' , 120),
('David', 'UK' , 220),
('John', 'UK' , 420),
('David', 'US' , 320),
('Tom', 'US' ,340),
('Tom', 'UK' , 660),
('John', 'India' , 430),
('David', 'India' , 230),
('David', 'India' , 280),
('Tom', 'UK' , 480),
('John', 'UK' , 360),
('David', 'UK' , 140)

select * from ProductSales

select SalesCountry, SalesAgent, SUM(SalesAmount) as total 
from ProductSales
group by SalesCountry, SalesAgent
order by SalesCountry, SalesAgent

--pivot n�ide
select SalesAgent, India, US, UK
from productSales
pivot 
(
sum(SalesAmount) for  SalesCountry in ([India],[US],[UK])
)
as PivotTable
--p�ring muudab unikaalsete veergude v��rtust (India, US ja UK) SalesCountry veerus
--omaette veergueks koos veergudega SalesAmount liitmisega.

create table ProductSalesWithId
(
Id int primary key,
SalesAgent nvarchar(50),
SalesCountry nvarchar(50),
SalesAmount int
)

insert into ProductSalesWithId(Id, SalesAgent, SalesCountry,SalesAmount)
values (1,'Tom', 'UK' , 200),
(2,'John', 'US' , 180),
(3,'John', 'UK' , 260),
(4,'David', 'India' , 450),
(5,'Tom', 'India' , 350),
(6,'David', 'US' , 200),
(7,'Tom', 'US' , 130),
(8,'John', 'India' , 540),
(9,'John', 'UK' , 120),
(10,'David', 'UK' , 220),
(11,'John', 'UK' , 420),
(12,'David', 'US' , 320),
(13,'Tom', 'US' ,340),
(14,'Tom', 'UK' , 660),
(15,'John', 'India' , 430),
(16,'David', 'India' , 230),
(17,'David', 'India' , 280),
(18,'Tom', 'UK' , 480),
(19,'John', 'UK' , 360),
(20,'David', 'UK' , 140)

select * from ProductSalesWithId