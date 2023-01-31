�� �� : ������ �м����� ������ ����
�� �� : 2022.12.30. ~ 2023.06.19.
�� �� : ���Գ�
==============================

-- 2023 - 01 - 09
-- ������
-- �Լ��� ���� : �����Լ� , ����� �����Լ�
-- �Լ��� ���� : �������Լ� , ������ �Լ�
-- ����, ����, ��¥ �Լ�

-- ���� : lower, Upper, Initcap, replace
--            substr, length, instr, concat  --�� �Լ����� ����Ƽ�� ������ ���� ��������
select last_name, length(last_name) len_name, salary --length�� ���ڿ��� ������ ǥ������
 from employees;

select last_name, substr(last_name, 1, 4) as sub_name, salary --���� ���ڿ� 1���� 4���� ǥ���ϱ�
from employees;

select last_name,Upper(last_name) as sub_name, salary --���� ���ڿ� �빮�ڷ� ǥ���ϱ�
from employees;



-- �������� ����ȯ
-- ������(�Ͻ���) ����ȯ --����Ŭ�� �˾Ƽ� �Ǵ��ؼ� ��ȯ��Ű�°�
-- ����� ����ȯ

--������ ����ȯ

select 1+2 from dual; -- 3���� --���⼭ dual�� �׳� 0���̶�� �����ϸ��/��𿡼� �ҷ����°� �ƴ϶� �̷� ����Ҷ� ���
select '100' + '200' from dual; -- 300�� ���� --���ڷ� ó����
-- ���⼭ ���ڸ� ���ڷ� �޾Ƶ��̴� ����
-- ���ڴ� �������� ���ڴ� ������������ �� ����� ���� �Ѵ� ���ڷ� �ν��� �ߴٴ� ��
-- ����Ŭ�� ��������ڰ� ���� ����ǥ�� ���縻�� �ƹ�ư ���ڷ� �ν���

select '100' || '200' from dual; -- ���ڷ� ó����
-- ���ڿ� ���� �����ڷ� ���� �����Ű���� �ϴϱ�
-- **��� --> �����ڸ� �߽����� ����ȯ�� �Ѵ�.


-- ����� ����ȯ

-- to_date  -- �������� ��¥�� �ٲ���� �Լ�
select to_date('2023-02-28')  from dual;
-- to_number -- ���ڷ� �ٲ��
select to_number('20230109')  from dual;
--to_char ���������� ����ȯ�ϴµ� �� ��ó�� ������ �� �� ����
select to_char('20230109', '99,999,999,999' )  from dual; 

-- �޿��� ��ȸ�ϴµ� ���ڸ����� ','�� �����Ͻÿ�..
select last_name, to_char (salary, '99,999' )as sal
from employees;

--�׳� ���ڱ� �˷��ֽ� ���
-- ���� - ȯ�漳�� - �����ͺ��̽� - NLS�� ���� �ð���� ���� �ٲ�θ�
-- ��¥ ������ ��½�Ű�� ����� ��ȯ�� �����ϴ�
select last_name, hire_date, to_char (salary, '99,999' )as sal
from employees;
--�̰� �����ϸ� hire_date�� ����ȯ�� �Ǵ� ���� �� �� �ִ�.

-- null�� ó��
select last_name, nvl( commission_pct,0) as commi, salary 
from employees;
--nvl ( ���̺��̸�, null���϶� ��½�ų ����) 

