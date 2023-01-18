-- 자동 변환 연습
select hire_date
from employees
where hire_date = '2003/06/17'; -- char을 날짜 형식으로 형변환 시킨것이다. hire_Date를 변환 시키려면 107개를 변환 시켜야해서 별로임

-- 날짜로 형변환
select salary 
from employees
where salary = '7000';

-- date가 char로 변한다.
select hire_date || ''
from employees;

-- number가 char로 변한다.
select salary || ''
from employees;

-- char로 변환 시킨다.
select to_char (hire_Date)
from employees;

--내가 지정한 형식대로 나온다 (2번째 파라미터)
select to_char(sysdate, 'yyyy-mm-dd')
from dual;

-- 날짜를 문자로 나타낼수 있다
select to_char(sysdate, 'YEAR MONTH DDsp Day(DY)')
from dual;

--대소문자 구분해서 사용해보자.
select to_char(sysdate, 'Year Month Ddsp Day(Dy)')
from dual;

--오늘 날짜를 숫자로 표현한다.
-- 기억해두세요. 과제 나옴!
select to_char (Sysdate, 'd')
from dual;

select last_name, hire_date,
            to_char(hire_date, 'day'),
            to_char(hire_date, 'd')
from employees;

--과제 : 위 테이블을 월요일부터 입사일 순으로 오름차순 정렬하라. (관점의 전환을 해야지 풀 수 있다.)
select last_name, hire_date,
            to_char(hire_date, 'day'),
            to_char(hire_date, 'd')
from employees
order by  to_char(hire_date -1 , 'd') , hire_date;

--강사님 답안
select last_name, hire_date,
            to_char(hire_date, 'day')
from employees
order by  to_char(hire_date -1 , 'd') , hire_date;

--시 분 초 오전/오후 나타낸다.
select to_char (sysdate, 'hh24:mi:ss am')
from dual;

-- 그대로 보여지고 싶은 문자는 " " 를 사용한다. ex) "of"
select to_char(sysdate, 'DD "of" Month')
from dual;

select to_char(hire_date, 'DD Month YY')
from employees;

--위 예제에 빈 공간을 눌러준다 . = fm (fill mode)
select to_char(hire_date, 'fmDD Month YY')
from employees;

-- 과제 : 사원들의 이름, 입사일, 인사평가일을 조회하라.
--           인사평가일은 입사한 지 3개월 후 첫번째 월요일이다.
--           날짜는 YYYY.MM.DD로 표시한다.
select last_name , to_char(hire_date, 'YYYY.MM.DD') ,
           to_char( next_day( ( add_months(hire_date , 3) ) , 2) , 'YYYY.MM.DD') "인사평가일"
from employees;

--강사님 답안
select last_name, to_char(hire_date, 'YYYY.MM.DD') hire_date,
            to_char(next_day(add_months(hire_date, 3), 'monday'), 'YYYY.MM.DD') review_date
from employees;


--숫자를 문자로 바꿔보자.
select to_char(salary)
from employees;

--9와 0의 차이는 1이후 숫자에서 나타난다.
--
select to_char(salary, '$99,999.99') , to_char(salary, '$00,000.00')
from employees
where last_name = 'Ernst';

select '|' || to_char(12.12, '9999.99') || '|' ,
            '|' || to_char(12.12, '0000.00') || '|'
from dual;

select '|' || to_char(12.12, 'fm9999.99') || '|' ,
            '|' || to_char(12.12, '0000.00') || '|'
from dual;

-- 클라이언트가 실행되는 기준 돈 단위로 바뀐다. = 현재 america
select to_char(1237, 'L9999')
from dual;

-- 과제 : <이름> earns <$,월급> monthly but wants <$, 월급 x 3> . 을 조회하라.
--다이아몬드로 표시하는 것은 변수이다. monthly but wants는 상수이다.
select  last_name || ' earns ' ||
            to_char(salary, 'fm$99,999') || ' monthly but wants ' ||
            to_char (salary * 3 , 'fm$99,999')
from employees;

--문자를 날짜로 바꾼다. to_date( ' 문자' , '내가 사용한 패턴적기')
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005',  'Mon dd, yyyy');

--패턴을 개떡같이 적어도 출력해준다. -> 거짓된 데이터를 출력할수도 있다.
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005' , 'Mon  dd yy');

-- 정확한 패턴만 출력하도록 하려면 fx를 사용하면 된다.
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005' , 'fxMon  dd yy');

--to_number
select to_number('1237')
from dual;

--문자가 섞여서 에러뜸
select to_number('1,237.12')
from dual;

--문자를 섞어서 쓰면 패턴을 지정해주면 된다.
select to_number('1,237.12', '9,999.99')
from dual;

