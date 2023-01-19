-- group function
-- group function�� call �Ǵ� Ƚ���� �׷��� ������ ����Ѵ�

--��� ���ϱ� : avg
select avg(salary), max(salary), min(salary), sum(salary)
from employees;

--��¥�� ���ؼ��� min�� max ��밡���ϴ�. 
--min = ���� ������ �Ի��� , max = ���� �ֱ� �Ի���
select min(hire_date), max(hire_date)
from employees;

--���� : �ְ� ���ް� �ּ� ������ ������ ��ȸ�϶�.
select max(salary) - min(salary)
from employees;

--count : row�� ������ ����.
--count�� Ư¡ : ��� * �÷��̶�� �� �� �ִ�.
select count(*)
from employees;

--���� : 70�� �μ����� ������� ��ȸ�϶�.
select count (*)
from employees
where department_id = 70;

-- count �ȿ� �ʵ������ ����غ���. (18-19 �ٰ� ���� ����� ���´�.)
select count(employee_id)
from employees;

select count(manager_id)
from employees;

-- �׷� �Լ��� Ư¡�� null ���� �����Ѵ�.
-- count �ȿ� �ʵ������ ����ϰ� ������ primary key�� ������ �ʵ� ������ ���� �����ϴ�.

--����� ���غ���. ����������� Ŀ�̼� ��հ�
select avg(commission_pct)
from employees;

-- ���� : ������ ��� Ŀ�̼����� ��ȸ�϶�.
-- null ���� ���ش� = nvl function
select avg(nvl(commission_pct, 0))
from employees;

-- �ߺ��� �Ű澲�� �ʴ´�. salary �տ� all�� �����Ǿ� �ִ�. all �� ��� �⺻ function�� �� �ִ�.
select avg(salary)
from employees;

--distinct = �ߺ��� ����.
select avg(distinct salary)
from employees;

--���� : ������ ��ġ�� �μ� ������ ��ȸ�϶�.
-- �μ� -> department , ���� -> employee �����ؼ� Ǯ��. 
select count(distinct department_id)
from employees;

-- ���� : �Ŵ��� ���� ��ȸ�϶�.
select count(distinct manager_id)
from employees;

-- select ���� �׷��Լ��� ������ �ϴϱ� ������ ����.
-- �������� ������̶� ���Ұ�. 
-- group by �� ����Ͽ�  department_id�� ���� �ֵ鳢�� ���δ�.
-- �ڡ� select ���� Į������ �����ϸ� group by�� ����ؾ��Ѵ�.  = group by expression�� select ���� ��Ÿ�����Ѵ�.
select department_id, count(employee_id)
from employees
group by department_id
order by department_id; -- ���� �����ϴϱ� ����������.
-- �׷��� call Ƚ���� �׷��� ������ �����ϴ�.

select employee_id
from employees
where department_id = 30;

select department_id, job_id, count(employee_id)
from employees
group by department_id , job_id
order by department_id;

-- ���� : ������ ������� ��ȸ�϶�.
select job_id , count (employee_id)
from employees
group by job_id;

-- ���� ���� ��������� ��
select job_id , count (*)
from employees
group by job_id;

-- �Ϻ� group�� ��󳻰� �ʹ�.
-- having : group by�� ������ �ɾ��ش�.
select department_id, max(salary)
from employees
group by department_id
having department_id > 50;

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;

select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000; -- ������ �������δ� ����� �� ����.

-- row�� ��󳻰� (where��)  �� ����� group by
-- 94~97 �ٰ� ���� ��ɹ��̴�. (having ��)
select department_id, max(salary)
from employees
where department_id > 50
group by department_id;

-- where���� single function�� ����� �� �ִ�.
--  �������� group function�� ����ϰ� ������ ,having �� ���
-- �Ʒ��� ��������.
select department_id, max(salary)
from employees
where max(salary) > 10000
group by department_id;


-- having ������ group function ���/ single function����ϰ� ������ where �� ���
-- order by���� ���� ��� ����

select job_id, sum(salary) payroll
from employees
where job_id not like '%REP%'
group by job_id
having sum(salary) > 13000
order by payroll;


-- ���� : �Ŵ��� ID, �Ŵ��� �� ���� ������ �� �ּ� ������ ��ȸ�϶�.
--          �ּ� ������ $6,000 �ʰ������Ѵ�.
select manager_id, min(salary) 
from employees
group by manager_id
having min(salary) > 6000
order by min(salary); 
-- �Ŵ����� -> �Ŵ��� ���� null�� �ִ� ���� ���ƴ�. -> where manager_id is not null

--����� ��� / �� ��Ȱ� ��� ���� �ٸ���
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) > 6000
order by 2 desc;

-- �׷� �Լ��� n�� ����Ƿ��� n�� �ݺ��Ǿ���Ѵ�.
-- ������ �Ķ���ͷ� ���� �׷��� n�� �־�̴�.
-- �ð������� ����  �Ķ���ͷ� ���� �׷��� n�� �־ > �׷��Լ��� n�� ���� >  n�� �ݺ�
-- ���������� �׷��Լ��� 2�ܰ踸 ����� �� �ִ� . �Ʒ� ���� ó�� ! max �ѿ� �߰��ϸ� ���� �߻��Ѵ�.
select max(avg(salary))
from employees
group by department_id;

select department_id, round(avg(salary))
from employees
group by department_id;

-- ���� �߻� / group by ���� group ��ɰ� single  ����� ���� �� �� ����.
select department_id, round(avg(salary))
from employees;

-- 2�������� �����Ͽ� �����غ���. -> �ڹ� �� ����������,,
-- ���� : 2001��, 2002��,  2003�⵵�� �Ի��� ���� ��ȸ�϶�.

-- ����� ���
select sum (decode(to_char(hire_date, 'YYYY'), '2001' , 1, 0)) "2001",
            sum (decode(to_char(hire_date, 'YYYY'), '2002' , 1, 0)) "2002",
            sum (decode(to_char(hire_date, 'YYYY'), '2003' , 1, 0)) "2003"
from employees;

-- �л��� ��� (1)
select to_char(hire_date, 'YYYY') hire_year  , count(*) emp_cnt
from employees
where to_char(hire_date, 'YYYY') in (2001, 2002, 2003)
group by to_char(hire_date, 'YYYY')
order by hire_year;

--�л��� ���(2)
select count(case when hire_date like '2001%' then 1 else null end) "2001" ,
            count(case when hire_date like '2002%' then 1 else null end) "2002" ,
            count(case when hire_date like '2003%' then 1 else null end) " 2003"
from employees;

-- ���� : ������ , �μ��� �������� ��ȸ�϶�.
--           �μ��� 20, 50, 80 �̴�.
--           2�������� �����ض�. �� �࿡�� ����, �� �࿡�� �μ��� �־���Ѵ�.
--            ���� ������ group by�� ����ϸ� �ȴ�.
select job_id, sum(decode (department_id , 20, salary )) "20",
                        sum(decode (department_id, 50, salary ))  "50",
                        sum(decode (department_id, 80, salary )) "100"
from employees
group by job_id;

