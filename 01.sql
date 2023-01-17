-- ��ü �����͸� ����ʹ� . * ����Ѵ�.
select  * 
from departments;

select department_id, location_id
from departments;

select location_id, department_id
from departments;

--�ڹپ��� �ۼ��� ���� �ƴϰ� �׳� command�̴�.
desc departments

-- ������ �����͸� ����� �ʹ�. -> expression ���   ex) salary + 300 = ���޿� 300�� ���ߴ�.
select last_name, salary, salary + 300 
from employees;

-- ���� : ������� ����, ������ ��ȸ�϶�. /����
select  salary , salary  * 12
from employees;

select last_name, salary, 12 * salary + 100
from employees;

-- ���� �켱 ������ �ٲٰ� �ʹ�.
select last_name, salary, 12 *( salary + 100) 
from employees;

select last_name, job_id, commission_pct
from employees;

select last_name, job_id,  12 * salary + (12 * salary * commission_pct)
from employees;

--column �� �� ����� �����ϰ�ʹ�. as�� ����ϸ� �ȴ�. as�� ���������ϴ�. " " �� ��밡���ϴ�.
select  last_name as name, commission_pct comm
from employees;

select last_name "Name", salary * 12 "Annual Salary"
from employees;

--���� : ������� ���, �̸�, ����, �Ի��� (STARTDATE)�� ��ȸ�϶�. /����
select employee_id ID , last_name NAME , job_id JOB , hire_date STARTDATE
from employees;

--���� : ������� ��� (Emp #), �̸� (Name), ����(Job) , �Ի��� (Hire Date)�� ��ȸ�϶�.
select employee_id "Emp #" , last_name "Name" , job_id "JOB" , hire_date  "Hire Date"
from employees;

--�÷��� �ϳ��� ����� �ʹ�. ���̱� ������ || ��� (���ϰ��� charŸ���̴�.)
select last_name ||  job_id
from employees;

-- expression�� �����Ӹ� �ƴ϶� ����� ������ �ִ�.
-- 'is' = ��� , job_id = ����
select last_name ||  ' is ' || job_id
from employees;

select last_name || ' is ' || job_id employee
from employees;

--null -> empty string ���
select last_name || null
from employees;

-- commission �� vachar2�� ��ȯ���״�.
select last_name || commission_pct
from employees;

--salary�� char�� ��ȯ�Ǿ���.
select last_name || salary
from employees;

select last_name || hire_date
from employees;

select last_name || (salary * 12)
from employees;

-- ���� : ������� '�̸�, ����'(Emp and Title)�� ��ȸ�϶�.
select last_name || ', ' ||  job_id "Emp and Title"
from employees;

