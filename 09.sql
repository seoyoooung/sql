-- 삭제하는 명령문
drop table dept;

-- 테이블을 만들어보자. 
-- data definition language : DDL 
-- DDL은 auto commit 이다.
create table dept(
department_id number(4),
department_name varchar2(30),
manager_id number(6),
location_id number(4)
);

create table emp(
employee_id number(6),
first_name varchar(20),
last_name varchar2(25),
email varchar2(25),
phone_number varchar2(20),
hire_date date,
job_id varchar2(10),
salary number(8,2),
commission_pct number(2,2),
manager_id number(6),
department_id number(4));

-- DML중에 insert를 연습해보자. // 4개의 필드를 내가 준비하였다.
insert into dept (department_id, department_name, manager_id, location_id)
values (100, 'Public Relation' , 100, 1700);

-- 값이 비어있는 것은 null로 표시한다.
insert into dept(department_id, department_name)
values(310, 'Purchasing');

select * from dept;

-- commit = 끝을 내준다.  transaction 끝내준다. 커밋완료. 라고 안내해준다.
commit;

--read consistance : 읽기 일관성

drop table emp;

insert into emp(employee_id, first_name, last_name,
                        email, phone_number, hire_date,
                        job_id, salary, commission_pct,
                        manager_id, department_id)
values(300, 'Louis', 'Pop',
                'Pop@gmail.com', '010-378-1278', sysdate,
                'AC_ACCOUNT' , 6900, null,
                205, 110);
                
insert into emp
values( 320, 'Terry', 'Benard',  
                'Benard@gamil.com' , '010-637-0972', '2022/07/20',
                'AD_PRES', 5000, .2,
                100, 310); 

commit;

select * from emp;

-- 영업사원 테이블
-- 테이블 명을 복수명으로
create table sa_reps (
rep_id number(6),
rep_name varchar2(25),
salary number(8,2),
commission_pct number(2,2)
);

-- into sa_reps 대신에 all로 전체를 불러준다.
-- insert 에서 서브쿼리 사용
insert all
        into sa_reps values(1, '최한석', 20000, .1)
        into sa_reps values(2, '한아름', 30000, .12)
select * from dual;

commit;

select * from sa_reps;

--  PL/SQL  -> procedure(절차)를 만든다.
-- 끝은 / 으로 내야한다.
-- declare로 변수 선언한거 (base)는 begin~end에서 사용가능하다.
declare
        base number(6) := 400;
begin 
    for i in 1..10 loop
            insert into sa_reps(rep_id, rep_name, salary, commission_pct)
            values (base + i, 'n' || (base + i) , base * i, i * 0.01);
    end loop;
end;
/

select *
from sa_reps
where rep_id > 400;

commit;

--나만의 테이블을 만들고 + 이름을 붙여보자. 
-- 데이터 타입이 서로 같아야한다.
insert into sa_reps ( rep_id, rep_name, salary, commission_pct)
            select employee_id, last_name, salary , commission_pct
            from employees
            where job_id like '%REP%';
            
commit;

-- 최초의 insert가 실행될 때 transaction이 시작되고, commit하면 transaction이 끝난다.

-------------------------------------
-- update
-- set : 내가 고칠 칼럼명을 지정한다. = 새로운 값을 주고싶은 value를 쓴다.
update emp
set job_id = 'IT_PROG',
        salary = '30000'
where employee_id = 300;

select job_id, salary
from emp
where employee_id = 300;

update emp
set salary = null
where employee_id = 300;

select job_id, salary 
from emp
where employee_id = 300;

--롤백해주면 마지막 commit 시점으로 간다. 취소됐다라고 표현하자.
rollback;

select job_id, salary 
from emp
where employee_id = 300; -- 45~52 번째 commit한 값으로 조회된다.

--트랜젝션을 끝내는 방법은 2가지가 있다, commit or rollback / 대부분 commit이다.

--기존 데이터를 사용할 때 서브쿼리를 사용한다.
update emp
set job_id = (select job_id
                        from employees
                        where employee_id = 205), 
        salary = (select salary
                            from employees
                            where employee_id = 205)
where employee_id = 300;

select job_id, salary
from emp
where employee_id = 300;

rollback;

select job_id, salary
from emp
where employee_id = 300;

--144~151줄을 좋은 코드로 바꿔보자.
update emp
set ( job_id, salary ) = (
        select job_id, salary
        from employees
        where employee_id = 205)
where employee_id = 300;

select job_id, salary
from emp
where employee_id = 300;

commit;

-- delete
--delete 메소드 생성 -> update 메소드
delete dept 
where department_id = 310;

select * from dept;

rollback;

select * from dept;

--delete 에서 서브쿼리를 사용해보자.
delete dept 
where department_name = (
        select department_name
        from departments
        where department_name = 'Purchasing'); 
        
select * from dept;

commit;