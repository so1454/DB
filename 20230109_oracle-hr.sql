과 정 : 빅데이터 분석서비스 개발자 과정
기 간 : 2022.12.30. ~ 2023.06.19.
담 임 : 강규남
==============================

-- 2023 - 01 - 09
-- 단일행
-- 함수의 종류 : 내장함수 , 사용자 정의함수
-- 함수의 종류 : 단일행함수 , 다중행 함수
-- 문자, 숫자, 날짜 함수

-- 문자 : lower, Upper, Initcap, replace
--            substr, length, instr, concat  --이 함수들은 피피티에 파일이 따로 나와있음
select last_name, length(last_name) len_name, salary --length는 문자열의 갯수를 표시해줌
 from employees;

select last_name, substr(last_name, 1, 4) as sub_name, salary --지정 문자열 1부터 4까지 표시하기
from employees;

select last_name,Upper(last_name) as sub_name, salary --지정 문자열 대문자로 표시하기
from employees;



-- 데이터의 형변환
-- 묵시적(암시적) 형변환 --오라클이 알아서 판단해서 변환시키는거
-- 명시적 형변환

--묵시적 형변환

select 1+2 from dual; -- 3나옴 --여기서 dual은 그냥 0값이라고 생각하면됨/어디에서 불러오는게 아니라 이런 계산할때 사용
select '100' + '200' from dual; -- 300이 나옴 --숫자로 처리됨
-- 여기서 숫자를 숫자로 받아들이는 이유
-- 문자는 왼쪽정렬 숫자는 오른쪽정렬이 됨 결과를 보면 둘다 숫자로 인식을 했다는 것
-- 오라클은 산술연산자가 들어가면 따옴표가 들어가든말든 아무튼 숫자로 인식함

select '100' || '200' from dual; -- 문자로 처리됨
-- 문자열 연결 연산자로 둘을 연결시키려고 하니까
-- **결론 --> 연산자를 중심으로 형변환을 한다.


-- 명시적 형변환

-- to_date  -- 문자형을 날짜로 바꿔라라는 함수
select to_date('2023-02-28')  from dual;
-- to_number -- 숫자로 바꿔라
select to_number('20230109')  from dual;
--to_char 문자형으로 형변환하는데 이 밑처럼 형식을 줄 수 있음
select to_char('20230109', '99,999,999,999' )  from dual; 

-- 급여를 조회하는데 세자리마다 ','로 구분하시오..
select last_name, to_char (salary, '99,999' )as sal
from employees;

--그냥 갑자기 알려주신 상식
-- 도구 - 환경설정 - 데이터베이스 - NLS로 들어가서 시간기록 형식 바꿔두면
-- 날짜 형식을 출력시키는 양식을 변환이 가능하다
select last_name, hire_date, to_char (salary, '99,999' )as sal
from employees;
--이거 실행하면 hire_date가 형변환이 되는 것을 볼 수 있다.

-- null의 처리
select last_name, nvl( commission_pct,0) as commi, salary 
from employees;
--nvl ( 테이블이름, null값일때 출력시킬 숫자) 

