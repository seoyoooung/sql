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












