--DDL 을 주제삼아 써보자.

drop table hire_dates;

-- 필드 벨류 null값 넣는 방법 1) null값을 명시한다. 2) 필드를 생략한다.(null값이 기본으로 생략된다)
--기본 null값이 아니고 null값을 따로 입력(지정)하고 싶으면 default 를 사용해준다.
create table hire_dates (
emp_id number(8),
hire_date date default sysdate);

-- data dictionary : 메타 데이터를 가지고 있는 테이블 / 메타 데이터를 제공하는 읽기 전용 테이블이다.
select tname
from tab;

-- 위 명령문에서 쓰레기를 제외하고 출력해보자.
select tname
from tab
where tname not like 'BIN$%';

insert into hire_dates values(1, to_date('2025/12/21'));
insert into hire_dates values(2, null);
insert into hire_dates(emp_id) values(3); --hire_date는 null값이 들어간다. 9번째 줄 선언한 null값.

select * from hire_dates;

commit;
-- insert > 메모리에 저장 / commit > 파일에 저장
-- drop table 하게되면 auto commit해서 복구 불가능 
-- DDL : 자동커밋 / DML : 수동커밋
--DCL (Data Control Language) : 데이터 제어어 / language 의 형태이지만 command이다.

-----------------------------------------------------------------------------------------------

--시스템 스키마로 바꿔서 grant해준다.
--특정 개체에 대한 권한을 주자. you에게 departments 권한을 전부 넘겨준다.
--모든 객체 권한을 주겠다 = all
grant all on hr.departments to you;

-- you 유저로 바꾼다.
drop table employees cascade constraints;

create table employees(
employee_id number(6) constraint emp_empid_pk primary key,
first_name varchar2(20),
last_name varchar2(25) constraint emp_lastname_nn not null,
-- 컬럼 하나에 여러개의 제약조건을 넣을 수 있다.
email varchar2(25) constraint emp_email_nn not null
                               constraint emp_email_uk unique,
phone_number varchar2(20),
hire_date date constraint emp_hiredate_nn not null,
job_id varchar2(10) constraint emp_jobid_nn not null,
salary number(8) constraint emp_salary_ck check(salary > 0),
commission_pct number(2,2),
--매니저 아이디는 이메일 아이디를 reference 한다.
manager_id number(6) constraint emp_managerid_fk references employees(employee_id),
-- 다른 스키마 안에서 사용 할때는 접두사를 붙여줘야 한다. ex) hr.departments
department_id number(4) constraint emp_dept_fk references hr.departments(department_id));

-- 부모테이블에 레코드가 삭제될때 자식 테이블에 레코드는 어떻게 할 것이냐?
-- 그에 관련된 옵션
create table gu (
gu_id number(3) primary key,
gu_name char(9) not null);

create table dong(
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete cascade);
-- 부모가 delete되면 자식도 delete할거야 = on delete cascade

-- 마포구는 없앴지만 합정동은 유지한다. 다른 구에 종속되기 전에.,..,,,.
create table dong2(
dong_id number(4) primary key,
dong_ndma varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete set null);

insert into gu values (100, '강남구');
insert into gu values(200, '노원구');

--자식테이블
insert into dong values(5000, '압구정동', null);
insert into dong values(5001, '삼성동', 100);
insert into dong values(5002, '역삼동', 100);
insert into dong values(6001, '상계동', 200);
insert into dong values(6002, '중계동', 200);

--dong2테이블을 채운다.
insert into dong2
select * from dong;

delete gu
where gu_id = 100;

select * from dong;
select * from dong2; -- 삼성동 역삼동에 null값이 들어갔다. on delete set null의 효과이다.

commit;

--on delete set null가 없는 상태에서 부모의 데이터를 삭제하려고 하면 거부한다.
-- 개발하는동안 재웠다가 서비스할때 깨운다. 컨시스턴스를 재우는 방법
create table a (
aid number(1) constraint a_aid_pk primary key);

drop table b;

create table b (
bid number(2),
aid number(1),
constraint b_aid_fk foreign key(aid) references a(aid));

insert into a values(1);
insert into b values(31, 1);
--에러상황 연출->parent key not found
insert into b values(32, 9);

-- 재운다. diable시킨다. -> 실행 후 위 실행문을 실행시키면 정상 삽입된다.
alter table b disable constraint b_aid_fk;

--통합 테스트
alter table b enable constraint b_aid_fk;
-- foreign키는 깨우되 검사는 안하게 한다.
alter table b enable novalidate constraint b_aid_fk;

insert into b values(33, 8);

-- 내가 필요한 키만 복사했다.
create table sub_departments as
        select department_id dept_id, department_name dept_name
        from hr.departments;
        
select * from sub_departments;

------
create table users(
user_id number(3));
desc users
--추가
alter table users add(user_name varchar2(10));
desc users
--변경
alter table users modify(user_name number(7));
desc users
--삭제
alter table users drop column user_name;
desc users

insert into users values(1);
--read only로 변경
alter table users read only;
insert into users values(2); --오류

--read write로 변경
alter table users read write;
insert into users values(2); -- 정상 삽입된다.
