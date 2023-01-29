=================================
-- 오라클 설치및 환경구축

--윈도우 검색창에서 cmd
cmd 실행
C:\Users\smhrd> sqlplus / as sysdba

--------------------------
sql>@C:\Users\user\Desktop\DataBase\create_scott.sql

sql> quit, exit
C:\Users\smhrd>sqlplus hr/hr

-- 디비 재접속
sqlplus hr/hr

-- 학습용 table을 조회
select table_name from user_tables;

-- 테이블의 구조를 조회
desc departments
desc employees

-- 부서 테이블 자료의 조회
select * 
from departments;

--sqlplus 설정
show user;
COLUMN last_name format a18;
COLUMN department_name format a18;

set pagesize 50;
set linesize 100;

-- 쿼리 수정
ed  -- 메모장 편집
SQL> /   -- 실행

=================================
-- 5장 DQL(Data Query Language)
=================================
-- Select
--   From
-- [where
-- Group by
-- Having
-- Order By ]
--
-- 1.SELECT 절의 사용
--  1-1 *  : from 절에 기술한 테이블의 모든항목 조회
      select * from departments;  -- 셀렉션
	  select department_name from departments; -- 프로젝션
--- 1-2 from절에 기술된 컬럼을 기술, 여러개의 컬럼은 ','로 구분한다.
	  select department_id, department_name
	    from departments;  -- 프로잭션
--- 1-3 distinct : 중복을 제거한다.
      select job_id
	    from employees;
--- 1-4 별명(alias)
	  select last_name lname, salary
  	    from employees;
	  select last_name as lname, salary
		from employees;
	 -. 열머리는 대문자로 표기되고, 문자는 왼쪽정렬, 숫자는 오른쪽 정렬한다.
--- 1-5 연산(+, -, *, /)이 가능하다.
      select last_name, (salary * 12) annsal
	      from employees;
	  -. 연산의 우선순위를 따른다.(*, /,+, -)
--- 1-6 연산에 null의 참여시 결과는 Null이다.
      select last_name, salary,
	       (salary * commission_pct) cmmsal
	  from employees;
--- 1-7. 문자열의 연결(||)
	  select (last_name || first_name) irum
        from employees;
   	  select (last_name || '-' || first_name) irum
        from employees;

-- 2.From절 의 사용
--- 2-1 테이블 명, view명
--- 2-2 데이터 셋
--- 2-3 여러개의 테이블명을 기술(조인)
--- 2-4 가상의 테이블 dual;

-- 3.where절(조건절) 의 사용
--  3-1.조건식 등식으로 완성되어야 한다.
   직원번호가 100인 직원의 이름, 직종을 조회하시오..
    select last_name, job_id, 
	  from employees
	 where employee_id = 100;
--  3-2.조건이 여러개인 경우는(and, or)연결하고 이후
     조건도 완전한 등식 성립되어야 한다.
   부서가 50부서이고, 직종이 'IT_PROG'인 직원의 이름, 급여를 조회하시오..
	  select last_name, job_id, salary
	    from employees
       where department_id = 50
         and job_id ='ST_MAN';
--  3-3.문자열, 날짜를 비교할때에는 홑따옴표('')안에 표기한다.
--  3-4.문자열 값을 비교할 때에는 대소문자가 구별된다.
--  3-5.연산자 우선순위가 있다.(and, or)
     select last_name, job_id, salary
	    from employees
       where job_id ='IT_PROG'
	      or job_id ='AD_PRES'
	     and salary > 15000;

--  3-6 범위를 조회하는 방법
     select last_name, job_id, salary
	    from employees
       where salary >=  5000
		 and salary <=  10000;
		(=)
      select last_name, job_id, salary
	    from employees
       where salary between 5000  and 10000;
--  3-7 포함(소속) 하는 2가지 방법
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

--  3-8 비슷한 자료 like
  	 last_name like 'M%'
  	 % : 모든 문자열을 포함하다.
  	 _ : 한 문자열을 포함. ( last_name like '__c%')
     select last_name, salary
	   from employees
	  where last_name like 'M%';

	 select last_name, salary
	   from employees
	  where last_name like '__c%'

