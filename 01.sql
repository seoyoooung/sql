-- 전체 데이터를 보고싶다 . * 사용한다.
select  * 
from departments;

select department_id, location_id
from departments;

select location_id, department_id
from departments;

--자바언어로 작성된 것이 아니고 그냥 command이다.
desc departments

-- 나만의 데이터를 만들고 싶다. -> expression 사용   ex) salary + 300 = 월급에 300을 더했다.
select last_name, salary, salary + 300 
from employees;

-- 과제 : 사원들의 월급, 연봉을 조회하라. /성공
select  salary , salary  * 12
from employees;

select last_name, salary, 12 * salary + 100
from employees;

-- 연산 우선 순위를 바꾸고 싶다.
select last_name, salary, 12 *( salary + 100) 
from employees;

select last_name, job_id, commission_pct
from employees;

select last_name, job_id,  12 * salary + (12 * salary * commission_pct)
from employees;

--column 명도 내 맘대로 조정하고싶다. as를 사용하면 된다. as는 생략가능하다. " " 도 사용가능하다.
select  last_name as name, commission_pct comm
from employees;

select last_name "Name", salary * 12 "Annual Salary"
from employees;

--과제 : 사원들의 사번, 이름, 직업, 입사일 (STARTDATE)을 조회하라. /성공
select employee_id ID , last_name NAME , job_id JOB , hire_date STARTDATE
from employees;

--과제 : 사원들의 사번 (Emp #), 이름 (Name), 직업(Job) , 입사일 (Hire Date)을 조회하라.
select employee_id "Emp #" , last_name "Name" , job_id "JOB" , hire_date  "Hire Date"
from employees;

--컬럼을 하나로 만들고 싶다. 붙이기 연산자 || 사용 (리턴값이 char타입이다.)
select last_name ||  job_id
from employees;

-- expression에 변수뿐만 아니라 상수도 섞을수 있다.
-- 'is' = 상수 , job_id = 변수
select last_name ||  ' is ' || job_id
from employees;

select last_name || ' is ' || job_id employee
from employees;

--null -> empty string 취급
select last_name || null
from employees;

-- commission 을 vachar2로 변환시켰다.
select last_name || commission_pct
from employees;

--salary가 char로 변환되었다.
select last_name || salary
from employees;

select last_name || hire_date
from employees;

select last_name || (salary * 12)
from employees;

-- 과제 : 사원들의 '이름, 직업'(Emp and Title)을 조회하라.
select last_name || ', ' ||  job_id "Emp and Title"
from employees;

