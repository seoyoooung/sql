--single funtion : row를 하나 받는다.
desc dual
select * from dual;

-- lower ( 파라미터) from  -> single function / lower : 전체 소문자
select lower ('SQL Course')
from dual;

-- upper : 전체 다 대문자 
select upper ('SQL Course')
from dual;

-- initcap : 첫단어만 대문자 
select initcap('SQL Course')
from dual;

select last_name
from employees
where last_name = 'higgins';

-- 우리는 last_name이 맨 첫자가 대문자인것을 알기 때문에 쉽게 수정할 수 있다.
select last_name
from employees
where last_name = 'Higgins';

--single function 이용해보자
-- lower function의 리턴값과 higgins를 비교하고 있는 것이다.
select last_name
from employees
where lower(last_name) = 'higgins';

--concat (파라미터, 파라미터)
select concat ('Hello' , 'World')
from dual;

--row 는 1개 , 필드는 3개    (  '   '   , index , length)
select substr('HelloWorld' , 2, 5)
from dual;

--인덱스를 오른쪽에서 왼쪽으로 세고 싶으면 - 를 쓰면 된다.
select substr('Hello' , -1 , 1)
from dual;

--글자 수 얻어내는법 = length
select length ('Hello')
from dual;

--instr = 'l'이라는 글자가 인덱스 몇번째에 있는지 나타내는 것이다.
-- 리턴값이 0보다 큰지 비교해본다. 0보다 크면 l이라는 글자가 있다.
select instr('Hello', 'l')
from dual;

select instr('Hello', 'w')
from dual;

-- 5자리인 애만 나타낼거야. 4자리인 애들은 왼쪽에 *로 채워서 5자리를 해줄게. 
-- 과제에 준비해두었다.
select lpad(salary, 5, '*')
from employees;

--오른쪽을 *로 채워줄게.
select rpad(salary, 5, '*')
from employees;

-- J라는 글자를 BL로 고쳐줄게
select replace ('JACK and JUE' , 'J' , 'BL')
from dual;

--H라는 문자를 빼낼거야.
select trim('H' from 'Hello')
from dual;

select trim('l' from 'Hello')
from dual;

select trim( ' ' from ' Hello ')
from dual;

--과제 : 위 query에서 ' '가 trim이 됐음을, 눈으로 확인할 수 있게 조회해라.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;

-- trim 의 기본이 space bar이다. from을 사용하지 않아도 된다.
select trim (' Hello World ')
from dual;

select employee_id, concat(first_name, last_name) name,
        job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG'; -- (job_id, 4) 4번 인덱스에서 마지막까지

-- 과제 : 위 query 에서, where 절을 like로 refactoring 하라.
select employee_id, concat(first_name, last_name) name,
        job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';
