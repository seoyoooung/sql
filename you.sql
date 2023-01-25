select tname
from tab;

-- Į�� ���� + ������ Ÿ�� + PK ����(���̺��_ �÷���_pk) or Ÿ��
-- constraint  = �������� 
-- depts_deptid_pk -> �������� ����
-- ���̺��� PK�� ������ �־���Ѵ�.
create table depts(-- �������� �˻� : ex) salary = 0 �̻��� ���������Ѵ�.
department_id number(3) constraint depts_deptid_pk primary key,
department_name varchar2(20));

--���������� Ȯ���� �� �ִ� ������ ��ųʸ�
desc user_constraints

select constraint_name, constraint_type, table_name
from user_constraints;

create table emps( --pk�������� ������ �ڵ����� ����Ŭ���� �������ش�.
employee_id number(3) primary key, --number : �ڸ��� //primary key > ����ũ�� ���� 
emp_name varchar2(10) constraint emps_empname_nn not null, --varchar2 : ����Ʈ
email varchar2(20), -- �ƹ� ���� ����.
salary number(6) constraint emps_sal_ck check( salary > 1000) , -- check( salary > 1000) > �������� ���Ἲ�� üũ�Ѵ�.
department_id number(3), 
constraint emps_email_uk unique(email), --���̺�� level ���� =  email �ʵ� �������� �˻��Ѵٴ� ���̴�.
constraint emps_deptid_fk foreign key(department_id)  --foreign key -> relationship�� ��Ÿ����.
        references depts (department_id)); -- references -> department_id�� �����ؼ� relationship�� ǥ���Ѵ�.
-- relationship (���� friendship) �ּ� 2��

--22��° ���� �������� ���Ἲ�� üũ�ϰ�, �� �� ������ �������� 4������ üũx

select constraint_name, constraint_type , table_name
from user_constraints;

--����--
insert into depts values(100, 'Development');
insert into emps values(500, 'musk', 'musk@gmail.com', 5000,100);
insert into emps values(501, 'a', 'musk@gmail.net', 2000, 100);
-- foreign key:  ������ ������ �������� �ʴ� ������ �����͸� �ִ°��� �����ϱ� ���� �������.

drop table emps cascade constraints;
-- �������ǵ� ���� �������ڴ� ��ɹ��̴�.

select constraint_name, constraint_type ,  table_name
from user_constraints;

-- hr��Ű���� �����ؼ� ��ȸ�ϸ� �����Ͱ� ������ �ʴ´�.
select * from depts;



--�ʵ�� ���̺�� �ٸ��� ���ϴ� ���� ? 