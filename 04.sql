-- �ڵ� ��ȯ ����
select hire_date
from employees
where hire_date = '2003/06/17'; -- char�� ��¥ �������� ����ȯ ��Ų���̴�. hire_Date�� ��ȯ ��Ű���� 107���� ��ȯ ���Ѿ��ؼ� ������

-- ��¥�� ����ȯ
select salary 
from employees
where salary = '7000';

-- date�� char�� ���Ѵ�.
select hire_date || ''
from employees;

-- number�� char�� ���Ѵ�.
select salary || ''
from employees;

-- char�� ��ȯ ��Ų��.
select to_char (hire_Date)
from employees;

--���� ������ ���Ĵ�� ���´� (2��° �Ķ����)
select to_char(sysdate, 'yyyy-mm-dd')
from dual;

-- ��¥�� ���ڷ� ��Ÿ���� �ִ�
select to_char(sysdate, 'YEAR MONTH DDsp Day(DY)')
from dual;

--��ҹ��� �����ؼ� ����غ���.
select to_char(sysdate, 'Year Month Ddsp Day(Dy)')
from dual;

--���� ��¥�� ���ڷ� ǥ���Ѵ�.
-- ����صμ���. ���� ����!
select to_char (Sysdate, 'd')
from dual;

select last_name, hire_date,
            to_char(hire_date, 'day'),
            to_char(hire_date, 'd')
from employees;

--���� : �� ���̺��� �����Ϻ��� �Ի��� ������ �������� �����϶�. (������ ��ȯ�� �ؾ��� Ǯ �� �ִ�.)
select last_name, hire_date,
            to_char(hire_date, 'day'),
            to_char(hire_date, 'd')
from employees
order by  to_char(hire_date -1 , 'd') , hire_date;

--����� ���
select last_name, hire_date,
            to_char(hire_date, 'day')
from employees
order by  to_char(hire_date -1 , 'd') , hire_date;

--�� �� �� ����/���� ��Ÿ����.
select to_char (sysdate, 'hh24:mi:ss am')
from dual;

-- �״�� �������� ���� ���ڴ� " " �� ����Ѵ�. ex) "of"
select to_char(sysdate, 'DD "of" Month')
from dual;

select to_char(hire_date, 'DD Month YY')
from employees;

--�� ������ �� ������ �����ش� . = fm (fill mode)
select to_char(hire_date, 'fmDD Month YY')
from employees;

-- ���� : ������� �̸�, �Ի���, �λ������� ��ȸ�϶�.
--           �λ������� �Ի��� �� 3���� �� ù��° �������̴�.
--           ��¥�� YYYY.MM.DD�� ǥ���Ѵ�.
select last_name , to_char(hire_date, 'YYYY.MM.DD') ,
           to_char( next_day( ( add_months(hire_date , 3) ) , 2) , 'YYYY.MM.DD') "�λ�����"
from employees;

--����� ���
select last_name, to_char(hire_date, 'YYYY.MM.DD') hire_date,
            to_char(next_day(add_months(hire_date, 3), 'monday'), 'YYYY.MM.DD') review_date
from employees;


--���ڸ� ���ڷ� �ٲ㺸��.
select to_char(salary)
from employees;

--9�� 0�� ���̴� 1���� ���ڿ��� ��Ÿ����.
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

-- Ŭ���̾�Ʈ�� ����Ǵ� ���� �� ������ �ٲ��. = ���� america
select to_char(1237, 'L9999')
from dual;

-- ���� : <�̸�> earns <$,����> monthly but wants <$, ���� x 3> . �� ��ȸ�϶�.
--���̾Ƹ��� ǥ���ϴ� ���� �����̴�. monthly but wants�� ����̴�.
select  last_name || ' earns ' ||
            to_char(salary, 'fm$99,999') || ' monthly but wants ' ||
            to_char (salary * 3 , 'fm$99,999')
from employees;

--���ڸ� ��¥�� �ٲ۴�. to_date( ' ����' , '���� ����� ��������')
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005',  'Mon dd, yyyy');

--������ �������� ��� ������ش�. -> ������ �����͸� ����Ҽ��� �ִ�.
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005' , 'Mon  dd yy');

-- ��Ȯ�� ���ϸ� ����ϵ��� �Ϸ��� fx�� ����ϸ� �ȴ�.
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005' , 'fxMon  dd yy');

