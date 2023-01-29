=================================
-- ����Ŭ ��ġ�� ȯ�汸��

--������ �˻�â���� cmd
cmd ����
C:\Users\smhrd> sqlplus / as sysdba

--------------------------
sql>@C:\Users\user\Desktop\DataBase\create_scott.sql

sql> quit, exit
C:\Users\smhrd>sqlplus hr/hr

-- ��� ������
sqlplus hr/hr

-- �н��� table�� ��ȸ
select table_name from user_tables;

-- ���̺��� ������ ��ȸ
desc departments
desc employees

-- �μ� ���̺� �ڷ��� ��ȸ
select * 
from departments;

--sqlplus ����
show user;
COLUMN last_name format a18;
COLUMN department_name format a18;

set pagesize 50;
set linesize 100;

-- ���� ����
ed  -- �޸��� ����
SQL> /   -- ����

=================================
-- 5�� DQL(Data Query Language)
=================================
-- Select
--   From
-- [where
-- Group by
-- Having
-- Order By ]
--
-- 1.SELECT ���� ���
--  1-1 *  : from ���� ����� ���̺��� ����׸� ��ȸ
      select * from departments;  -- ������
	  select department_name from departments; -- ��������
--- 1-2 from���� ����� �÷��� ���, �������� �÷��� ','�� �����Ѵ�.
	  select department_id, department_name
	    from departments;  -- �������
--- 1-3 distinct : �ߺ��� �����Ѵ�.
      select job_id
	    from employees;
--- 1-4 ����(alias)
	  select last_name lname, salary
  	    from employees;
	  select last_name as lname, salary
		from employees;
	 -. ���Ӹ��� �빮�ڷ� ǥ��ǰ�, ���ڴ� ��������, ���ڴ� ������ �����Ѵ�.
--- 1-5 ����(+, -, *, /)�� �����ϴ�.
      select last_name, (salary * 12) annsal
	      from employees;
	  -. ������ �켱������ ������.(*, /,+, -)
--- 1-6 ���꿡 null�� ������ ����� Null�̴�.
      select last_name, salary,
	       (salary * commission_pct) cmmsal
	  from employees;
--- 1-7. ���ڿ��� ����(||)
	  select (last_name || first_name) irum
        from employees;
   	  select (last_name || '-' || first_name) irum
        from employees;

-- 2.From�� �� ���
--- 2-1 ���̺� ��, view��
--- 2-2 ������ ��
--- 2-3 �������� ���̺���� ���(����)
--- 2-4 ������ ���̺� dual;

-- 3.where��(������) �� ���
--  3-1.���ǽ� ������� �ϼ��Ǿ�� �Ѵ�.
   ������ȣ�� 100�� ������ �̸�, ������ ��ȸ�Ͻÿ�..
    select last_name, job_id, 
	  from employees
	 where employee_id = 100;
--  3-2.������ �������� ����(and, or)�����ϰ� ����
     ���ǵ� ������ ��� �����Ǿ�� �Ѵ�.
   �μ��� 50�μ��̰�, ������ 'IT_PROG'�� ������ �̸�, �޿��� ��ȸ�Ͻÿ�..
	  select last_name, job_id, salary
	    from employees
       where department_id = 50
         and job_id ='ST_MAN';
--  3-3.���ڿ�, ��¥�� ���Ҷ����� Ȭ����ǥ('')�ȿ� ǥ���Ѵ�.
--  3-4.���ڿ� ���� ���� ������ ��ҹ��ڰ� �����ȴ�.
--  3-5.������ �켱������ �ִ�.(and, or)
     select last_name, job_id, salary
	    from employees
       where job_id ='IT_PROG'
	      or job_id ='AD_PRES'
	     and salary > 15000;

--  3-6 ������ ��ȸ�ϴ� ���
     select last_name, job_id, salary
	    from employees
       where salary >=  5000
		 and salary <=  10000;
		(=)
      select last_name, job_id, salary
	    from employees
       where salary between 5000  and 10000;
--  3-7 ����(�Ҽ�) �ϴ� 2���� ���
     select last_name, department_id,
	          job_id, salary
	    from employees
       where department_id = 10
	      or department_id = 30
	      or department_id = 70;
		  (=)
	   select last_name, department_id,
	          job_id, salary
	    from employees
       where department_id IN (10,30,70);