-- ��Ȯ�� 1���� ���� : (salary +( commission_pct * salary = ���ʽ�) * 12 
-- ��Ȯ�� 1���� ���� : (salary *(1+ nvl(commission_pct ,0)= ���ʽ�)) * 12 
select last_name, (salary+ (nvl( commission_pct,0) * salary)) * 12 as year, salary 
from employees; 
--commission�� null���� ���� ����� ������ϴϱ� null�� 0���� ��ȯ����

==============================
-- �׷��Լ�
-- ���� : sum(), avg(), count(), min(), max()
-- ���� : sum(), avg() --> ���� ���� �� �̰� �� �������� ���� ���� �� ��밡��
-- null���� ���Ե��� �ʴ´�.
==============================

-- ȸ�� ��ü ������ �޿��� ���, �հ�, ����, �ְ�, ���� �ο��� ��ȸ�Ͻÿ�
select department_id,job_id
    ,sum(salary)
    ,avg(salary) 
    ,count(salary)
    ,min(salary)
    ,max(salary)
    ,count(department_id)
    , count(commission_pct)
from employees

group by department_id,job_id; -- �μ�, �������� �������̴�~
                                        --group by�� ���� ���̺��� ������ select�� ������Ѵ�.


--������ �߿� ���� ���� �ٹ��� ������ �ֱٿ� �Ի��� �������� �ٹ������� ���̴�?
select round( (max (hire_date) - min(hire_date) ) /  365, 0)
from employees;
--*round�� �ݿø� <-- round( ��, �Ҽ��� �Ʒ� ���° ����) 


--�μ��� �������� �޿� ���̸� �ְ�, ������ ���� �ݾ� ��ȸ
select department_id ,max(salary) as max_sal, min(salary) as min_sal, 
    (max(salary) - min(salary)) as pay_cha --���⼭ as�� �� �ٸ� �̸����� �������شٴ� ����(�ʹ� �̸��� �涧 ��� ������)
from employees
group by department_id
order by department_id; --�������� �������� �����ϴµ� �ʿ��Ѱ� order by�ΰ���


-- where : select ���� ��ȸ�Ǵ� �������� �����ϴ� ����
select * from employees
where department_id = 50;

-- having : group by���� �����͸� ����/group by �����Լ� ���� ���� �����͸� ����
select department_id ,max(salary) as max_sal, min(salary) as min_sal, 
    (max(salary) - min(salary)) as pay_cha --���⼭ as�� �� �ٸ� �̸����� �������شٴ� ����(�ʹ� �̸��� �涧 ��� ������)
from employees
group by department_id
having max(salary)>11000;  --group by�� �з��Ȱ� �� �����ϴ� ����

--��ձ޿��� 15000���� ���� ������, ��ձ޿��� ��ȸ�Ͻÿ�.
select job_id, salary, avg(salary)
    from employees
    group by job_id,salary
    having avg(salary)>15000;
    

-- �μ���, ������, �޿� �հ谡 10000���� ���� �μ�, ����, �޿��հ�, ��� �޿��� ��ȸ.
select department_id, job_id, sum (salary), round( avg(salary),1) as avg_sal
    from employees
    group by department_id, job_id
    having sum(salary) > 10000;
    
    
-- �μ��� ������ �޿��� ���̰� 5000���� �� ū �μ�, �ְ�, ����, ���̱ݾ��� ��ȸ
select department_id,max(salary)as mx_sal, min(salary) as mn_sal
    ,(max(salary)- min(salary)) as char_sal
    from employees
    group by department_id
    having  (max(salary)- min(salary))> 5000;
    
    
==================================
-- �������� : �����ȿ� ������ �����Ѵ�.
-- ��ȸ�ϰ����ϴ� ���� ���� ���Ҷ� ���
-- ���� : ������ , ������ ��������
-- ()�ȿ� ���������� ���, where���� �����ʿ� ���������� �ۼ��Ѵ�.
==================================

-- ������ �߿� ȸ���� ��� �޿����� ���� �޴� ������ �̸�, ����, �޿��� ��ȸ
select last_name, job_id, salary
from employees
where salary > (select avg(salary) from employees); --�̷������� ��ȣ�ȿ� �ִ°� ����������

-- ������ �߿� 'ST_MAN' ��ձ޿����� ���� �޴� ������ �̸�, ����, �޿��� ��ȸ
select last_name, job_id, salary
from employees
where salary > (select avg(salary) 
                            from employees
                            where job_id = 'ST_MAN');
                            
-- �������߿� �ְ�޿��� �޴� ������ �̸�, ����, �޿��� ��ȸ...

select last_name, job_id, salary
from employees
where salary = (select max(salary) 
                            from employees);

--�ּұ޿��� 80�μ��� �ּ� �޿����� ���� �޴� �μ��� ID, �ּұ޿��� ��ȸ
select department_id,  min(salary)
from employees
group by department_id
having min(salary) < (select min(salary) -- 80�μ��� ���� select�ϱ����ؼ�! 
                            from employees
                            where department_id = 80);

-- ������ �����ڸ� ����ϴ� �������� **(�������̶�°� �������� ���� ����س��°�?)
-- ���������� ������ �Լ�
-- ���� :  in(or), any(or), all(and) 

select salary    
        from employees  
        where department_id = 60; -- (9000,6000,4800,4200)�� ���� ����
        
-- in (or) : ��� ���� 1 : 1�� ����
-- any(or) : '<any '�� �ִ밪���� ������(= �� ������� ����ߵȴ�) , '>any'��  �ּҰ����� ū ��(=�� � ������ Ŀ�ߵȴ�)
-- all : '<all '�� �ּҰ����� ���� ��, '>all' �ִ밪���� ū ��
select last_name, job_id, salary, department_id
from employees
where salary<any  (select salary       --���⼭ where���ǿ� �ִ밪���� ���� ���� ����������ϱ�
                    from employees      -- ex. �� select������ ������ ���� ū ���� 9000�ε�, ���⼭ ����°� 9000���� ���� ���� ã�ƶ� ��� ����
                    where department_id = 60);
                    
                    
select last_name, job_id, salary, department_id
from employees
where salary<all  (select salary     --���⼭ where���ǿ� �ּҰ����� ���� ���� ���������
                    from employees    --�� ���������� select���� �ش��ϴ� �͵� �� salary���� ���� �ּ��� ���� ����Ҳ���.
                    where department_id = 60);

select last_name, job_id, salary, department_id
from employees
where salary in  (select salary     --���⼭ where���ǿ� in�� ������ ��Ŵ
                    from employees  -- **���� �� select������ ��µǴ� �͸� salary���� ����Ҳ���
                    where department_id = 60);
                    
====================================
-- ���� (join) -- �ΰ� �̻��� ���̺���� ���� �Ǵ� �����Ͽ� �����͸� ��ȸ�ϴ� ��
select * --������ ����ض�
from employees,departments;
-- �� ����� �ϸ� 2889���� ��µ� 

--employees.department_id -- employees ���̺��� foreignŰ
--departments.department_id -- departments ���̺��� primaryŰ

select last_name, employee_id
        ,employees.department_id  --employees���̺� �ִ� �μ����̵� �����
        ,departments.department_id --departments���̺� �ִ� �μ����̵� �����
from employees, departments
where employee_id = 107;   -- id�� 107�ΰ͸� ����غ���

select last_name, employee_id
        ,employees.department_id  --emplyees���̺� �ִ� �μ����̵� �����
        ,departments.department_id --departments���̺� �ִ� �μ����̵� �����
from employees, departments
where employee_id = 107 -- employee_id�� 107�� �ش��ϰ�
and employees.department_id = departments.department_id; --�� ���̺��� ��ġ�ϴ� ���̵� ����ض�/�Ѱǹۿ� �ȳ���

--���� join�� �� ����
select last_name, employee_id
        ,employees.department_id  
        ,departments.department_id 
from employees, departments
where employees.department_id = departments.department_id; --�� ���̺��� ��ġ�ϴ� ���̵� ����ض�

select e. last_name, e.employee_id
        ,e.department_id  
        ,d.department_id 
from employees e,  departments d --ansal�� �� �� �ִ� �� ���̺� �̸��� e�� d�� �����
where e.department_id = d.department_id;

--������ ����
--1. �(inner join), ��, ��ü����, ��������(Left, Rightn, Full)
--Pk(primary key), FK(foreign key)�� ������
select e. last_name, e.employee_id
        ,e.department_id  
        ,d.department_id 
        ,d.department_name
from employees e,  departments d --ansal�� �� �� �ִ� �� ���̺� �̸��� e�� d�� �����
where e.department_id = d.department_id -- FK�� PK�� ��� �����ϰ� ���� --� ����
and job_id = 'ST_MAN';

--2. �� ���� 
--������ �����Ѵ�.
select last_name, salary, grade_level
from employees e, job_grades j
where salary between j.lowest_sal and j.highest_sal; -- between�� ���� ������ �������ְ� ����

select e.last_name, e.job_id, e.salary, 
        m.last_name as mgr_name, m.salary
from employees e, employees m  --���� ���̺��ε� �ϳ��� ���� ���̺� �ϳ��� ���������̺�� ��
where e.manager_id = m.employee_id;

--����. ����� ������
--�þ�Ʋ���� �ٹ��ϴ� ������ �̸�, ����, �μ��̸�, �޿��� ����ض�

select last_name, job_id, d.department_id, salary, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id --department���̺� �ִ� department_id�� employee���̺� �ִ� department_id�� ���غ��°���
    and d. location_id = l.location_id
    and l.city = 'Seattle';
--���� ���� ���ε� ���������� �̿��ؼ� ������
select last_name, job_id, d.department_id, salary
from employees e, departments d
where e.department_id = d.department_id 
    and d. location_id =(select location_Id from locations
                                where city = 'Seattle');

--����(�ܺ�) ���� (Left, Right)
--���� null���� ���� ��ȸ�ϴµ� null���� ��ȸ�ϴ� ����
--left�� �ִ� ���� ����� ��Ų��
--right�� right�� �ִ� ���� ��½�Ų��
--full�� ���� ��½�Ų��

select last_name, job_id, d.department_name, salary
from employees e, departments d
where e.department_id = d.department_id(+); --�䷯�� (+)�־��ָ� �� ���̺��� null���� �����ؼ� ���
--107�ǳ���

select last_name, job_id, d.department_name, salary
from employees e, departments d
where e.department_id(+) = d.department_id; -- 122�ǳ���

--�̰͵� �����ؼ� �˷��ֱ������� ���� �������� �ٸ��ٰ� �������ֽ�**�ٽ� �����ϱ�
select distinct department_id
from employees; 
    
    
--15. ȸ�� ��ü�� �ִ�޿�, �ּұ޿�, �޿� �� �� �� ��� �޿��� ����Ͻÿ�.
select max(salary), min(salary), sum(salary),avg(salary)
from employees;

-- 16. �� ������, �ִ� �޿�, �ּ� �޿�, �޿� �� �� �� ��� �޿��� ����Ͻÿ�.
--   �� �ִ� �޿��� MAX, �ּ� �޿��� MIN, �޿� �� ���� SUM ��
--   ��� �޿��� AVG�� ����ϰ�, ������ ������������ �����Ͻÿ�

select job_id, max(salary) as MAX, min(salary) as MIN, 
            sum(salary) as SUM, avg(salary) as AVG
    from employees
    group by job_id
    order by  job_id ;

-- 17. ������ ������ ���� ������� �� ���� ����Ͻÿ� --107���ΰ�
select e.job_id as e , j.job_id as j
from employees e,jobs j
where e.job_id = j.job_id;


-- 18. �Ŵ����� �ٹ��ϴ� ������� �� ���� ����Ͻÿ�
select manager_id
from employees;


-- 19. �系�� �ִ� �޿� �� �ּ� �޿��� ���̸� ����Ͻÿ�
    
    select salary, max(salary), min(salary)
    from empoyees;
    where (max(salary)- min(salary));

-- 20. �Ŵ����� ��� �� �� �Ŵ��� �� ����� �� �ּ� �޿��� �޴� ����� �޿��� ����Ͻÿ�
--      - �Ŵ����� ���� ������� �����Ѵ�.
--      - �ּ� �޿��� 5000 �̸��� ���� �����Ѵ�.
--      - �޿� ���� �������� ��ȸ�Ѵ�.

select manager_id,  min(salary)
from employees
where  manager_id is not null --�Ŵ��� �ִ� ����鸸 ������ ��
group by manager_id 
having min(salary)<5000
order by min(salary) desc ;
    
    

-- 22. ��� ������� �̸�, �μ� �̸� �� �μ� ��ȣ�� ����Ͻÿ�.
--�̸� - e.last_name , �μ��̸�d. department_name  ,�μ���ȣ e. department_id
--�� ���̺��� ���ļ� ������ �� �ִ°� -- department_id
select  e.department_id, e.last_name,d.department_name,d.department_id
from departments d, employees e
where e.department_id = d.department_id;

-- 23. Ŀ�̼��� �޴� ��� ������� �̸�, �μ� ��, ���� ID �� ���� ���� ����Ͻÿ� (������ ���� ����)

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
from employees e, departments d , locations l  --�䷸�� �������� ����ϸ� ������ ������ ������ϳ���
                                                                --�� ���� ���� ���̺��� ��� �ϳ��� ���̺�� ����� �����ΰ��� ���̰�..������;;
where  e.department_id = d.department_id 
    and d. location_id = l.location_id
    and e.commission_pct is not null;


-- 24. �ڽ��� �Ŵ������� ���� ���� ������� �̸� �� ������� ����Ͻÿ� (�̰� ���� ���̺� ���� ����)
--���� �Ŵ����� ����̶� ���Ϸ������ݾ� �״ϱ� �� ���̺��� ���������
--�Ŵ��� ����� > ��� ����� (���� ����)
--��� �̸�, ����� ���
select e.last_name, e.hire_date
from employees e, employees M
where e.employee_id = m.manager_id --���� ��ġ�� �κ��� ����/�Ŵ����� ���̵�� ����� ���̵�
                                                --���� ���̺��� ��ġ�°� �����ϱ� �װɷ� ������ ���ٶ��
and e.hire_date<m.hire_date
order by hire_date;


select emp.last_name ,emp.employee_id, emp.hire_date 
from employees emp , employees mgr 
where emp.manager_id  = mgr.employee_id
and emp.hire_date < mgr.hire_date
order by emp.last_name;

-- 25. �μ� ��, �μ���ġID, �� �μ� �� ��� �� ��, �� �μ� �� ��� �޿��� ����ϵ�,
--    �μ���ġ�� ������������ ����Ͻÿ�

select d.department_name,  d.location_id, 
count(e.employee_id), avg(e.salary) 
from departments d, employees e
where d.department_id = e. department_id
group by d.department_name, d.location_id
order by d.location_id;

-----������� �ϴ� ��

-- 26. Zlotkey �� ������ �μ��� �ٹ��ϴ� ��� ������� ��� �� ��볯¥�� ����Ͻÿ�.

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

-- 27. ȸ�� ��ü ��� �޿����� �� �޿��� ���� �޴� ������� ��� �� �̸��� ����Ͻÿ�

select employee_id, last_name
from employees
where salary > (select avg(salary)
                        from employees);


-- 28. �̸��� u �� ���ԵǴ� ������ ���� �μ��� �ٹ��ϴ� ������� ��� �� �̸��� ����Ͻÿ�.
-- **���� ���� �ܿ��(�� ó�� �������)
select employee_id, last_name
from employees
where department_id in (
                            select distinct department_id -- distinct�� �ߺ�����, �Ȱ��� ���� �� �����Ϸ���
                                    from employees
                                    where last_name like '%u%')
and last_name not like '%u%';

-- 29. �þ�Ʋ�� �ٹ��ϴ� ��� �� Ŀ�̼��� �����ʴ� 
--��� ������� �̸�, �μ� ��, ���� ID�� ����Ͻÿ�

select e.last_name, d.department_name, l.location_id
from employees e, locations l ,departments d
where e.department_id = d.department_id
       and d.location_id =l.location_id
        and city = 'Seattle';


-- 30. �̸��� DAVIES �� ������� �Ŀ� ���� ������� �̸� �� ������ڸ� ����Ͻÿ�.
--	   ������ڸ� �������� ����Ͻÿ�






-- 31. King �� �Ŵ����� �ΰ� �ִ� ��� ������� �̸� �� �޿��� ����Ͻÿ�

-- 32. ȸ�� ��ü ��ձ޿����� �� ���� �޴� ����� �� �̸��� u �� �ִ� �������
--   �ٹ��ϴ� �μ����� �ٹ��ϴ� ������� ���, �̸� �� �޿��� ����Ͻÿ�

    ==========================
    
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
                --300�� department_id/ 'AI Big Data'�� department_name/114�� manager_id/1400�� location_id�� �� 1:1���� ��
      select * from departments;
    (2) insert into ���̺�� [(�÷���)] values (); : ����� ��� �÷� �� 1:1 ����
      ��) insert into departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID)
        values (310, 'AI Big Data', null, null);
    (3) insert into ���̺�� [(�Ϻ� �÷���)] values (); : ���������� ���� �÷� �� 1:1 ����
      ��) insert into departments (DEPARTMENT_ID,DEPARTMENT_NAME)
           values (320, 'AI Big Data');
        insert into departments (DEPARTMENT_ID,DEPARTMENT_NAME) --���ڸ� ���ڷ� ����ȯ�ؼ� ������ �Ȼ���
        values ('330', 'AI Big Data');
      insert into employees (EMPLOYEE_ID,LAST_NAME,EMAIL,HIRE_DATE,JOB_ID)
      values (340, 'inho', 'shin@smrd.co.kr', sysdate, 'IT_PROG');
      
      select * from employees;
      
    