--  3-9 null 의 비교
    -- Null은 등식으로 비교되지 않는다.
  	 commission_pct = ''
    -- 잘된 비교
  	 commission_pct is null
  	 commission_pct is not null
    -. 0건 조회
     select last_name, salary
       from employees
       where commission_pct is null;
--       where commission_pct is not null

-- 4. order by 정렬
    - 컬럼, 별명 [asc || desc]
        last_name desc
	-.기본값 asc
	    last_name
	-. 다중컬럼의 정렬
	-. col1 , col2 desc, col3

-- 5. Query의 실행 순서
	-. From > Where > Group By > Having > Select > Order By

=================================
-- HR실전쿼리연습문제01.ppt 문제 풀이 1-14
=================================

-- 6장 단일행 함수
-- 함수의 종류 : 내장함수, 사용자 정의 함수
-- 내장함수 종류 : 단일행 함수, 다중행 함수

-- 단일행 함수 종류 : 문자, 숫자, 날짜함수
-- 문자함수 : LOWER, upper, INITCAP, concat,
		   substr, length, instr, replace,
--		   trim
-- 숫자함수 : round, trunc, mod
-- 날짜함수 :
		   sysdate, MONTHS_BETWEEN, ADD_MONTHS, LAST_DAY
-- 일반 함수:
		   nvl, case
=================================
-- 문자함수
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

--  숫자함수
select 12.345678 as idat,
	mod(10,3) as div_mod,
	round(12.345678, 2) as run2,
	trunc(12.345678, 2) as trun2
from dual;
select round(avg(salary), 2) aa from employees;

select round(avg(salary), -1) aa from employees;

select 10/3 dd1, mod(10, 3) dd2, round(10/3, 2) dd3 from dual;

select trunc(45.3271,2) from dual;

-- 날짜
select last_name, hire_date,
       round((sysdate - hire_date) / 7, 0) weeks
from employees;

select MONTHS_BETWEEN(sysdate, '2022-01-01') from dual;

select add_MONTHS(sysdate, 3) from dual;

select last_day('2022.02.01') from dual;

select next_day('2022.02.01', 3) from dual;
   -- 1: 일요일, 2: 월요일, 3: 화요일, 4: 수요일, 5: 목요일, 6: 금요일, 7: 토요일
--
select sysdate as now_date,
	 MONTHS_BETWEEN(sysdate,'2022.12.31') as Betwmm
from dual;
select sysdate as now_date,
	MONTHS_BETWEEN(sysdate,'2022.12.31') as Betwmm,
	add_months(sysdate, 3) add_mon,
	last_day(sysdate) lday,
	-- 1: 일, 2: 월, 3: 화, 4: 수, 5:목, 6:금,7:토
	next_day(sysdate, '수')
from dual;

select sysdate - 7 as date7 from dual;

-- 데이터의 형변화 : 묵시적, 명시적 형변화
-- 암시적(묵시적), 명시적 형 변환
select 100 + '200' from dual;
300
select 100 + '2a' from dual;
오류
select '100' + '200' from dual;
300
select 100 || '200' from dual;
100200
select 100 || 200, (100 || 200) + 100 from dual;
select 100 || 200, 100 || (200 + 100) from dual;

------------------------
-- 명시적 형변환(문자, 숫자, 날짜.)
-- to_cahr, to_date, to_number

select ('1' + to_number('2')) as tmp from dual;

select to_number('123456') aa from dual;
select to_char(123456) aa from dual;
select to_date(123456) aa from dual;

select last_name, hire_date,
       to_char(hire_date,'yyyy-mm') 입사일
from employees

select '2022-07-08' dat  from dual;
select to_date('2022-07-08') dat  from dual;

select '123', to_number('123')
  from dual;
select to_number('123') + 100
  from dual;

-- 데이터의 조회 형식의 지정
select last_name, hire_date, salary
  from employees;
select last_name,
	   to_char(hire_date,'yyyy-mm-dd') hire_date,
	   to_char(salary, '999,999') salary
  from employees;
select TO_DATE('2022-09-08')
  from dual;
-- 오류
select to_number('12345dd')
  from dual;

-- 일반함수 : nvl, case
-- nvl(commission_pct,0)
select last_name, salary,
       (salary * 12 * commission_pct) annual
  from employees;

