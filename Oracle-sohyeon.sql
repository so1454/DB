

show user;

create table temp_tbl2(
            irum varchar2(30),
            addr varchar2(100)
);

select table_name from user_tables;

create view vw_tmp as
    select * from temp_tbl;
    
select * from hr.departments;  --소유자 기술 '.' 불러올 개체 하면 그 개체가 불러와짐

select object_name from user_objects;








