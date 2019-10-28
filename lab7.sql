drop table instructor cascade;
drop table student cascade;
create table instructor(
	ID numeric(10),
	name varchar(15),
	street varchar(30),
	city varchar(15),
	salary numeric(10),
	rank varchar(15),
	primary key(ID)
);
create table secretary(
	ID numeric(10),
	name varchar(15),
	street varchar(30),
	city varchar(15),
	salary numeric(10),
	hours_per_week numeric(2)
);
create table student(
	ID numeric(10),
	name varchar(15),
	street varchar(30),
	city varchar(15)
);
select * from instructor;
select * from secretary;
select * from student;

insert into instructor(ID,name,street,city,salary,rank)
values(1000,'Dr.Ramesh','Balgot Street,Avenue Park','London',100000,'Assistant P'),
(1001,'Dr.Suresh','Rocko St,Flatnagar','Mumbai',150000,'Assistant P'),
(1002,'Dr.Rakesh','ISRO-1','Sriharikota',145000,'Associate P'),
(1003,'Dr.Andrew','CA-22 St','CA',155500,'Professor'),
(1004,'Prakash Nair','OS-12 St','NY',165000,'Associate P');

insert into secretary(ID,name,street,city,salary,hours_per_week)
values(1100,'Dr.Chandra','JP St','Hyderabad',120000,28),
(1101,'Dr.Sudha','RS St','Chennai',122200,24),
(1102,'Dr.Chatterji','Byomkesh St','Calcutta',125000,23);
/*1*/
select name from instructor;
select name from secretary;
/*2*/
select rank,round(avg(salary)) from instructor
group by rank;
/*3*/
alter table student
add column Campus varchar(12),
add column Program varchar(15);
insert into student(ID,name,street,city,Campus,Program)
values('100','Ronak Sharma','BK St','Chennai','Amritapuri','CS AI'),
('101','Rohit Sharma','RS St','Mumbai','Coimbatore','CCE'),
('102','BK Sharma','VK St','Bangalore','Bangalore','CSE'),
('103','Sachin T','TKS St','Bhillai','Chennai','ME'),
('104','Shikar D','SAI St','Hyderabad','Coimbatore','AE'),
('105','Dhoni','KJ St','Ranchi','Bangalore','CSE'),
('106','RK Narayan','AD St','Mumbai','Amritapuri','CS AI');
select Campus,Program,count(*) from student
group by Campus,Program;
/*Part 2*/
/*1 and 2*/
drop table Employee cascade;
drop table Department cascade;
create table Department(
Dname varchar(25),
DepNo numeric(3),
MgrSSN numeric(9),
MgrSDate date,
foreign key(MgrSSN) references Employee(SSN) on delete set null,
primary key(DepNo)
);
create table Employee(
FName varchar(15),
Minit varchar(2),
LName varchar(15),
SSN   numeric(9) ,
BDate date,
Address varchar(200),
Sex varchar(2) check(Sex='F' or Sex='M' or Sex='NA'),
Salary numeric(8),
SuperSSN numeric(9),
DepNo numeric(3),
primary key(SSN)
);
alter table Employee
add constraint DepNo foreign key(DepNo) references Department;

create table Dept_Locations(
	DepNo numeric(3),
	DLocation varchar(20),
	primary key(DepNo,DLocation),
	foreign key(DepNo) references Department
);
create table Project(
	PName varchar(30),
	PNumber numeric(7),
	PLocation varchar(30),
	DepNo numeric(3),
	primary key(PNumber),
	foreign key(DepNo) references Department
);
create table Works_On(
	ESSN numeric(9),
	PNo numeric(7),
	Hours numeric(2),
	primary key(ESSN,PNo),
	foreign key(ESSN) references Employee(SSN),
	foreign key(PNo) references Project(PNumber)
);
create table Dependent(
	ESSN numeric(9),
	Dependent_Name varchar(20),
	Sex varchar(2) check(Sex='F' or Sex='M' or Sex='NA'),
	BDate date,
	Relationship varchar(15),
	primary key(ESSN,Dependent_Name),
	foreign key(ESSN) references Employee(SSN)
);
/*3*/
INSERT INTO employee VALUES 
  ('James','E','Borg','888665555','10-NOV-27','450 Stone, Houston, TX','M',55000,null,null);