--  3-8 ����� �ڷ� like
  	 last_name like 'M%'
  	 % : ��� ���ڿ��� �����ϴ�.
  	 _ : �� ���ڿ��� ����. ( last_name like '__c%')
     select last_name, salary
	   from employees
	  where last_name like 'M%';

	 select last_name, salary
	   from employees
	  where last_name like '__c%'

--  3-9 null �� ��
    -- Null�� ������� �񱳵��� �ʴ´�.
  	 commission_pct = ''
    -- �ߵ� ��
  	 commission_pct is null
  	 commission_pct is not null
    -. 0�� ��ȸ
     select last_name, salary
       from employees
       where commission_pct is null;
--       where commission_pct is not null

-- 4. order by ����
    - �÷�, ���� [asc || desc]
        last_name desc
	-.�⺻�� asc
	    last_name
	-. �����÷��� ����
	-. col1 , col2 desc, col3

-- 5. Query�� ���� ����
	-. From > Where > Group By > Having > Select > Order By

=================================
-- HR����������������01.ppt ���� Ǯ�� 1-14
=================================

-- 6�� ������ �Լ�
-- �Լ��� ���� : �����Լ�, ����� ���� �Լ�
-- �����Լ� ���� : ������ �Լ�, ������ �Լ�

-- ������ �Լ� ���� : ����, ����, ��¥�Լ�
-- �����Լ� : LOWER, upper, INITCAP, concat,
		   substr, length, instr, replace,
--		   trim
-- �����Լ� : round, trunc, mod
-- ��¥�Լ� :
		   sysdate, MONTHS_BETWEEN, ADD_MONTHS, LAST_DAY
-- �Ϲ� �Լ�:
		   nvl, case
=================================
-- �����Լ�
select lower('ABCD')   from dual;

select upper('abcd')   from dual;

select initcap('abcd') from dual;

select upper(last_name) from employees;

select CONCAT(FIRST_name, last_name) fname
from employees;

select last_name, length(last_name) len_name
from employees;

select last_name, instr(last_name,'i') in_name
from employees;

select last_name, substr(last_name,1,4) sub_name
from employees;

select lpad('inho', 10, '#') from dual;
select rpad('inho', 10, '#') from dual;

select '[' || '  abcd  ' || ']' from dual;
select trim('  abcd  ') from dual;
select '[' || trim('  abcd  ') || ']' from dual;
select trim('b' from 'abcd') from dual;

select replace('inho', 'in','Shin') from dual;
--
select substr('shin@navar.com', 1,4) as sub_irum,
	 instr('inho', 'h')            as in_irum,
	 instr('inho', 'A')            as in_irum2,
	 replace('inho', 'in', 'Shin') as re_irum
from dual;

--  �����Լ�
select 12.345678 as idat,
	mod(10,3) as div_mod,
	round(12.345678, 2) as run2,
	trunc(12.345678, 2) as trun2
from dual;
select round(avg(salary), 2) aa from employees;

select round(avg(salary), -1) aa from employees;

select 10/3 dd1, mod(10, 3) dd2, round(10/3, 2) dd3 from dual;

select trunc(45.3271,2) from dual;

-- ��¥
select last_name, hire_date,
       round((sysdate - hire_date) / 7, 0) weeks
from employees;

select MONTHS_BETWEEN(sysdate, '2022-01-01') from dual;

select add_MONTHS(sysdate, 3) from dual;

select last_day('2022.02.01') from dual;

select next_day('2022.02.01', 3) from dual;
   -- 1: �Ͽ���, 2: ������, 3: ȭ����, 4: ������, 5: �����, 6: �ݿ���, 7: �����
--
select sysdate as now_date,
	 MONTHS_BETWEEN(sysdate,'2022.12.31') as Betwmm
from dual;
select sysdate as now_date,
	MONTHS_BETWEEN(sysdate,'2022.12.31') as Betwmm,
	add_months(sysdate, 3) add_mon,
	last_day(sysdate) lday,
	-- 1: ��, 2: ��, 3: ȭ, 4: ��, 5:��, 6:��,7:��
	next_day(sysdate, '��')
from dual;

select sysdate - 7 as date7 from dual;

-- �������� ����ȭ : ������, ����� ����ȭ
-- �Ͻ���(������), ����� �� ��ȯ
select 100 + '200' from dual;
300
select 100 + '2a' from dual;
����
select '100' + '200' from dual;
300
select 100 || '200' from dual;
100200
select 100 || 200, (100 || 200) + 100 from dual;
select 100 || 200, 100 || (200 + 100) from dual;

