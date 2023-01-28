과 정 : 빅데이터 분석서비스 개발자 과정
기 간 : 2022.12.30. ~ 2023.06.19.
담 임 : 강규남
==============================

--1. 초록색 + 생성 후  이름적고 
--밑칸에 hr /비밀번호도 hr

 --2회차 2023-01-05---------
 
 select last_name
    from employees;
select * 
from employees;

select last_name "Lname"
from employees;
 
 select last_name, job_id, salary,commission_pct,
 (salary * commission_pct)bonus
 from employees;
 
  select (last_name ||'-'|| first_name), job_id, salary,commission_pct,
 (salary * commission_pct)bonus
 from employees;
 
 ---------------------
 --where 절
 --조건절
-- 1. 등식으로 조건표현
    a = b, a > b
    select last_name , salary
        from employees
        where salary > 10000; -- where에 조건을 적으면 그게 출력됨
--2. 등식이 여러개인 경우 : 등식을 and,or 연결
    select last_name , salary
        from employees
        where salary > 5000
        and job_id = 'ST_MAN' --''안에 글은 대소문자 구별됨
                            --이런식으로 두개의 조건을 만족시키려면 and를 써라
 --3. 값, 날짜를 비교할때는 ''안에 넣어서 사용하고 대소문자를 구별한다.
  --'Seattle' 이랑 'seattle'이랑은 다름
  
-- 4. 산술연산이 가능하다. 
    select last_name ,job_id, salary
        from employees
        where salary *12 > 125000;
 --5. 범위의 사용 (and)
 select last_name , salary
        from employees
        where salary >= 9000
        and salary <= 10000;
 select last_name , salary    -->위의 식을 between으로 사용가능하다.
        from employees
        where salary BETWEEN 7000 AND 10000
 --그외의 범위
 select last_name , salary    
        from employees
        where salary not BETWEEN 7000 AND 10000 --> not을 붙히면 이 안의 범위 외의 것들을 찾아줌
 --6. 소속의 사용 (or) 포함의사용 (in)
    select last_name, job_id, salary
        from employees
        where department_id = 20
        or department_id = 30
        or department_id = 60
        or department_id = 90;
--위의 식과 같으나 간단하게 정리함 'in'으로 !
    select last_name, job_id, salary
        from employees
        where department_id in ( 20,30,60,90) ;  --> 세미콜론은 끝난다는 표시 하나만 표시하기 
        
--7. 비슷한 자료의 조회(like)
 --% : 모든 문자열에 대응, _ : 한 문자에 대응
    --> %n 이면 끝이 n인 문자를 찾아라임
    --> %_ _ n % 세번째 자리에 n이 있는걸 찾아라
 select last_name, department_id , job_id, salary
        from employees
        where last_name like '%__u%'; --> %와 _를 이용해서 찾고자하는 문자가 포함된 것을 모두 출력해줌 
 
--null의 비교
    select last_name, department_id, job_id ,salary
           from employees
        where department_id is not null ;
 ---------------
 --order by 절 <--내림차순(desc)/ 오름차순
 --정렬
 
  select last_name, department_id, job_id ,salary
           from employees
        order by salary desc ; -->테이블 구조 조회랑은 다름
        
 select last_name, department_id, job_id ,salary
           from employees
           where department_id = 60
         order by salary desc ;
         
         select last_name, department_id, job_id ,salary sal --> 여기에 sal을 적고, 밑에 order by에 sal을 적으면 그대로 salary값이 실행됨
           from employees
           where department_id = 60
         order by sal desc ;
  
  from > where> group by> having>select>order by
  
  select last_naem as lnam
  from employees
  where lnam like '%u%' 
  --이렇게 하면 오류남 왜냐면 where 먼저하고 그다음 select를 실행하니까 알리아스를 where는 모름
   select last_naem as lnam
  from employees
  where last_name like '%u%' 
  -- 이렇게 해야 정확한 답이 나옴
         
         --------------
    --1.
         select last_name, department_id
           from employees
           where employee_id = 176;
    --2.
         select last_name, salary*12
           from employees
           where salary*12 >= 120000 ;
    --3.
         select employee_id,last_name, job_id,department_id
           from employees
           where department_id = 30
           and job_id = 'PU_MAN';
           
    --4.
        select last_name, salary *12 As Annsal --Annsal로 출력하라고 했을때 필요한거
           from employees
           where  salary *12 
           not between 150000 and  200000; 
    
    --5.
     select last_name, employee_id,hire_date
           from employees
           where  hire_date between '03/01/01' and '05/05/30'
           order by hire_date desc;
           
    --6.
    select last_name, department_id
           from employees
           where  department_id in (20,50)
           order by last_name Asc;  --> Asc 는 알파벳순으로 정렬
    --7.
    select last_name, hire_date
           from employees
           where  hire_date like '06/__/__' ;
    
    --8.
    select last_name, salary *12
           from employees
           where department_id in (20,50)
           and salary *12 between 20000 and 250000;
    
    --9.
    select last_name, job_id
           from employees
           where manager_id is null; -->값이 없음이란 뜻
           
    --10.
      select last_name, job_id,manager_id
           from employees
           where manager_id is not null;
        
    --11.
     select last_name, commission_pct, salary*12 AS Annsal
           from employees
           where commission_pct is not null
           order by salary*12 desc;
 
    --12.
        select last_name
           from employees
        where last_name like '%h';
    
    --13.
     select last_name
           from employees
        where last_name like '%a%' 
        and last_name like '%e%' ;
 
    --14.
    select last_name, salary,job_id
    from employees
    where salary not in (2500,3500,7000)
    and job_id in ( 'SA_REP', 'ST_CLERK');
 
    -- 15.
     select job_id,department_id
    from employees
    where department_id in (30,90)
    order by job_id ;