--nvl함수의 파라미터 두 개는 데이터 타입이 같아야한다. = 한 칼럼에는 데이터 타입이 같아야해서.
select nvl(null, 0)
from dual;

select job_id, nvl(commission_pct, 0)
from employees;

--과제 : 사원들의 이름, 직업, 연봉을 조회하라.
select last_name, job_id, salary * (1 + nvl(commission_pct, 0)) * 12 
from employees;

-- 과제 : 사원들의 이름, 커미션율을 조회하라.
--           커미션이 없으면, No Commission을 표시한다.
select last_name, nvl (to_char( commission_pct) , 'No commission')
from employees;

-- ★ sysdate와 nvl 자주 사용하니까 꼭 기억하기. ★

-- 값이 있으면 첫번째 '' 를 리턴하고, null이면 두번째 ''를 리턴한다.
select job_id, nvl2(commission_pct, 'Sal+COMM', 'SAL') income
from employees;

--여기서 0 은 문자 0이다.
select job_id, nvl2(commission_pct, 'Sal+COMM', 0 ) income
from employees;

-- nullif( , ) -> 두개의 파라미터 값이 같으면 null이 나온다.
select first_name, last_name,
        nullif(length(first_name), length(last_name))
from employees;

select to_char(null), to_number(null), to_date(null)
from dual;

-- coalesce :: 첫번째 파라미터 = null >  두번째 파라미터 = null 이라서 'None'을 출력하였다
select last_name, job_id,
        coalesce (to_char(commission_pct), to_char(manager_id), 'None')
from employees;

-- decode (A , B ):: 
--세율, 소득세율 구하는것
select last_name, salary,
        decode(trunc(salary / 2000), 
                0, 0.00,
                1, 0.09,
                2, 0.20,
                3, 0.30,
                4, 0.40,
                5, 0.42,
                6, 0.44,
                    0.45) tax_rate
from employees
where department_id = 80;

-- decode(기준값, 비교값, 리턴값)
select decode( salary, 'a' , 1)
from employees;

-- 위 예제에서  null값이 나와서 기본값을 0 으로 지정하였다. 기준값과 비교값은 타입이 같아야한다.
select decode( salary, 'a' , 1 , 0)
from employees;

select decode(job_id, 1,1)
from employees; -- 비교값 1이 숫자처리 되서 에러난다.

-- 과제 : 사원들의 직업, 직업별 등급을 조회하라.
--           기본 등급은 null이다.
--           IT_PROG      A
--           AD_PRES     B
--           ST_MAN        C
--           ST_CLERK   D
select job_id, decode( job_id ,
        'IT_PROG' , 'A',
        'AD_PRES' , 'B',
        'ST_MAN' , 'C',
        'ST_CLERK' , 'D',
                null) Grade
from employees; --decode의 기본값은 null이라서 null은 명시하지 않아도 된다.


-- case~ end 로 이루어져 있다. // case 기준값 when+ 비교값  then + 리턴값
select last_name, job_id, salary,
        case job_id  when 'IT_PROG' then 1.10 * salary
                            when 'AD_PRES' then 1.05 * salary
        else salary end revised_salary
from employees;

-- 첫번째 리턴값 형태로 통일 시켜야 한다.
select case job_id when '1' then 1
                                when '2' then 2
                                else 0
                    end grade
from employees;

select case job_id when '1' then'1'
                                when '2' then '2'
                                else '0'
                    end grade
from employees;

--기준값과 비교값의 타입이 같아야한다. salary = 숫자 타입
select case salary when 1 then'1'
                                when 2 then '2'
                                else '0'
                    end grade
from employees;

-- case 문법 첫줄부터 순서대로 처리된다.
select last_name, salary,
        case when salary < 5000 then 'low'
                when salary < 10000 then 'medium'
                when salary <20000 then 'high'
                else 'good'
        end grade
from employees;

-- 과제 : 사원들의 이름, 입사일, 입사요일을 월요일부터 요일순으로 조회하라.
select last_name, hire_date , to_char(hire_date , 'fmday' ) day
from employees
order by case day
                when 'monday' then 1
                when 'tuesday' then 2
                when 'wednesday' then 3
                when 'thursday' then 4
                when 'friday' then 5
                when 'saturday' then 6
                when ' sunday' then 7
                end;
                
-- 과제 : 2005년 이전에 입사한 사원들에게 100만원 상품권,
--          2005년 후에 입사한 사원들에게 10만원 상품권을 지급한다.
--          사원들의 이름, 입사일, 상품권 금액을 조회하라.

select last_name, hire_date, 
        case when to_char(hire_date <= '2004.12.31') then '100만원'
        else '50만원'
        end
from employees;