INSERT INTO employee VALUES 
  ('Franklin','T','Wong','333445555','08-DEC-45','638 Voss, Houston, TX','M',40000,'888665555',null);
INSERT INTO employee VALUES 
  ('Jennifer','S','Wallace','987654321','20-JUN-31','291 Berry, Bellaire, TX','F',43000,'888665555',null);
INSERT INTO employee VALUES
  ('Jared','D','James','111111100','10-OCT-1966','123 Peachtree, Atlanta, GA','M',85000,null,null);
INSERT INTO employee VALUES
  ('Alex','D','Freed','444444400','09-OCT-1950','4333 Pillsbury, Milwaukee, WI','M',89000,null,null);
INSERT INTO employee VALUES
  ('John','C','James','555555500','30-JUN-1975','7676 Bloomington, Sacramento, CA','M',81000,null,null);
select * from Employee;

INSERT INTO department VALUES ('Research', 5, '333445555', '22-MAY-78');
INSERT INTO department VALUES ('Administration', 4, '987654321', '01-JAN-85');
INSERT INTO department VALUES ('Headquarters', 1, '888665555', '19-JUN-71');
INSERT INTO department VALUES ('Software',6,'111111100','15-MAY-1999');
INSERT INTO department VALUES ('Hardware',7,'444444400','15-MAY-1998');
INSERT INTO department VALUES ('Sales',8,'555555500','01-JAN-1997');
select * from Department;

UPDATE employee SET DepNo = 5 WHERE ssn = '333445555';
UPDATE employee SET DepNo = 4 WHERE ssn = '987654321';
UPDATE employee SET DepNo = 1 WHERE ssn = '888665555';
UPDATE employee SET DepNo = 6 WHERE ssn = '111111100';
UPDATE employee SET DepNo = 7 WHERE ssn = '444444400';
UPDATE employee SET DepNo = 6 WHERE ssn = '555555500';
select DepNo from employee;

INSERT INTO employee VALUES 
  ('John','B','Smith','123456789','09-Jan-55','731 Fondren, Houston, TX','M',30000,'333445555',5);
INSERT INTO employee VALUES 
  ('Alicia','J','Zelaya','999887777','19-JUL-58','3321 Castle, Spring, TX','F',25000,'987654321',4);
INSERT INTO employee VALUES 
  ('Ramesh','K','Narayan','666884444','15-SEP-52','971 Fire Oak, Humble, TX','M',38000,'333445555',5);
INSERT INTO employee VALUES 
  ('Joyce','A','English','453453453','31-JUL-62','5631 Rice Oak, Houston, TX','F',25000,'333445555',5);
INSERT INTO employee VALUES 
  ('Ahmad','V','Jabbar','987987987','29-MAR-59','980 Dallas, Houston, TX','M',25000,'987654321',4);
insert into EMPLOYEE values
  ('Jon','C','Jones','111111101','14-NOV-1967','111 Allgood, Atlanta, GA','M',45000,'111111100',6);
insert into EMPLOYEE values
  ('Justin',null,'Mark','111111102','12-JAN-1966','2342 May, Atlanta, GA','M',40000,'111111100',6);
insert into EMPLOYEE values
  ('Brad','C','Knight','111111103','13-FEB-1968','176 Main St., Atlanta, GA','M',44000,'111111100',6);
insert into EMPLOYEE values
  ('Evan','E','Wallis','222222200','16-JAN-1958','134 Pelham, Milwaukee, WI','M',92000,null,7);
insert into EMPLOYEE values
  ('Josh','U','Zell','222222201','22-MAY-1954','266 McGrady, Milwaukee, WI','M',56000,'222222200',7);
insert into EMPLOYEE values
  ('Andy','C','Vile','222222202','21-JUN-1944','1967 Jordan, Milwaukee, WI','M',53000,'222222200',7);
insert into EMPLOYEE values
  ('Tom','G','Brand','222222203','16-DEC-1966','112 Third St, Milwaukee, WI','M',62500,'222222200',7);
