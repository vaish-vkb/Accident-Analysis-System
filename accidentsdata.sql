create database accidentsanalyse;
use accidentsanalyse;
create table liable
(
	licenseno int,
    name varchar(20),
    sex char(1),
    age int,
    primary key(licenseno)
);

create table vehicletype
(
	vehicleno int,
    licenseno int references liable(licenseno),
    brand varchar(20),
    yearofpurchase int,
    primary key(vehicleno)
);

create table area
(
	vehicleno int references vehicletype(vehicleno),
    streetname varchar(20),
    primary key(vehicleno,streetname)
);

create table expenditure
(
	licenseno int references liable(licenseno),
    fine int,
    compensation int,
    damagecost int,
	totalexpenses int,
    primary key(licenseno)
);
drop table expenditure;
create table casualty
(
    vehicleno int references vehicletype(vehicleno),
    noofaccidents int,
    primary key(vehicleno)
);
drop table casualty;

insert into liable values
('123','John','M','25'),
('234','Mary','F','40'),
('345','Anjali','F','31'),
('456','George','M','18'),
('567','James','M','20'),
('678','Thomas','M','45'),
('789','Jaideep','M','27'),
('890','Zara','F','22'),
('012','Akshay','M','24'),
('135','Deepa','F','37'),
('246','Abdul','M','39'),
('357','Ravi','M','60');

insert into vehicletype values
('9876','123','ford','2002'),
('8765','123','toyota','2014'),
('7654','234','maruti','2000'),
('6543','345','swift','2006'),
('5433','345','ford','2020'),
('4321','345','bolero','2012'),
('0978','456','ford','2013'),
('7082','567','maruti','2010'),
('4896','567','swift','2002'),
('3812','678','honda','2002'),
('3333','890','honda','2009'),
('4444','012','ford','2010'),
('9999','135','ford','2011'),
('6666','246','swift','2017'),
('5555','567','bolero','2021');

insert into area values
('9876','mg road'),
('8765','panvel'),
('7654','church street'),
('6543','church street'),
('5433','panvel'),
('4321','panvel'),
('0978','mg road'),
('7082','church street'),
('4896','church street'),
('3812','church street'),
('3333','panvel'),
('4444','panvel'),
('9999','church street'),
('6666','mg road'),
('5555','panvel');

insert into casualty values
('9876','12'),
('8765','10'),
('7654','13'),
('6543','6'),
('5433','15'),
('4321','11'),
('0978','15'),
('7082','7'),
('4896','27'),
('3812','14'),
('3333','10'),
('4444','15'),
('9999','19'),
('6666','27'),
('5555','7');

create trigger totalexpenses on expenditure
after insert
as
declare @var integer
declare @var1 integer
declare @var2 integer
declare @licenseno varchar(10)
select @var=i.fine from inserted i 
select @var1=i.compensation from inserted i 
select @var2=i.damagecost from inserted i 
select @licenseno=i.licenseno from inserted i 

update expenditure
set totalexpenses=@var+@var1+@var2
where licenseno=@licenseno
GO 

insert into expenditure values
('123','1200','1000','25000',null),
('234','400','1500','40000',null),
('345','500','650','32500',null),
('456','2000','1020','17000',null),
('567','6500','15000','100000',null),
('678','100','500','2000',null),
('789','2500','5050','10200',null),
('890','150','670','1025',null),
('012','2080','11065','55000',null),
('135','1000','4080','20060',null),
('246','50','250','1000',null),
('357','7000','10000','50000',null);

select * from expenditure