--to_number
select to_number('1237')
from dual;

--���ڰ� ������ ������
select to_number('1,237.12')
from dual;

--���ڸ� ��� ���� ������ �������ָ� �ȴ�.
select to_number('1,237.12', '9,999.99')
from dual;

--nvl�Լ��� �Ķ���� �� ���� ������ Ÿ���� ���ƾ��Ѵ�. = �� Į������ ������ Ÿ���� ���ƾ��ؼ�.
select nvl(null, 0)
from dual;

select job_id, nvl(commission_pct, 0)
from employees;

--���� : ������� �̸�, ����, ������ ��ȸ�϶�.
select last_name, job_id, salary * (1 + nvl(commission_pct, 0)) * 12 
from employees;

-- ���� : ������� �̸�, Ŀ�̼����� ��ȸ�϶�.
--           Ŀ�̼��� ������, No Commission�� ǥ���Ѵ�.
select last_name, nvl (to_char( commission_pct) , 'No commission')
from employees;

-- �� sysdate�� nvl ���� ����ϴϱ� �� ����ϱ�. ��

-- ���� ������ ù��° '' �� �����ϰ�, null�̸� �ι�° ''�� �����Ѵ�.
select job_id, nvl2(commission_pct, 'Sal+COMM', 'SAL') income
from employees;

--���⼭ 0 �� ���� 0�̴�.
select job_id, nvl2(commission_pct, 'Sal+COMM', 0 ) income
from employees;

-- nullif( , ) -> �ΰ��� �Ķ���� ���� ������ null�� ���´�.
select first_name, last_name,
        nullif(length(first_name), length(last_name))
from employees;

select to_char(null), to_number(null), to_date(null)
from dual;

-- coalesce :: ù��° �Ķ���� = null >  �ι�° �Ķ���� = null �̶� 'None'�� ����Ͽ���
select last_name, job_id,
        coalesce (to_char(commission_pct), to_char(manager_id), 'None')
from employees;

-- decode (A , B ):: 
--����, �ҵ漼�� ���ϴ°�
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

-- decode(���ذ�, �񱳰�, ���ϰ�)
select decode( salary, 'a' , 1)
from employees;

-- �� ��������  null���� ���ͼ� �⺻���� 0 ���� �����Ͽ���. ���ذ��� �񱳰��� Ÿ���� ���ƾ��Ѵ�.
select decode( salary, 'a' , 1 , 0)
from employees;

select decode(job_id, 1,1)
from employees; -- �񱳰� 1�� ����ó�� �Ǽ� ��������.

-- ���� : ������� ����, ������ ����� ��ȸ�϶�.
--           �⺻ ����� null�̴�.
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
from employees; --decode�� �⺻���� null�̶� null�� ������� �ʾƵ� �ȴ�.


-- case~ end �� �̷���� �ִ�. // case ���ذ� when+ �񱳰�  then + ���ϰ�
select last_name, job_id, salary,
        case job_id  when 'IT_PROG' then 1.10 * salary
                            when 'AD_PRES' then 1.05 * salary
        else salary end revised_salary
from employees;

-- ù��° ���ϰ� ���·� ���� ���Ѿ� �Ѵ�.
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

--���ذ��� �񱳰��� Ÿ���� ���ƾ��Ѵ�. salary = ���� Ÿ��
select case salary when 1 then'1'
                                when 2 then '2'
                                else '0'
                    end grade
from employees;

-- case ���� ù�ٺ��� ������� ó���ȴ�.
select last_name, salary,
        case when salary < 5000 then 'low'
                when salary < 10000 then 'medium'
                when salary <20000 then 'high'
                else 'good'
        end grade
from employees;

-- ���� : ������� �̸�, �Ի���, �Ի������ �����Ϻ��� ���ϼ����� ��ȸ�϶�.
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
                
-- ���� : 2005�� ������ �Ի��� ����鿡�� 100���� ��ǰ��,
--          2005�� �Ŀ� �Ի��� ����鿡�� 10���� ��ǰ���� �����Ѵ�.
--          ������� �̸�, �Ի���, ��ǰ�� �ݾ��� ��ȸ�϶�.

select last_name, hire_date, 
        case when to_char(hire_date <= '2004.12.31') then '100����'
        else '50����'
        end
from employees;
