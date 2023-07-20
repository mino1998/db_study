use mino;
-- select 구문은 트랜잭션과 아무런 연관성이 없음
-- 데이터의 변화와 상관이 없기 때문이다.
select * from DEPT;
-- DEPT 테이블에 데이터를 하나 삽입해보자.
-- dept 테이블에 데이터 1개 삽입, 이전 트랜잭션이 없어서 트랜잭션 생성
insert into DEPT (deptno, dname, loc) values (50, "Computing", "SEOUL");
select * from DEPT;
-- 철회: savepoint를 입력하지 않으면 트랜잭션 시작 전으로 복구
ROLLBACK;
-- 내가 insert 한 것이 없어졌어!
-- 트랜잭션 전으로 돌아가버렸다.
select * from DEPT;


-- 다시 데이터를 넣어보자.
-- 트랜잭션이 다시 하나 생성된다.
insert into DEPT (deptno, dname, loc) values (50, "Computing", "SEOUL");
-- 이제 create 구문을 하나 써볼까?
-- DEPT 복제 테이블 하나 생성하기
create table DEPT_COPY 
as select * from DEPT;
-- 다시 ROLLBACK하기
ROLLBACK;
-- 이번에는 50이 나온다.
-- ROLLBACK을 했는데 왜 나왔지?
-- DDL(create, drop, alter, truncate, rename)이나
-- DCL(grant, revoke)를 수행하면 AUTO COMMIT이다.
-- why? : 관리자 영역의 명령어들이라 나중에 적용되면 안되기 때문이다.
-- 트랜잭션은 변경 내역을 반영하고 종료를 한다.
-- 물론 create한 테이블도 잘 보인다.
select * from DEPT;
select * from DEPT_COPY;


-- 트랜잭션 생성
insert into DEPT (deptno, dname, loc) values (60, "Computing1", "SEOUL1");
savepoint sv1;
insert into DEPT (deptno, dname, loc) values (70, "Computing2", "SEOUL2");
savepoint sv2;
insert into DEPT (deptno, dname, loc) values (80, "Computing3", "SEOUL3");
select * from DEPT;
-- sv1을 생성한 지점으로 이동
ROLLBACK TO sv1;
-- sv1으로 오게 된다면 sv2는 없는 것을 생각하자.
select * from DEPT;
-- 이대로 냅두면 lock이 걸린다. 
-- 왜냐면 내가 rollback이나 commit, ddel, dcl 한 적이 없음
-- 에러는 아니고 데드락에 걸려요 이걸 connect timeout을 걸어야 함
-- commit 수행 : 트랜잭션 종료
-- COMMIT;
ROLLBACK;
select * from DEPT;
delete from DEPT where DEPTNO=50;
commit;

-- emp 테이블에서 empno, ename, sal, comm만으로 구성된 뷰를 생성
create view KIM
as
select EMPNO, ENAME, SAL, COMM 
from EMP;
-- 사용은 테이블과 똑같다.
select * from KIM;
-- VIEW에 DML(삽입 삭제, 갱신) 작업은 가능한 경우도 있고 가능하지 않는 경우도 존재
DESC EMP;
-- view에 데이터 삽입
insert into KIM(EMPNO, ENAME, SAL, COMM) VALUES(999, 'MINO', 10000, 9000);
SELECT * FROM KIM;
-- 확인해 보면 EMP 테이블에 들어가있음
SELECT * FROM EMP;
-- VIEW 구조 확인
DESC KIM;
-- VIEW 삭제
DROP VIEW KIM;


-- 임시 테이블
create temporary table temp(
	name char(20)
);
select * from temp;

-- CTE : SQL 수행 중에만 일시적으로 
-- 메모리 공간을 할당받아서 사용하는 테이블
-- FROM 절에 쓰는 것 : INLINE VIEW
-- SUB QUERY는WHERE 뒤에 있는거
SELECT * 
FROM (SELECT NAME, SALARY, SCORE) FROM tStaff 
WHERE DEPART='영업부' AND GENDER='남') TEMP
WHERE SALARY>=(SELECT AVG(SALARY) FROM TEMP);
-- 이러면 WEHRE에 있는 TEMP가 뭔지 모른다.
-- 이와 유사한 작업을 INLINE VIEW에서 가능할거라 보이지만,
-- INLINE VIEW는 SUB QUERY보다 늦게 수행되기 때문에
-- INLINEEVESMS SUB QUERY에서 못쓴다.
WITH TEMP AS
(SELECT NAME, SALARY, SCORE FROM tStaff WHERE DEPART='영업부'AND GENDER='남')
SELECT * FROM TEMP WHERE SALARY>=(SELECT AVG(SALARY)FROM TEMP);


-- usertbl 테이블 본재 여부 확인
SELECT * FROM usertbl;
-- 프로시저 생성
-- delimiter는 프로시저 종료를 알리기 위한 기호설정
-- 왜냐하면 안에 이미 세미콜론이 있기 때문에 모르기 때문이다.
-- 두개로 쓰는 이유는 하나로 만들면 데이터로 사용되는 것과
-- 혼동이 올 수 있기 때문이다.
-- dbeaver에서 수행할 때는 sql script 실행으로 실행해야 한다.
delimiter //
create procedure myproc(vuserid char(15), vname varchar(20), 
						vbirthyear int(11), vaddr char(100), 
						vmobile char(11), vmdate date)
		begin
			insert into usertbl
			values(vuserid, vname, vbirthyear,vaddr, vmobile, vmdate);
		end//
delimiter ;
-- 지우기는 drop 입니다.
drop procedure myproc;
-- 실행하기
call myproc('mino', '이민호', 1998,'서울' ,'01012341234', '1998-09-25');
select * from usertbl;


-- 트리거를 수행하기 위한 샘플 테이블 생성
create table emp01(
	empno int primary key,
	ename varchar(30) not null,
	job varchar(100)
);
create table sal01(
	salno int primary key auto_increment,
	sal float(7,2),
	empno int references emp01(empno) on delete cascade
);
-- emp01 테이블에 데이터 추가시, sal01테이블에 데이터가 자동으로 추가되는 트리거
set global log_bin_trust_function_creators=on;
delimiter //
create trigger trg_01
after insert on emp01
for each row 
BEGIN 
	insert into sal01(sal,empno) values(100,NEW.empno);
END//
delimiter ;
insert into emp01 values(1,'mino','데이터분석가');
select * from emp01;
select * from sal01;

use mino;
show tables;
desc DEPT;
select * from DEPT;

-- 파일을 저장할 수 있는 테이블 생성
create table blobtable(
	filename varchar(100),
	filecontent longblob
);
desc blobtable;
select * from blobtable;