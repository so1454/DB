CREATE TABLE my_employee
( id	 NUMBER(4) not NULL,
 last_name VARCHAR2(25),
 first_name VARCHAR2(25),
 userid VARCHAR2(8),
 salary	 NUMBER(9,2)
);

ID	LAST_NAME	FIRST_NAME, USERID	salary
1,	Patel,	Ralph,	rpatel,	895
2,	Dancs,	Betty,	bdancs,	860
3,	Biri,	Ben,	bbiri,	1100
4,	Newman,	Chad,	cnewman,	750
5,	Ropeburn,	Audrey,	aropebur,	1550


insert into my_employee values (1,'Patel','Ralph', 'rpatel', 895);
insert into my_employee values (2,	'Dancs',	'Betty',	'bdancs',	860);