--�̰� ���� �����ϴ°� (�̰� where �Ⱥ����� �� ���󰡴ϱ� �� where ������ �ϱ�)
 delete from employees where EMPLOYEE_ID >= 300;
 delete from departments where department_id >= 300;

--���̺� �ϳ� �����ϴ°� 
create table emp_ddl (
     emp_id  number
    ,Lname varchar(30)
    ,sal   number
    ,bouns number(5,2)
    ,dept_id  number
    ,cdate  date
 );

 
-- SUB Query�� �̿��� data�� ���� -- employees �� �ִ� �����͸� emp_ddl�� �����Ѱ���
insert into emp_ddl (
   select employee_id, last_name, salary, commission_pct, department_id ,sysdate
     from employees); 
     --���̺� �����͸� �μ�Ʈ�ϴ� ��
     
commit;
delete from emp_ddl; --�̰� �����ϴ°�
select * from emp_ddl;

-- update�� ++ select�� �����ϰ� ������Ʈ�� �ؾ��Ѵ�.
-- �÷������� ������ �����ϴ�.
--update set where �� ����Ʈ 
--������Ʈ�� �����ؼ� ������Ʈ �ؾߵȴ�. �ֳĸ�...�ٽ� �ǵ����� ��Ʊ⶧����,,�׷� �� ���Ѱǰ�..
update table��
   set col1 = val01,
       col2 = val02,
       col3 = val03
 where ���ǽ�  ;
 