-- 정확한 1년의 연봉 : (salary +( commission_pct * salary = 보너스) * 12 
-- 정확한 1년의 연봉 : (salary *(1+ nvl(commission_pct ,0)= 보너스)) * 12 
select last_name, (salary+ (nvl( commission_pct,0) * salary)) * 12 as year, salary 
from employees; 
--commission의 null값을 빼고 계산을 해줘야하니까 null을 0으로 변환해줌

==============================
-- 그룹함수
-- 종류 : sum(), avg(), count(), min(), max()
-- 숫자 : sum(), avg() --> 위의 종류 중 이거 뺀 나머지는 숫자 문자 다 사용가능
-- null값은 포함되지 않는다.
==============================

-- 회사 전체 직원의 급여의 평균, 합계, 최저, 최고, 수급 인원을 조회하시오
select department_id,job_id
    ,sum(salary)
    ,avg(salary) 
    ,count(salary)
    ,min(salary)
    ,max(salary)
    ,count(department_id)
    , count(commission_pct)
from employees

group by department_id,job_id; -- 부서, 직종별로 나눌것이다~
                                        --group by에 나온 테이블은 가급적 select에 적어야한다.


--직원들 중에 가장 오래 근무한 직원과 최근에 입사한 직원과의 근무연수의 차이는?
select round( (max (hire_date) - min(hire_date) ) /  365, 0)
from employees;
--*round는 반올림 <-- round( 수, 소숫점 아래 몇번째 까지) 


--부서별 직원들의 급여 차이를 최고, 최저의 차이 금액 조회
select department_id ,max(salary) as max_sal, min(salary) as min_sal, 
    (max(salary) - min(salary)) as pay_cha --여기서 as는 또 다른 이름으로 정의해준다는 말임(너무 이름이 길때 사용 많이함)
from employees
group by department_id
order by department_id; --내림차순 오름차순 정렬하는데 필요한게 order by인가봄


-- where : select 절에 조회되는 데이터의 제한하는 거임
select * from employees
where department_id = 50;

-- having : group by절에 데이터를 제한/group by 집계함수 값에 대한 데이터를 제한
select department_id ,max(salary) as max_sal, min(salary) as min_sal, 
    (max(salary) - min(salary)) as pay_cha --여기서 as는 또 다른 이름으로 정의해준다는 말임(너무 이름이 길때 사용 많이함)
from employees
group by department_id
having max(salary)>11000;  --group by로 분류된걸 또 제한하는 거임

--평균급여가 15000보다 많은 직종과, 평균급여를 조회하시오.
select job_id, salary, avg(salary)
    from employees
    group by job_id,salary
    having avg(salary)>15000;
    

-- 부서별, 직종별, 급여 합계가 10000보다 많은 부서, 직종, 급여합계, 평균 급여를 조회.
select department_id, job_id, sum (salary), round( avg(salary),1) as avg_sal
    from employees
    group by department_id, job_id
    having sum(salary) > 10000;
    
    
-- 부서별 직원들 급여의 차이가 5000보다 더 큰 부서, 최고, 최저, 차이금액을 조회
select department_id,max(salary)as mx_sal, min(salary) as mn_sal
    ,(max(salary)- min(salary)) as char_sal
    from employees
    group by department_id
    having  (max(salary)- min(salary))> 5000;
    
    
==================================
-- 서브쿼리 : 쿼리안에 쿼리가 존재한다.
-- 조회하고자하는 값을 알지 못할때 사용
-- 종류 : 단일행 , 다중행 서브쿼리
-- ()안에 서브쿼리를 기술, where절의 오른쪽에 서브쿼리를 작성한다.
==================================

-- 직원들 중에 회사의 평균 급여보다 많이 받는 직원의 이름, 직종, 급여를 조회
select last_name, job_id, salary
from employees
where salary > (select avg(salary) from employees); --이런식으로 괄호안에 넣는게 서브쿼리임

-- 직원들 중에 'ST_MAN' 평균급여보다 많이 받는 직원의 이름, 직종, 급여를 조회
select last_name, job_id, salary
from employees
where salary > (select avg(salary) 
                            from employees
                            where job_id = 'ST_MAN');
                            
-- 직원들중에 최고급여를 받는 직원의 이름, 직종, 급여를 조회...

select last_name, job_id, salary
from employees
where salary = (select max(salary) 
                            from employees);

--최소급여가 80부서의 최소 급여보다 많이 받는 부서의 ID, 최소급여를 조회
select department_id,  min(salary)
from employees
group by department_id
having min(salary) < (select min(salary) -- 80부서를 따로 select하기위해서! 
                            from employees
                            where department_id = 80);

-- 다중행 연산자를 사용하는 서브쿼리 **(다중행이라는게 여러개의 행을 출력해내는거?)
-- 서브쿼리의 다중행 함수
-- 종류 :  in(or), any(or), all(and) 

select salary    
        from employees  
        where department_id = 60; -- (9000,6000,4800,4200)이 값이 나옴
        
-- in (or) : 모든 값에 1 : 1로 대응
-- any(or) : '<any '는 최대값보다 적은값(= 그 어떤값보다 적어야된다) , '>any'는  최소값보다 큰 값(=그 어떤 값보다 커야된다)
-- all : '<all '는 최소값보다 적은 값, '>all' 최대값보다 큰 값
select last_name, job_id, salary, department_id
from employees
where salary<any  (select salary       --여기서 where조건에 최대값보다 적은 값을 적용시켰으니까
                    from employees      -- ex. 이 select문에서 나오는 가장 큰 값이 9000인데, 여기서 물어보는건 9000보다 적은 값을 찾아라 라는 뜻임
                    where department_id = 60);
                    
                    
select last_name, job_id, salary, department_id
from employees
where salary<all  (select salary     --여기서 where조건에 최소값보다 적은 값을 적용시켰음
                    from employees    --이 서브쿼리의 select문에 해당하는 것들 중 salary에서 가장 최소의 값을 출력할꺼다.
                    where department_id = 60);

select last_name, job_id, salary, department_id
from employees
where salary in  (select salary     --여기서 where조건에 in을 적용을 시킴
                    from employees  -- **여기 이 select문에서 출력되는 것만 salary에서 출력할꺼다
                    where department_id = 60);
                    
====================================
-- 조인 (join) -- 두개 이상의 테이블들을 연결 또는 결합하여 데이터를 조회하는 것
select * --모든것을 출력해라
from employees,departments;
-- 이 위대로 하면 2889건이 출력됨 

--employees.department_id -- employees 테이블에서 foreign키
--departments.department_id -- departments 테이블에서 primary키

select last_name, employee_id
        ,employees.department_id  --employees테이블에 있는 부서아이디를 출력함
        ,departments.department_id --departments테이블에 있는 부서아이디를 출력함
from employees, departments
where employee_id = 107;   -- id가 107인것만 출력해봐라

select last_name, employee_id
        ,employees.department_id  --emplyees테이블에 있는 부서아이디를 출력함
        ,departments.department_id --departments테이블에 있는 부서아이디를 출력함
from employees, departments
where employee_id = 107 -- employee_id가 107에 해당하고
and employees.department_id = departments.department_id; --두 테이블에서 일치하는 아이디만 출력해라/한건밖에 안나옴

--밑은 join을 한 거임
select last_name, employee_id
        ,employees.department_id  
        ,departments.department_id 
from employees, departments
where employees.department_id = departments.department_id; --두 테이블에서 일치하는 아이디만 출력해라

select e. last_name, e.employee_id
        ,e.department_id  
        ,d.department_id 
from employees e,  departments d --ansal로 할 수 있다 각 테이블 이름을 e랑 d로 명명함
where e.department_id = d.department_id;

--조인의 종류
--1. 등가(inner join), 비등가, 자체조인, 포괄조인(Left, Rightn, Full)
--Pk(primary key), FK(foreign key)로 연결함
select e. last_name, e.employee_id
        ,e.department_id  
        ,d.department_id 
        ,d.department_name
from employees e,  departments d --ansal로 할 수 있다 각 테이블 이름을 e랑 d로 명명함
where e.department_id = d.department_id -- FK와 PK를 등가로 연결하고 있음 --등가 조인
and job_id = 'ST_MAN';

--2. 비등가 조인 
--범위로 연결한다.
select last_name, salary, grade_level
from employees e, job_grades j
where salary between j.lowest_sal and j.highest_sal; -- between과 같은 범위로 연결해주고 있음

select e.last_name, e.job_id, e.salary, 
        m.last_name as mgr_name, m.salary
from employees e, employees m  --같은 테이블인데 하나는 직원 테이블 하나는 관리자테이블로 봄
where e.manager_id = m.employee_id;

--문제. 등가조인 문제임
--시애틀에서 근무하는 직원의 이름, 직종, 부서이름, 급여를 출력해라

select last_name, job_id, d.department_id, salary, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id --department테이블에 있는 department_id랑 employee테이블에 있는 department_id랑 비교해보는거임
    and d. location_id = l.location_id
    and l.city = 'Seattle';
--위와 같은 식인데 서브쿼리를 이용해서 만들어본거
select last_name, job_id, d.department_id, salary
from employees e, departments d
where e.department_id = d.department_id 
    and d. location_id =(select location_Id from locations
                                where city = 'Seattle');

--포괄(외부) 조인 (Left, Right)
--원래 null값은 빼고 조회하는데 null값도 조회하는 조인
--left에 있는 값을 출력을 시킨다
--right는 right에 있는 값을 출력시킨다
--full은 전부 출력시킨다

select last_name, job_id, d.department_name, salary
from employees e, departments d
where e.department_id = d.department_id(+); --요러케 (+)넣어주면 그 테이블의 null값도 포함해서 출력
--107건나옴

select last_name, job_id, d.department_name, salary
from employees e, departments d
where e.department_id(+) = d.department_id; -- 122건나옴

--이것도 구분해서 알려주긴하지만 위의 쿼리랑은 다르다고 설명해주심**다시 복습하기
select distinct department_id
from employees; 
    
    
--15. 회사 전체의 최대급여, 최소급여, 급여 총 합 및 평균 급여를 출력하시오.
select max(salary), min(salary), sum(salary),avg(salary)
from employees;

-- 16. 각 직종별, 최대 급여, 최소 급여, 급여 총 합 및 평균 급여를 출력하시오.
--   단 최대 급여는 MAX, 최소 급여는 MIN, 급여 총 합은 SUM 및
--   평균 급여는 AVG로 출력하고, 직업을 오름차순으로 정렬하시오

select job_id, max(salary) as MAX, min(salary) as MIN, 
            sum(salary) as SUM, avg(salary) as AVG
    from employees
    group by job_id
    order by  job_id ;

-- 17. 동일한 직업을 가진 사원들의 총 수를 출력하시오 --107행인가
select e.job_id as e , j.job_id as j
from employees e,jobs j
where e.job_id = j.job_id;


-- 18. 매니저로 근무하는 사원들의 총 수를 출력하시오
select manager_id
from employees;


-- 19. 사내의 최대 급여 및 최소 급여의 차이를 출력하시오
    
    select salary, max(salary), min(salary)
    from empoyees;
    where (max(salary)- min(salary));

-- 20. 매니저의 사번 및 그 매니저 밑 사원들 중 최소 급여를 받는 사원의 급여를 출력하시오
--      - 매니저가 없는 사람들은 제외한다.
--      - 최소 급여가 5000 미만인 경우는 제외한다.
--      - 급여 기준 역순으로 조회한다.

select manager_id,  min(salary)
from employees
where  manager_id is not null --매니저 있는 사람들만 나오게 함
group by manager_id 
having min(salary)<5000
order by min(salary) desc ;
    
    

-- 22. 모든 사원들의 이름, 부서 이름 및 부서 번호를 출력하시오.
--이름 - e.last_name , 부서이름d. department_name  ,부서번호 e. department_id
--두 테이블을 겹쳐서 가져올 수 있는게 -- department_id
select  e.department_id, e.last_name,d.department_name,d.department_id
from departments d, employees e
where e.department_id = d.department_id;

-- 23. 커미션을 받는 모든 사람들의 이름, 부서 명, 지역 ID 및 도시 명을 출력하시오 (여러개 조인 문제)

select e.last_name, 
d.department_name,
d.location_id,
l.city,
e.commission_pct
from locations l, employees e, departments d
where e.department_id = d.department_id
  and d.location_id = l.location_id
 and e.commission_pct is not null;


select e.last_name , d.department_name, l.location_id,  l.city
from employees e, departments d , locations l  --요렇게 여러개를 사용하면 무조건 조인을 해줘야하나봄
                                                                --그 안의 같은 테이블을 묶어서 하나의 테이블로 만드는 과정인가봄 와이걸..이제앎;;
where  e.department_id = d.department_id 
    and d. location_id = l.location_id
    and e.commission_pct is not null;


-- 24. 자신의 매니저보다 먼저 고용된 사원들의 이름 및 고용일을 출력하시오 (이거 같은 테이블 조인 문제)
--지금 매니저랑 사원이랑 비교하려고하잖아 그니까 두 테이블을 묶어줘야지
--매니저 고용일 > 사원 고용일 (먼저 고용된)
--사원 이름, 고용일 출력
select e.last_name, e.hire_date
from employees e, employees M
where e.employee_id = m.manager_id --둘이 겹치는 부분이 있음/매니저의 아이디와 사원의 아이디
                                                --같은 테이블에서 겹치는게 있으니까 그걸로 정리를 해줄라고
and e.hire_date<m.hire_date
order by hire_date;


select emp.last_name ,emp.employee_id, emp.hire_date 
from employees emp , employees mgr 
where emp.manager_id  = mgr.employee_id
and emp.hire_date < mgr.hire_date
order by emp.last_name;

-- 25. 부서 명, 부서위치ID, 각 부서 별 사원 총 수, 각 부서 별 평균 급여를 출력하되,
--    부서위치를 오름차순으로 출력하시오

select d.department_name,  d.location_id, 
count(e.employee_id), avg(e.salary) 
from departments d, employees e
where d.department_id = e. department_id
group by d.department_name, d.location_id
order by d.location_id;

-----여기까지 일단 함

-- 26. Zlotkey 와 동일한 부서에 근무하는 모든 사원들의 사번 및 고용날짜를 출력하시오.

--select employee_id, hire_date
--from departments d, employees e
--where e. department_id = d. department_id
--and last_name= 'Zlotkey';

select employee_id, hire_date
from employees 
where department_id in (select department_id 
                                from employees
                                where last_name =  'Zlotkey'
and last_name !=  'Zlotkey';

-- 27. 회사 전체 평균 급여보다 더 급여를 많이 받는 사원들의 사번 및 이름을 출력하시오

select employee_id, last_name
from employees
where salary > (select avg(salary)
                        from employees);


-- 28. 이름에 u 가 포함되는 사원들과 동일 부서에 근무하는 사원들의 사번 및 이름을 출력하시오.
-- **시행 순서 외우기(맨 처음 배웠던거)
select employee_id, last_name
from employees
where department_id in (
                            select distinct department_id -- distinct는 중복제거, 똑같은 값을 덜 시행하려고
                                    from employees
                                    where last_name like '%u%')
and last_name not like '%u%';

-- 29. 시애틀에 근무하는 사람 중 커미션을 받지않는 
--모든 사람들의 이름, 부서 명, 지역 ID를 출력하시오

select e.last_name, d.department_name, l.location_id
from employees e, locations l ,departments d
where e.department_id = d.department_id
       and d.location_id =l.location_id
        and city = 'Seattle';


-- 30. 이름이 DAVIES 인 사람보다 후에 고용된 사원들의 이름 및 고용일자를 출력하시오.
--	   고용일자를 역순으로 출력하시오






-- 31. King 을 매니저로 두고 있는 모든 사원들의 이름 및 급여를 출력하시오

-- 32. 회사 전체 평균급여보다 더 많이 받는 사원들 중 이름에 u 가 있는 사원들이
--   근무하는 부서에서 근무하는 사원들의 사번, 이름 및 급여를 출력하시오

    ==========================
    
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

--테이블 하나 생성하는거 
create table emp_ddl (
     emp_id  number
    ,Lname varchar(30)
    ,sal   number
    ,bouns number(5,2)
    ,dept_id  number
    ,cdate  date
 );

 
-- SUB Query를 이용한 data의 삽입 -- employees 에 있는 데이터를 emp_ddl에 삽입한거임
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

=======================--Dml실전문제.sql===================
2023.01.12
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

--문제1. 열없이 행 추가해라
insert into my_employee values (1,'Patel','Ralph', 'rpatel', 895); --인서트문은 행단위로 들어간다. (가로)
insert into my_employee values (2,	'Dancs',	'Betty',	'bdancs',	860);

--문제2. 예제 데이터의 3,4행을 my_employee 태이블에 추가하십시오.
--insert절에 열을 명시적으로 나열하십시오.(열을 일대일로 명시적으로 보이게 해라)
insert into my_employee (id, last_name, first_name, userid, salary)
values (3,	'Biri',	'Ben',	'bbiri',	1100);
insert into my_employee (id, last_name, first_name, userid, salary)
values (4,	'Newman',	'Chad',	'cnewman',	750);
insert into my_employee (id, last_name, first_name, userid, salary)
values (5,	'Ropeburn',	'Audrey',	'aropebur',	1550);

delete my_employee
where id = 5;

      select * from my_employee;
      
--문제3. 사원3의 성을 drexler로 변경하십시오.
update my_employee
set last_name = 'drexler' 
where id = 3;

      select * from my_employee;
      
--문제 5. 급여가 900미만인 모든사원의 급여를 1000으로 변경하십시오
update my_employee
set salary = 1000
where salary < 900;

      select * from my_employee;
--문제 6.
delete my_employee
where first_name = 'Betty'
and last_name = 'Dancs';

 select * from my_employee;

commit;

--문제 8.
insert into my_employee 
(id, last_name, first_name, salary)
values (5,	'Ropeburn',	'Audrey', 1550);


 select * from my_employee;

savepoint tag01;

--문제 10.
--테이블 내용 전체삭제
delete from my_employee;

 select * from my_employee;


--12 이전 작업은 버리지 말고 최근의 delete작업만 버리십시오

rollback to tag01;

--13
 select * from my_employee;


--영구히 저장

commit;

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



-- 엑셀문제 풀이후 문제
-- 직원의 급여가 5000보다 많이 받는 직원의
-- 직원번호, 이름, 직종, 입사일,급여, 부서명, 관리자명을 조회하시오..
-- 급여는 3자리마다 ','로 구분한다.

---실습)) 테이블 삽입과 데이터 삽입
create table dept (
    DEPTNO number(2) constraint dept_pk primary key
    ,DNAME varchar2(14) constraint dept_dname not null
    ,LOC varchar2(13) 
    );
    select * from dept;

