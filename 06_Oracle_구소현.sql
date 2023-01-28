과 정 : 빅데이터 분석서비스 개발자 과정
기 간 : 2022.12.30. ~ 2023.06.19.
담 임 : 강규남
==============================
2023 01 12
=================================
-- 11장 TCL 트랜잭션(Transaction Control Language)
--05에서 배웠던 11장 부분 이어서

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


--Dml실전문제.sql 파일


=================================

-- 12장 DDL(Data Definition Language)
-- ddl 종류 : create, alter, drop,
--          truncate, rename, comment
=================================

-- 컬럼의 속성(90% 이용하는 컬럼의 속성만 가지고 왔다고함)
-- 문자
   char, varchar, varchar2  --문자형 데이터를 그 컬럼에 넣을꺼다
                                       -- (varchar같은 경우var가 가변이라는 뜻으로 변할 수 있는 문자형을 넣는다는말)
-- 숫자
   number, number(5), number(5,2) --숫자를 5자리만 쓰겠다/ 다섯자리 중에서 소숫점 이하 둘째까지 쓸래 
-- 날짜
   date --연월일 나오는 친구들
   TimeStamp

-- 테이블의 생성
create table emp_ddl (  --이 괄호안에 컬럼 이름과 컬럼의 속성을 지정해주는거임
    emp_id  number, --number같은게 컬럼의 속성
    lname varchar(30), --이건 뭘 뜻하는지**
    sal   number,
    bouns number(5,2),
	dept_id  number,
    cdate  date
);
-- 서브쿼리를 이용한 테이블의 생성
create table 테이블이름 as (서브쿼리)
;
-- 예)
create table emp_ddl10 as (
   select employee_id as emp_id
         ,last_name as lname
		 ,salary as sal
		 ,commission_pct as bonus
		 ,department_id as dept_id
		 ,sysdate as cdate
      from employees
);
select * from emp_ddl10;

-- 빈 테이블 생성
create table emp_ddl20 as (
   select employee_id as emp_id
         ,last_name as lname
		 ,salary as sal
		 ,commission_pct as bonus
		 ,department_id as dept_id
		 ,sysdate as cdate
     from employees
    where 1 <> 1 --거짓으로 조회 = 머릿글만 만든다는 말임
);

-- 조인 서브쿼리 활용 테이블 생성
create table emp_ddl30 as (
   select e.department_id as dept_id, d.department_name as dname,
          avg(salary) avg_sal
      from employees e, departments d
     where e.department_id = d.department_id
    group by e.department_id,d.department_name
);
select * from emp_ddl30;

-- 테이블의 변경(alter) --테이블을 수정하는거
-- alter table 테이블명
-- add, modify, rename, drop
alter table emp_ddl30 add( cdate date ); --컬럼을 하나 추가하겠다.
alter table emp_ddl30 add( cdate date default sysdate); --r기본값으로 바꾸겠다.

alter table emp_ddl modify( lname varchar(40) ); --칼럼의 속성을 바꾼다는 뜻 /원래 30이 40으로 바뀜

alter table emp_ddl30 rename column dname to lname;  --원래 dname이던거를 lname으로 바꾸겠다.

alter table emp_ddl30 drop (cdate);

-- 컬럼에 주석 달기.. 뒤에 달려있는 comment 자리 채우기
comment on column emp_ddl.emp_id is '직원 번호';
-- 테이블에 주석 달기..
comment on table  emp_ddl30 is '직원 정보'; --ddl30을 들어가서 sql확인해보면 
                            --이렇게 나옴 이게 코멘트 달린거임 COMMENT ON TABLE "HR"."EMP_DDL30"  IS '직원 정보';
-- 테이블 이름을 바꾸기
rename emp_ddl30 to emp_ddl35; --데이터는 그대로 있고 테이블 이름만 바뀌는거임

select * from emp_ddl35;

-- ddl언어의 실행은 auto commit;
-- DDL언어는 commit,  rollback; 하지 않는다..

-- truncate
select * from  emp_ddl;

delete from emp_ddl;  -- dml(데이터조작어 롤백하면 돌아가는거)
rollback; --돌아감

truncate table emp_ddl;  --ddl(데이터 정의어 롤백하면 안돌아가는거) --ddl은 자동 commit되는 친구라서 조심해야됨
rollback; --다시 안돌아감

-- 테이블의 삭제
drop table emp_ddl;
drop table emp_ddl10;
drop table emp_ddl20;
drop table emp_ddl35;
drop table my_employee;
--깰꼼한 마무리


=================================
-- 13장 제약조건
-- 내가 원하는 것만 insert 하기 위해서 조건과 제약을 만들어두는 것.
-- 데이터의 무결성을 보장하기 위하여 필요하다.
--  무결성: 데이터의 정확성과 일관성을 보장
--   (영역(null),개체(Pk),참조(Fk)무결성)
-- 종류:
    not null, unique, primary key, 
	foreign key, check, [ default ]
