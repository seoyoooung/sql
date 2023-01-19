-- group function
-- group function이 call 되는 횟수는 그룹의 갯수에 비례한다

--평균 구하기 : avg
select avg(salary), max(salary), min(salary), sum(salary)
from employees;

--날짜에 대해서도 min과 max 사용가능하다. 
--min = 가장 오래된 입사일 , max = 가장 최근 입사일
select min(hire_date), max(hire_date)
from employees;

--과제 : 최고 월급과 최소 월급의 차액을 조회하라.
select max(salary) - min(salary)
from employees;

--count : row의 갯수를 세다.
--count의 특징 : 모든 * 컬럼이라고 쓸 수 있다.
select count(*)
from employees;

--과제 : 70번 부서원이 몇명인지 조회하라.
select count (*)
from employees
where department_id = 70;

-- count 안에 필드네임을 명시해보자. (18-19 줄과 같은 결과가 나온다.)
select count(employee_id)
from employees;

select count(manager_id)
from employees;

-- 그룹 함수의 특징은 null 값은 무시한다.
-- count 안에 필드네임을 사용하고 싶으면 primary key로 지정된 필드 네임을 쓰면 안전하다.

--평균을 구해보자. 영업사원들의 커미션 평균값
select avg(commission_pct)
from employees;

-- 과제 : 조직의 평균 커미션율을 조회하라.
-- null 값을 없앤다 = nvl function
select avg(nvl(commission_pct, 0))
from employees;

-- 중복을 신경쓰지 않는다. salary 앞에 all이 생략되어 있다. all 은 모든 기본 function에 들어가 있다.
select avg(salary)
from employees;

--distinct = 중복값 제거.
select avg(distinct salary)
from employees;

--과제 : 직원이 배치된 부서 개수를 조회하라.
-- 부서 -> department , 직원 -> employee 생각해서 풀자. 
select count(distinct department_id)
from employees;

-- 과제 : 매니저 수를 조회하라.
select count(distinct manager_id)
from employees;

-- select 절에 그룹함수를 쓰려고 하니까 오류가 난다.
-- 논리적으로 비논리적이라서 사용불가. 
-- group by 를 사용하여  department_id가 같은 애들끼리 묶인다.
-- ★★ select 절에 칼럼명이 등장하면 group by를 사용해야한다.  = group by expression이 select 절에 나타나야한다.
select department_id, count(employee_id)
from employees
group by department_id
order by department_id; -- 보기 불편하니까 정렬해주자.
-- 그룹의 call 횟수는 그룹의 갯수와 동일하다.

select employee_id
from employees
where department_id = 30;

select department_id, job_id, count(employee_id)
from employees
group by department_id , job_id
order by department_id;

-- 과제 : 직업별 사원수를 조회하라.
select job_id , count (employee_id)
from employees
group by job_id;

-- 위와 같은 결과나오는 것
select job_id , count (*)
from employees
group by job_id;

-- 일부 group만 골라내고 싶다.
-- having : group by에 조건을 걸어준다.
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
having max_sal > 10000; -- 지정한 별명으로는 사용할 수 없다.

-- row를 골라내고 (where절)  그 결과를 group by
-- 94~97 줄과 같은 명령문이다. (having 절)
select department_id, max(salary)
from employees
where department_id > 50
group by department_id;

-- where절에 single function만 사용할 수 있다.
--  조건절에 group function을 사용하고 싶으면 ,having 절 사용
-- 아래는 오류난다.
select department_id, max(salary)
from employees
where max(salary) > 10000
group by department_id;


-- having 절에는 group function 사용/ single function사용하고 싶으면 where 절 사용
-- order by에는 별명 사용 가능

select job_id, sum(salary) payroll
from employees
where job_id not like '%REP%'
group by job_id
having sum(salary) > 13000
order by payroll;


-- 과제 : 매니저 ID, 매니저 별 관리 직원들 중 최소 월급을 조회하라.
--          최소 월급이 $6,000 초과여야한다.
select manager_id, min(salary) 
from employees
group by manager_id
having min(salary) > 6000
order by min(salary); 
-- 매니저별 -> 매니저 값이 null이 있는 것을 놓쳤다. -> where manager_id is not null

--강사님 답안 / 위 답안과 결과 값이 다르다
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) > 6000
order by 2 desc;

-- 그룹 함수가 n번 실행되려면 n번 반복되어야한다.
-- 원인은 파라미터로 쓰인 그룹이 n개 있어서이다.
-- 시간순으로 보면  파라미터로 쓰인 그룹이 n개 있어서 > 그룹함수가 n번 실행 >  n번 반복
-- 문법적으로 그룹함수는 2단계만 사용할 수 있다 . 아래 예제 처럼 ! max 겉에 추가하면 에러 발생한다.
select max(avg(salary))
from employees
group by department_id;

select department_id, round(avg(salary))
from employees
group by department_id;

-- 에러 발생 / group by 없이 group 기능과 single  기능을 같이 쓸 수 없다.
select department_id, round(avg(salary))
from employees;

-- 2차원으로 접근하여 생각해봐라. -> 자바 때 가위바위보,,
-- 과제 : 2001년, 2002년,  2003년도별 입사자 수를 조회하라.

-- 강사님 답안
select sum (decode(to_char(hire_date, 'YYYY'), '2001' , 1, 0)) "2001",
            sum (decode(to_char(hire_date, 'YYYY'), '2002' , 1, 0)) "2002",
            sum (decode(to_char(hire_date, 'YYYY'), '2003' , 1, 0)) "2003"
from employees;

-- 학생들 답안 (1)
select to_char(hire_date, 'YYYY') hire_year  , count(*) emp_cnt
from employees
where to_char(hire_date, 'YYYY') in (2001, 2002, 2003)
group by to_char(hire_date, 'YYYY')
order by hire_year;

--학생들 답안(2)
select count(case when hire_date like '2001%' then 1 else null end) "2001" ,
            count(case when hire_date like '2002%' then 1 else null end) "2002" ,
            count(case when hire_date like '2003%' then 1 else null end) " 2003"
from employees;

-- 과제 : 직업별 , 부서별 월급합을 조회하라.
--           부서는 20, 50, 80 이다.
--           2차원으로 생각해라. 한 축에는 직업, 한 축에는 부서가 있어야한다.
--            직전 과제에 group by만 사용하면 된다.
select job_id, sum(decode (department_id , 20, salary )) "20",
                        sum(decode (department_id, 50, salary ))  "50",
                        sum(decode (department_id, 80, salary )) "100"
from employees
group by job_id;