-- update ��� ��)
--������ ���� select ������ Ȯ��
select lname, sal, bouns 
from emp_ddl
where emp_id = 156;

--�� ���� ������Ʈ �ϰ� �ٽ� select�� ������ Ȯ���ϸ� ������Ʈ �Ȱ� Ȯ�� �� �� ����
update emp_ddl
  set lname = 'Shin inho',
      sal = 2400
where emp_id = 156;

-- emp_ddl ���̺��� ��ü ������ ��ձ޿����� ���� �����鿡�� �޿��� 5% �λ��ϱ�..
--���� avg (sal) �� 6390.
--���� 56
--������Ʈ �ϴϱ� 55��
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

-- delete��
-- �� ������ �۾��� ����ȴ�.
delete [ from ] table��
 where ���ǽ�..
-- ��� ��)
  delete from emp_ddl
  where emp_id = 156;

  delete from emp_ddl
  where emp_id = 112;

    
    
    =================================
-- 11�� TCL Ʈ�����(Transaction Control Language)
-- DML �۾��� �����ϸ� Ʈ������� �߻��Ѵ�. ---�۾� �ϳ��ϳ��� Ʈ�������̶�� �Ѵ�.
-- Ʈ������� �����۾����� �ϳ��� ���� �����Դϴ�. 
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
select * from emp_ddl where emp_id = 101; --���⼭ �ϳ��ϳ��� �۾��� �����̶�� �Ѵٰ���

update emp_ddl
    set lname = ' inho'
    where emp_id = 101; --101���� lname�� ����ȣ�� �ٲ��� 
                                --�̷��� �ٲ۰� �ٸ� ���Ǿȿ����� ������ �ȵ�/�Ʒ� commit�� ����� �����

