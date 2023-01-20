--subquery
-- Abel의 salary보다 많은 사람을 알고 싶다. () subquery 사용
-- 서브 뭐리는 계산 과정에서 사용하는 것을 말한다. where절에서 쓸뿐이다. = inner 쿼리
select last_name, salary
from employees
where salary >  (select salary
                            from employees
                            where last_name = 'Abel') ;
                            
-- 서브쿼리는 여러개 사용할 수 있다.
select last_name, job_id, salary
from employees
where job_id = (select job_id
                            from employees
                            where last_name = 'Ernst')
and salary > (select salary
                        from employees
                        where last_name = 'Ernst');
                        
-- 과제 : Kochhar 에게 보고하는 사원들의 이름, 월급을 조회하라.
select last_name ,salary
from employees
where manager_id = (select manager_id
                                    from employees
                                    where last_name = 'Kochhar');

-- 과제 : IT부서에서 일하는 사원들의 부서번호, 이름, 직업을 조회하라.
select department_id, last_name, job_id
from employees
where department_id = (select department_id
                                        from departments
                                          where department_name = 'IT');
                                          
-- 과제 : Abel 과 같은 부서에서 일하는 동료들의 이름, 입사일을 조회하라.
--           이름 오름차순 정렬한다
select last_name, hire_date
from employees
where department_id = (select department_id
                                        from employees
                                        where last_name = 'Abel')
and employee_id <> (select employee_id
                                    from employees
                                    where last_name = 'Abel')
order by last_name;

--강사님 답안
select last_name, hire_date
from employees
where department_id = (select department_id
                                        from employees
                                        where last_name = 'Abel')
and last_name <> 'Abel'
order by last_name;

--에러가 발생하는 코드를 작성해보자.
-- 서브쿼리에 리턴되는 값이 2개라서 오류난다.
-- 서브쿼리 사용할 때 주의할 점 : 서브쿼리에 리턴되는 row의 갯수!
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
                                    
-- 과제 : 회사 평균 월급 이상 버는 사원들의 사번, 이름 , 월급을 조회하라
--             월급 내림차순 정렬한다.
select employee_id , last_name, salary
from employees
where salary >= (select avg(salary)
                            from employees)
order by salary desc;

--오류나는 예제이다.!!
select employee_id, last_name
from employees
where salary = (select min(salary)
                            from employees
                            group by department_id);

-- 위 예제를 실행되도록 고쳐보아라 // = -> in 으로 고쳐준다.
-- 서브 쿼리 값이 n개 이상 나올때 in(집합)을 사용해주자.
select employee_id, last_name
from employees
where salary in (select min(salary)
                            from employees
                            group by department_id);
                            
-- 과제 :이름에 u가 포함된 사원이 있는 부서에서 일하는 사원들의 사번, 이름을 조회하라.
select employee_id , last_name
from employees
where department_id in ( select department_id
                                            from employees
                                            where last_name like '%u%');

-- 과제 : 1700번 지역에 위치한 부서에서 일하는 사원들의 이름, 직업, 부서번호를 조회하라.
select last_name, job_id, department_id
from employees
where department_id in (select department_id
                                        from departments
                                        where location_id = '1700')
order by department_id;

--새로운 연산자
--서브 쿼리 리턴값이 n개일때 사용하는 연산자

-- =any   :  기존에 배웠던 i과 뜻이 같다. or
select employee_id, last_name
from employees
where salary =any (select min(salary)
                                from departments
                                where location_id = 1700);

-- any는 다른 연산자와도 결합하여 사용할 수 있다.
select employee_id, last_name, job_id, salary
from employees
where salary <any (select salary
                                from employees
                                where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';
--위 예제에서 서브쿼리 값은 5개이다. -> 9000 미만이다로 통합할 수 있다.

--any에 대응하는 all이 있다. 
-- all = and / 4200 미만인 것을 찾는것이다.
select employee_id, last_name, job_id, salary
from employees
where salary <all (select salary
                                from employees
                                where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';
--any는 서브쿼리의 하나라도 true이면 되고, all은 몽땅 다 true여야한다.

-- 과제 : 60번 부서의 일부 사원보다 월급이 많은 사원들의 이름을 조회하라.
select last_name
from employees
where salary >any (select salary
                                from employees
                                where department_id = '60');

-- 과제 : 회사 평균 월급보다, 그리고 모든 프로그래머보다 월급을 더 받는
--           사원들의 이름, 직업, 월급을 조회하라.

--첫번째 서브쿼리는 값이 1개 이므로 >만 사용해줘도 된다. 
--두번째 서브 쿼리는 값이 여러개 다 만족해야하므로 >all을 사용해준다.
select last_name, job_id, salary
from employees
where salary > (select avg(salary)
                         from employees)
and salary >all (select salary
                            from employees
                            where job_id = '%PROG');

-- 서브쿼리에서 리턴되는 값이 없을 경우 = row가 없을 때
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

-- 서브 쿼리에 null값이 포함되어 있을 때 -> 문제없다.
select last_name
from employees
where employee_id in (select manager_id
                                        from employees);

--not in // 결과 값으로 King이 나와야하지만 나오지 않는다.  왜??
select last_name
from employees
where employee_id not in (select manager_id
                                            from employees);
                        
-- = any -> in
                                            
-- 과제 : 위 문장을 all 연산자로 refactoring 하라.  ->  <>all 
select last_name
from employees
where employee_id <>all (select manager_id
                                            from employees);

select count(*)
from departments;

--직원들이 있는 부서를 알아보자.
--exists
--from departments d 90번 부서를 서브쿼리에 넣으면 리턴되는 row가 있을 것이다.
select count(*)
from departments d
where exists (select *
                        from employees e
                        where e.department_id = d.department_id);
                                     
-- 과제 : 직업을 바꾼적이 있는 사원들의 사번, 이름, 직업을 조회하라.
select employee_id, last_name, job_id
from employees e
where exists (select *
                        from job_history j
                        where e.employee_id = j.employee_id);
                        