------------------------
-- ����� ����ȯ(����, ����, ��¥.)
-- to_cahr, to_date, to_number

select ('1' + to_number('2')) as tmp from dual;

select to_number('123456') aa from dual;
select to_char(123456) aa from dual;
select to_date(123456) aa from dual;

select last_name, hire_date,
       to_char(hire_date,'yyyy-mm') �Ի���
from employees

select '2022-07-08' dat  from dual;
select to_date('2022-07-08') dat  from dual;

select '123', to_number('123')
  from dual;
select to_number('123') + 100
  from dual;

-- �������� ��ȸ ������ ����
select last_name, hire_date, salary
  from employees;
select last_name,
	   to_char(hire_date,'yyyy-mm-dd') hire_date,
	   to_char(salary, '999,999') salary
  from employees;
select TO_DATE('2022-09-08')
  from dual;
-- ����
select to_number('12345dd')
  from dual;

-- �Ϲ��Լ� : nvl, case
-- nvl(commission_pct,0)
select last_name, salary,
       (salary * 12 * commission_pct) annual
  from employees;

select last_name, salary, commission_pct,
       (salary * (1 + nvl(commission_pct,0))) sal_com,
       (salary * (1 + nvl(commission_pct,0)))*12 annual
  from employees;
-- ��ø�Լ�
select last_name,
       nvl(to_char(manager_id), 'No Manager') as mgr
  from employees;

=================================
-- 07�� ������ �Լ�(�׷��ռ�)
-- group by ������ �׷��Ϸ��� �׸�(�÷�)�� ����Ѵ�.
-- having ������ �׷��Ϸ��� �ڷḦ �����Ѵ�.
-- �׷��Լ� ����: sum(), avg(), count(), min(), max()
-- ���ڿ� ����ϴ� �׷��Լ�: sum(), avg()
-- ����, ���ڿ� ��� : max(), min(), count()
-- null ���� ���Ե��� �ʴ´�
=================================
select avg(salary) sal_avg,
       sum(salary) sal_sum,
	   max(salary) sal_max,
	   min(salary) sal_min,
	   count(salary) sal_cnt
from employees;

-- null ���� ���Ե� �׸��� �����Լ� 
-- sum, count, avg�� null�� �����ϰ� �����Ѵ�.

-- group by ���� �÷��� �����ϰ� Select���� ����Ѵ�.
-- where : select���� data�� ����
-- having :group by(�����Լ�) ���� �����Ѵ�.
select department_id, job_id,
	   avg(salary) sal_avg,
       sum(salary) sal_sum,
	   count(salary) sal_cnt
from employees
where department_id is not null
group by department_id, job_id
order by department_id;

-- ������ �������� ����: having
-- where : select ��(��)�� ���� ����
-- having : group by �� ���� ����
SELECT job_id, avg(salary)
FROM employees
group BY job_id
HAVING avg(salary) > 15000
;
select department_id, job_id,
       to_char(sum(salary), '999,999') sum_sal,
	   to_char(avg(salary), '999,999.99') avg_sal
  from employees
group by department_id, job_id
having  sum(salary) > 10000
order by department_id, job_id;

-- �츮ȸ���� ������ �������� �ְ�޿��� �����޿�, ����,�ְ� �޿��� ���̰� 
-- 1,000���� ū ��ȸ�Ͻÿ�.
select job_id,
       max(salary) as max_sal, min(salary) as min_sal,
       (max(salary) - min(salary)) as sal_cha
from employees
group by job_id
having (max(salary) - min(salary)) > 1000;
       
-- �츮ȸ���� ������ ���� ���� �ټӳ��, �����ټӳ��, �ټӳ��(��)�� ���̸� ��ȸ�Ͻÿ�.
select min(hire_date) as min_hire, 
	   max(hire_date) as max_hire,
       max(hire_date)- min(hire_date) as cha_day,
       round((max(hire_date)-min(hire_date))/ 365,0) as max_cha
from employees       
;
=================================
-- HR����������������01.ppt ���� Ǯ�� 15-21
=================================

-- 8�� ���� ���̺��� ������ ǥ��(����)
-- : �ΰ� �̻��� ���̺��� ���η� ���̴� ȿ��
-- from ���� n���� ���̺��� ���
--       ����� ���̺��� �� -1�� where ������ �ʿ��ϴ�..
=================================
-- 2889��
select employees.department_id, departments.department_name
from employees, departments

