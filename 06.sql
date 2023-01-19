--join : 테이블을 조인한다 = row들을 조인한다
-- 내 입맛에 맞는 테이블 하나 만드는 것이라고 생각하면 된다.

-- 테이블을 살펴보자.
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- erd를 살펴보자.!
-- PK : Primary Key  /   FK : Foreign Key  
-- Relationship이 있는 테이블끼리 join한다.
-- 점선 : 동네에는 부서가 있을수 있다. 라고 읽는다. = may
-- 실선 : 동네에는 부서가 있다. = must

--equi join의 종류

-- natural join
select department_id, department_name, location_id, city
from departments natural join locations;
-- departments 테이블과 locations의 공통 칼럼(location_id)을 조인한다.


-- using 내가 공통 칼럼중 고를 수 있다.
select department_id , department_name, location_id, city
from departments natural join locations
where department_id in(20, 50);

-- join ~ using : 공통이 되는 것들끼리
select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);

-- 과제 : 위에서 누락된 1인의 이름, 부서번호를 조회하라.
select last_name, department_id
from employees
where department_id is null;
-- 부서 테이블에 부서ID에 null값을 포함 시켜도 윗값은 안나온다  -> 왜냐? null 값은 true값을 내지않기 때문이다.

select employee_id, last_name, department_id, location_id
from employees natural join departments;
-- 29~31줄과 다른점은 39-40 줄은 employees와 departments의 공통 칼럼이 department_id와 manager_id이고,
-- 29-31 줄읜 using을 사용해서 department_id 칼럼을 골랐기 때문에 값이 다르다.

select locations.city, departments.department_name
from locations join departments 
using (location_id)
where location_id = 1400;

-- 위 예제에서 접두사로 대신 쓸 수 있다.
select l.city, d.department_name
from locations l  join departments d
using (location_id)
where location_id = 1400;

-- error -> 이유: using절에 접두사를 안붙이는 것으로 문법이 선택되어 있다.
select l.city, d.department_name
from locations l  join departments d
using (location_id)
where d.location_id = 1400;

-- 접두사를 붙이면 안되는 이유가 뭘까????????????????????????????????????????
select l.city, d.department_name, location_id
from locations l  join departments d
using (location_id)
where location_id = 1400;