

show user;

create table temp_tbl2(
            irum varchar2(30),
            addr varchar2(100)
);

select table_name from user_tables;

create view vw_tmp as
    select * from temp_tbl;
    
select * from hr.departments;  --������ ��� '.' �ҷ��� ��ü �ϸ� �� ��ü�� �ҷ�����

select object_name from user_objects;








