--join : ���̺��� �����Ѵ� = row���� �����Ѵ�
-- �� �Ը��� �´� ���̺� �ϳ� ����� ���̶�� �����ϸ� �ȴ�.

-- ���̺��� ���캸��.
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- erd�� ���캸��.!
-- PK : Primary Key  /   FK : Foreign Key  
-- Relationship�� �ִ� ���̺��� join�Ѵ�.
-- ���� : ���׿��� �μ��� ������ �ִ�. ��� �д´�. = may
-- �Ǽ� : ���׿��� �μ��� �ִ�. = must

--equi join�� ����

-- natural join
select department_id, department_name, location_id, city
from departments natural join locations;
-- departments ���̺�� locations�� ���� Į��(location_id)�� �����Ѵ�.


-- using ���� ���� Į���� �� �� �ִ�.
select department_id , department_name, location_id, city
from departments natural join locations
where department_id in(20, 50);

-- join ~ using : ������ �Ǵ� �͵鳢��
select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);

-- ���� : ������ ������ 1���� �̸�, �μ���ȣ�� ��ȸ�϶�.
select last_name, department_id
from employees
where department_id is null;
-- �μ� ���̺� �μ�ID�� null���� ���� ���ѵ� ������ �ȳ��´�  -> �ֳ�? null ���� true���� �����ʱ� �����̴�.

select employee_id, last_name, department_id, location_id
from employees natural join departments;
-- 29~31�ٰ� �ٸ����� 39-40 ���� employees�� departments�� ���� Į���� department_id�� manager_id�̰�,
-- 29-31 ���� using�� ����ؼ� department_id Į���� ����� ������ ���� �ٸ���.

select locations.city, departments.department_name
from locations join departments 
using (location_id)
where location_id = 1400;

-- �� �������� ���λ�� ��� �� �� �ִ�.
select l.city, d.department_name
from locations l  join departments d
using (location_id)
where location_id = 1400;

-- error -> ����: using���� ���λ縦 �Ⱥ��̴� ������ ������ ���õǾ� �ִ�.
select l.city, d.department_name
from locations l  join departments d
using (location_id)
where d.location_id = 1400;

-- ���λ縦 ���̸� �ȵǴ� ������ ����????????????????????????????????????????
select l.city, d.department_name, location_id
from locations l  join departments d
using (location_id)
where location_id = 1400;