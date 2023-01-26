--view : 테이블을 투명하게 보여주는 창문 역할을 한다.
-- data를 view를 통해서 본다, 보안 때문에/

--hr스키마로 작업한다.

create view empvu80 as
--노출시키고 싶은 데이터를 서브쿼리로 작성한다.
        select employee_id, last_name, department_id
        from employees
        where department_id = 80;
        
desc empvu80

select * from empvu80; -- 아래처럼 번거롭게하지 않기 위해 empvu80 에 저장을 해둔것이다.

select * from (
        select employee_id, last_name, department_id
        from employees
        where department_id = 80);

--view를 수정해보자. 칼럼을 줄여보자.
-- create or replace   // 이미 empvu80 가 있기 때문에 replace로 작동한다. 오라클이 알아서 create하거나 replace한다.
create or replace view empvu80 as
        select employee_id, job_id
        from employees
        where department_id = 80;

desc empvu80

--과제 : 50번 부서원들의 사번, 이름, 부서번호로 구성된 DEPT50 view를 만들어라.
--          view의 구조는 EMPNO, EMPLOYEE, DEPTNO이다.
create or replace view DEPT50 as
        select employee_id EMPNO, last_name EMPLOYEE, department_id DEPTNO
        from employees
        where department_id = 50;

desc DEPT50

--강사님 답안.
create or replace view dept50 (empno, employee, depyno) as
        select employee_id, last_name, department_id
        from employees
        where department_id = 50;

desc dept50
select * from dept50;


create or replace view dept50 (empno, employee, depyno) as
        select employee_id, last_name, department_id
        from employees
        where department_id = 50
        with check option constraint dept50_ck;
        
--check option
-- 복습할때는 drop 테이블하기
create table teams as
        select department_id team_id, department_name team_name
        from hr.departments;
        
create view team50 as
        select *
        from teams
        where team_id = 50;
        
select * from team50;

select count(*) from teams;

--teams에 추가된것
insert into team50
values(300, 'Markerting');

select count(*) from teams;

--위에꺼를 체크옵션 적용시켜보자
create or replace view team50 as
        select *
        from teams
        where team_id = 50
        with check option;

insert into team50 values(50, 'IT Support');
select count(*) from teams;

--이때 체크옵션에 걸린다.
--80번째 줄 where절을 검사한다. 50과 301이 같다는 거짓이라서 오류난다
insert into team50 values(301, 'IT Support');

create or replace view empvu10(employee_num, employee_name, job_title) as
        select employee_id, last_name, job_id
        from employees
        where department_id = 10
        with read only;
        
insert into empvu10 values(501, 'abel', 'Sales'); -- 오류 /insert거부
select * from empvu10; 

--시퀀스
--포트폴리오 만들때 필수로 사용한다.
drop sequence team_teamid_seq;

create sequence team_teamid_seq; -- 테이블명_ 칼럼명_시퀀스표시

--게시판의 글번호로 만ㄶ이 사용
select team_teamid_seq.nextval from dual; -- nextval : 새로운 값만드는것 
select team_teamid_seq.nextval from dual;
select team_teamid_seq.currval from dual; -- currval : 현재 값 조회

insert into teams
values(team_teamid_seq.nextval, 'Marketing');

select * from teams
where team_id < 5;

create sequence x_xid_seq
        start with 10
        increment by 5
        maxvalue 20
        nocache -- 미리 준비해놓는 작업 //
        --nocache는 하나하나 번호표 나눠주는것, cache는 번호표 묶을을 하나씩 가져가는것이라고 생각하자.
        nocycle; -- 반복하지 않는다. 반복하고 싶으면 cycle
        
select x_xid_seq.nextval from dual;


drop sequence dept_departmentid_seq;

-- 과제 : DEPT 테이블의 DEPARTMENT_ID 칼럼의 field value로 쓸 sequence를 만들어라.
--           sequence는 400이상, 1000이하로 생성한다. 10씩 증가한다.
create sequence dept_departmentid_seq
        start with 400
        increment by 10
        maxvalue 1000;
        
select dept_departmentid_seq.nextval from dual;
select dept_departmentid_seq.currval from dual;

-- 과제 : 위 sequence를 이용해서 , DEPT 테이블에서 Education 부서를 insert하라.
insert into dept(department_id, department_name)
values(dept_departmentid_seq.nextval, 'Education');

commit;

--테이블에 pk를 생성하면 자동으로 인덱스 생성
-- index : 참조한다. 복사한다.
drop index emp_lastname_idx;

create index emp_lastname_idx
on employees(last_name);

--rowid : 유일한 값 (index)
select last_name, rowid
from employees;

select last_name
from employees
where rowid = 'AAAEAbAAEAAAADNABe';

--내가 사용하는 스키마에는 어떤 인덱스가 있는지 보자.
select index_name, index_type, table_owner, table_name
from user_indexes;

-- 과제 : DEPT 테이블의 DEPARTMENT_NAME 에 대해 index를 만들어라.
drop index dept_departmentname_idx;

create index dept_departmentname_idx
on departments(department_name);

--1) 객체 이름이 길어서, 2) 조직내에서 객체 하나 부르는 이름이 다르다.
drop synonym team;

create synonym team
for departments;

select * from team;

-- 과제 : EMPLOYEES 테이블에 EMPS synonym을 만들어라.
drop synonym emps;

create synonym emps
for employees;