select last_name, salary, commission_pct,
       (salary * (1 + nvl(commission_pct,0))) sal_com,
       (salary * (1 + nvl(commission_pct,0)))*12 annual
  from employees;
-- 중첩함수
select last_name,
       nvl(to_char(manager_id), 'No Manager') as mgr
  from employees;

=================================
-- 07장 다중행 함수(그룹합수)
-- group by 절에는 그룹하려는 항목(컬럼)을 기술한다.
-- having 절에는 그룹하려는 자료를 제한한다.
-- 그룹함수 종류: sum(), avg(), count(), min(), max()
-- 숫자에 사용하는 그룹함수: sum(), avg()
-- 문자, 숫자에 사용 : max(), min(), count()
-- null 값은 포함되지 않는다
=================================
select avg(salary) sal_avg,
       sum(salary) sal_sum,
	   max(salary) sal_max,
	   min(salary) sal_min,
	   count(salary) sal_cnt
from employees;

-- null 값이 포함된 항목의 집합함수 
-- sum, count, avg는 null를 제외하고 집계한다.

-- group by 절에 컬럼은 동일하게 Select절에 기술한다.
-- where : select절의 data를 제한
-- having :group by(집계함수) 절을 제한한다.
select department_id, job_id,
	   avg(salary) sal_avg,
       sum(salary) sal_sum,
	   count(salary) sal_cnt
from employees
where department_id is not null
group by department_id, job_id
order by department_id;

-- 다중행 데이터의 제한: having
-- where : select 절(행)에 대한 제한
-- having : group by 에 대한 제한
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

-- 우리회사의 직원의 직종별로 최고급여와 최저급여, 최저,최고 급여의 차이가 
-- 1,000보다 큰 조회하시오.
select job_id,
       max(salary) as max_sal, min(salary) as min_sal,
       (max(salary) - min(salary)) as sal_cha
from employees
group by job_id
having (max(salary) - min(salary)) > 1000;
       
-- 우리회사의 직원의 가장 오랜 근속년수, 최저근속년수, 근속년수(년)의 차이를 조회하시오.
select min(hire_date) as min_hire, 
	   max(hire_date) as max_hire,
       max(hire_date)- min(hire_date) as cha_day,
       round((max(hire_date)-min(hire_date))/ 365,0) as max_cha
from employees       
;
=================================
-- HR실전쿼리연습문제01.ppt 문제 풀이 15-21
=================================

-- 8장 여러 테이블의 데이터 표시(조인)
-- : 두개 이상의 테이블을 가로로 붙이는 효과
-- from 절에 n개의 테이블을 기술
--       기술한 테이블의 수 -1의 where 조건이 필요하다..
=================================
-- 2889건
select employees.department_id, departments.department_name
from employees, departments

-- 106건 / 107건
select e.department_id, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

-- 조인의 종류
-- 등가(=):inner, 비등가, 자체조인, 포괄(left,right join)

-- 등가 조인(inner join)
--사용 예) 등가조인: pk, fk,서로 연결되는 데이터만 조회
-- 50부서에 근무하는 직원의 이름, 부서코드, 부서명, 직종, 급여를 조회..
select e.last_name, e.department_id, d.department_name, job_id, salary
from employees e, departments d
where e.department_id = d.department_id
  and e.department_id = 50
;
-- 비등가 조인(>,<, >=, <=)
--사용 예) 비등가조인:  범위로 데이터 연결
select e.last_name, e.salary, j.GRADE_LEVEL
from employees e, job_grades j
where e.salary between j.LOWEST_SAL and j.HIGHEST_SAL;

-- 자체조인...
-- 직원의 이름, 상관의 이름, 직종, 급여 조회하시오..
select emp.employee_id, emp.last_name, mgr.last_name as manager_irum,
       emp.job_id, emp.salary
from employees emp, employees mgr
where emp.manager_id = mgr.employee_id;

-- 포괄조인(outer join)
106건 > 107건 > 122건

-- 표준쿼리의 조인.

=================================
-- 9장 서브쿼리(Sub Query)
-- 서브 쿼리 : 쿼리안에 쿼리가 있는 쿼리문
-- 조회하고자 하는 값을 모르는 경우 활용
-- 종류: 단일행, 다중행 반환 서브쿼리
=================================

