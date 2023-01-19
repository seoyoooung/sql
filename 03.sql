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

-- 우리는 last_name이 맨 첫자가 대문자인것을 알기 때문에 위 예제를 쉽게 수정할 수 있다.
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

select substr('HelloWorld' , 2)
from dual;

--인덱스를 왼쪽에서 오른쪽으로 세고 싶으면 - 를 쓰면 된다.
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

-- 과제 : 이름이 J나 A나 M으로 시작하는 사원들의 이름, 이름의 글자수를 조회하라.
--           이름의 첫글자는 대문자, 나머지는 소문자로 출력한다.
select  initcap(last_name) ,length (last_name)
from employees
where last_name like 'J%' or
        last_name like 'A%' or
        last_name like 'M%';
        
--round function을 다뤄보자
-- 파라미터가 넘버인 것 / 2번째 파라미터는 소수점 2번째 자리를 나타낸다. 반올림할 자리를 나타낸다.
select round(45.926, 2)
from dual;
-- 2번째 파라미터 위치에서 내림 처리
select trunc(45.926 , 2)
from dual;

--라운드로 정수를 표현하고 싶다. 올림처리해서 정수처리 (파라미터 하나만 주고 사용해도 된다)
select round(45.923, 0), round(45.923)
from dual;

-- 내림처리해서 정수처리
select trunc(45.926, 0), trunc(45.923)
from dual;

--과제 : 사원들의 이름, 월급, 15.5% 인상된 월급(New Salary,정수), 인상액(Increase)을 조회하라.
select last_name, salary,
        round(salary * 1.155) "New Salary",
        round(salary * 1.155) - salary "Increase"
from employees;

--날짜를 다루는 function. 현장에서 많이 사용된다. 
--sysdate는 파라미터가 없다. 출력 당시 날짜를 나타낸다.
select sysdate
from dual;

select sysdate + 1
from dual;

select sysdate - 1
from dual;

--기간을 알아낼 수 있다.
select sysdate - sysdate
from dual;

--근속 기간을 알 수 있다.
select last_name, sysdate - hire_date
from employees
where department_id = 90;

--파라미터로 날짜값 2개를 받는다.  두 날짜 사이의 개월수를 나타내준다.
select months_between('2023/12/31', '2022/12/31')
from dual;

--두번째 파라미터만큼의 개월 수를 더해준다.
select add_months('2023/01/18' , 3)
from dual;

--5 목요일 / 1월 18일 이후로 첫번째 목요일을 나타낸다. 
select next_day('2023/01/18', 5)
from dual;

select next_day('2023/01/18', 4)
from dual;

--숫자 말고 문자로도 표현할 수 있다.
select next_day('2023/01/18', 'thursday')
from dual;

--요일을 약자로
select next_day('2023/01/18', 'thu')
from dual;

--특정날짜의 말일을 구하고 싶다.
select last_day('2023/01/18')
from dual;

--과제 : 20년 이상 재직한 사원들의 이름, 첫 월급일을 조회하라.
--          월급은 매월 말일에 지급한다.
select last_name, last_day(hire_date)
from employees
where months_between (sysdate, hire_date) >= 12 *20;

--pad function이용
-- 과제 : 사원들의 이름, 월급 그래프를 조회하라.
--          그래프는 $1000 당 * 하나를 표시한다. 
select last_name, salary, rpad(' ', salary / 1000 + 1 ,'*' )
from employees;
-- ' ' 스페이스가 있는것을 표시하기 위해 1000 +1 해준것이다 (1이 스페이스를 나타남)

