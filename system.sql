alter user hr account unlock; 
alter user hr identified by hr; 

create user you identified by you; 
--�տ� you�� username / �ڿ� you�� password

--������ �ִ�. DBA ����
grant connect , resource to you;

--rule
-- connect -> create session
-- resource -> create tabel .....