insert into dept (deptno, dname, loc) 
   values (10, 'Adminstration', 1700); 
   insert into dept (deptno, dname, loc) 
   values (20, 'marketing', 1800); 
   insert into dept (deptno, dname, loc) 
   values (30, 'purchasing',1700); 
   insert into dept (deptno, dname, loc) 
   values (40, 'Human', 2400); 
   insert into dept (deptno, dname, loc) 
   values (50, 'Shipping', 1500); 
   


create table emp (
    empno number(4) constraint emp_pk_2 primary key
    ,ename varchar2(10) constraint emp_ename not null
    ,job varchar2(9) constraint emp_job not null
    ,mgr number(4)
    ,hiredate date default sysdate
    ,sal number(7,2) constraint emp_sal not null
    ,comm number(7,2)
    ,deptno number(2) references dept (deptno)
    );
SELECT
    *
FROM
    emp;

COMMIT;

INSERT INTO emp VALUES (
    100,
    'King',
    'AD_PRES',
    NULL,
    '87-1-17',
    24000,
    NULL,
    10
);

INSERT INTO emp VALUES (
    101,
    'Kochar',
    'AD_VP',
    100,
    '89-9-21',
    17000,
    NULL,
    50
);

INSERT INTO emp VALUES (
    102,
    'DE_Haen',
    'AD_VP',
    100,
    '93-1-13',
    17000,
    NULL,
    50
);

