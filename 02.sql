-- where

-- 내가 고른 row만 빼오고 싶다. where 절에 true가 되는 것만 조회해준다.
-- where에서는 row를 골라준다. 자연스럽게 boolean타입
select employee_id, last_name, department_id
from employees
where department_id = 50;

-- 과제 : 176번 사원의 사번, 이름, 부서번호를 조회하라.
select employee_id, last_name, department_id
from employees
where employee_id = 176;

select employee_id, last_name, department_id
from employees
where last_name = 'Whalen'; -- 데이터는 대소문자 구분한다.

--date 타입 입력 (문법이 따로 없다.) char 타입으로 변환해서 사용한다.
-- 단지 cilent에서 지정한 날짜 형식으로 써줘야한다.
select employee_id, last_name, hire_date
from employees
where hire_date = '2008/02/06';

-- <= 이하 , >=이상,  != 다르다
select last_name, salary
from employees
where salary <= 3000;

-- 과제 : 월 $12,000 이상 버는 사원들의 이름, 월급을 조회하라.
select last_name, salary
from employees
where salary >= 12000;

select last_name, job_id
from employees
where job_id != 'IT_PROG';

-- between 이상 and 이하 (between = 실선의 형태)
select last_name, salary
from employees
where salary between 2500 and 3500;

select last_name
from employees
where last_name between 'King' and 'Smith';

-- 과제 : King 사원의 first_name, last_name, 직업,월급을 조회하라.
select first_name, last_name, job_id, salary
from employees
where last_name = 'King';

select last_name, hire_date
from employees
where hire_date between '2002/01/01' and '2002/12/31';

--in () : 점선 형태 , 괄호안에 값 하나라도 true값이면 조회된다. 
select employee_id, last_name, manager_id
from employees
where manager_id in (100, 101, 201);

--in 연산자는 논리연산자로 바꿀수 있다. (자바 and or)
select employee_id, last_name, manager_id
from employees
where manager_id = 100 or 
        manager_id = 101 or
        manager_id = 201;
     
select employee_id, last_name
from employees
where last_name in ('Hartstein' , 'Vargars');

--날짜
select last_name, hire_date
from employees
where hire_date in ('2003/06/17' , '2005/09/21');

-- like 연산자 / 같다  + 다르다(%) 
-- like 연산자는 검색 기능에서 사용한다.
--like 연산자는 타입을 char로 바꾸고 사용한다.
-- % 는 임의의 n개 이상의 문자를 의미한다.
select last_name
from employees
where last_name like 'S%';
        
select last_name
from employees
where last_name like '%r';

--과제 : 이름에 s가 포함된 사원들의 이름을 조회하라.
select last_name
from employees
where last_name like '%s%';

--과제 : 2005년에 입사한 사원들의 이름, 입사일을 조회하라.
select last_name, hire_date
from employees
where hire_date like '2005%';

--임의의 한글자 : _
select last_name
from employees
where last_name like 'K___';

--과제 : 이름의 두번째 글자가 o인 사원의 이름을 조회하라.
select last_name
from employees
where last_name like '_o%';

-- 데이터 분석해보자.
select job_id
from employees;

-- 와일드카드가 중복되는데 언더바로 구분하고 싶으면 escape + _ 사용 후 escape 선언하면 된다.
select last_name, job_id
from employees
where job_id like 'I_\_%' escape '\';

select last_name, job_id
from employees
where job_id like 'I_[_%' escape '[';

--과제 : 직업에 _R이 포함된 사원들의 이름, 직업을 조회하라.
select last_name, job_id
from employees
where job_id like '%\_R%' escape '\';

select employee_id, last_name, manager_id
from employees;

--회장을 찾고싶어.  true에 적합한게 없어서 빈 값이 조회되는 것이 맞다.
-- where 절은 true or false를 골라낸다.
select last_name, manager_id 
from employees
where manager_id = null;

--field value가 null인 값을 찾고싶다. = is null 연산자
select last_name, manager_id 
from employees
where manager_id is null;

-- and 논리연산자 : 둘 다 true이면 조회된다.
select last_name, job_id, salary
from employees
where salary >= 5000 and job_id like '%IT%';

--or 논리연산자 : 둘 중 하나라도 true라면 조회된다.
select last_name, job_id, salary
from employees
where salary >= 5000 or job_id like '%IT%';

-- 과제 : 월급이 $ 5000 이상 $ 12000이하이다. 그리고,
--           20번이나 50번 부서에서 일한다.
--           위 사원들의 이름, 월급,부서번호를 조회하라.
-- ★ sql에서 배운 것을 사용해서 예제를 푸세요~!
select last_name, salary, department_id
from employees
where (salary between 5000 and 12000) and (department_id in (20 , 50));

-- 과제 : 이름에 a와 e가 포함된 사원들의 이름을 조회하라.
select last_name
from employees
where last_name like '%a%' and 
        last_name like '%e%';  

--in 연산자 연습 : 여집합을 구해보자(집합의 반대) = not
select last_name, job_id
from employees
where job_id not in ('IT_PROG' , 'SA_REP');

select last_name, salary
from employees
where salary not between 1000 and 15000;

select last_name, job_id
from employees
where job_id not like '%IT%';

select last_name, job_id
from employees
where commission_pct is not null;

select last_name, salary
from employees
where not (manager_id is null and salary >= 20000);

--과제 : 직업이 영업이다. 그리고, 월급이 $2500, $3500가 아니다.
--          위 사원들의 이름, 직업, 월급을 조회하라.
select last_name, job_id, salary
from employees
where job_id like 'SA_R%' and  
       salary not in (2500, 3500);   -- where job_id like 'SA%' and salary not in (2500, 3500);


--order by : 맨 마지막에 사용된다 . 내가 order by 전에 조회된 값을 가지고 분류한다. 기본이 오름차순이다.
-- 오름차순이 기본 값이다.
select last_name, department_id
from employees
order by department_id; 

-- 내림차순
select last_name, department_id
from employees
order by department_id desc; 
       
select last_name, department_id
from employees
order by 2; 

--별명을 붙여줬다면 order by 절에서도 사용가능하다.
select last_name, department_id dept_id
from employees
order by dept_id; 

 --지금까지의 모든 문법을 다 써보자.
 select last_name, hire_date
 from employees
 where department_id = 100
 order by hire_date;
 
 select last_name, department_id, salary
 from employees
 where department_id > 80
 order by department_id asc, salary desc;
 