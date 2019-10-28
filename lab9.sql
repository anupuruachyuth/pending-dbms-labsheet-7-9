create table Dept
(
	depname varchar(20) primary key,
	location varchar(20),
	budget numeric(7,2)
);


create table Instructor
( 
	id varchar(5) primary key,
	iname varchar(20),
	designation varchar(20),
	salary numeric(7,2),
	depname varchar(20) references Dept
);


drop table Take cascade;


create table Course
(
	Ccode varchar(5) primary key,
	Ctitle varchar(20),
	credits numeric(1,0),
	depname varchar(20) references Dept
);


create table Section
(
	sectionid varchar(2),
	Ccode varchar(5) references Course,
	SEM numeric(1,0),
	year numeric(4,0),
	room_no numeric(4,0),
	primary key(sectionid,Ccode,SEM,year)
);


create table Teach
(
	id varchar(5) references instructor,
	sectionid varchar(2),
	Ccode varchar(5),
	SEM numeric(1,0),
	year numeric(4,0),
	foreign key(sectionid,Ccode,SEM,year) references section,
	primary key(id,sectionid,Ccode,SEM,year)
);


create table Student
(
	sid varchar(5) primary key,
	sname varchar(20),
	date_of_birth date,
	depname varchar(20) references Dept
);


create table Take
(
	sid varchar(5) references Student,
	sectionid varchar(2),
	Ccode varchar(5) references Course,
	SEM numeric(1,0),
	year numeric(4,0),
	grade varchar(1),
	foreign key(sectionid,Ccode,SEM,year) references section,
	primary key(sid,sectionid,Ccode,SEM,year,grade)
);


select * from Dept;


insert into Dept values ('CSE','First', 80000),('ECE','Second', 54000),('EEE','Third', 30000),('ME','First', 54840),('Bcom','Second', 72340);

insert into Instructor values ('CSE12','Karan','Prof',60000,'CSE'),
								('MEC16','Bindu','Asst Prof',46300,'ME'),
								('CSE43','Jacob','HOD',32420,'EEE'),
								('ECE24','Nivin','Prof',87600,'ECE'),
								('CSE42','Priya','Asst Prof',64330,'CSE'),
								('BC036','Suraj','Asst Prof',40085,'Bcom');
			      
insert into Course values ('CS202','OS',4,'CSE'),
							('CS301','TOC',4,'CSE'),
							('BC302','Business',3,'Bcom'),
							('ME201','Fluids',2,'ME'),
							('EC203','Mach',3,'ECE'),
							('EE303','EE',3,'EEE');

insert into Section values ('A','CS301',5,2017,1012),
							('B','ME201',5,2017,1412),
							('C','CS202',4,2018,1552),
							('A','BC302',3,2016,1123),
							('D','EC203',4,2016,1533);
			
insert into Teach values ('CSE12','A', 'CS301',5,2017),
							('MEC16','B','ME201',5,2017),
							('CSE43','C','CS202',4,2018),
							('CSE42','A','CS301',5,2017),
							('BC036','A','BC302',3,2016),
							('ECE24','D','EC203',4,2016);

insert into Student values ('101','Riya','04-jun-1999','Bcom'),
							('102','Danish','14-mar-1999','ECE'),
							('105','Megha','3-feb-1999','CSE'),
							('145','Viraj','3-feb-1999','CSE'); 

insert into Take values ('101','A','BC302',3,2016,'A'),
						('102','D','EC203',4,2016,'B'),
						('105','C','CS202',4,2018,'B'),
						('145','A','CS301',5,2017,'A');

select distinct Ccode from section where SEM = 2 and year= 2009 and Ccode in (select Ccode from section where SEM = 4 and year= 2010);

select distinct Ccode from section where SEM = 2 and year= 2009 and Ccode not in (select Ccode from section where SEM = 4 and year= 2010);     

select iname from instructor where salary > some (select salary from instructor where depname = 'CSE');

select iname from instructor where salary > all (select salary from instructor where depname = 'CSE');   

select Ccode from section S where SEM = 2 and year= 2009 and exists (select * from section  T where SEM = 4 and year= 2010 and S.Ccode= T.Ccode);  

select depname, avg_salary from (select depname, avg(salary) as avg_salary from instructor group by depname) as avg_salary where avg_salary > 42000;               

select course_id from section as S where semester=2 and year= 2009 and exists (select * from section T where semester=4 and year= 2010 and S.course_id= T.course_id);

select course_id from section as S where semester=2 and year= 2009 and exists (select * from section T where semester!=4 and year!= 2010 and S.course_id= T.course_id);

select name from instructor where salary > some (select salary from instructor where dept_name = ’Biology’);

select name from instructor where salary > all (select salary from instructor where dept_name = ’Biology’);

select course_id from section as S where semester=2 and year= 2009 and exists (select * from section T where semester=4 and year= 2010 and S.course_id= T.course_id);

select av,depname from (select avg(salary) as av,depname from instructor303 group by depname where avg(salary>42000));

select name,depname,sal from instructor natural join (select depname,avg(salary) as sal from instructor group by depname);
with sal_details as (select dept_name,avg(salary) sal from instructor group by dept_name) select dept_name from sal_details where sal>20000;

with max_sal as (select max(salary) sal from instructor) select name,salary from instructor i,max_sal where i.salary=max_sal.sal;

with dept_avg_sal as (select dept_name,avg(salary) d_avg from instructor group by dept_name) ,uni_avg_sal as(select avg(salary) u_avg from instructor) select dept_name from dept_avg_sal,uni_avg_sal where u_avg>d_avg;

with dept _total as (select dept_name, sum(salary) value from instructor group by dept_name), dept_total_avg as (select avg(value)  as av_sal from dept_total)

select dept_name from dept_total, dept_total_avg where dept_total.value >= dept_total_avg.av_sal;

select depname,count(*) from instructor group by depname;

select name from instructor i1 where salary> 2*(select avg(salary) from instructor i2 where i1.dept_name=i2.dept_name);

select dept_namemfrom instructor group by dept_name having max(salary)>(select avg(salary) from instructor);

delete from instructor where dept_name in (select dept_name from department where building = ’Watson’);

delete from instructor where salary< (select avg (salary) from instructor);

insert into instructors select ID,name,dept_name,20000 from student where dept_name=‘History’ and tot_credits>150;

update instructor set salary = case when salary <= 100000 then salary * 1.05 else salary * 1.03 end

update student S set tot_cred = ( select sum(credits) from takes natural join course where S.ID= takes.ID and takes.grade != ’F’ and takes.grade is not null);

select max(avg(salary)) from instructor group by dept_name;

select dept_name from instructor group by dept_name having avg(salary)=(select max(av_sal) from (select avg(salary) av_sal from instructor group by dept_name));

select course_id,(select count(*) from section where c.course_id=section.course_id) from course c;

select name from instructor where salary=(select max(salary) from (select salary from instructor where  salary!= (select max(salary) from instructor)));                                                                                                                 
© 2019 GitHub, Inc.