-- 01. 사원번호가 176 인 사원의 이름과 부서 번호를 출력하시오

SELECT LAST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 176;


-- 02. 연봉이 120,000 이상되는 사원들의 이름 및 연봉을 출력하시요

SELECT LAST_NAME, SALARY*12
FROM EMPLOYEES
WHERE SALARY*12 >= 120000;


--3. 30부서에서 근무하는 직원 중 직책이 'PU_MAN'인 직원의
--의 사원번호, 이름, 직종, 급여, 부서번호를 조회시오.
select employee_id, last_name, job_id, 
	   salary, department_id
from employees
where department_id = 30
  and job_id = 'PU_MAN';


-- 04. 2003/01/01 일부터 2005/05/30일 사이에 고용된 사원들의 이름, 사번,
--   고용일자를 출력하시오. 고용일자 순으로 정렬하시오

SELECT LAST_NAME, EMPLOYEE_ID, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '2003/01/01' AND '2005/05/30'
ORDER BY HIRE_DATE DESC;


-- 05. 20번 및 50 번 부서에서 근무하는 모든 사원들의 이름 및 부서 번호를
--   알파벳순으로 출력하시오

SELECT LAST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN ( 20, 50 )
ORDER BY LAST_NAME ASC;


-- 06. 2006년도에 고용된 모든 사람들의 이름 및 고용일을 조회한다

SELECT LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE LIKE '06%';
----
SELECT * 
FROM nls_session_parameters 
WHERE parameter LIKE '%FORMAT%';


-- 07. 20 및 50 부서에 근무하며, 연봉이 20,000 ~ 250,000 사이인 사원
--   들의 이름 및 연봉을 출력하시오

SELECT LAST_NAME, 12*SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN ( 20, 50 )
AND 12*SALARY BETWEEN 20000 AND 250000;


-- 08. 매니저가 없는 사람들의 이름 및 업무를 출력하시오

SELECT LAST_NAME , JOB_ID
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;


-- 09. 매니저가 있는 사람들의 이름 및 업무, 매니저번호를 조회한다

SELECT LAST_NAME , JOB_ID, MANAGER_ID
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL;


-- 10. 커미션을 받는 모든 사원들의 이름, 연봉 및 커미션을 출력하시오.
--   - 연봉을 역순으로 정렬하고, 연봉은 ANNSAL로 출력하시오

SELECT LAST_NAME, 12*SALARY AS ANNSAL,
	COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
ORDER BY ANNSAL  DESC;


-- 11. 이름의 네번째 글자가 h인 사원의 이름을 조회하시오

SELECT LAST_NAME
FROM EMPLOYEES
WHERE LAST_NAME LIKE '___h%';


-- 12. 이름에 a 및 e 글자가 있는 사원의 이름을 조회하시오

SELECT LAST_NAME
FROM EMPLOYEES
WHERE LAST_NAME LIKE '%a%'
  AND LAST_NAME LIKE '%e%';


-- 13. 급여가 2500,3500,7000이 아니며 직업이 SA_REP나 ST_CLERK인 사원의 이름과, 급여, 직업을 출력하시오.

SELECT LAST_NAME, SALARY, JOB_ID
FROM EMPLOYEES
WHERE SALARY NOT IN ( 2500, 3500, 7000 )
AND JOB_ID IN ( 'SA_REP', 'ST_CLERK' );


-- 14. 30번 부서내의 모든 직업들을 유일한 값으로 출력하시오.
--    90번 부서 또한 포함하고, 직업을 오름차순으로 출력하시오

SELECT DISTINCT JOB_ID, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN ( 30, 90 )
ORDER BY JOB_ID;


-- 15. 회사 전체의 최대 급여, 최소 급여, 급여 총 합 및 평균 급여를 출력하시오

SELECT MAX(SALARY), MIN(SALARY),
	SUM(SALARY), AVG(SALARY)
FROM EMPLOYEES;


-- 16. 각 직종별, 최대 급여, 최소 급여, 급여 총 합 및 평균 급여를 출력하시오.
--   단 최대 급여는 MAX, 최소 급여는 MIN, 급여 총 합은 SUM 및
--   평균 급여는 AVG로 출력하고, 직업을 오름차순으로 정렬하시오

SELECT  JOB_ID, MAX(SALARY) MAX, MIN(SALARY) MIN ,
           SUM(SALARY) SUM, AVG(SALARY) AVG
FROM   EMPLOYEES
GROUP BY JOB_ID
ORDER BY JOB_ID;


-- 17. 동일한 직업을 가진 사원들의 총 수를 출력하시오
SELECT  JOB_ID, COUNT(EMPLOYEE_ID)
FROM   EMPLOYEES
GROUP BY JOB_ID;


-- 18. 매니저로 근무하는 사원들의 총 수를 출력하시오

SELECT COUNT(DISTINCT MANAGER_ID)
FROM EMPLOYEES;


-- 19. 사내의 최대 급여 및 최소 급여의 차이를 출력하시오

SELECT MAX(SALARY) - MIN(SALARY)
FROM EMPLOYEES;


