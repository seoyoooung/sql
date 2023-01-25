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












