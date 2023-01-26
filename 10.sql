--DDL �� ������� �Ẹ��.

drop table hire_dates;

-- �ʵ� ���� null�� �ִ� ��� 1) null���� ����Ѵ�. 2) �ʵ带 �����Ѵ�.(null���� �⺻���� �����ȴ�)
--�⺻ null���� �ƴϰ� null���� ���� �Է�(����)�ϰ� ������ default �� ������ش�.
create table hire_dates (
emp_id number(8),
hire_date date default sysdate);

-- data dictionary : ��Ÿ �����͸� ������ �ִ� ���̺� / ��Ÿ �����͸� �����ϴ� �б� ���� ���̺��̴�.
select tname
from tab;

-- �� ��ɹ����� �����⸦ �����ϰ� ����غ���.
select tname
from tab
where tname not like 'BIN$%';

insert into hire_dates values(1, to_date('2025/12/21'));
insert into hire_dates values(2, null);
insert into hire_dates(emp_id) values(3); --hire_date�� null���� ����. 9��° �� ������ null��.

select * from hire_dates;

commit;
-- insert > �޸𸮿� ���� / commit > ���Ͽ� ����
-- drop table �ϰԵǸ� auto commit�ؼ� ���� �Ұ��� 
-- DDL : �ڵ�Ŀ�� / DML : ����Ŀ��
--DCL (Data Control Language) : ������ ����� / language �� ���������� command�̴�.

-----------------------------------------------------------------------------------------------

--�ý��� ��Ű���� �ٲ㼭 grant���ش�.
--Ư�� ��ü�� ���� ������ ����. you���� departments ������ ���� �Ѱ��ش�.
--��� ��ü ������ �ְڴ� = all
grant all on hr.departments to you;

-- you ������ �ٲ۴�.
drop table employees cascade constraints;

create table employees(
employee_id number(6) constraint emp_empid_pk primary key,
first_name varchar2(20),
last_name varchar2(25) constraint emp_lastname_nn not null,
-- �÷� �ϳ��� �������� ���������� ���� �� �ִ�.
email varchar2(25) constraint emp_email_nn not null
                               constraint emp_email_uk unique,
phone_number varchar2(20),
hire_date date constraint emp_hiredate_nn not null,
job_id varchar2(10) constraint emp_jobid_nn not null,
salary number(8) constraint emp_salary_ck check(salary > 0),
commission_pct number(2,2),
--�Ŵ��� ���̵�� �̸��� ���̵� reference �Ѵ�.
manager_id number(6) constraint emp_managerid_fk references employees(employee_id),
-- �ٸ� ��Ű�� �ȿ��� ��� �Ҷ��� ���λ縦 �ٿ���� �Ѵ�. ex) hr.departments
department_id number(4) constraint emp_dept_fk references hr.departments(department_id));

-- �θ����̺� ���ڵ尡 �����ɶ� �ڽ� ���̺� ���ڵ�� ��� �� ���̳�?
-- �׿� ���õ� �ɼ�
create table gu (
gu_id number(3) primary key,
gu_name char(9) not null);

create table dong(
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete cascade);
-- �θ� delete�Ǹ� �ڽĵ� delete�Ұž� = on delete cascade

-- �������� �������� �������� �����Ѵ�. �ٸ� ���� ���ӵǱ� ����.,..,,,.
create table dong2(
dong_id number(4) primary key,
dong_ndma varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete set null);

insert into gu values (100, '������');
insert into gu values(200, '�����');

--�ڽ����̺�
insert into dong values(5000, '�б�����', null);
insert into dong values(5001, '�Ｚ��', 100);
insert into dong values(5002, '���ﵿ', 100);
insert into dong values(6001, '��赿', 200);
insert into dong values(6002, '�߰赿', 200);

--dong2���̺��� ä���.
insert into dong2
select * from dong;

delete gu
where gu_id = 100;

select * from dong;
select * from dong2; -- �Ｚ�� ���ﵿ�� null���� ����. on delete set null�� ȿ���̴�.

commit;

--on delete set null�� ���� ���¿��� �θ��� �����͸� �����Ϸ��� �ϸ� �ź��Ѵ�.
-- �����ϴµ��� ����ٰ� �����Ҷ� �����. ���ý��Ͻ��� ���� ���
create table a (
aid number(1) constraint a_aid_pk primary key);

drop table b;

create table b (
bid number(2),
aid number(1),
constraint b_aid_fk foreign key(aid) references a(aid));

insert into a values(1);
insert into b values(31, 1);
--������Ȳ ����->parent key not found
insert into b values(32, 9);

-- ����. diable��Ų��. -> ���� �� �� ���๮�� �����Ű�� ���� ���Եȴ�.
alter table b disable constraint b_aid_fk;

--���� �׽�Ʈ
alter table b enable constraint b_aid_fk;
-- foreignŰ�� ����� �˻�� ���ϰ� �Ѵ�.
alter table b enable novalidate constraint b_aid_fk;

insert into b values(33, 8);

-- ���� �ʿ��� Ű�� �����ߴ�.
create table sub_departments as
        select department_id dept_id, department_name dept_name
        from hr.departments;
        
select * from sub_departments;

------
create table users(
user_id number(3));
desc users
--�߰�
alter table users add(user_name varchar2(10));
desc users
--����
alter table users modify(user_name number(7));
desc users
--����
alter table users drop column user_name;
desc users

insert into users values(1);
--read only�� ����
alter table users read only;
insert into users values(2); --����

--read write�� ����
alter table users read write;
insert into users values(2); -- ���� ���Եȴ�.