-- 20. 매니저의 사번 및 그 매니저 및 사원들 중 최소 급여를 받는 사원의 급여를 출력하시오
--      - 매니저가 없는 사람들은 제외한다.
--      - 최소 급여가 5000 미만인 경우는 제외한다.
--      - 급여 기준 역순으로 조회한다.

SELECT MANAGER_ID, MIN(SALARY)
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID
HAVING MIN(SALARY) >= 5000
ORDER BY MIN(SALARY) DESC;


-- 21. 급여합계가 10,000보다 많은 직원의
-- 부서, 직종별 급여합계, 평균급여, 직원수 출력하세요.
-- 급여는 3자리마다 ","형식으로, 평균급여는 소수점 이하 2자리에서 까지출력하세요

select department_id, job_id,
    to_char(sum(salary),'999,999') sum_sal,
    to_char(avg(salary),'999,999.99') avg_sal,
    count(*)
from employees
group by department_id, job_id
having sum(salary) > 10000
order by department_id, job_id


-- 22. 모든 사원들의 이름, 부서 이름 및 부서 번호를 출력하시오.

SELECT E.LAST_NAME
      , D.DEPARTMENT_NAME, D.DEPARTMENT_ID
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID;


-- 23. 커미션을 받는 모든 사람들의 이름, 부서 명, 지역 ID 및 도시 명을 출력하시오

SELECT E.LAST_NAME, D.DEPARTMENT_NAME,
	L.LOCATION_ID, L.CITY
FROM  EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND    D.LOCATION_ID = L.LOCATION_ID
AND    E.COMMISSION_PCT IS NOT NULL;


-- 24. 자신의 매니저보다 먼저 고용된 사원들의 이름 및 고용일을 출력하시오
SELECT  EMP.LAST_NAME, EMP.EMPLOYEE_ID,
	EMP.HIRE_DATE, MGR.HIRE_DATE
FROM   EMPLOYEES EMP, EMPLOYEES MGR
WHERE  EMP.MANAGER_ID = MGR.EMPLOYEE_ID
AND     EMP.HIRE_DATE < MGR.HIRE_DATE
ORDER BY EMP.LAST_NAME;


-- 25. 부서 명, 부서위치ID, 각 부서 별 사원 총 수, 각 부서 별 평균 급여를 출력하되,
--    부서위치를 오름차순으로 출력하시오

SELECT D.DEPARTMENT_NAME , D.LOCATION_ID
	, COUNT(E.EMPLOYEE_ID)
	, AVG(E.SALARY) AVG_SALARY
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME, D.LOCATION_ID
ORDER BY D.LOCATION_ID;


-- 26. Zlotkey 와 동일한 부서에 근무하는 모든 사원들의 사번 및 고용날짜를 출력하시오.

SELECT EMPLOYEE_ID, HIRE_DATE
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN ( SELECT DEPARTMENT_ID
				FROM EMPLOYEES
			   WHERE LAST_NAME = 'Zlotkey')
AND LAST_NAME != 'Zlotkey';


-- 27. 회사 전체 평균 급여보다 더 급여를 많이 받는 사원들의 사번 및 이름을 출력하시오

SELECT EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEES
WHERE SALARY > ( SELECT AVG(SALARY)
                   FROM EMPLOYEES);


-- 28. 이름에 u 가 포함되는 사원들과 동일 부서에 근무하는 사원들의 사번 및 이름을 출력하시오.

SELECT EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN(
		SELECT distinct DEPARTMENT_ID
		FROM EMPLOYEES
		WHERE LAST_NAME LIKE '%u%')
and LAST_NAME not LIKE '%u%';


-- 29. 시애틀에 근무하는 사람 중 커미션을 받지않는 모든 사람들의 이름, 부서 명, 지역 ID를 출력하시오
select e.last_name, d.department_name, d.location_id
from employees e, departments d
where e.department_id = d.department_id
  and d.location_id = (select location_id
     from locations
     where city = 'Seattle')
  and e.commission_pct is null;


-- 30. 이름이 DAVIES 인 사람보다 후에 고용된 사원들의 이름 및 고용일자를 출력하시오.
--	   고용일자를 역순으로 출력하시오
SELECT LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE >all ( SELECT HIRE_DATE
					 FROM EMPLOYEES
					 WHERE LAST_NAME = 'Davies')
ORDER BY HIRE_DATE;


-- 31. King 을 매니저로 두고 있는 모든 사원들의 이름 및 급여를 출력하시오

SELECT LAST_NAME, SALARY, MANAGER_ID
FROM EMPLOYEES
WHERE MANAGER_ID IN ( SELECT EMPLOYEE_ID
                       FROM EMPLOYEES
                       WHERE LAST_NAME = 'King');


-- 32. 회사 전체 평균급여보다 더 많이 받는 사원들 중 이름에 u 가 있는 사원들이
--   근무하는 부서에서 근무하는 사원들의 사번, 이름 및 급여를 출력하시오
SELECT EMPLOYEE_ID, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (
		SELECT DEPARTMENT_ID
		  FROM EMPLOYEES
		 WHERE LAST_NAME LIKE '%u%'
		   AND SALARY >= ( SELECT AVG(SALARY)
						  FROM EMPLOYEES));
