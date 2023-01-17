--single funtion : row�� �ϳ� �޴´�.
desc dual
select * from dual;

-- lower ( �Ķ����) from  -> single function / lower : ��ü �ҹ���
select lower ('SQL Course')
from dual;

-- upper : ��ü �� �빮�� 
select upper ('SQL Course')
from dual;

-- initcap : ù�ܾ �빮�� 
select initcap('SQL Course')
from dual;

select last_name
from employees
where last_name = 'higgins';

-- �츮�� last_name�� �� ù�ڰ� �빮���ΰ��� �˱� ������ ���� ������ �� �ִ�.
select last_name
from employees
where last_name = 'Higgins';

--single function �̿��غ���
-- lower function�� ���ϰ��� higgins�� ���ϰ� �ִ� ���̴�.
select last_name
from employees
where lower(last_name) = 'higgins';

--concat (�Ķ����, �Ķ����)
select concat ('Hello' , 'World')
from dual;

--row �� 1�� , �ʵ�� 3��    (  '   '   , index , length)
select substr('HelloWorld' , 2, 5)
from dual;

--�ε����� �����ʿ��� �������� ���� ������ - �� ���� �ȴ�.
select substr('Hello' , -1 , 1)
from dual;

--���� �� ���¹� = length
select length ('Hello')
from dual;

--instr = 'l'�̶�� ���ڰ� �ε��� ���°�� �ִ��� ��Ÿ���� ���̴�.
-- ���ϰ��� 0���� ū�� ���غ���. 0���� ũ�� l�̶�� ���ڰ� �ִ�.
select instr('Hello', 'l')
from dual;

select instr('Hello', 'w')
from dual;

-- 5�ڸ��� �ָ� ��Ÿ���ž�. 4�ڸ��� �ֵ��� ���ʿ� *�� ä���� 5�ڸ��� ���ٰ�. 
-- ������ �غ��صξ���.
select lpad(salary, 5, '*')
from employees;

--�������� *�� ä���ٰ�.
select rpad(salary, 5, '*')
from employees;

-- J��� ���ڸ� BL�� �����ٰ�
select replace ('JACK and JUE' , 'J' , 'BL')
from dual;

--H��� ���ڸ� �����ž�.
select trim('H' from 'Hello')
from dual;

select trim('l' from 'Hello')
from dual;

select trim( ' ' from ' Hello ')
from dual;

--���� : �� query���� ' '�� trim�� ������, ������ Ȯ���� �� �ְ� ��ȸ�ض�.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;

-- trim �� �⺻�� space bar�̴�. from�� ������� �ʾƵ� �ȴ�.
select trim (' Hello World ')
from dual;

select employee_id, concat(first_name, last_name) name,
        job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG'; -- (job_id, 4) 4�� �ε������� ����������

-- ���� : �� query ����, where ���� like�� refactoring �϶�.
select employee_id, concat(first_name, last_name) name,
        job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';
