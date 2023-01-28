과 정 : 빅데이터 분석서비스 개발자 과정
기 간 : 2022.12.30. ~ 2023.06.19.
담 임 : 강규남
==============================

-- 다중행 연산자를 사용하는 서브쿼리 **(다중행이라는게 여러개의 행을 출력해내는거?)
-- 서브쿼리의 다중행 함수
-- 종류 :  in(or), any(or), all(and) 

select salary    
        from employees  
        where department_id = 60; -- (9000,6000,4800,4200)이 값이 나옴
        
-- in (or) : 모든 값에 1 : 1로 대응
-- any(or) : '<any '는 최대값보다 적은값(= 그 어떤값보다 적어야된다) , '>any'는  최소값보다 큰 값(=그 어떤 값보다 커야된다)
-- all : '<all '는 최소값보다 적은 값, '>all' 최대값보다 큰 값 **암기필요
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
-- 조인 (join) -- 두개 이상의 테이블들을 연결 또는 결합하여 데이터를 조회하는 것,테이블을 가로로 연결한다.
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
select  e.department_id, e.last_name,d.department_name,d.department_id
from departments d, employees e
where e.department_id = d.department_id;

-- 23. 커미션을 받는 모든 사람들의 이름, 부서 명, 지역 ID 및 도시 명을 출력하시오
--개어렵네
select e.last_name , d.department_name, l.location_id,  l.city
from employees e, departments d , locations l  --요렇게 여러개를 사용하면 무조건 조인을 해줘야하나봄
                                                                --그 안의 같은 테이블을 묶어서 하나의 테이블로 만드는 과정인가봄 와이걸..이제앎;;
where  e.department_id = d.department_id 
    and d. location_id = l.location_id
    and e.commission_pct is not null;


-- 24. 자신의 매니저보다 먼저 고용된 사원들의 이름 및 고용일을 출력하시오

select emp.last_name ,emp.employee_id, emp.hire_date 
from employees emp , employees mgr 
where emp.manager_id  = mgr.employee_id
and emp.hire_date < mgr.hire_date
order by emp.last_name;

-- 25. 부서 명, 부서위치ID, 각 부서 별 사원 총 수, 각 부서 별 평균 급여를 출력하되,
--    부서위치를 오름차순으로 출력하시오

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


