commit; -- ���� ���� ������Ʈ ���¿��� commit�� �ϸ� �ٸ� ����(��� ������Ʈ)������ �ݿ���
            --������ �۱ݾ������ �����ϸ�� ���� ���� ���´µ� �ٸ� ���� ������ �ȵǾ������� �� �� ����
            --commit�� �ѹ��ϸ� rollback�ص� �ȵǳ��� **Ȯ���ʿ�
savepoint abc;

rollback to abc;

rollback ;

LOCK /  UNLOCK

-- insert > savepoint > delete > rollback to (save point���� ���� ������-->�׷� insert�� ����ä�� update�� �Ѿ)
--> update > rollback(insert���� ���� ������--> �׷� delete�� commit�� ���Ե�) > delete > commit

=======================--Dml��������.sql===================
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

--����1. ������ �� �߰��ض�
insert into my_employee values (1,'Patel','Ralph', 'rpatel', 895); --�μ�Ʈ���� ������� ����. (����)
insert into my_employee values (2,	'Dancs',	'Betty',	'bdancs',	860);

--����2. ���� �������� 3,4���� my_employee ���̺� �߰��Ͻʽÿ�.
--insert���� ���� ��������� �����Ͻʽÿ�.(���� �ϴ��Ϸ� ��������� ���̰� �ض�)
insert into my_employee (id, last_name, first_name, userid, salary)
values (3,	'Biri',	'Ben',	'bbiri',	1100);
insert into my_employee (id, last_name, first_name, userid, salary)
values (4,	'Newman',	'Chad',	'cnewman',	750);
insert into my_employee (id, last_name, first_name, userid, salary)
values (5,	'Ropeburn',	'Audrey',	'aropebur',	1550);

delete my_employee
where id = 5;

      select * from my_employee;
      
--����3. ���3�� ���� drexler�� �����Ͻʽÿ�.
update my_employee
set last_name = 'drexler' 
where id = 3;

      select * from my_employee;
      
--���� 5. �޿��� 900�̸��� ������� �޿��� 1000���� �����Ͻʽÿ�
update my_employee
set salary = 1000
where salary < 900;

      select * from my_employee;
--���� 6.
delete my_employee
where first_name = 'Betty'
and last_name = 'Dancs';

 select * from my_employee;

commit;

--���� 8.
insert into my_employee 
(id, last_name, first_name, salary)
values (5,	'Ropeburn',	'Audrey', 1550);


 select * from my_employee;

savepoint tag01;

--���� 10.
--���̺� ���� ��ü����
delete from my_employee;

 select * from my_employee;


--12 ���� �۾��� ������ ���� �ֱ��� delete�۾��� �����ʽÿ�

rollback to tag01;

--13
 select * from my_employee;


--������ ����

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

-- Ʈ�����(Transaction)�� ����
-- ����� : commit, rollbcak
-- �Ϲ��� : ������ ����, ddl�� ����(commit)


--Dml��������.sql ����


=================================

-- 12�� DDL(Data Definition Language)
-- ddl ���� : create, alter, drop,
--          truncate, rename, comment
=================================

-- �÷��� �Ӽ�(90% �̿��ϴ� �÷��� �Ӽ��� ������ �Դٰ���)
-- ����
   char, varchar, varchar2  --������ �����͸� �� �÷��� ��������
                                       -- (varchar���� ���var�� �����̶�� ������ ���� �� �ִ� �������� �ִ´ٴ¸�)
-- ����
   number, number(5), number(5,2) --���ڸ� 5�ڸ��� ���ڴ�/ �ټ��ڸ� �߿��� �Ҽ��� ���� ��°���� ���� 
-- ��¥
   date --������ ������ ģ����
   TimeStamp

-- ���̺��� ����
create table emp_ddl (  --�� ��ȣ�ȿ� �÷� �̸��� �÷��� �Ӽ��� �������ִ°���
    emp_id  number, --number������ �÷��� �Ӽ�
    lname varchar(30), --�̰� �� ���ϴ���**
    sal   number,
    bouns number(5,2),
	dept_id  number,
    cdate  date
);
-- ���������� �̿��� ���̺��� ����
create table ���̺��̸� as (��������)
;
-- ��)
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

-- �� ���̺� ����
create table emp_ddl20 as (
   select employee_id as emp_id
         ,last_name as lname
		 ,salary as sal
		 ,commission_pct as bonus
		 ,department_id as dept_id
		 ,sysdate as cdate
     from employees
    where 1 <> 1 --�������� ��ȸ = �Ӹ��۸� ����ٴ� ����
);

-- ���� �������� Ȱ�� ���̺� ����
create table emp_ddl30 as (
   select e.department_id as dept_id, d.department_name as dname,
          avg(salary) avg_sal
      from employees e, departments d
     where e.department_id = d.department_id
    group by e.department_id,d.department_name
);
select * from emp_ddl30;

-- ���̺��� ����(alter) --���̺��� �����ϴ°�
-- alter table ���̺��
-- add, modify, rename, drop
alter table emp_ddl30 add( cdate date ); --�÷��� �ϳ� �߰��ϰڴ�.
alter table emp_ddl30 add( cdate date default sysdate); --r�⺻������ �ٲٰڴ�.

alter table emp_ddl modify( lname varchar(40) ); --Į���� �Ӽ��� �ٲ۴ٴ� �� /���� 30�� 40���� �ٲ�

alter table emp_ddl30 rename column dname to lname;  --���� dname�̴��Ÿ� lname���� �ٲٰڴ�.

alter table emp_ddl30 drop (cdate);

-- �÷��� �ּ� �ޱ�.. �ڿ� �޷��ִ� comment �ڸ� ä���
comment on column emp_ddl.emp_id is '���� ��ȣ';
-- ���̺� �ּ� �ޱ�..
comment on table  emp_ddl30 is '���� ����'; --ddl30�� ���� sqlȮ���غ��� 
                            --�̷��� ���� �̰� �ڸ�Ʈ �޸����� COMMENT ON TABLE "HR"."EMP_DDL30"  IS '���� ����';