-- 106�� / 107��
select e.department_id, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

-- ������ ����
-- �(=):inner, ��, ��ü����, ����(left,right join)

-- � ����(inner join)
--��� ��) �����: pk, fk,���� ����Ǵ� �����͸� ��ȸ
-- 50�μ��� �ٹ��ϴ� ������ �̸�, �μ��ڵ�, �μ���, ����, �޿��� ��ȸ..
select e.last_name, e.department_id, d.department_name, job_id, salary
from employees e, departments d
where e.department_id = d.department_id
  and e.department_id = 50
;
-- �� ����(>,<, >=, <=)
--��� ��) ������:  ������ ������ ����
select e.last_name, e.salary, j.GRADE_LEVEL
from employees e, job_grades j
where e.salary between j.LOWEST_SAL and j.HIGHEST_SAL;

-- ��ü����...
-- ������ �̸�, ����� �̸�, ����, �޿� ��ȸ�Ͻÿ�..
select emp.employee_id, emp.last_name, mgr.last_name as manager_irum,
       emp.job_id, emp.salary
from employees emp, employees mgr
where emp.manager_id = mgr.employee_id;

-- ��������(outer join)
106�� > 107�� > 122��

-- ǥ�������� ����.

=================================
-- 9�� ��������(Sub Query)
-- ���� ���� : �����ȿ� ������ �ִ� ������
-- ��ȸ�ϰ��� �ϴ� ���� �𸣴� ��� Ȱ��
-- ����: ������, ������ ��ȯ ��������
=================================

select last_name, job_id, salary
from employees
where salary > (6461);

-- ������ ������(=,>,<,>=,<=, <>)
-- ȸ���� �����߿��� ��ձ޿� ���� ���� �޴� ������ �̸�, ����, �޿��� ��ȸ..
select last_name, job_id, salary
from employees
where salary > (select avg(salary)
                  from employees);
;
-- ȸ���� �����߿��� �ְ�޿��� �޴� ������ �̸�, ����, �޿��� ��ȸ..
select last_name, job_id, salary
from employees
where salary = (select max(salary)
                  from employees);
;

-- ������ �������� ���
-- in, >all, <all, >any, <any
-- in(or)  : ��� ���� ���� �����ϴ� ���� ��ȯ
-- any(or) : <any �ִ밪 ���� ������, >any �ּҰ����� ū��(10,20,30,40)
-- all(and): <all �ּҰ����� ������,  >all �ִ밪���� ū��(10,20,30,40)

--(9000,6000,4800,4200)
select employee_id, department_id, job_id, last_name, salary
  FROM employees
 where salary in (select salary
                     from employees
                    where department_id = 60)
;                    
select employee_id, last_name, job_id, salary
  FROM employees
 where salary <all (select salary
                     from employees
                    where department_id = 60)
;                    
select employee_id, last_name, job_id, salary
  FROM employees
 where salary <any (select salary
                     from employees
                    where department_id = 60)
;  

=================================
-- 10�� DML(Data manipulation Language)
-- insert, update, delete, commit, rollback, savepoint
-- insert ��
-- Ʈ������(TRANSACTION)
=================================
  1) ���̺� ���ο� ���� �߰� �Ѵ�. ������� �۾��� ����ȴ�.
  2) ����
    -. ����, �Ӽ�, ������  �����Ǿ�� �Ѵ�.
    (1) insert into ���̺�� values (); ���̺� �ִ� ��� �÷� �� 1:1 ����
      ��) insert into departments values (300, 'AI Big Data', 114, 1400);
      select * from departments;
    (2) insert into ���̺�� (�÷���) values (); : ����� ��� �÷� �� 1:1 ����
      ��) insert into departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID)
        values (310, 'AI Big Data', null, null);
    (3) insert into ���̺�� (�Ϻ� �÷���) values (); : ���������� ���� �÷� �� 1:1 ����
      ��) insert into departments (DEPARTMENT_ID,DEPARTMENT_NAME)
           values (320, 'AI Big Data');

-- update��
-- update ���� ���� �ϱ����� �ݵ�� ��� �����͸� Ȯ���Ѵ�.
-- �÷������� ������ �����ϴ�.
update table��
   set col1 = val01,
       col2 = val02,
       col3 = val03
 where ���ǽ�  ;
-- ��� ��)
--������ ������ Ȯ��
select lname, sal, bouns 
from emp_ddl
where emp_id = 156;

