과 정 : 빅데이터 분석서비스 개발자 과정
기 간 : 2022.12.30. ~ 2023.06.19.
담 임 : 강규남
==============================
2023.01.11
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
                --300은 department_id/ 'AI Big Data'는 department_name/114는 manager_id/1400은 location_id로 각 1:1대응 됨
      select * from departments;
    (2) insert into 테이블명 [(컬럼명)] values (); : 기술한 모든 컬럼 과 1:1 대응
      예) insert into departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID)
        values (310, 'AI Big Data', null, null);
    (3) insert into 테이블명 [(일부 컬럼명)] values (); : 제약조건이 없는 컬럼 과 1:1 대응
      예) insert into departments (DEPARTMENT_ID,DEPARTMENT_NAME)
           values (320, 'AI Big Data');
        insert into departments (DEPARTMENT_ID,DEPARTMENT_NAME) --문자를 숫자로 형변환해서 오류가 안생김
        values ('330', 'AI Big Data');
      insert into employees (EMPLOYEE_ID,LAST_NAME,EMAIL,HIRE_DATE,JOB_ID)
      values (340, 'inho', 'shin@smrd.co.kr', sysdate, 'IT_PROG');
      
      select * from employees;
      
    
--이건 행을 삭제하는거 (이거 where 안붙히면 다 날라가니까 꼭 where 붙히고 하기)
 delete from employees where EMPLOYEE_ID >= 300;
 delete from departments where department_id >= 300;

--테이블 하나 생성하는거 --**왜 안되는거지
create table emp_ddl (
     emp_id  number
    ,Lname varchar(30)
    ,sal   number
    ,bouns number(5,2)
    ,dept_id  number
    ,cdate  date
 );

 
-- SUB Query를 이용한 data의 삽입
insert into emp_ddl (
   select employee_id, last_name, salary, commission_pct, department_id ,sysdate
     from employees); 
     --테이블에 데이터를 인서트하는 거
     
commit;
delete from emp_ddl; --이건 삭제하는거
select * from emp_ddl;

-- update문 ++ select를 먼저하고 업데이트를 해야한다.
-- 컬럼단위의 수정이 가능하다.
--update set where 가 디폴트 
--업데이트는 조심해서 업데이트 해야된다. 왜냐면...다시 되돌리기 어렵기때무네,,그럼 난 망한건가..
update table명
   set col1 = val01,
       col2 = val02,
       col3 = val03
 where 조건식  ;
 
-- update 사용 예)
--수정전 먼저 select 데이터 확인
select lname, sal, bouns 
from emp_ddl
where emp_id = 156;

--그 다음 업데이트 하고 다시 select로 데이터 확인하면 업데이트 된걸 확인 할 수 있음
update emp_ddl
  set lname = 'Shin inho',
      sal = 2400
where emp_id = 156;

-- emp_ddl 테이블의 전체 직원의 평균급여보다 적은 직원들에게 급여를 5% 인상하기..
--원래 avg (sal) 이 6390.
--원래 56
--업데이트 하니까 55됨
select emp_id, lname
from emp_ddl
where sal < (select avg(sal) from emp_ddl);


update emp_ddl
   set sal = sal + (sal * 0.05)
where sal < (select avg(sal) from emp_ddl);

update emp_ddl
   set sal = (select sal from emp_ddl where emp_id= 125)
where emp_id = 112;

select * from emp_ddl where emp_id = 112;

commit;


select * from emp_ddl where

-- delete문
-- 행 단위의 작업이 수행된다.
delete [ from ] table명
 where 조건식..
-- 사용 예)
  delete from emp_ddl
  where emp_id = 156;

  delete from emp_ddl
  where emp_id = 112;
  
  
  =================================
-- 11장 TCL 트랜잭션(Transaction Control Language)
-- DML 작업을 진행하면 트랜잭션이 발생한다. ---작업 하나하나를 트랜젝션이라고 한다.
-- 트랜잭션은 여러작업들을 하나로 묶은 단위입니다. 
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
select * from emp_ddl where emp_id = 101; --여기서 하나하나의 작업을 섹션이라고 한다고함

update emp_ddl
    set lname = ' inho'
    where emp_id = 101; --101행의 lname을 신인호로 바꿔줌 
                                --이렇게 바꾼건 다른 섹션안에서는 변경이 안됨/아래 commit을 해줘야 변경됨

commit; -- 이제 위의 업데이트 상태에서 commit을 하면 다른 섹션(명령 프롬프트)에서도 반영됨
            --은행의 송금업무라고 이해하면됨 내가 돈을 보냈는데 다른 곳에 저장이 안되어있으면 내 돈 날라감
            --commit은 한번하면 rollback해도 안되나봄 **확인필요
savepoint abc;

rollback to abc;

rollback ;

LOCK /  UNLOCK

-- insert > savepoint > delete > rollback to (save point까지 전부 지워짐-->그럼 insert만 남은채로 update로 넘어감)
--> update > rollback(insert까지 전부 지워짐--> 그럼 delete랑 commit만 남게됨) > delete > commit