insert into EMPLOYEE values
  ('Jenny','F','Vos','222222204','11-NOV-1967','263 Mayberry, Milwaukee, WI','F',61000,'222222201',7);
insert into EMPLOYEE values
  ('Chris','A','Carter','222222205','21-MAR-1960','565 Jordan, Milwaukee, WI','F',43000,'222222201',7);
insert into EMPLOYEE values
  ('Kim','C','Grace','333333300','23-OCT-1970','6677 Mills Ave, Sacramento, CA','F',79000,null,6);
insert into EMPLOYEE values
  ('Jeff','H','Chase','333333301','07-JAN-1970','145 Bradbury, Sacramento, CA','M',44000,'333333300',6);
insert into EMPLOYEE values
  ('Bonnie','S','Bays','444444401','19-JUN-1956','111 Hollow, Milwaukee, WI','F',70000,'444444400',7);
insert into EMPLOYEE values
  ('Alec','C','Best','444444402','18-JUN-1966','233 Solid, Milwaukee, WI','M',60000,'444444400',7);
insert into EMPLOYEE values
  ('Sam','S','Snedden','444444403','31-JUL-1977','987 Windy St, Milwaukee, WI','M',48000,'444444400',7);
insert into EMPLOYEE values
  ('Nandita','K','Ball','555555501','16-APR-1969','222 Howard, Sacramento, CA','M',62000,'555555500',6);
insert into EMPLOYEE values
  ('Bob','B','Bender','666666600','17-APR-1968','8794 Garfield, Chicago, IL','M',96000,null,8);
insert into EMPLOYEE values
  ('Jill','J','Jarvis','666666601','14-JAN-1966','6234 Lincoln, Chicago, IL','F',36000,'666666600',8);
insert into EMPLOYEE values
  ('Kate','W','King','666666602','16-APR-1966','1976 Boone Trace, Chicago, IL','F',44000,'666666600',8);
insert into EMPLOYEE values
  ('Lyle','G','Leslie','666666603','09-JUN-1963','417 Hancock Ave, Chicago, IL','M',41000,'666666601',8);
insert into EMPLOYEE values
  ('Billie','J','King','666666604','01-JAN-1960','556 Washington, Chicago, IL','F',38000,'666666603',8);
insert into EMPLOYEE values
  ('Jon','A','Kramer','666666605','22-AUG-1964','1988 Windy Creek, Seattle, WA','M',41500,'666666603',8);
insert into EMPLOYEE values
  ('Ray','H','King','666666606','16-AUG-1949','213 Delk Road, Seattle, WA','M',44500,'666666604',8);
insert into EMPLOYEE values
  ('Gerald','D','Small','666666607','15-MAY-1962','122 Ball Street, Dallas, TX','M',29000,'666666602',8);
insert into EMPLOYEE values
  ('Arnold','A','Head','666666608','19-MAY-1967','233 Spring St, Dallas, TX','M',33000,'666666602',8);
insert into EMPLOYEE values
  ('Helga','C','Pataki','666666609','11-MAR-1969','101 Holyoke St, Dallas, TX','F',32000,'666666602',8);
insert into EMPLOYEE values
  ('Naveen','B','Drew','666666610','23-MAY-1970','198 Elm St, Philadelphia, PA','M',34000,'666666607',8);
insert into EMPLOYEE values
  ('Carl','E','Reedy','666666611','21-JUN-1977','213 Ball St, Philadelphia, PA','M',32000,'666666610',8);
insert into EMPLOYEE values
  ('Sammy','G','Hall','666666612','11-JAN-1970','433 Main Street, Miami, FL','M',37000,'666666611',8);
insert into EMPLOYEE values
  ('Red','A','Bacher','666666613','21-MAY-1980','196 Elm Street, Miami, FL','M',33500,'666666612',8);
select * from Employee;