update emp_ddl
  set lname = 'Shin inho',
      sal = 2400
where emp_id = 156;

-- emp_ddl ���̺��� ��ü ������ ��ձ޿����� ���� �����鿡�� �޿��� 5% �λ��ϱ�..
update emp_ddl
   set sal = sal + (sal * 0.05)
where sal < (select avg(sal) from emp_ddl);

-- delete��
-- delete ���� ���� �ϱ����� �ݵ�� ��� �����͸� Ȯ���Ѵ�.
-- �� ������ �۾��� ����ȴ�.
delete [ from ] table��
 where ���ǽ�..
-- ��� ��)
 delete from employees where EMPLOYEE_ID >= 300;
 delete from departments where department_id >= 300;


=================================
-- 11�� TCL Ʈ�����(Transaction Control Language)
-- DML �۾��� �����ϸ� Ʈ������� �߻��Ѵ�.
-- Ʈ�������� �����۾����� �ϳ��� ���� �����Դϴ�. 
--  �� ����� �۾����� ��� ����ǰų�,������� �ʽ��ϴ�.(all-or-nothing)
-- ACID : �������� ��ȿ���� �����ϱ� ����, Ʈ�������� Ư¡���� �ձ��ڸ� �� �ܾ��Դϴ�.
  - ���ڼ�(Atomicity) : ��� �۾��� �ݿ��ǰų� ��� �ѹ�Ǵ� Ư���Դϴ�
  - �ϰ���(Consistency): �����ʹ� �̸� ���ǵ� ��Ģ������ ������ ������ Ư���� �ǹ��մϴ�.
      �����÷��� ���ڿ����� ������ �ȵǵ��� �������ݴϴ�.
  - �ݸ���(Isolation): A�� B �ΰ��� Ʈ�������� ����ǰ� ���� ��,
      A�� �۾����� B���� �������� ������ �ǹ��մϴ�.
  - ���Ӽ�(Durability): �ѹ� �ݿ�(Ŀ��)�� Ʈ�������� ������ ������ ����Ǵ� Ư���� �ǹ��մϴ�.
-- ��ɾ� : commit, rollback, savepoint
=================================
commit;
savepoint abc;
rollback to abc;
rollback ;

------------------------
-- Ʈ����� �ǽ�
-- 1.insert > 2.savepoint > 3.delete > 4.rollback to >
-- 5.update > 6.rollback > 7.delete > 8.commit
------------------------
-- 1. insert
insert into emp_ddl ( 
select employee_id, last_name, salary, commission_pct, sysdate
  from employees
);
-- 2. savepoint
savepoint sp_int;
-- 3. delete
delete from emp_ddl;
-- 4. rollback to
rollback to sp_int;
-- 5. update
update emp_ddl
   set sal = sal + (sal * 0.05)
 where sal < (select avg(sal) from emp_ddl);
-- 6. rollback
rollback;
-- 7. delete
delete from emp_ddl;
 where sal >= (select avg(sal) from emp_ddl);
-- 8. commit
commit;

-- Ʈ�����(Transaction)�� ����
-- ����� : commit, rollbcak
-- �Ϲ��� : ������ ����, ddl�� ����(commit)

=================================

-- 12�� DDL(Data Definition Language)
-- ddl ���� : create, alter, drop,
--          truncate, rename, comment
=================================

-- �÷��� �Ӽ�
-- ����
   char, varchar, varchar2
-- ����
   number, number(5), number(5,2)
-- ��¥
   date
   TimeStamp

-- ���̺��� ����
drop table emp_ddl;
create table emp_ddl (
    emp_id  number,
    lname varchar(30),
    sal   number,
    bouns number(5,2),
	dept_id  number,
    cdate  date
);
drop table dept_ddl;
create table dept_cnst(
    dept_id number(4) PRIMARY key 
   ,dept_nm varchar2(30) not null
   ,mgr_Id   number(4) REFERENCES emp_cnst(emp_id)
);
--���������� Ȱ���� ������ ����
insert into emp_ddl (
   select employee_id 
	 ,last_name, salary, commission_pct 
	 ,department_id, sysdate
    from employees)
;
-- �μ�����
insert into dept_ddl (
  select department_id, department_name
        ,Manager_id
	from departments	 
);
select * from dept_ddl;

