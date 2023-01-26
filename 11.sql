--view : ���̺��� �����ϰ� �����ִ� â�� ������ �Ѵ�.
-- data�� view�� ���ؼ� ����, ���� ������/

--hr��Ű���� �۾��Ѵ�.

create view empvu80 as
--�����Ű�� ���� �����͸� ���������� �ۼ��Ѵ�.
        select employee_id, last_name, department_id
        from employees
        where department_id = 80;
        
desc empvu80

select * from empvu80; -- �Ʒ�ó�� ���ŷӰ����� �ʱ� ���� empvu80 �� ������ �صа��̴�.

select * from (
        select employee_id, last_name, department_id
        from employees
        where department_id = 80);

--view�� �����غ���. Į���� �ٿ�����.
-- create or replace   // �̹� empvu80 �� �ֱ� ������ replace�� �۵��Ѵ�. ����Ŭ�� �˾Ƽ� create�ϰų� replace�Ѵ�.
create or replace view empvu80 as
        select employee_id, job_id
        from employees
        where department_id = 80;

desc empvu80

--���� : 50�� �μ������� ���, �̸�, �μ���ȣ�� ������ DEPT50 view�� ������.
--          view�� ������ EMPNO, EMPLOYEE, DEPTNO�̴�.
create or replace view DEPT50 as
        select employee_id EMPNO, last_name EMPLOYEE, department_id DEPTNO
        from employees
        where department_id = 50;

desc DEPT50

--����� ���.
create or replace view dept50 (empno, employee, depyno) as
        select employee_id, last_name, department_id
        from employees
        where department_id = 50;

desc dept50
select * from dept50;


create or replace view dept50 (empno, employee, depyno) as
        select employee_id, last_name, department_id
        from employees
        where department_id = 50
        with check option constraint dept50_ck;
        
--check option
-- �����Ҷ��� drop ���̺��ϱ�
create table teams as
        select department_id team_id, department_name team_name
        from hr.departments;
        
create view team50 as
        select *
        from teams
        where team_id = 50;
        
select * from team50;

select count(*) from teams;

--teams�� �߰��Ȱ�
insert into team50
values(300, 'Markerting');

select count(*) from teams;

--�������� üũ�ɼ� ������Ѻ���
create or replace view team50 as
        select *
        from teams
        where team_id = 50
        with check option;

insert into team50 values(50, 'IT Support');
select count(*) from teams;

--�̶� üũ�ɼǿ� �ɸ���.
--80��° �� where���� �˻��Ѵ�. 50�� 301�� ���ٴ� �����̶� ��������
insert into team50 values(301, 'IT Support');

create or replace view empvu10(employee_num, employee_name, job_title) as
        select employee_id, last_name, job_id
        from employees
        where department_id = 10
        with read only;
        
insert into empvu10 values(501, 'abel', 'Sales'); -- ���� /insert�ź�
select * from empvu10; 

--������
--��Ʈ������ ���鶧 �ʼ��� ����Ѵ�.
drop sequence team_teamid_seq;

create sequence team_teamid_seq; -- ���̺��_ Į����_������ǥ��

--�Խ����� �۹�ȣ�� ������ ���
select team_teamid_seq.nextval from dual; -- nextval : ���ο� ������°� 
select team_teamid_seq.nextval from dual;
select team_teamid_seq.currval from dual; -- currval : ���� �� ��ȸ

insert into teams
values(team_teamid_seq.nextval, 'Marketing');

select * from teams
where team_id < 5;

create sequence x_xid_seq
        start with 10
        increment by 5
        maxvalue 20
        nocache -- �̸� �غ��س��� �۾� //
        --nocache�� �ϳ��ϳ� ��ȣǥ �����ִ°�, cache�� ��ȣǥ ������ �ϳ��� �������°��̶�� ��������.
        nocycle; -- �ݺ����� �ʴ´�. �ݺ��ϰ� ������ cycle
        
select x_xid_seq.nextval from dual;


drop sequence dept_departmentid_seq;

-- ���� : DEPT ���̺��� DEPARTMENT_ID Į���� field value�� �� sequence�� ������.
--           sequence�� 400�̻�, 1000���Ϸ� �����Ѵ�. 10�� �����Ѵ�.
create sequence dept_departmentid_seq
        start with 400
        increment by 10
        maxvalue 1000;
        
select dept_departmentid_seq.nextval from dual;
select dept_departmentid_seq.currval from dual;

-- ���� : �� sequence�� �̿��ؼ� , DEPT ���̺��� Education �μ��� insert�϶�.
insert into dept(department_id, department_name)
values(dept_departmentid_seq.nextval, 'Education');

commit;

--���̺� pk�� �����ϸ� �ڵ����� �ε��� ����
-- index : �����Ѵ�. �����Ѵ�.
drop index emp_lastname_idx;

create index emp_lastname_idx
on employees(last_name);

--rowid : ������ �� (index)
select last_name, rowid
from employees;

select last_name
from employees
where rowid = 'AAAEAbAAEAAAADNABe';

--���� ����ϴ� ��Ű������ � �ε����� �ִ��� ����.
select index_name, index_type, table_owner, table_name
from user_indexes;

-- ���� : DEPT ���̺��� DEPARTMENT_NAME �� ���� index�� ������.
drop index dept_departmentname_idx;

create index dept_departmentname_idx
on departments(department_name);

--1) ��ü �̸��� ��, 2) ���������� ��ü �ϳ� �θ��� �̸��� �ٸ���.
drop synonym team;

create synonym team
for departments;

select * from team;

-- ���� : EMPLOYEES ���̺� EMPS synonym�� ������.
drop synonym emps;

create synonym emps
for employees;