-- ���̺� �̸��� �ٲٱ�
rename emp_ddl30 to emp_ddl35; --�����ʹ� �״�� �ְ� ���̺� �̸��� �ٲ�°���

select * from emp_ddl35;

-- ddl����� ������ auto commit;
-- DDL���� commit,  rollback; ���� �ʴ´�..

-- truncate
select * from  emp_ddl;

delete from emp_ddl;  -- dml(���������۾� �ѹ��ϸ� ���ư��°�)
rollback; --���ư�

truncate table emp_ddl;  --ddl(������ ���Ǿ� �ѹ��ϸ� �ȵ��ư��°�) --ddl�� �ڵ� commit�Ǵ� ģ���� �����ؾߵ�
rollback; --�ٽ� �ȵ��ư�

-- ���̺��� ����
drop table emp_ddl;
drop table emp_ddl10;
drop table emp_ddl20;
drop table emp_ddl35;
drop table my_employee;
--������ ������


=================================
-- 13�� ��������
-- ���� ���ϴ� �͸� insert �ϱ� ���ؼ� ���ǰ� ������ �����δ� ��.
-- �������� ���Ἲ�� �����ϱ� ���Ͽ� �ʿ��ϴ�.
--  ���Ἲ: �������� ��Ȯ���� �ϰ����� ����
--   (����(null),��ü(Pk),����(Fk)���Ἲ)
-- ����:
    not null, unique, primary key, 
	foreign key, check, [ default ]
-- primary key : not null, unique --�⺻Ű�� �ߺ�����,�����ؾ��ϰ�,null���� ����ߵ�
-- not null : � ���̵��� �־�� �Ѵ�.
-- unique   : ���� �ߺ��� ������� �ʴ´�. �׷��� ���� �ƴ� �׳� ��ĭ�� null�� ���
-- foreign key : �ܺ�Ű�� ����
-- check : �ԷµǴ� ���� ������ ����(���� �� �������� �ϰڴ�.) 
                                                -- ex. salary ���� ��� 100-1000 ���̸� ��Ÿ���ڴ�.�� ���⼭ ��������

-- ���������� �ο��ϴ� ���
   -. �� ���ؿ���  �ִ¹��
   -. ���̺� ���ؿ��� �ִ¹��
   -. ���� ������ �̸��� �ߺ����� �ʾƾ��Ѵ�. --���� �̸��� ������ �ȵȴ�.
=================================
-- ���������� ��ȸ
select table_name from user_tables; --hr�� ����� �� �ִ� ���̺��� ��� �ִ��� Ȯ���� �� �ִ� �Ŷ��

select * from user_constraints --user_constraints�� ������ �������ǿ� ���� ����̴�.
                                        --���⼭ ���� owner�� ������ = user=���� ���� =���⼱ hr
where table_name = 'EMP_CNST'; 

-- �������� �����ϴ� ���� ���� -> ���� ����Ȱ��

-- �������� ���� ���� �ο�..
-- sys_c123456

drop table emp_cnst; --�� ���̺��� �����ϱ� ������ ����(������ �ȳ�����)
                            --�����Ѵٴ� ��

create table emp_cnst(      --�̰� ���� ddl
    emp_id number(4)   constraint emp_pk primary key -- �̰� �⺻Ű��� ������ �ذ���
   ,lname varchar2(30) constraint emp_lname_nn not null --not null�̶�� ������ ��
   ,email varchar2(30) unique
   ,hdate date  default sysdate
   ,job_id varchar2(15)
   ,sal    number(8,2) constraint emp_sal_ck check (sal between 1000 and 10000)
   ,bonus  number(5,2)
   ,mgr_id   number(4)
   ,dept_id number(4) references departments(department_id) --departments�� �ִ� id�� �����Ҳ���
);

select * from emp_cnst; --���̺� Ȯ��

--���� �������ǿ� ���� insert�� �ϴ°��� �����غ��� ����

insert into emp_cnst (emp_id, lname, email) 
   values (10, 'shin inho', 'inho@smhr.or.kr'); --1. �� �����ϰ� �ؿ��� id�� �ٸ����ϰ� �����ϸ�
   insert into emp_cnst (emp_id, lname, email) --2. ���⼭ �ѹ��� �ϸ� ������ (email�� unique�� �����Ǿ������ϱ�)
   values (12, 'shin inho', 'inho@smhr.or.kr');
     insert into emp_cnst (emp_id, lname, email) 
   values (12, 'soso', 'inho@smhr.or.kr');  --3. �̰͵� 12�� ���������ϸ� ������(id�� primaryŰ�ϱ�, �ߺ� ���X)
   
insert into emp_cnst (emp_id, lname, email, sal)
   values (20, 'shin inho01', 'inho01@smhr.or.kr', 12000); --�޿��� 1000-10000���� ������ �صּ� ������
insert into emp_cnst (emp_id, lname, email, hdate)
   values (30, 'shin inho', 'inho02@smhr.or.kr', sysdate); 
                                        --���� lname�� ���� ������, lname�� ���ѿ� �ߺ� ������ �ִ°� �ƴϴϱ� ���Ե�

insert into emp_cnst (emp_id, lname, email, hdate, dept_id) --���⼭ dept_id ���̺��� departments���̺��� �����ϴµ�
   values (40, 'shin inho', 'inho03@smhr.or.kr', sysdate, 350); --������ ���̺� 350�� �����ϱ�(�� ���̺� Ȯ���ʿ�)
   insert into emp_cnst (emp_id, lname, email, hdate, dept_id)
   values (40, 'shin inho', 'inho03@smhr.or.kr', sysdate, 100);  --�׷��� ���̺� �ִ� 100,110..�� �� �־��ָ� ���� �Ȼ���
   
insert into emp_cnst (emp_id, lname, hdate, dept_id)
   values (60, 'shin inho', sysdate, 100);

rollback;


-----------------
--  ���̺� ���ؿ����� ���� ���� �ο�.. 
                            --(���� �����ٰ� ���������� �����Ű� �̰� �� ���� �ؿ� ���Ƽ� ���������� ��а���)
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
   ,foreign key (dept_id) references dept_cnst10(dept_id) --foreignŰ�� ������ ����
);



