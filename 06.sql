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

select l.city, d.department_name, location_id
from locations l  join departments d
using (location_id)
where location_id = 1400;

-- using 절에는 접두사를 안붙이고 그 외에는 접두사를 붙여야 값이 출력된다.
select e.last_name, d.department_name
from employees e join departments d
using (department_id)
where d.manager_id = 100;


-- on = 조건문
select e.employee_id , e.last_name, e.department_id,
        d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d. department_id);

select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

-- 과제 : 위 query를 using으로 refactoring하라.
select employee_id, city , department_name
from employees e join departments d
using (department_id)
join locations l
using (location_id);

-- 149번을 상사로 모시고 있는 애들을 골라낸 것
select e.employee_id, e.last_name, e.department_id,
        d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
where e.manager_id = 149;

-- 과제 : Toronto 에 위치한 부서에서 일하는 사원들의
--          이름, 직업, 부서번호, 부서명, 도시를 조회하라.
select e.last_name , e.job_id, e.department_id, 
           d.department_name, l.city
from employees e join departments d
on (e.department_id = d.department_id)
join locations l
on d.location_id = l.location_id 
where l.city = 'Toronto';

-- 위 예제에서 on : 조건문 1, where  : 조건문 2 를 나타나기 때문에 아래처럼 on~ and~로 변경할 수 있다.
select e.last_name , e.job_id, e.department_id, 
           d.department_name, l.city
from employees e join departments d
on (e.department_id = d.department_id)
join locations l
on d.location_id = l.location_id 
and l.city = 'Toronto';

-- non-equi join : 연산자가 아닌 다른 조건으로 join
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

--self join
--from 절에서 별명을 붙여줬다.
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

-- on절에서 접두사 생략하면 오류난다.
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on manager_id = employee_id;

-- 과제 : 같은 부서에서 일하는 사원들의 부서번호, 이름 , 동료명을 조회하라.
--강사님 답안
select e.department_id, e.last_name employee, c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id <> c.employee_id
order by 1, 2, 3;

-- 과제 : Davies보다 후에 입사한 사원들의 이름, 입사일을 조회하라.
select e.last_name, e.hire_date
from employees e join employees d
on d.last_name = 'Davies'
and e.hire_date > d.hire_date
order by e.hire_date;

-- 과제 : 매니저보다 먼저 입사한 사원들의 이름, 입사일, 매니저명, 매니저 입사일을 조회하라.
select e.last_name, e.hire_date , m.last_name, m.hire_date
from employees e join employees m
on e.manager_id = m.employee_id
and e.hire_date < m.hire_date;

--inner join : 조인된 것들만 내 테이블에 채우고 있다.
select e.last_name, e.department_id , d.department_name
from employees e join departments d
on e.department_id = d.department_id;

-- outer join (left)
select e.last_name, e.department_id , d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id;

--right
select e.last_name, e.department_id , d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;

-- full : 양쪽 다 포함되지 않은 것을 합치는것 
select e.last_name, e.department_id , d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id;

-- 과제 : 사원들의 이름, 사번, 매니저명, 매니저의 사번을 조회하라.
--          King  회장도 테이블에 포함하라.
select w.last_name, w.employee_id, m.last_name, m.employee_id
from employees w left outer join employees m
on w.manager_id = m.employee_id
order by 2;

select d.department_id, d.department_name, d.location_id , l.city
from departments d, locations l
where d.location_id = l.location_id;

select d.department_id, d.department_name, d.location_id , l.city
from departments d, locations l
where d.location_id = l.location_id   
            and d.department_id in (20 , 50);

-- 3개의 테이블을 조인해보자.
select e.last_name, d.department_name, l.city
from employees e, departments d , locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;

select e.last_name, e.salary, e.job_id
from employees e, jobs j
where e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

-- null 이 있을 곳에 (+) 해준다.
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;

-- null(+) 을 오른쪽에 두면 right outer join
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id= d.department_id(+) ;

--self join
select worker.last_name || 'works for ' || manager.last_name
from employees worker, employees manager
where worker.manager_id = manager.employee_id;