INSERT INTO emp VALUES (
    103,
    'Hunold',
    'IT_PROG',
    102,
    '90-7-3',
    9000,
    NULL,
    40
);

INSERT INTO emp VALUES (
    104,
    'Ernst',
    'IT_PROG',
    103,
    '97-7-25',
    4800,
    NULL,
    40
); 

--문제.
-- 직원의 급여가 5000보다 많이 받는 직원의
SELECT
    *
FROM
    emp
WHERE
    sal > 5000;
-- 직원번호, 이름, 직종, 입사일,급여, 부서명, 관리자명을 조회하시오..
SELECT
    e.empno,
    e.ename,
    d.dname,
    e.sal,
    e.hiredate,
    e.mgr
FROM
    dept d,
    emp  e
WHERE
        d.deptno = e.deptno
    AND e.sal > 5000;

-- 급여는 3자리마다 ','로 구분한다.
SELECT
    e.empno,
    e.ename,
    d.dname,
    to_char(e.sal, '99,999') AS sal,
    e.hiredate,
    e.mgr
FROM
    dept d,
    emp  e
WHERE
        d.deptno = e.deptno
    AND e.sal > 5000;
-- 관리자가 없는 직원도 출력한다.
SELECT
    e.empno,
    e.ename,
    d.dname,
    to_char(e.sal, '99,999') AS sal,
    e.hiredate,
    e.mgr