-- �������� Ǯ���� ����
-- ������ �޿��� 5000���� ���� �޴� ������
-- ������ȣ, �̸�, ����, �Ի���,�޿�, �μ���, �����ڸ��� ��ȸ�Ͻÿ�..
-- �޿��� 3�ڸ����� ','�� �����Ѵ�.

---�ǽ�)) ���̺� ���԰� ������ ����
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

--����.
-- ������ �޿��� 5000���� ���� �޴� ������
SELECT
    *
FROM
    emp
WHERE
    sal > 5000;
-- ������ȣ, �̸�, ����, �Ի���,�޿�, �μ���, �����ڸ��� ��ȸ�Ͻÿ�..
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

-- �޿��� 3�ڸ����� ','�� �����Ѵ�.
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
-- �����ڰ� ���� ������ ����Ѵ�.
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

--1. ���̺� �����ǽ� 
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
-- 14�� ��Ÿ ��ü
-- ���̺�, ��, �ε���, ������, ���Ǿ�
=================================
-- �����ͻ��� --��� �ʿ��� �߿� ������ ���� --�������� ������ �ƴ� view������ ����� select�� �����ϸ� ��������
select * from user_tables;
select * from all_tables;
select * from all_objects where owner ='HR';  --������ hr�ΰ͸� ����ض�
                         --��� ������Ʈ �߿���
select * from user_objects;

select * from user_col_comments
where table_name = 'DEPARTMENTS'; --departments��� ���̺� �̸��� ���� ���� column�� �ڸ�Ʈ ���
select * from all_col_comments
where table_name = 'EMP_DDL';

select * from user_tab_comments  -- ���̺��� �ڸ�Ʈ
where table_name = 'DEPARTMENTS';
select * from all_tab_comments
where table_name = 'DEPARTMENTS';

select * from user_constraints  --���� ����ڰ� ������ �ִ� �츮�� �̸� ������ �������ǿ� ���ؼ� ����
where table_name = 'EMP_CNST';

select * from user_cons_columns --�̰� �������� ���������ΰ���
where table_name = 'EMP_CNST';

-----------------
-- ��ü ���� (���̺�, ��, �ε���, ������, ���Ǿ�, Ʈ����, �Լ�)
create ��ü������ ��ü�� ...
;
-- 1. view
-- �並 ���� ����
-- create view ��� as (select from ..) -- �並 ����� ���
-- �������� ������ ���� �Ҷ� 
-- ������ ���Ǹ� ���� �Ҷ� -- select�� view�̸��� �ҷ��� �ٷ� ���
-- �������� �������� �����Ҷ�..

create view vw_lname as  --�����Ҷ� create
  (select last_name from employees);
--drop  -- ���ﶩ drop

--�μ�id,�μ���, ��ձ޿�, �����޿�, �ְ�޿� ����� ��ȸ�ض�
--���� �Ź� Ÿ�����ؼ� �����;��ϴµ�, view�� �����θ�
--view�� �̸��� �ҷ��� �ٷ� ����� ������---�Ʒ��� �� ����

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

-- in Line �� --�̰� �� ������°ž�(����)
-- ȸ�系�� �޿��� ���� �޴� ���� ���� 5���� �̸��� �޿� ��ȸ�� ����..?
select rownum, a.*  --������ ��ȣ�� rownum�̶��
from (select last_name, salary
        from employees
        order by salary desc) a  --������� ����� �ϱ����� ���������� ����
where rownum < 6 ;

--���� �ι�°���� ���ؼ� ������ �ƴϰ� ����� �� �Ҷ��?
-- ȸ�系�� �޿��� ���� �޴� ���� ���� 5���� �̸��� �޿� ��ȸ..
select rownum, a.*
from  employees a
where rownum <= 4
order by salary desc;


-- 2. �ε���
-- �˻��� �ӵ��� ���δ�.
-- �������� ���� ������ ������ �ִ�.
-- DML�� ����ϰ� �Ͼ�� Tablel�� ���ؼ��� ������ ���� �����´�.
--                        dml�� ���� �Ͼ�� table�� ���� �ε��� �������ƶ�
-- �ε��� ����� �������
--  1) ���� ������ �������ϰ� ���ԵǴ� ��� 
                --�ʹ� ������ ���� �幮�幮 �������� �ִ� �ſ� ���
--  2) ������, ������ ���� �Ͼ�� �׸� 
                 
