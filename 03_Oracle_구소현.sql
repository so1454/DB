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

select last_name, substr(last_name, 1, 4) as sub
_name, salary --지정 문자열 1부터 4까지 표시하기
from employees;

select last_name,Upper(last_name) as sub_name, salary --지정 문자열 대문자로 표시하기
from employees;



-- 데이터의 형변환
-- 묵시적(암시적) 형변환 --오라클이 알아서 판단해서 변환시키는거
-- 명시적 형변환

--묵시적 형변환

select 1+2 from dual; -- 3나옴 
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
                              -- ** group by에 나온 테이블은 꼭 select에 적어야한다.


--직원들 중에 가장 오래 근무한 직원과 최근에 입사한 직원과의 근무연수의 차이는?
select round( (max (hire_date) - min(hire_date) ) /  365, 0)
from employees;
--*round는 반올림 <-- round( 수, 소숫점 아래 몇번째 까지) 


--부서별 직원들의 급여 차이를 최고, 최저의 차이 금액 조회
select department_id ,max(salary) as max_sal, min(salary) as min_sal, 
    (max(salary) - min(salary)) as pay_cha --여기서 as는 또 다른 이름으로 정의해준다는 말임(너무 이름이 길때 사용 많이함)
from employees
group by department_id
order by department_id;


-- **where과 having은 다른거에영
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
--서브쿼리의 단일행
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
							
--서브쿼리의 다중행 함수
-- in, any, all 