FROM
    dept d,
    emp e,
    emp m
WHERE
        d.deptno = e.deptno
    AND e.mgr = m.empno (+)
        AND e.sal > 5000;

select * from departments;

--1. 테이블 생성실습 
drop table dept;
drop table emp;
create table dept (
	deptno number(2),
	dname varchar2(14) not null,
	loc varchar2(13),
	constraint dept_deptno_pk primary key(deptno)
);
create table emp (
	empno number(4),
	ename varchar2(10) not null,
	jobid varchar2(9) not null,
	mgr number(4),
	hiredate date,
	sal number(7,2) not null,
	comm number(7,2),
	deptno number(2),
	constraint emp_empno_pk primary key(empno),
	constraint emp_deptno_fk foreign key(deptno)
	  references dept(deptno)
);
	
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
alter table emp_cnst
  add not null(lname);
alter table emp_cnst
  add unique(email);
alter table emp_cnst
  add check(sal between 1000 and 10000);
alter table emp_cnst
  add foreign key (dept_id) references dept_cnst(dept_id);

alter table emp_cnst
  add constraint emp99_pk primary key(emp_id);
alter table emp_cnst
  drop primary key;
alter table emp_cnst
  drop constraint sys_c0007009;

=================================
-- 14장 기타 객체
-- 테이블, 뷰, 인덱스, 시퀀스, 동의어
=================================
-- 데이터사전 --운영에 필요한 중요 데이터 보관 --직접적인 접근이 아닌 view정도의 기능을 select로 지정하면 제공해줌
select * from user_tables;
select * from all_tables;
select * from all_objects where owner ='HR';  --주인이 hr인것만 출력해라
                         --모든 오브젝트 중에서
