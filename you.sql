select tname
from tab;

-- 칼럼 네임 + 데이터 타입 + PK 지정(테이블명_ 컬럼명_pk) or 타입
-- constraint  = 제약조건 
-- depts_deptid_pk -> 종속적인 존재
-- 테이블에는 PK가 무조건 있어야한다.
create table depts(-- 로지컬한 검사 : ex) salary = 0 이상의 정수여야한다.
department_id number(3) constraint depts_deptid_pk primary key,
department_name varchar2(20));

--제약조건을 확인할 수 있는 데이터 딕셔너리
desc user_constraints

select constraint_name, constraint_type, table_name
from user_constraints;

create table emps( --pk지정하지 않으면 자동으로 오라클에서 지정해준다.
employee_id number(3) primary key, --number : 자릿수 //primary key > 유니크와 낫널 
emp_name varchar2(10) constraint emps_empname_nn not null, --varchar2 : 바이트
email varchar2(20), -- 아무 조건 없다.
salary number(6) constraint emps_sal_ck check( salary > 1000) , -- check( salary > 1000) > 논리적으로 무결성을 체크한다.
department_id number(3), 
constraint emps_email_uk unique(email), --테이블로 level 선언 =  email 필드 벨류값만 검사한다는 뜻이다.
constraint emps_deptid_fk foreign key(department_id)  --foreign key -> relationship을 나타낸다.
        references depts (department_id)); -- references -> department_id을 복사해서 relationship을 표시한다.
-- relationship (예시 friendship) 최소 2개

--22번째 줄은 논리적으로 무결성을 체크하고, 그 외 나머지 제약조건 4가지는 체크x

select constraint_name, constraint_type , table_name
from user_constraints;

--연습--
insert into depts values(100, 'Development');
insert into emps values(500, 'musk', 'musk@gmail.com', 5000,100);
insert into emps values(501, 'a', 'musk@gmail.net', 2000, 100);
-- foreign key:  유저가 업무상 존재하지 않는 엉뚱한 데이터를 넣는것을 방지하기 위해 만들었다.

drop table emps cascade constraints;
-- 제약조건도 같이 삭제하자는 명령문이다.

select constraint_name, constraint_type ,  table_name
from user_constraints;

-- hr스키마로 변경해서 조회하면 데이터가 나오지 않는다.
select * from depts;



--필드와 테이블명 다르게 말하는 이유 ? 