INSERT INTO project VALUES ('ProductX',1,'Bellaire',5);
INSERT INTO project VALUES ('ProductY',2,'Sugarland',5);
INSERT INTO project VALUES ('ProductZ',3,'Houston',5);
INSERT INTO project VALUES ('Computerization',10,'Stafford',4);
INSERT INTO project VALUES ('Reorganization',20,'Houston',1);
INSERT INTO project VALUES ('Newbenefits',30,'Stafford',4);
INSERT INTO project VALUES ('OperatingSystems',61,'Jacksonville',6);
INSERT INTO project VALUES ('DatabaseSystems',62,'Birmingham',6);
INSERT INTO project VALUES ('Middleware',63,'Jackson',6);
INSERT INTO project VALUES ('InkjetPrinters',91,'Phoenix',7);
INSERT INTO project VALUES ('LaserPrinters',92,'LasVegas',7);

INSERT INTO dept_locations VALUES (1,'Houston');
INSERT INTO dept_locations VALUES (4,'Stafford');
INSERT INTO dept_locations VALUES (5,'Bellaire');
INSERT INTO dept_locations VALUES (5,'Sugarland');
INSERT INTO dept_locations VALUES (5,'Houston');
INSERT INTO dept_locations VALUES (6,'Atlanta');
INSERT INTO dept_locations VALUES (6,'Sacramento');
INSERT INTO dept_locations VALUES (7,'Milwaukee');
INSERT INTO dept_locations VALUES (8,'Chicago');
INSERT INTO dept_locations VALUES (8,'Dallas');
INSERT INTO dept_locations VALUES (8,'Philadephia');
INSERT INTO dept_locations VALUES (8,'Seattle');
INSERT INTO dept_locations VALUES (8,'Miami');

INSERT INTO dependent VALUES ('333445555','Alice','F','05-APR-76','Daughter');
INSERT INTO dependent VALUES ('333445555','Theodore','M','25-OCT-73','Son');
INSERT INTO dependent VALUES ('333445555','Joy','F','03-MAY-48','Spouse');
INSERT INTO dependent VALUES ('987654321','Abner','M','29-FEB-32','Spouse');
INSERT INTO dependent VALUES ('123456789','Michael','M','01-JAN-78','Son');
INSERT INTO dependent VALUES ('123456789','Alice','F', '31-DEC-78','Daughter');
INSERT INTO dependent VALUES ('123456789','Elizabeth','F','05-MAY-57','Spouse');
INSERT INTO dependent VALUES ('444444400','Johnny','M','04-APR-1997','Son');
INSERT INTO dependent VALUES ('444444400','Tommy','M','07-JUN-1999','Son');
INSERT INTO dependent VALUES ('444444401','Chris','M','19-APR-1969','Spouse');
INSERT INTO dependent VALUES ('444444402','Sam','M','14-FEB-1964','Spouse');
select * from Dependent;