select last_name, job_id, salary
from employees
where salary > (6461);

-- 단일행 연산자(=,>,<,>=,<=, <>)
-- 회사의 직원중에서 평균급여 보다 많이 받는 직원의 이름, 직종, 급여를 조회..
select last_name, job_id, salary
from employees
where salary > (select avg(salary)
                  from employees);
;
-- 회사의 직원중에서 최고급여를 받는 직원의 이름, 직종, 급여를 조회..
select last_name, job_id, salary
from employees
where salary = (select max(salary)
                  from employees);
;

-- 다중행 연사자의 사용
-- in, >all, <all, >any, <any
-- in(or)  : 모든 행의 값에 대응하는 값을 반환
-- any(or) : <any 최대값 보다 적은값, >any 최소값보다 큰값(10,20,30,40)
-- all(and): <all 최소값보다 적은값,  >all 최대값보다 큰값(10,20,30,40)

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
-- 10장 DML(Data manipulation Language)
-- insert, update, delete, commit, rollback, savepoint
-- insert 문
-- 트랜젠션(TRANSACTION)
=================================
  1) 테이블에 새로운 행을 추가 한다. 행단위의 작업이 진행된다.
  2) 문법
    -. 순서, 속성, 갯수가  대응되어야 한다.
    (1) insert into 테이블명 values (); 테이블에 있는 모든 컬럼 과 1:1 대응
      예) insert into departments values (300, 'AI Big Data', 114, 1400);
      select * from departments;
    (2) insert into 테이블명 (컬럼명) values (); : 기술한 모든 컬럼 과 1:1 대응
      예) insert into departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID)
        values (310, 'AI Big Data', null, null);
    (3) insert into 테이블명 (일부 컬럼명) values (); : 제약조건이 없는 컬럼 과 1:1 대응
      예) insert into departments (DEPARTMENT_ID,DEPARTMENT_NAME)
           values (320, 'AI Big Data');

-- update문
-- update 문을 실행 하기전에 반드시 대상 데이터를 확인한다.
-- 컬럼단위의 수정이 가능하다.
update table명
   set col1 = val01,
       col2 = val02,
       col3 = val03
 where 조건식  ;
-- 사용 예)
--수정전 데이터 확인
select lname, sal, bouns 
from emp_ddl
where emp_id = 156;

update emp_ddl
  set lname = 'Shin inho',
      sal = 2400
where emp_id = 156;

-- emp_ddl 테이블의 전체 직원의 평균급여보다 적은 직원들에게 급여를 5% 인상하기..
update emp_ddl
   set sal = sal + (sal * 0.05)
where sal < (select avg(sal) from emp_ddl);

-- delete문
-- delete 문을 실행 하기전에 반드시 대상 데이터를 확인한다.
-- 행 단위의 작업이 수행된다.
delete [ from ] table명
 where 조건식..
-- 사용 예)
 delete from employees where EMPLOYEE_ID >= 300;
 delete from departments where department_id >= 300;


=================================
-- 11장 TCL 트랜잭션(Transaction Control Language)
-- DML 작업을 진행하면 트랜잭션이 발생한다.
-- 트랜젼션은 여러작업들을 하나로 묶은 단위입니다. 
--  한 덩어리의 작업들은 모두 실행되거나,실행되지 않습니다.(all-or-nothing)
-- ACID : 데이터의 유효성을 보장하기 위한, 트랜젝션의 특징들의 앞글자를 딴 단어입니다.
  - 원자성(Atomicity) : 모든 작업이 반영되거나 모두 롤백되는 특성입니다
  - 일관성(Consistency): 데이터는 미리 정의된 규칙에서만 수정이 가능한 특성을 의미합니다.
      숫자컬럼에 문자열값을 저장이 안되도록 보장해줍니다.
  - 격리성(Isolation): A와 B 두개의 트랜젝션이 실행되고 있을 때,
      A의 작업들이 B에게 보여지는 정도를 의미합니다.
  - 영속성(Durability): 한번 반영(커밋)된 트랜젝션의 내용은 영원히 적용되는 특성을 의미합니다.
