-- set -> �ߺ��� ���� ���� �ʴ´�.(�ߺ��� ���Ұ� ����.)  Key�� ����.
-- list -> �ߺ��� ���� ����. (�ߺ��� ���Ұ� �ִ�.)  Key�� �ִ�

--���տ����ڿ� ���� ���� �������.

--������
-- 2���� ���� ��ġ�� �ʹ�. : union
--union�ϴ� ���� ������ Į���� ������ ���ƾ��Ѵ�.  �� Į���� ������ Ÿ���� ���ƾ��Ѵ�.
-- ù��° ���� Į������ ���󰣴�. 
-- union : �ߺ��� �����Ͽ���.
select employee_id, job_id 
from employees
union
select employee_id , job_id
from job_history;

-- union all : �ߺ��� ���Ÿ� �����ʴ´�.
select employee_id, job_id 
from employees
union all
select employee_id , job_id
from job_history
order by employee_id;

-- ���� : ���� ������ ���� ���� �ִ� ������� ���, �̸�, ������ ��ȸ�϶�.
-- 4���� ��� �� �����ϴ�.
select employee_id, last_name, job_id
from employees e
where job_id in (select job_id
                            from job_history j
                            where e.employee_id = j.employee_id);
                            
select employee_id, last_name , job_id
from employees e
where job_id =any ( select job_id
                                from job_history j
                                where e.employee_id = j.employee_id);
                                
select employee_id , last_name, job_id
from employees e
where exists (select *
                        from job_history j
                        where e.employee_id = j.employee_id
                        and e.job_id = j.job_id);
                        
select e.employee_id, e.last_name, e.job_id
from employees e , job_history j
where e.employee_id = j.employee_id
and e.job_id = j.job_id;
-----------------------------------------
-- ��������δ� ������ ������ ���������δ� ������ �ִ�.
select location_id , department_name
from departments
union
select location_id, state_province
from locations;

-- ���� : �� ������ service �������� ���Ķ�.
--           union�� ����Ѵ�.
select location_id, department_name , null state
from departments
union
select location_id, null,  state_province
from locations;

--�÷� ������ ������Ѵ�.
select employee_id, job_id, salary
from employees
union
select employee_id, job_id , 0
from job_history
order by salary;

