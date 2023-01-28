과 정 : 빅데이터 분석서비스 개발자 과정
기 간 : 2022.12.30. ~ 2023.06.19.
담 임 : 강규남
==============================
-- 오라클 설치 및 환경 구축


--(@앞에 파일 가져다둠)
--cmd실행
sql> @C:\Users\smhrd > sqlplus hr/hr

--학습용 table을 조회
 select table_name from user_tables;
 
 --테이블의 구조화를 조회
 SQL> desc departments; -- desc+테이블이름 /테이블구조를 불러옴
 SQL> desc employees;
 
 --
 select *
 from departments;
 
 

 column department_name format a20; --> 이 column을 20으로 조정한다는 뜻
 set pagesize 60; --> 한페이지에 60개 보내겠다
 show user;  --못들음
 show pagesize;
 
 ed --> 마지막 실행 쿼리 수정하기위해 사용
 
 select *
 -->여기서 *은 '모두'보여주라 라고 생각하면됨
 
 --이런식으로 사용하는거다~
 select department_name
 from departments;
 
  select last_name
 from employees;
 
 ---------------------DQL(data query laguage)
 --SELECT절에 기술할 수 있는 것들
 --SELECT 절
 --select
 --from
 --Where
 --[group BY --범위 지정하는 함수 ex. 3학년 중/ 부서별
 --having --
 --order BY ] -->[]안은 생략이 가능하다
 
 1. 컬럼..from절에 기술된 테이블의 항목
 2. 여러개의 컬럼을 기술할 경우는 ","로 구분한다. --프로젝션이라고 한다고 ppt 55쪽
 --select * --셀렉션이라고 한다
 
  select last_name,salary
 from employees;
 
 3. *: from절의 테이블의 모든항목 조회.
 4. distinct : 중복을 제거한다. 
 
 select distinct job_id --원래는 107건이 나오는데 distinct로 중복제거하면 17건으로 출력
 from employees;
 
 5. 별명의 사용 -- 'as bb', " " 같은것들로 별명지정 <- 알리아스라고 부른다 
 --소문자로 써도 대문자로 나온다.
 select last_name irum from employees;
 -->여기서 irum을 소문자로 줘도 머릿글은 대문자로자 동출력됨
  select last_name as irum from employees;
 ------ 
  select last_name "Irum name" from employees;
  --> 스페이스가 필요한경우 ""가 꼭 필요 안그러면 오류남
  select last_name as"Irum name" from employees;

 
6.연산이 가능하다(+_*/)
 select last_name, salary,salary*12
 from employees;
 
 7. null을 연산에 참여하면 결과는 null이다. 
  select last_name, 
			salary,salary* commission_pct
 from employees;
 
 8. || :문자열을 연결한다 
 select last_name || first_name,salary
 from employees;
 --|| '문자를 넣는 칸' || 이런식도 가능 -- 두 문자를 이어주는 거임
 
 --from절에 올 수 있는 것들
 1. table 명 , view 명
 2. 데이터 셋
 3. 여러개의 테이블 (조인)
 4. 가상의 테이블 dual
 
 select sysdate from dual; --이게 머여
 
 
 
 
 
 
 
 
 
 
 
 