--  3) ��κ��� ���ǿ� ���� �˻���� 2-4%�̸��� ���
     -- ī�װ����� ���������� ������ �׷� �͵鿡 ��� / �ʹ� ���� ����� �ε����ϸ� ���ʿ��ϴϱ�
    --�ε��� �̸��� 5���Ŀ� ���� ����� ���ֵ��� ���ض�
    
    create table emp_ddl (  --�� ��ȣ�ȿ� �÷� �̸��� �÷��� �Ӽ��� �������ִ°���
   employee_id  number, --number������ �÷��� �Ӽ�
    last_name varchar(30), --�̰� �� ���ϴ���**
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


    --�ε��� ����°�
    
create index emp_name_idx --�ε����̸�
   on emp_ddl (last_name); ---���̺��̸��� lname�� �����ϰڴ�
            --�̷��� ����� ���� where���� f10�� ������ ������ ���� ��������� �� �� ����
select * from emp_ddl
where last_name like 'K%';

select * from user_indexes;

select * from user_ind_columns;

drop index emp_name_idx; --���ﶩ drop���

-- 3. ������(Sequence)
--  ������ ��ȣ�� �ڵ����� �����Ѵ�.
--  ������ �����ϴ�.
--  �Ϲ����� �⺻Ű(pK)�� ����Ѵ�.

drop sequence emp_seq;  --������ �����ϴ°�

        --������ ����� ���
create sequence empddl_seq  --�̸� ���
   increment by 10 --  10�� �����ض�
   start with 100   --���۰�
   maxvalue 999999999999999  --������� ���
   nocache      --cache��� �ӵ������Բ� �ϴ°ǵ� ��κ� no�� ����
   nocycle;       --��������

drop table  emp_ddl;

insert into emp_ddl (employee_id, last_name, salary)
  (select empddl_seq.nextval , last_name,  salary
    from employees);
    
commit;

select empddl_seq.nextval from dual; --��� ���� 
select empddl_seq.currval from dual;  --nextval�̶�� ���� ���� ����

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
select substr('ajkdaskjd', 2,3) from dual; -- �ι�°���� ����°���� �����Ͷ�
select upper('asasdasdf') from dual; -- �빮�ڷ� ���� �ٲ��
select fn_dname(10) from dual;  --

-- ����� ���� �Լ�
-- �μ��̸��� ��ȯ�ϴ� �Լ�..
                            --���� ��ȯ �Լ��� ���� (����)
create or replace function fn_dname (dept_id in int) --�Լ� �̸��� ������ �Ѿ������ dept_id�� �ްڵ�.
   return varchar  ---������� ���ڿ��� �����ߴ�.
is
                                --���α׷����� ����� ���� ����
   dnm varchar2(30);   
begin
   select department_name into dnm --dnm�� ������ �޴´�.
     from departments
     where department_id = dept_id;
   return dnm;
end;
/  <--�Լ����� �������̶�� �����ִ°ŷ��� �־���ϴ°�

select last_name, salary, job_id ,fn_dname(department_id) 
from employees;



-- �μ����� ��ȸ�ϴ� ����� �����Լ� �̿��Ͽ� ������ �̸�, �μ��̸�, �Ի���, �޿��� ��ȸ�Ͻÿ�..
select last_name, fn_dname(department_id), hire_date, salary
  from employees;


-- 6. TRIGGER
-- ����� �߻��ϸ� �װ��� ���� ���������� �Ͼ�� ��

--�ǽ�)   --����ٴ� ������� ������ 
            --�����͸� ����� �Ѵٴ� �׷� �۾��� �غ��ڴ�
--1, ����� ���̺� ����
--2. Ʈ���� �ۼ�
--3. emp ����
--4. ����� ���̺� Ȯ��

--1, ����� ���̺� ����
create table emp_bak as ( select emp.*, sysdate as cdate from emp where 1 <> 1);
                                                    --������ ��¥�� �˾ƺ������� sysdate�߰�
--2. Ʈ���� �ۼ�
create or replace TRIGGER emp_delete  --trigger�����ϰڴ�. �̸�����
  before delete on emp for each row    
begin
insert into emp_bak values (     --���⿡ �� ������ emp���̺��� ������ ���ƾߵ�
    :old.EMPNO ,:old.ENAME ,:old.JOB ,:old.MGR  --old��� ���� �����ϱ� ���� ���̶�¸�
    ,:old.HIREDATE ,:old.SAL ,:old.COMM ,:old.DEPTNO
    ,sysdate
  );
end;
/
--3. emp ������ ���� 
delete emp where EMPNO in (100,101);

commit;

--4. ����� ���̺� Ȯ��  --������ ������ ���� Ȯ���ϴ� ���̺��� �ҷ����� ����
                                --���� �����ϸ� ������ �� Ȯ���̶�� �˸��
select * from emp_bak;

drop table EMP_BAK;
=================================
-- 15�� DCL(Dta Control Language)
-- DCL : grant to, revoke from
=================================

--2023 01 16 3�� ���� --��¥ �Ӷ���� 1�� �𸣰ڰ� �ʹ� �Դٰ��ٰŸ�**

----------------------------------- Oracle-system���� �����ؼ� �����ؾߵ�-----
show user;  --�̰� ���� ���� �����ϰ� �ִ� �ý����� ���� ����°���

create user sohyeon IDENTIFIED by sohyeon;  --��������

grant create session to sohyeon;          -- �������� ����Ŭ ������ �� �ִ� ���ǿ� ���� ���� �ְڴ�.
                                        --> �ٵ� ���⼭ system�� ������ ������ ������ �����ϱ�
                                        --> ������ sohyoen���� ������ �ִ°��� system ��������
                                        -->�׸��� �Ѿ�� sohyeon���� ���̺� �����, �丸���...����� ������ �����ϴ°���
grant create table to sohyeon; 

grant resource to sohyeon;



grant select , insert on hr.departments to sohyeon with grant option;


drop user sohyeon cascade;

grant create session, RESOURCE,
      create table,create view,
      create sequence
to sohyeon;




select * from user_sys_privs;





-- ��������� �ο�
grant create session to inho;

-- ���̺� ���������� �ο�
grant create table to inho;
grant create view to inho;

-- �ڿ��� ������ �ο�
grant resource to inho;

--�Ѳ����� grant�ϱ� ����
grant create session, RESOURCE,
      create table,create view,
      create sequence
to sohyeon;

-- �ٸ� ������� ��ü�� ��ȸ
grant select on hr.employees to sohyeon;

-- �ٸ� ����ڿ��� ������ �ο��� �� �ִ� ������ �����մϴ�.
grant select, insert on departments
to sohyeon with grant option;  -->�� ������ �ְڴ�.


-- ��� ����鿡�� ���� �ο�
grant select on hr.departments to scott;
grant select on hr.departments to public;

-- ��ȣ ����
alter user sohyeon IDENTIFIED by 0000 account lock;

alter user sohyeon IDENTIFIED by 0000 account unlock;

-- �ο��� ������ Ȯ��
select * from role_sys_privs;
select * from role_tab_privs;

--**
select * from user_sys_privs;

-- ������ ȸ��-- �� �κ� �ٽ� ���� ���� ������
revoke create table from sohyeon;    
                -->  �̰�  select * from user_sys_privs; ���⼭ ���� ���� NO�� �Ǿ�����(�� ȸ���Ǿ����ϱ�)

grant select, insert on hr.departments to sohyeon with grant option;

alter user sohyeon IDENTIFIED by 0000 account unlock;






revoke create session, RESOURCE,
  create table,create view,
  create sequence
from inho;

-- ��Ȱ�� ����
create  role mgr;

grant create session, RESOURCE,
  create table,create view,
  create sequence
to mgr;
-- ��Ȱ�� Ȱ��.
grant mgr to inho, hr, scott;

drop user inho cascade;

===============================
-- ����� �������� ����
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