INSERT INTO works_on VALUES ('123456789',1, 32.5);
INSERT INTO works_on VALUES ('123456789',2,  7.5);
INSERT INTO works_on VALUES ('666884444',3, 40.0);
INSERT INTO works_on VALUES ('453453453',1, 20.0);
INSERT INTO works_on VALUES ('453453453',2, 20.0);
INSERT INTO works_on VALUES ('333445555',2, 10.0);
INSERT INTO works_on VALUES ('333445555',3, 10.0);
INSERT INTO works_on VALUES ('333445555',10,10.0);
INSERT INTO works_on VALUES ('333445555',20,10.0);
INSERT INTO works_on VALUES ('999887777',30,30.0);
INSERT INTO works_on VALUES ('999887777',10,10.0);
INSERT INTO works_on VALUES ('987987987',10,35.0);
INSERT INTO works_on VALUES ('987987987',30, 5.0);
INSERT INTO works_on VALUES ('987654321',30,20.0);
INSERT INTO works_on VALUES ('987654321',20,15.0);
INSERT INTO works_on VALUES ('888665555',20,null);
INSERT INTO works_on VALUES ('111111100',61,40.0);
INSERT INTO works_on VALUES ('111111101',61,40.0);
INSERT INTO works_on VALUES ('111111102',61,40.0);
INSERT INTO works_on VALUES ('111111103',61,40.0);
INSERT INTO works_on VALUES ('222222200',62,40.0);
INSERT INTO works_on VALUES ('222222201',62,48.0);
INSERT INTO works_on VALUES ('222222202',62,40.0);
INSERT INTO works_on VALUES ('222222203',62,40.0);
INSERT INTO works_on VALUES ('222222204',62,40.0);
INSERT INTO works_on VALUES ('222222205',62,40.0);
INSERT INTO works_on VALUES ('333333300',63,40.0);
INSERT INTO works_on VALUES ('333333301',63,46.0);
INSERT INTO works_on VALUES ('444444400',91,40.0);
INSERT INTO works_on VALUES ('444444401',91,40.0);
INSERT INTO works_on VALUES ('444444402',91,40.0);
INSERT INTO works_on VALUES ('444444403',91,40.0);
INSERT INTO works_on VALUES ('555555500',92,40.0);
INSERT INTO works_on VALUES ('555555501',92,44.0);
INSERT INTO works_on VALUES ('666666601',91,40.0);
INSERT INTO works_on VALUES ('666666603',91,40.0);
INSERT INTO works_on VALUES ('666666604',91,40.0);
INSERT INTO works_on VALUES ('666666605',92,40.0);
INSERT INTO works_on VALUES ('666666606',91,40.0);
INSERT INTO works_on VALUES ('666666607',61,40.0);
INSERT INTO works_on VALUES ('666666608',62,40.0);
INSERT INTO works_on VALUES ('666666609',63,40.0);
INSERT INTO works_on VALUES ('666666610',61,40.0);
INSERT INTO works_on VALUES ('666666611',61,40.0);
INSERT INTO works_on VALUES ('666666612',61,40.0);
INSERT INTO works_on VALUES ('666666613',61,30.0);
INSERT INTO works_on VALUES ('666666613',62,10.0);

/*4*/
select DName,min(Salary) from Department,employee where employee.DepNo=Department.DepNo;
group by DName;

/*5*/
select DName,round(avg(Salary),2) from Department,employee where employee.DepNo=Department.DepNo
group by DName
having avg(Salary)>40000;

/*6*/
select count(*) from Employee where DepNo=6;

/*7*/
select Dname,count(*) from Employee join Department using(DepNo)
where fname like 'J%'
group by Dname;

/*8*/
select Department.Dname,count(*) from Department,Project where Department.Depno=Project.depno
group by Dname;

/*9*/
alter table department
add column budget numeric(10);
select * from department;

/*10*/
select a.fname,b.fname from Employee A left join Employee B on a.SuperSSN=b.SSN;

/*11*/
select fname from Employee 
where salary>(select min(salary) from Employee where depno=5);

/*12*/
select fname from Employee
where bdate<(select bdate from Employee order by SSN limit 1 offset 4);

/*13*/
select fname from Employee where salary=(select max(salary) from Employee);

/*14*/
select address from Employee where salary=(select max(salary) from Employee);

/*15*/
select Department.dname from Department,Employee where Department.depno=Employee.depno
and salary=(select max(salary) from Employee);

/*16*/
select fname from Employee
where salary>(select salary from Employee order by SSN limit 1 offset 4);

/*17*/
select fname from Employee where Depno in (select depno from Department where budget>20000);

/*18*/
select fname from Employee where Depno in (select depno from Department where budget=(select max(budget) from Department));

/*19*/
select budget from Department where Depno in (select depno from Employee where salary=(select max(salary) from Employee));

/*20*/
select fname from Employee
where salary>(select salary from Employee order by SSN limit 1 offset 4) and to_char(bdate,'MM')=(select to_char(bdate,'MM') from Employee order by SSN limit 1 offset 4) 
and to_char(bdate,'DD')=(select to_char(bdate,'DD') from Employee order by SSN limit 1 offset 4);

/*21 Ms Sandhya is not present hence using employee Red*/
select pname from project,works_on where project.pnumber=works_on.pno and works_on.essn=(select ssn from Employee where fname='Red' and lname='Bacher');

/*22*/
select fname,lname from employee where employee.ssn in (select essn from works_on where works_on.pno=(select pno from project where pname='Middleware'));

/*23*/
delete from employee
where salary<(select avg(salary) from employee);

/*24*/
update employee
set salary=salary+20000
where depno=(select depno from department where dname='HR') and salary > 9000;