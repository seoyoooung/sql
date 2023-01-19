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

-- �츮�� last_name�� �� ù�ڰ� �빮���ΰ��� �˱� ������ �� ������ ���� ������ �� �ִ�.
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

select substr('HelloWorld' , 2)
from dual;

--�ε����� ���ʿ��� ���������� ���� ������ - �� ���� �ȴ�.
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

-- ���� : �̸��� J�� A�� M���� �����ϴ� ������� �̸�, �̸��� ���ڼ��� ��ȸ�϶�.
--           �̸��� ù���ڴ� �빮��, �������� �ҹ��ڷ� ����Ѵ�.
select  initcap(last_name) ,length (last_name)
from employees
where last_name like 'J%' or
        last_name like 'A%' or
        last_name like 'M%';
        
--round function�� �ٷﺸ��
-- �Ķ���Ͱ� �ѹ��� �� / 2��° �Ķ���ʹ� �Ҽ��� 2��° �ڸ��� ��Ÿ����. �ݿø��� �ڸ��� ��Ÿ����.
select round(45.926, 2)
from dual;
-- 2��° �Ķ���� ��ġ���� ���� ó��
select trunc(45.926 , 2)
from dual;

--����� ������ ǥ���ϰ� �ʹ�. �ø�ó���ؼ� ����ó�� (�Ķ���� �ϳ��� �ְ� ����ص� �ȴ�)
select round(45.923, 0), round(45.923)
from dual;

-- ����ó���ؼ� ����ó��
select trunc(45.926, 0), trunc(45.923)
from dual;

--���� : ������� �̸�, ����, 15.5% �λ�� ����(New Salary,����), �λ��(Increase)�� ��ȸ�϶�.
select last_name, salary,
        round(salary * 1.155) "New Salary",
        round(salary * 1.155) - salary "Increase"
from employees;

--��¥�� �ٷ�� function. ���忡�� ���� ���ȴ�. 
--sysdate�� �Ķ���Ͱ� ����. ��� ��� ��¥�� ��Ÿ����.
select sysdate
from dual;

select sysdate + 1
from dual;

select sysdate - 1
from dual;

--�Ⱓ�� �˾Ƴ� �� �ִ�.
select sysdate - sysdate
from dual;

--�ټ� �Ⱓ�� �� �� �ִ�.
select last_name, sysdate - hire_date
from employees
where department_id = 90;

--�Ķ���ͷ� ��¥�� 2���� �޴´�.  �� ��¥ ������ �������� ��Ÿ���ش�.
select months_between('2023/12/31', '2022/12/31')
from dual;

--�ι�° �Ķ���͸�ŭ�� ���� ���� �����ش�.
select add_months('2023/01/18' , 3)
from dual;

--5 ����� / 1�� 18�� ���ķ� ù��° ������� ��Ÿ����. 
select next_day('2023/01/18', 5)
from dual;

select next_day('2023/01/18', 4)
from dual;

--���� ���� ���ڷε� ǥ���� �� �ִ�.
select next_day('2023/01/18', 'thursday')
from dual;

--������ ���ڷ�
select next_day('2023/01/18', 'thu')
from dual;

--Ư����¥�� ������ ���ϰ� �ʹ�.
select last_day('2023/01/18')
from dual;

--���� : 20�� �̻� ������ ������� �̸�, ù �������� ��ȸ�϶�.
--          ������ �ſ� ���Ͽ� �����Ѵ�.
select last_name, last_day(hire_date)
from employees
where months_between (sysdate, hire_date) >= 12 *20;

--pad function�̿�
-- ���� : ������� �̸�, ���� �׷����� ��ȸ�϶�.
--          �׷����� $1000 �� * �ϳ��� ǥ���Ѵ�. 
select last_name, salary, rpad(' ', salary / 1000 + 1 ,'*' )
from employees;
-- ' ' �����̽��� �ִ°��� ǥ���ϱ� ���� 1000 +1 ���ذ��̴� (1�� �����̽��� ��Ÿ��)