-- 명령어 : commit, rollback, savepoint
=================================
commit;
savepoint abc;
rollback to abc;
rollback ;

------------------------
-- 트랜잭션 실습
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

-- 트랜잭션(Transaction)의 종료
-- 명시적 : commit, rollbcak
-- 암묵적 : 세션의 종료, ddl의 실행(commit)

=================================

-- 12장 DDL(Data Definition Language)
-- ddl 종류 : create, alter, drop,
--          truncate, rename, comment
=================================

-- 컬럼의 속성
-- 문자
   char, varchar, varchar2
-- 숫자
   number, number(5), number(5,2)
-- 날짜
   date
   TimeStamp

-- 테이블의 생성
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
--서브쿼리을 활용한 데이터 삽입
insert into emp_ddl (
   select employee_id 
	 ,last_name, salary, commission_pct 
	 ,department_id, sysdate
    from employees)
;
-- 부서정보
insert into dept_ddl (
  select department_id, department_name
        ,Manager_id
	from departments	 
);
select * from dept_ddl;

-- 서브쿼리를 이용한 테이블의 생성
create table 테이블이름 as (서브쿼리)
;
-- 빈 테이블 생성
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
-- 데이터를 포함한 테이블 생성
create table emp_ddl20 (emp_id,lname,sal,bonus,dept_id,cdate) as 
   (Select employee_id, last_name, salary
		 ,commission_pct, department_id, sysdate
      from employees
);
select * from emp_ddl20;
-- 조인 서브쿼리 활용 테이블 생성
create table emp_ddl30 as (
      select e.department_id, d.department_name,
          avg(salary)
      from employees e, departments d
     where e.department_id = d.department_id
    group by e.department_id,d.department_name
);
select * from emp_ddl30;

-- 테이블의 변경(alter)
-- alter table 테이블명
-- add, modify, rename, drop
alter table emp_ddl30 add( cdate date);

alter table emp_ddl30 modify( lname varchar(40) );

alter table emp_ddl30 rename column lname to last_nm;

alter table emp_ddl30 drop (cdate);

-- 컬럼에 주석 달기..
comment on column emp_ddl30.emp_id is '직원 번호';
-- 테이블에 주석 달기..
comment on table  emp_ddl30 is '직원 정보';

-- 테이블 이름을 바꾸기
rename emp_ddl30 to emp_ddl35;

select * from user_tab_comments

select * from emp_ddl35;

-- DDL언어의 실행은 auto commit;
-- DDL언어는 commit,  rollback; 하지 않는다..

-- truncate
select * from  emp_ddl;

delete from emp_ddl;  -- dml
rollback;

truncate table emp_ddl;  --ddl
rollback;

-- 테이블의 삭제
drop table emp_ddl10;
drop table emp_ddl20;
drop table emp_ddl35;


=================================
-- 13장 제약조건
-- 데이터의 무결성을 보장하기 위하여 필요하다.
--  무결성: 데이터의 정확성과 일관성을 보장
--   (영역(null),개체(Pk),참조(Fk)무결성)
-- 종류:
    primary key,not null, unique, 
	check, foreign key, [ default ]
-- primary key : not null, unique
-- not null : 어떤 값이든지 있어야 한다.
-- unique   : 중복을 허용하지 않는다. null 허용
-- foreign key : 외부키를 참조
-- check : 입력되는 값의 범위를 검증

-- 제약조건을 부여하는 방법
   -. 열 수준에서  주는방법
   -. 테이블 수준에서 주는방법
   -. 제약 조건의 이름도 중복되지 않는다.
=================================
-- 제약조건의 조회
select * from user_constraints
where table_name = 'DEPT';

-- 열단위의 제약 조건 부여..
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
-- 테이블 수준에서의 제약 조건 부여..
-- not null은 열 수준에서 제약조건 부여
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

-- foreign key 실습
insert into emp_cnst (emp_id, lname, sal, bonus, dept_id)
  (select 350,lname, sal, bonus, 30 
	from emp_ddl
	where emp_id = 107
  );
select * from emp_cnst;
rollback;