select * from user_objects;

select * from user_col_comments
where table_name = 'DEPARTMENTS'; --departments라는 테이블 이름을 가진 애의 column의 코멘트 출력
select * from all_col_comments
where table_name = 'EMP_DDL';

select * from user_tab_comments  -- 테이블의 코멘트
where table_name = 'DEPARTMENTS';
select * from all_tab_comments
where table_name = 'DEPARTMENTS';

select * from user_constraints  --현재 사용자가 가지고 있는 우리가 이름 정해준 제약조건에 대해서 나옴
where table_name = 'EMP_CNST';

select * from user_cons_columns --이건 열단위의 제약조건인가봄
where table_name = 'EMP_CNST';

-----------------
-- 객체 유형 (테이블, 뷰, 인덱스, 시퀀스, 동의어, 트리거, 함수)
create 객체의유형 객체명 ...
;
-- 1. view
-- 뷰를 쓰는 목적
-- create view 뷰명 as (select from ..) -- 뷰를 만드는 양식
-- 데이터의 접근을 제한 할때 
-- 복잡한 질의를 쉽게 할때 -- select에 view이름만 불러서 바로 사용
-- 데이터의 독립성을 보장할때..

create view vw_lname as  --생성할땐 create
  (select last_name from employees);
--drop  -- 지울땐 drop

--부서id,부서명, 평균급여, 최저급여, 최고급여 등등을 조회해라
--원래 매번 타이핑해서 가져와야하는데, view로 만들어두면
--view의 이름만 불러서 바로 사용이 가능함---아래가 그 예시

drop view vw_deptsal ;

create view vw_deptsal as (
select e.department_id , d.department_name as dept_nm , 
    round(avg(e.salary),2) as avg_sal
    ,max(e.salary) as max_sal   
   ,min(e.salary) as min_sal
from employees e, departments d 
where e.department_id = d.department_id
group by e.department_id, d.department_name) ;