-- ���������� �̿��� ���̺��� ����
create table ���̺��̸� as (��������)
;
-- �� ���̺� ����
create table emp_ddl10 as (
   select employee_id as emp_id
         ,last_name as lname
		 ,salary as sal
		 ,commission_pct as bonus
		 ,department_id as dept_id
		 ,sysdate as cdate
     from employees
    where 1 <> 1
);
select * from emp_ddl10;
-- �����͸� ������ ���̺� ����
create table emp_ddl20 (emp_id,lname,sal,bonus,dept_id,cdate) as 
   (Select employee_id, last_name, salary
		 ,commission_pct, department_id, sysdate
      from employees
);
select * from emp_ddl20;
-- ���� �������� Ȱ�� ���̺� ����
create table emp_ddl30 as (
      select e.department_id, d.department_name,
          avg(salary)
      from employees e, departments d
     where e.department_id = d.department_id
    group by e.department_id,d.department_name
);
select * from emp_ddl30;

-- ���̺��� ����(alter)
-- alter table ���̺��
-- add, modify, rename, drop
alter table emp_ddl30 add( cdate date);

alter table emp_ddl30 modify( lname varchar(40) );

alter table emp_ddl30 rename column lname to last_nm;

alter table emp_ddl30 drop (cdate);

-- �÷��� �ּ� �ޱ�..
comment on column emp_ddl30.emp_id is '���� ��ȣ';
-- ���̺� �ּ� �ޱ�..
comment on table  emp_ddl30 is '���� ����';

-- ���̺� �̸��� �ٲٱ�
rename emp_ddl30 to emp_ddl35;

select * from user_tab_comments

select * from emp_ddl35;

-- DDL����� ������ auto commit;
-- DDL���� commit,  rollback; ���� �ʴ´�..

-- truncate
select * from  emp_ddl;

delete from emp_ddl;  -- dml
rollback;

truncate table emp_ddl;  --ddl
rollback;

-- ���̺��� ����
drop table emp_ddl10;
drop table emp_ddl20;
drop table emp_ddl35;


=================================
-- 13�� ��������
-- �������� ���Ἲ�� �����ϱ� ���Ͽ� �ʿ��ϴ�.
--  ���Ἲ: �������� ��Ȯ���� �ϰ����� ����
--   (����(null),��ü(Pk),����(Fk)���Ἲ)
-- ����:
    primary key,not null, unique, 
	check, foreign key, [ default ]
-- primary key : not null, unique
-- not null : � ���̵��� �־�� �Ѵ�.
-- unique   : �ߺ��� ������� �ʴ´�. null ���
-- foreign key : �ܺ�Ű�� ����
-- check : �ԷµǴ� ���� ������ ����

-- ���������� �ο��ϴ� ���
   -. �� ���ؿ���  �ִ¹��
   -. ���̺� ���ؿ��� �ִ¹��
   -. ���� ������ �̸��� �ߺ����� �ʴ´�.
=================================
-- ���������� ��ȸ
select * from user_constraints
where table_name = 'DEPT';

-- �������� ���� ���� �ο�..
-- sys_c123456

create table emp_cnst(
    emp_id number(4)  constraint emp_pk primary key
   ,lname varchar2(30) constraint emp_lname_nn not null
   ,email varchar2(30) unique
   ,hdate date  default sysdate
   ,job_id varchar2(15)
   ,sal    number(8,2) constraint emp_sal_ck check (sal between 1000 and 10000)
   ,bonus  number(5,2)
   ,mgr_id   number(4)
   ,dept_id number(4) references dept_ddl(dept_id)
);
select * from emp_cnst;

-- PRIMARY key
insert into emp_cnst (emp_id, lname, email)
   values (10, 'shin inho', 'inho@smhr.or.kr');
select * from emp_cnst;   
-- not null - lname
insert into emp_cnst (emp_id, email, sal)
   values (20, 'inho@smhr.or.kr', 9000);
select * from emp_cnst;   
-- unique, null - email
insert into emp_cnst (emp_id, lname, email)
   values (30, 'shin inho01', 'inho@smhr.or.kr');
insert into emp_cnst (emp_id, lname, job_id)
   values (35, 'shin inho01', 'IT_PROG');
select * from emp_cnst;   
-- check
insert into emp_cnst (emp_id, lname, email, sal)
   values (40, 'shin inho01', 'inho@smhr.or.kr', 12000);
select * from emp_cnst;   
-- foreign KEY
insert into emp_cnst (emp_id, lname, email, dept_id)
   values (50, 'shin inho', 'inho03@smhr.or.kr', 350);
