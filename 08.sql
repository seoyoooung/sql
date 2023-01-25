-- set -> 중복된 값이 들어가지 않는다.(중복된 원소가 없다.)  Key가 없다.
-- list -> 중복된 값이 들어간다. (중복된 원소가 있다.)  Key가 있다

--집합연산자에 관한 것을 배워보자.

--합집합
-- 2개의 셋을 합치고 싶다. : union
--union하는 셋의 조건은 칼럼의 갯수가 같아야한다.  각 칼럼의 데이터 타입이 같아야한다.
-- 첫번째 셋의 칼럼명을 따라간다. 
-- union : 중복값 제거하였다.
select employee_id, job_id 
from employees
union
select employee_id , job_id
from job_history;

-- union all : 중복값 제거를 하지않는다.
select employee_id, job_id 
from employees
union all
select employee_id , job_id
from job_history
order by employee_id;

-- 과제 : 과거 직업을 현재 갖고 있는 사원들의 사번, 이름, 직업을 조회하라.
-- 4가지 방법 다 가능하다.
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
-- 기술적으로는 문제가 없으나 업무적으로는 문제가 있다.
select location_id , department_name
from departments
union
select location_id, state_province
from locations;

-- 과제 : 위 문장의 service 관점에서 고쳐라.
--           union을 사용한다.
select location_id, department_name , null state
from departments
union
select location_id, null,  state_province
from locations;

--컬럼 갯수는 맞춰야한다.
select employee_id, job_id, salary
from employees
union
select employee_id, job_id , 0
from job_history
order by salary;