create view vw_emp80 as
  (select employee_id, last_name, job_id, salary, (salary * 12 ) as  annual
     from employees
    where department_id = 80
  );

select * from vw_emp80;

-- in Line 뷰 --이건 뭐 어따쓰는거야(시험)
-- 회사내의 급여를 많이 받는 직원 상위 5명의 이름과 급여 조회에 쓴다..?
select rownum, a.*  --숫자의 번호가 rownum이라고
from (select last_name, salary
        from employees
        order by salary desc) a  --순서대로 출력을 하기위해 서브쿼리를 쓴다
where rownum < 6 ;

--여기 두번째꺼랑 비교해서 역순이 아니게 출력을 잘 할라면?
-- 회사내의 급여를 많이 받는 직원 상위 5명의 이름과 급여 조회..
select rownum, a.*
from  employees a
where rownum <= 4
order by salary desc;


-- 2. 인덱스
-- 검색의 속도를 높인다.
-- 물리적인 저장 공간을 가지고 있다.
-- DML이 빈번하게 일어나는 Tablel에 대해서는 성능의 저하 가져온다.
--                        dml이 많이 일어나는 table은 엥간 인덱스 쓰지말아라
-- 인덱스 사용의 고려사항
--  1) 열의 정보가 광범위하게 포함되는 경우 
                --너무 많은거 말고 드문드문 여러군데 있는 거에 써라
--  2) 조건절, 조인이 자주 일어나는 항목 
                 
--  3) 대부분의 질의에 대한 검색결과 2-4%미만인 경우
     -- 카테고리별로 구분했을때 유용한 그런 것들에 써라 / 너무 적은 결과를 인덱스하면 불필요하니까
    --인덱스 이름은 5년후에 봐도 기억할 수있도록 정해라
    
    create table emp_ddl (  --이 괄호안에 컬럼 이름과 컬럼의 속성을 지정해주는거임
   employee_id  number, --number같은게 컬럼의 속성
    last_name varchar(30), --이건 뭘 뜻하는지**
    salary  number,
   commission_pct number(5,2),
	department_Id  number,
    cdate  date
);
select * from emp_ddl;

drop table emp_ddl;

    insert into emp_ddl (
        select employee_id, last_name, salary, commission_pct, department_Id,sysdate
        from employees );


    --인덱스 만드는거
    
create index emp_name_idx --인덱스이름
   on emp_ddl (last_name); ---테이블이름에 lname을 정의하겠다
            --이렇게 만든건 밑의 where문에 f10을 눌러서 정보를 보면 만들어진걸 알 수 있음
select * from emp_ddl
where last_name like 'K%';

select * from user_indexes;

select * from user_ind_columns;

drop index emp_name_idx; --지울땐 drop사용

-- 3. 시퀀스(Sequence)
--  고유의 번호를 자동으로 생성한다.
--  공유가 가능하다.
--  일반적을 기본키(pK)로 사용한다.

drop sequence emp_seq;  --시퀀스 삭제하는거

        --시퀀스 만드는 방법
create sequence empddl_seq  --이름 명명
   increment by 10 --  10씩 증가해라
   start with 100   --시작값
   maxvalue 999999999999999  --여기까지 출력
   nocache      --cache라고 속도빠르게끔 하는건데 대부분 no를 붙힘
   nocycle;       --마찬가지

drop table  emp_ddl;

insert into emp_ddl (employee_id, last_name, salary)
  (select empddl_seq.nextval , last_name,  salary
    from employees);
    
commit;

select empddl_seq.nextval from dual; --계속 증가 
select empddl_seq.currval from dual;  --nextval이라는 위의 값을 고정

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
select substr('ajkdaskjd', 2,3) from dual; -- 두번째부터 세번째까지 가져와라
select upper('asasdasdf') from dual; -- 대문자로 전부 바꿔라
select fn_dname(10) from dual;  --

-- 사용자 정의 함수
-- 부서이름을 반환하는 함수..
                            --밑은 반환 함수를 만듬 (시험)
create or replace function fn_dname (dept_id in int) --함수 이름과 정수로 넘어왔을때 dept_id로 받겠따.
   return varchar  ---결과값을 문자열로 리턴했다.
is
                                --프로그램에서 사용할 변수 선정
   dnm varchar2(30);   
begin
   select department_name into dnm --dnm의 변수를 받는다.
     from departments
     where department_id = dept_id;
   return dnm;
end;
/  <--함수에서 마지막이라고 끝내주는거래요 있어야하는거

select last_name, salary, job_id ,fn_dname(department_id) 
from employees;



-- 부서명을 조회하는 사용자 정의함수 이용하여 직원의 이름, 부서이름, 입사일, 급여을 조회하시오..
select last_name, fn_dname(department_id), hire_date, salary
  from employees;