select * from emp_cnst;   
-- Sysdate
insert into emp_cnst (emp_id, lname, email, hdate)
   values (60, 'shin inho', 'inho02@smhr.or.kr', sysdate);
rollback;

-----------------
-- ���̺� ���ؿ����� ���� ���� �ο�..
-- not null�� �� ���ؿ��� �������� �ο�
drop table emp_cnst;
create table emp_cnst(
    emp_id number(4)
   ,lname varchar2(30) not null
   ,email varchar2(30)
   ,hdate date
   ,job_id varchar2(15)
   ,sal    number(8,2)
   ,bonus  number(5,2)
   ,mgr_id   number(4)
   ,dept_id number(4)
   ,constraint emp_cns_pk primary key (emp_id)
   ,unique (email)
   ,constraint emp_cns_sal_ck check (sal between 1000 and 15000)
   ,foreign key (dept_id) references dept_ddl(dept_id)
);

-- foreign key �ǽ�
insert into emp_cnst (emp_id, lname, sal, bonus, dept_id)
  (select 350,lname, sal, bonus, 30 
	from emp_ddl
	where emp_id = 107
  );
select * from emp_cnst;
rollback;

-- �������� Ǯ���� ����
-- ������ �޿��� 5000���� ���� �޴� ������
-- ������ȣ, �̸�, ����, �Ի���,�޿�, �μ���, �����ڸ��� ��ȸ�Ͻÿ�..
-- �޿��� 3�ڸ����� ','�� �����Ѵ�.
-- �����ڰ� ���� ������ ����Ѵ�.

------------------------------------
--  ���������� ����
drop table emp_cnst;
create table emp_cnst(
    emp_id number(4)
   ,lname varchar2(30)
   ,email varchar2(30)
   ,hdate date 
   ,job_id varchar2(15)
   ,sal    number(8,2)
   ,bonus  number(5,2)
   ,mgr_id   number(4)
   ,dept_id number(4) 
);

alter table emp_cnst
  add primary key(emp_id);
--alter table emp_cnst
--  add not null(lname);
alter table emp_cnst
  add constraint emp_email_un unique(email);
alter table emp_cnst
  add check(sal between 1000 and 10000);
alter table emp_cnst
  add foreign key (dept_id) references dept_ddl(dept_id);

alter table emp_cnst
  add constraint emp99_pk primary key(emp_id);
alter table emp_cnst
  drop primary key;
alter table emp_cnst
  drop constraint sys_c0007009;


=================================
-- ���̺�ǽ���_����.xlsx Ǯ��
=================================

-- 14�� ��Ÿ ��ü
-- ���̺�, ��, �ε���, ������, ���Ǿ�
=================================
-- �����ͻ���
select * from user_tables;
select * from all_tables;
select * from all_objects where owner ='HR';
select * from user_objects;

select * from user_col_comments
where table_name = 'DEPARTMENTS';
select * from all_col_comments
where table_name = 'DEPARTMENTS';

select * from user_tab_comments
where table_name = 'DEPARTMENTS';
select * from all_tab_comments
where table_name = 'DEPARTMENTS';

select * from user_constraints
where table_name = 'DEPT';

select * from user_cons_columns
where table_name = 'DEPT';
-----------------

create ��ü������ ��ü�� ...
;
-- 1. view
-- create view ��� as (select from ..)
-- �������� ������ ���� �Ҷ�
-- ������ ���Ǹ� ���� �Ҷ�
-- �������� �������� �����Ҷ�..

create view vw_emp80 as
  (select employee_id, last_name, job_id, salary, (salary * 12 ) as  annual
     from employees
    where department_id = 80
  );

select * from vw_emp80;
select * from user_views;
-- ������ȣ, �̸�, ����, �Ի���(yyyy-mm-dd), �޿�(999,999), �μ��̸�, ����̸���
-- ��ȸ�ϴ� ���� ����

-- in Line ��
-- ȸ�系�� �޿��� ���� �޴� ���� ���� 5���� �̸��� �޿� ��ȸ..
select rownum, a.*
from (select last_name, salary
        from employees
        order by salary desc) a
where rownum < 6 ;

-- 2. �ε���
-- �˻��� �ӵ��� ���δ�.
-- �������� ���� ������ ������ �ִ�.
-- DML�� ����ϰ� �Ͼ�� Tablel�� ���ؼ��� ������ ���� �����´�.
-- �ε��� ����� �������
--  1) ���� ������ �������ϰ� ���ԵǴ� ���
--  2) ������, ������ ���� �Ͼ�� �׸�
--  3) ��κ��� ���ǿ� ���� �˻���� 2-4%�̸��� ���
-- �����ȹ�� ��ȸ F10
create index emp_name_idx
   on emp_ddl (lname);

