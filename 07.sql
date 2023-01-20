--subquery
-- Abel�� salary���� ���� ����� �˰� �ʹ�. () subquery ���
-- ���� ������ ��� �������� ����ϴ� ���� ���Ѵ�. where������ �����̴�. = inner ����
select last_name, salary
from employees
where salary >  (select salary
                            from employees
                            where last_name = 'Abel') ;
                            
-- ���������� ������ ����� �� �ִ�.
select last_name, job_id, salary
from employees
where job_id = (select job_id
                            from employees
                            where last_name = 'Ernst')
and salary > (select salary
                        from employees
                        where last_name = 'Ernst');
                        
-- ���� : Kochhar ���� �����ϴ� ������� �̸�, ������ ��ȸ�϶�.
select last_name ,salary
from employees
where manager_id = (select manager_id
                                    from employees
                                    where last_name = 'Kochhar');

-- ���� : IT�μ����� ���ϴ� ������� �μ���ȣ, �̸�, ������ ��ȸ�϶�.
select department_id, last_name, job_id
from employees
where department_id = (select department_id
                                        from departments
                                          where department_name = 'IT');
                                          
-- ���� : Abel �� ���� �μ����� ���ϴ� ������� �̸�, �Ի����� ��ȸ�϶�.
--           �̸� �������� �����Ѵ�
select last_name, hire_date
from employees
where department_id = (select department_id
                                        from employees
                                        where last_name = 'Abel')
and employee_id <> (select employee_id
                                    from employees
                                    where last_name = 'Abel')
order by last_name;

--����� ���
select last_name, hire_date
from employees
where department_id = (select department_id
                                        from employees
                                        where last_name = 'Abel')
and last_name <> 'Abel'
order by last_name;

--������ �߻��ϴ� �ڵ带 �ۼ��غ���.
-- ���������� ���ϵǴ� ���� 2���� ��������.
-- �������� ����� �� ������ �� : ���������� ���ϵǴ� row�� ����!
select last_name, salary
from employees
where salary > (select salary
                            from employees
                                where last_name = 'King');
                                
select last_name, job_id, salary
from employees
where salary = (select min(salary)
                            from employees);

select department_id , min(salary)
from employees
group by department_id
having min(salary) > (select min(salary)
                                    from employees
                                    where department_id = 50);
                                    
-- ���� : ȸ�� ��� ���� �̻� ���� ������� ���, �̸� , ������ ��ȸ�϶�
--             ���� �������� �����Ѵ�.
select employee_id , last_name, salary
from employees
where salary >= (select avg(salary)
                            from employees)
order by salary desc;

--�������� �����̴�.!!
select employee_id, last_name
from employees
where salary = (select min(salary)
                            from employees
                            group by department_id);

-- �� ������ ����ǵ��� ���ĺ��ƶ� // = -> in ���� �����ش�.
-- ���� ���� ���� n�� �̻� ���ö� in(����)�� ���������.
select employee_id, last_name
from employees
where salary in (select min(salary)
                            from employees
                            group by department_id);
                            
-- ���� :�̸��� u�� ���Ե� ����� �ִ� �μ����� ���ϴ� ������� ���, �̸��� ��ȸ�϶�.
select employee_id , last_name
from employees
where department_id in ( select department_id
                                            from employees
                                            where last_name like '%u%');

-- ���� : 1700�� ������ ��ġ�� �μ����� ���ϴ� ������� �̸�, ����, �μ���ȣ�� ��ȸ�϶�.
select last_name, job_id, department_id
from employees
where department_id in (select department_id
                                        from departments
                                        where location_id = '1700')
order by department_id;

--���ο� ������
--���� ���� ���ϰ��� n���϶� ����ϴ� ������

-- =any   :  ������ ����� i�� ���� ����. or
select employee_id, last_name
from employees
where salary =any (select min(salary)
                                from departments
                                where location_id = 1700);

-- any�� �ٸ� �����ڿ͵� �����Ͽ� ����� �� �ִ�.
select employee_id, last_name, job_id, salary
from employees
where salary <any (select salary
                                from employees
                                where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';
--�� �������� �������� ���� 5���̴�. -> 9000 �̸��̴ٷ� ������ �� �ִ�.

--any�� �����ϴ� all�� �ִ�. 
-- all = and / 4200 �̸��� ���� ã�°��̴�.
select employee_id, last_name, job_id, salary
from employees
where salary <all (select salary
                                from employees
                                where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';
--any�� ���������� �ϳ��� true�̸� �ǰ�, all�� ���� �� true�����Ѵ�.

-- ���� : 60�� �μ��� �Ϻ� ������� ������ ���� ������� �̸��� ��ȸ�϶�.
select last_name
from employees
where salary >any (select salary
                                from employees
                                where department_id = '60');

-- ���� : ȸ�� ��� ���޺���, �׸��� ��� ���α׷��Ӻ��� ������ �� �޴�
--           ������� �̸�, ����, ������ ��ȸ�϶�.

--ù��° ���������� ���� 1�� �̹Ƿ� >�� ������൵ �ȴ�. 
--�ι�° ���� ������ ���� ������ �� �����ؾ��ϹǷ� >all�� ������ش�.
select last_name, job_id, salary
from employees
where salary > (select avg(salary)
                         from employees)
and salary >all (select salary
                            from employees
                            where job_id = '%PROG');

-- ������������ ���ϵǴ� ���� ���� ��� = row�� ���� ��
select last_name
from employees
where salary = (select salary
                            from employees
                            where employee_id = 1);
                            
select last_name
from employees
where salary in(select salary
                            from employees
                            where job_id = 'IT');

-- ���� ������ null���� ���ԵǾ� ���� �� -> ��������.
select last_name
from employees
where employee_id in (select manager_id
                                        from employees);

--not in // ��� ������ King�� ���;������� ������ �ʴ´�.  ��??
select last_name
from employees
where employee_id not in (select manager_id
                                            from employees);
                        
-- = any -> in
                                            
-- ���� : �� ������ all �����ڷ� refactoring �϶�.  ->  <>all 
select last_name
from employees
where employee_id <>all (select manager_id
                                            from employees);

select count(*)
from departments;

--�������� �ִ� �μ��� �˾ƺ���.
--exists
--from departments d 90�� �μ��� ���������� ������ ���ϵǴ� row�� ���� ���̴�.
select count(*)
from departments d
where exists (select *
                        from employees e
                        where e.department_id = d.department_id);
                                     
-- ���� : ������ �ٲ����� �ִ� ������� ���, �̸�, ������ ��ȸ�϶�.
select employee_id, last_name, job_id
from employees e
where exists (select *
                        from job_history j
                        where e.employee_id = j.employee_id);
                        
