alter user hr account unlock; 
alter user hr identified by hr; 

create user you identified by you; 
--앞에 you는 username / 뒤에 you는 password

--권한을 주다. DBA 역할
grant connect , resource to you;

--rule
-- connect -> create session
-- resource -> create tabel .....