select * from emp_ddl
where lname like '��%';

select * from user_indexes;
select * from user_ind_columns;

drop index emp_name_idx;

-- 3. ������(Sequence)
--  ������ ��ȣ�� �ڵ����� �����Ѵ�.
--  ������ �����ϴ�.
--  �Ϲ����� �⺻Ű(pK)�� ����Ѵ�.

drop sequence emp_seq;
create sequence emp_seq
   increment by 10
   start with 100
   maxvalue 999999999999999
   nocache
   nocycle;

drop table  emp_ddl;
insert into emp_ddl (empno, lname, sal)
  (select emp_seq.nextval,last_name, salary
    from employees);
commit;

select emp_seq.nextval from dual;
select emp_seq.currval from dual;

alter sequence emp_seq
   increment by 5
   maxvalue 9999999
   nocache
   nocycle;


-- 4. ���Ǿ�(Synonym)
-- ��ü�� ���� ������ �ο��Ѵ�.
create Synonym emps for employees;

select * from emps;

drop Synonym emps;

select Synonym_name from user_synonyms;

-- 5. ����� ���� �Լ�
--  �Լ��� �ǵ��ƿ��� ��(return)�� �ִ�.
--  ������ ����̴�.
select substr('ajkdaskjd', 2,3) from dual;
select instr('Shin inho', 'ho') from dual;
select upper('asasdasdf') from dual;

-- ����� ���� �Լ�
-- �μ��̸��� ��ȯ�ϴ� �Լ�..
create or replace function fn_dname (dept_id in int)
   return varchar
is
   dnm varchar2(30);
begin
   select department_name into dnm
     from departments
     where department_id = dept_id;
   return dnm;
end;
/
select fn_dname(10) from dual;

-- �μ����� ��ȸ�ϴ� ����� �����Լ� �̿��Ͽ� ������ �̸�, �μ��̸�, �Ի���, �޿��� ��ȸ�Ͻÿ�..
select last_name, fn_dname(department_id), hire_date, salary
  from employees;


-- 6. TRIGGER
--
create table emp_cnstbak as ( select a.*, sysdate as cdate 
                                from emp_cnst a where 1 <> 1)
;
create or replace TRIGGER emp_delete
  before delete on emp_cnst for each row
begin
  insert into emp_cnstbak values (
    :old.emp_id   ,:old.lname   ,:old.email   ,:old.hdate
   ,:old.job_id   ,:old.sal   ,:old.bonus   ,:old.mgr_id
   ,:old.dept_id, sysdate
  );
end;
/
delete emp_cnst where EMP_id in (150,160);
commit;
select * from emp_cnstbak;

=================================
-- 15�� DCL(Dta Control Language)
-- DCL : grant to, revoke from
=================================
-- System �������� ����
show user;
-- ������ ����
create user inho IDENTIFIED by inho;

-- ��������� �ο�
grant create session to inho;

-- ���̺� ���������� �ο�
grant create table to inho;
grant create view to inho;

-- �ڿ��� ������ �ο�
grant resource to inho;

grant create session, RESOURCE,
      create table,create view,
      create sequence
to inho;
-- �ٸ� ������� ��ü�� ��ȸ
grant select on hr.employees to inho;
-- �ٸ� ����ڿ��� ������ �ο��� �� �ִ� ������ �����մϴ�.
grant select, insert on departments
   to inho with grant option;

-- ��ȣ ����
alter user inho IDENTIFIED by shin account lock;

alter user inho IDENTIFIED by shin account unlock;

-- �ο��� ������ Ȯ��
select * from user_role_privs;

-- ������ ȸ��
revoke create table from inho;

revoke create session, RESOURCE,
  create table,create view,
  create sequence
from inho;

-- ����� ����
drop user inho cascade;

===============================
-- inho �������� ����
show user;

create TABLE temp04 (
    irum varchar(20),
    phon varchar(20)
);
-- ������ ���̺��� ��ȸ
select table_name from user_tables;

create view vw_temp as
  (select * from temp);

create sequence temp_seq
   increment by 10
   start with 100
   maxvalue 999999999999999
   nocache
   nocycle;

select * from hr.employees;