-- primary key : not null, unique --기본키는 중복없고,유일해야하고,null값도 없어야됨
-- not null : 어떤 값이든지 있어야 한다.
-- unique   : 값의 중복을 허용하지 않는다. 그래서 값이 아닌 그냥 빈칸인 null은 허용
-- foreign key : 외부키를 참조
-- check : 입력되는 값의 범위를 검증(값을 이 범위내로 하겠다.) 
                                                -- ex. salary 같은 경우 100-1000 사이를 나타내겠다.를 여기서 제한해줌

-- 제약조건을 부여하는 방법
   -. 열 수준에서  주는방법
   -. 테이블 수준에서 주는방법
   -. 제약 조건의 이름도 중복되지 않아야한다. --같은 이름이 있으면 안된다.
=================================
-- 제약조건의 조회
select table_name from user_tables; --hr로 사용할 수 있는 테이블이 어떤게 있는지 확인할 수 있는 거라고

select * from user_constraints --user_constraints는 데이터 제약조건에 대한 목록이다.
                                        --여기서 나온 owner는 소유주 = user=나를 뜻함 =여기선 hr
where table_name = 'EMP_CNST'; 

-- 제약조건 설정하는 문법 설명 -> 교재 파일활용

-- 열단위의 제약 조건 부여..
-- sys_c123456

drop table emp_cnst; --이 테이블이 없으니까 오류가 났음(있으면 안나겠지)
                            --삭제한다는 뜻

create table emp_cnst(      --이건 생성 ddl
    emp_id number(4)   constraint emp_pk primary key -- 이게 기본키라는 조건을 준거임
   ,lname varchar2(30) constraint emp_lname_nn not null --not null이라는 조건을 줌
   ,email varchar2(30) unique
   ,hdate date  default sysdate
   ,job_id varchar2(15)
   ,sal    number(8,2) constraint emp_sal_ck check (sal between 1000 and 10000)
   ,bonus  number(5,2)
   ,mgr_id   number(4)
   ,dept_id number(4) references departments(department_id) --departments에 있는 id를 참조할꺼다
);

select * from emp_cnst; --테이블 확인

--위의 제약조건에 따라서 insert를 하는과정 시험해보는 거임

insert into emp_cnst (emp_id, lname, email) 
   values (10, 'shin inho', 'inho@smhr.or.kr'); --1. 얘 실행하고 밑에꺼 id만 다르게하고 실행하면
   insert into emp_cnst (emp_id, lname, email) --2. 여기서 한번더 하면 오류남 (email이 unique로 설정되어있으니까)
   values (12, 'shin inho', 'inho@smhr.or.kr');
     insert into emp_cnst (emp_id, lname, email) 
   values (12, 'soso', 'inho@smhr.or.kr');  --3. 이것도 12를 넣으려고하면 오류남(id는 primary키니까, 중복 허용X)
   
insert into emp_cnst (emp_id, lname, email, sal)
   values (20, 'shin inho01', 'inho01@smhr.or.kr', 12000); --급여는 1000-10000까지 제한을 해둬서 오류남
insert into emp_cnst (emp_id, lname, email, hdate)
   values (30, 'shin inho', 'inho02@smhr.or.kr', sysdate); 
                                        --여긴 lname이 위랑 같은데, lname의 제한에 중복 없음이 있는게 아니니까 삽입됨

insert into emp_cnst (emp_id, lname, email, hdate, dept_id) --여기서 dept_id 테이블이 departments테이블을 참조하는데
   values (40, 'shin inho', 'inho03@smhr.or.kr', sysdate, 350); --참조한 테이블에 350이 없으니까(그 테이블 확인필요)
   insert into emp_cnst (emp_id, lname, email, hdate, dept_id)
   values (40, 'shin inho', 'inho03@smhr.or.kr', sysdate, 100);  --그래서 테이블에 있는 100,110..등 을 넣어주면 오류 안생김
   
insert into emp_cnst (emp_id, lname, hdate, dept_id)
   values (60, 'shin inho', sysdate, 100);

rollback;


-----------------
--  테이블 수준에서의 제약 조건 부여.. 
                            --(위는 열에다가 제약조건을 붙힌거고 이건 열 쓰고 밑에 몰아서 제약조건을 써둔거임)
drop table emp_cnst;
drop table dept_cnst;
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
   ,constraint emp_pk primary key (empno)
   ,unique (email)
   ,constraint emp_sal_ck check (sal between 1000 and 10000)
   ,foreign key (dept_id) references dept_cnst10(dept_id) --foreign키로 쓸까라고 정의
);