-- 엑셀문제 풀이후 문제
-- 직원의 급여가 5000보다 많이 받는 직원의
-- 직원번호, 이름, 직종, 입사일,급여, 부서명, 관리자명을 조회하시오..
-- 급여는 3자리마다 ','로 구분한다.
-- 관리자가 없는 직원도 출력한다.

------------------------------------
--  제약조건의 변경
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
-- 테이블실습서_문제.xlsx 풀이
=================================

-- 14장 기타 객체
-- 테이블, 뷰, 인덱스, 시퀀스, 동의어
=================================
-- 데이터사전
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

create 객체의유형 객체명 ...
;
-- 1. view
-- create view 뷰명 as (select from ..)
-- 데이터의 접근을 제한 할때
-- 복잡한 질의를 쉽게 할때
-- 데이터의 독립성을 보장할때..

create view vw_emp80 as
  (select employee_id, last_name, job_id, salary, (salary * 12 ) as  annual
     from employees
    where department_id = 80
  );

select * from vw_emp80;
select * from user_views;
-- 직원번호, 이름, 직종, 입사일(yyyy-mm-dd), 급여(999,999), 부서이름, 상관이름을
-- 조회하는 뷰의 생성

-- in Line 뷰
-- 회사내의 급여를 많이 받는 직원 상위 5명의 이름과 급여 조회..
select rownum, a.*
from (select last_name, salary
        from employees
        order by salary desc) a
where rownum < 6 ;

-- 2. 인덱스
-- 검색의 속도를 높인다.
-- 물리적인 저장 공간을 가지고 있다.
-- DML이 빈번하게 일어나는 Tablel에 대해서는 성능의 저하 가져온다.
-- 인덱스 사용의 고려사항
--  1) 열의 정보가 광범위하게 포함되는 경우
--  2) 조건절, 조인이 자주 일어나는 항목
--  3) 대부분의 질의에 대한 검색결과 2-4%미만인 경우
-- 실행계획의 조회 F10
create index emp_name_idx
   on emp_ddl (lname);

select * from emp_ddl
where lname like '신%';

select * from user_indexes;
select * from user_ind_columns;

drop index emp_name_idx;

-- 3. 시퀀스(Sequence)
--  고유의 번호를 자동으로 생성한다.
--  공유가 가능하다.
--  일반적을 기본키(pK)로 사용한다.

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


-- 4. 동의어(Synonym)
-- 객체에 대한 별명을 부여한다.
create Synonym emps for employees;

select * from emps;

drop Synonym emps;

select Synonym_name from user_synonyms;

-- 5. 사용자 정의 함수
--  함수는 되돌아오는 값(return)이 있다.
--  절차적 언어이다.
select substr('ajkdaskjd', 2,3) from dual;
select instr('Shin inho', 'ho') from dual;
select upper('asasdasdf') from dual;

-- 사용자 정의 함수
-- 부서이름을 반환하는 함수..
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

-- 부서명을 조회하는 사용자 정의함수 이용하여 직원의 이름, 부서이름, 입사일, 급여을 조회하시오..
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
-- 15장 DCL(Dta Control Language)
-- DCL : grant to, revoke from
=================================
-- System 계정에서 실행
show user;
-- 계정의 생성
create user inho IDENTIFIED by inho;

-- 연결권한의 부여
grant create session to inho;

-- 테이블 생성권한의 부여
grant create table to inho;
grant create view to inho;

-- 자원의 사용권한 부여
grant resource to inho;

grant create session, RESOURCE,
      create table,create view,
      create sequence
to inho;
-- 다른 사용자의 객체를 조회
grant select on hr.employees to inho;
-- 다른 사용자에게 권한을 부여할 수 있는 권한을 제공합니다.
grant select, insert on departments
   to inho with grant option;

-- 암호 변경
alter user inho IDENTIFIED by shin account lock;

alter user inho IDENTIFIED by shin account unlock;

-- 부여된 권한의 확인
select * from user_role_privs;

-- 권한의 회수
revoke create table from inho;

revoke create session, RESOURCE,
  create table,create view,
  create sequence
from inho;

-- 사용자 삭제
drop user inho cascade;

===============================
-- inho 계정에서 실행
show user;

create TABLE temp04 (
    irum varchar(20),
    phon varchar(20)
);
-- 생성한 테이블의 조회
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