-- 6. TRIGGER
-- 사건이 발생하면 그것을 계기로 여러가지가 일어나는 것

--실습)   --지운다는 사건으로 지웠던 
            --데이터를 백업을 한다는 그런 작업을 해보겠다
--1, 백업용 테이블 생성
--2. 트리거 작성
--3. emp 삭제
--4. 백업용 테이블 확인

--1, 백업용 테이블 생성
create table emp_bak as ( select emp.*, sysdate as cdate from emp where 1 <> 1);
                                                    --삭제된 날짜를 알아보기위해 sysdate추가
--2. 트리거 작성
create or replace TRIGGER emp_delete  --trigger생성하겠다. 이름지정
  before delete on emp for each row    
begin
insert into emp_bak values (     --여기에 들어갈 변수는 emp테이블의 변수와 같아야됨
    :old.EMPNO ,:old.ENAME ,:old.JOB ,:old.MGR  --old라는 것이 삭제하기 전의 값이라는말
    ,:old.HIREDATE ,:old.SAL ,:old.COMM ,:old.DEPTNO
    ,sysdate
  );
end;
/
--3. emp 데이터 삭제 
delete emp where EMPNO in (100,101);

commit;

--4. 백업용 테이블 확인  --위에서 지워진 행을 확인하는 테이블을 불러오는 거임
                                --쉽게 생각하면 지워진 행 확인이라고 알면됨
select * from emp_bak;

drop table EMP_BAK;
=================================
-- 15장 DCL(Dta Control Language)
-- DCL : grant to, revoke from
=================================

--2023 01 16 3시 수업 --진짜 머라는지 1도 모르겠고 너무 왔다갔다거림**

----------------------------------- Oracle-system으로 접속해서 진행해야됨-----
show user;  --이건 내가 지금 접속하고 있는 시스템이 뭔지 물어보는거임

create user sohyeon IDENTIFIED by sohyeon;  --계정생성

grant create session to sohyeon;          -- 소현에게 오라클 접속할 수 있는 세션에 대한 권한 주겠다.
                                        --> 근데 여기서 system이 관리자 권한을 가지고 있으니까
                                        --> 권한을 sohyoen에게 권한을 주는거임 system 계정에서
                                        -->그리고 넘어가서 sohyeon에서 테이블 만들고, 뷰만들고...등등의 역할을 시행하는거임
grant create table to sohyeon; 

grant resource to sohyeon;



grant select , insert on hr.departments to sohyeon with grant option;


drop user sohyeon cascade;

grant create session, RESOURCE,
      create table,create view,
      create sequence
to sohyeon;




select * from user_sys_privs;





-- 연결권한의 부여
grant create session to inho;

-- 테이블 생성권한의 부여
grant create table to inho;
grant create view to inho;

-- 자원의 사용권한 부여
grant resource to inho;

--한꺼번에 grant하기 가능
grant create session, RESOURCE,
      create table,create view,
      create sequence
to sohyeon;

-- 다른 사용자의 객체를 조회
grant select on hr.employees to sohyeon;

-- 다른 사용자에게 권한을 부여할 수 있는 권한을 제공합니다.
grant select, insert on departments
to sohyeon with grant option;  -->내 권한을 주겠다.


-- 모든 사람들에게 권한 부여
grant select on hr.departments to scott;
grant select on hr.departments to public;

-- 암호 변경
alter user sohyeon IDENTIFIED by 0000 account lock;

alter user sohyeon IDENTIFIED by 0000 account unlock;

-- 부여된 권한의 확인
select * from role_sys_privs;
select * from role_tab_privs;

--**
select * from user_sys_privs;

-- 권한의 회수-- 이 부분 다시 보기 전혀 못들음
revoke create table from sohyeon;    
                -->  이걸  select * from user_sys_privs; 여기서 보면 전부 NO로 되어있음(다 회수되었으니까)

grant select, insert on hr.departments to sohyeon with grant option;

alter user sohyeon IDENTIFIED by 0000 account unlock;






revoke create session, RESOURCE,
  create table,create view,
  create sequence
from inho;

-- 역활의 생성
create  role mgr;

grant create session, RESOURCE,
  create table,create view,
  create sequence
to mgr;
-- 역활의 활용.
grant mgr to inho, hr, scott;

drop user inho cascade;

===============================
-- 사용자 계정에서 실행
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

CREATE VIEW VW_SCOREVIEW (TEAMNAME,FINALSCORE)
    AS(SELECT S.TEAMNAME,SUM(TRY.GETSCORE)
        FROM STUDENT S,TRYRESULT TRY 
        WHERE TRY.ISSUCCESS LIKE '%O%'
        AND S.STUDENTID = TRY.STUDENTID 
        group by S.TEAMNAME
        );

SELECT * FROM VW_SCOREVIEW;
SELECT * FROM TRYRESULT;

commit;









