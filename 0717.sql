-- 앞에 -- 붙이면 mySQL에선 주석이다.
-- show databases;
-- db를 하나 만들자.
-- create database 이름;
-- db를 지우자. 실무에선 쓸 일 거의 없음
-- drop database 이름;
-- db를 만들면 사용하겠다고 말해야 한다.
use mino; -- 이게 첫 번째로 입력할 명령어다.
-- table이 있는지 확인해보자.
-- show tables;
show tables;


-- oracle sample데이터처럼 준비를 해보자.

CREATE TABLE tCity
(
	name CHAR(10) PRIMARY KEY,
	area INT NULL ,
	popu INT NULL ,
	metro CHAR(1) NOT NULL,
	region CHAR(6) NOT NULL
);

INSERT INTO tCity VALUES ('서울',605,974,'y','경기');
INSERT INTO tCity VALUES ('부산',765,342,'y','경상');
INSERT INTO tCity VALUES ('오산',42,21,'n','경기');
INSERT INTO tCity VALUES ('청주',940,83,'n','충청');
INSERT INTO tCity VALUES ('전주',205,65,'n','전라');
INSERT INTO tCity VALUES ('순천',910,27,'n','전라');
INSERT INTO tCity VALUES ('춘천',1116,27,'n','강원');
INSERT INTO tCity VALUES ('홍천',1819,7,'n','강원');

SELECT * FROM tCity;

CREATE TABLE tStaff
(
	name CHAR (15) PRIMARY KEY,
	depart CHAR (10) NOT NULL,
	gender CHAR(3) NOT NULL,
	joindate DATE NOT NULL,
	grade CHAR(10) NOT NULL,
	salary INT NOT NULL,
	score DECIMAL(5,2) NULL
);

INSERT INTO tStaff VALUES ('김유신','총무부','남','2000-2-3','이사',420,88.8);
INSERT INTO tStaff VALUES ('유관순','영업부','여','2009-3-1','과장',380,NULL);
INSERT INTO tStaff VALUES ('안중근','인사과','남','2012-5-5','대리',256,76.5);
INSERT INTO tStaff VALUES ('윤봉길','영업부','남','2015-8-15','과장',350,71.25);
INSERT INTO tStaff VALUES ('강감찬','영업부','남','2018-10-9','사원',320,56.0);
INSERT INTO tStaff VALUES ('정몽주','총무부','남','2010-9-16','대리',370,89.5);
INSERT INTO tStaff VALUES ('허난설헌','인사과','여','2020-1-5','사원',285,44.5);
INSERT INTO tStaff VALUES ('신사임당','영업부','여','2013-6-19','부장',400,92.0);
INSERT INTO tStaff VALUES ('성삼문','영업부','남','2014-6-8','대리',285,87.75);
INSERT INTO tStaff VALUES ('논개','인사과','여','2010-9-16','대리',340,46.2);
INSERT INTO tStaff VALUES ('황진이','인사과','여','2012-5-5','사원',275,52.5);
INSERT INTO tStaff VALUES ('이율곡','총무부','남','2016-3-8','과장',385,65.4);
INSERT INTO tStaff VALUES ('이사부','총무부','남','2000-2-3','대리',375,50);
INSERT INTO tStaff VALUES ('안창호','영업부','남','2015-8-15','사원',370,74.2);
INSERT INTO tStaff VALUES ('을지문덕','영업부','남','2019-6-29','사원',330,NULL);
INSERT INTO tStaff VALUES ('정약용','총무부','남','2020-3-14','과장',380,69.8);
INSERT INTO tStaff VALUES ('홍길동','인사과','남','2019-8-8','차장',380,77.7);
INSERT INTO tStaff VALUES ('대조영','총무부','남','2020-7-7','차장',290,49.9);
INSERT INTO tStaff VALUES ('장보고','인사과','남','2005-4-1','부장',440,58.3);
INSERT INTO tStaff VALUES ('선덕여왕','인사과','여','2017-8-3','사원',315,45.1);

SELECT * FROM tStaff;

DESC tStaff;

DESC tCity;

CREATE TABLE DEPT(
	DEPTNO INT(2),
	DNAME VARCHAR(14) ,
	LOC VARCHAR(13),
	CONSTRAINT PK_DEPT PRIMARY KEY(DEPTNO)
);


CREATE TABLE EMP(
	EMPNO INT(4),
	ENAME VARCHAR(10),
	JOB VARCHAR(9),
	MGR INT(4),
	HIREDATE DATE,
	SAL FLOAT(7,2),
	COMM FLOAT(7,2),
	DEPTNO INT(2),
	CONSTRAINT PK_EMP PRIMARY KEY(EMPNO),
	CONSTRAINT FK_DEPTNO FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO)
);

INSERT INTO DEPT VALUES(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES(30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES(40,'OPERATIONS','BOSTON');

INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,'1980-12-17',800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,'1981-2-20',1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,'1981-2-22',1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,'1981-4-2',2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,'1981-9-28',1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,'1981-5-1',2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,'1981-6-9',2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,'1987-7-13',3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,'1981-11-17',5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,'1981-9-8',1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,'1987-7-13',1100,NULL,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,'1981-12-3',950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,'1981-12-3',3000,NULL,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,'1982-1-23',1300,NULL,10);

CREATE TABLE SALGRADE
      ( GRADE INT,
	LOSAL INT,
	HISAL INT );
INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

COMMIT;

SELECT * FROM DEPT;

SELECT * FROM EMP;

SELECT * FROM SALGRADE;


-- 회원테이블
create table usertbl(
userid char(15) not null primary key,
name varchar(20) not null,
birthyear int not null, 
addr char(100),
mobile char(11),
mdate date)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 구매테이블
create table buytbl(
num int auto_increment primary key,
userid char(8) not null,
productname char(10),
groupname char(10),
price int not null,
amount int not null,
foreign key (userid) references usertbl(userid) on delete cascade)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 데이터 삽입
insert into usertbl values('kty', '김태연',1989,'전주','01011111111', '1989-3-9');
insert into usertbl values('bsj', '배수지',1994,'광주','01022222222', '1994-10-10');
insert into usertbl values('ksh', '김설현',1995,'부천','01033333333', '1995-1-3');
insert into usertbl values('bjh', '배주현',1991,'대구','01044444444', '1991-3-29');
insert into usertbl values('ghr', '구하라',1991,'광주','01055555555', '1991-1-13');
insert into usertbl values('san', '산다라박',1984,'부산','01066666666', '1984-11-12');
insert into usertbl values('jsm', '전소미',2001,'캐나다','01077777777', '2001-3-9');
insert into usertbl values('lhl', '이효리',1979,'서울','01088888888', '1979-5-10');
insert into usertbl values('iyou', '아이유',1993,'서울','01099999999', '1993-5-19');
insert into usertbl values('ailee', '에일리',1989,'미국','01000000000', '1989-5-30');

commit;

insert into buytbl values(null, 'kty', '운동화', '잡화', 30, 2);
insert into buytbl values(null, 'kty', '노트북', '전자', 1000, 1);
insert into buytbl values(null, 'jsm', '운동화', '잡화', 30, 1);
insert into buytbl values(null, 'lhl', '모니터', '전자', 200, 1);
insert into buytbl values(null, 'bsj', '모니터', '전자', 200, 1);
insert into buytbl values(null, 'kty', '청바지', '잡화', 100, 1);
insert into buytbl values(null, 'lhl', '책', '서적', 15, 2);
insert into buytbl values(null, 'iyou', '책', '서적', 15, 7);
insert into buytbl values(null, 'iyou', '컴퓨터', '전자', 500, 1);
insert into buytbl values(null, 'bsj', '노트북', '전자', 1000, 1);
insert into buytbl values(null, 'bjh', '메모리', '전자', 50, 4);
insert into buytbl values(null, 'ailee', '운동화', '잡화', 30, 2);
insert into buytbl values(null, 'ghr', '운동화', '잡화', 30, 1);

commit;

-- 명령문을 선택하고 마우스 우클릭을 눌러 [sql 스크립트 실행]을 선택
-- 스크립트 실행 중 오류가 발생하면, 오류를 수정하고 그 다음부터 블럭을 잡고 다시 명령을 수행


-- sample 데이터 확인 * : 모든 데이터
select * from tCity;
select * from tStaff;
select * from DEPT;
select * from EMP;
select * from SALGRADE;
select * from usertbl;
select * from buytbl;
-- 볼드 갈색빛으로 나오는 것은 대소문자 구별 안함. 
-- 하지만 저 애들은 예약어이다. 

-- tCity 테이블에서 name과 popu만 조회
select NAME, popu from tCity;
-- tCity 테이블에서 region nane, area 컬럼을 조회
select region, name, region from tCity;
-- name은 도시이름, are는 면적 , popu는 인구로 출력
-- as 안써도 되지만 별명에 영문대문자, 공백이 있다면 ""안에 써야한다.
select name as "도시이름", area 면적, popu "인 구" from tCity;

-- tCity 테이블에서 popu에 10000을 곱한 값을 출력
select popu*10000 from tCity; -- 이러면 컬럼명이 popu*10000이 된다.
select popu*10000 as "실제 인구 수" from tCity; -- 계산식에는 이름을 붙이자.
-- tCity 테이블에서 popu에 10000을 곱한 뒤 area로 나눈 데이터를 출력하자.
select popu*10000/area as "면적대비 인구수" from tCity;

select 60*20*2+4; -- 오라클은 에러


-- name, area 출력을 하고 싶어요 tCity에서
select name, area from tCity; -- 배운건 이거
select CONCAT(name,' : ',area) from tCity; 

-- tCity 에서 region값을 조회하고 싶어 // 중복없이 보고싶어
select DISTINCT region from tCity;
select region from tCity group by region; -- group by 는 동일한거 묶는거여서 되는거야
-- 해당 결과의 CARDINALITY 는 5, DEGREE 는 1이다.
-- 두 개 이상을 검색하려면 둘 다 같아야지 중복으로 본다. 
select DISTINCT region, name from tCity;

-- tCity 에서 모든 데이터 조회하는데 popu의 오름차순
select * from tCity order by popu asc;

-- tCity 에서 region, name, area, popu 조회하는데,
-- region 오름차순 조회
select region, name, area, popu from tCity order by region;
-- tCity 에서 region, name, area, popu 조회하는데,
-- region 오름차순 조회이지만 동일한 값이면 area가 큰 것이 먼저
select region as "지역", name as "이름", area, popu from tCity order by 지역 asc, 3 DESC ;

desc tStaff;
-- tStaff 에서 모든 데이터 조회하되, salary 작은사람부터, 동일하다면 score 높은사람부터
select * from tStaff order by salary ,score DESC ;

-- MySQL과 MariaDB는 기본적으로 대소문자 구분을 하지 않고 조회한다.
-- tCity 테이블에서 name이 서울인 데이터 조회
select * from tCity where name='서울';
-- tCity 테이블에서 metro 가 y인 데이터 조회
select * from tCity where BINARY (metro)='Y';
select * from tCity where BINARY (metro)='y';


-- tStaff 테이블에서 score조회
select score from tStaff;
-- tStaff 테이블에서 score null인모든 컬럼 조회
select * from tStaff where score is null;
-- tStaff 테이블에서 score null이 아닌 모든 컬럼 조회
select * from tStaff where score is not null;
-- emp table에서 comm의 값이 null인 데이터의 ename과 sal, comm을 조회
select ENAME, SAL ,COMM from EMP where COMM is NULL;

select * from tStaff;
-- tCity 테이플에서 popu가 100이상이고 area가 700 이상인 데이터 조회
-- and나 or에서 조건의 순서는 결과에 영향을 미치지 않고, 과정에 영향을 미친다.
select * from tCity where POPU>=100; -- 2개 데이터
select * from tCity where AREA>=700;-- 5개 데이터
select * from tCity where POPU>=100 and AREA>=700; -- 2개 데이터 고르고 뒤의 조건 확인
-- tStaff 테이블에서 salary 가 300미만이거나 score가 60이상인 직원의 모든 컬럼 조회
select * from tStaff where salary <300; -- 5개 데이터
select * from tStaff where score >=60; -- 10개 데이터
select * from tStaff where score >=60 or salary <300; -- 10개 데이터 고른 뒤 5개 데이터 보기

-- tCity 테이블에서 name에 천이 포한됨 모든 데이터 조회
select * from tCity where name like'%천%';
-- EMP 테이블에서 ename에 L이 2개 포함된 데이터를 조회
select * from EMP where ENAME like '%L%L%';
-- EMP 테이블에서 ename에 L이 2개 이상 포함된 데이터를 조회
select * from EMP where ENAME like '%L%L%';
-- sale에 30%가 포함된 데이터를 조회
-- select * from ~~ where sale like '%30#%%' ESCAPE '#' ;
#뒤에 나오는 것은 일반 문자로 취급
-- tStaff 테이블에서 joindate(입사일)가 10월인 사원을 조회
select * from tStaff where joindate like '%-10-%';

-- tCity table에서 popu가 50에서 100사이인 데이터 조회
select * from tCity where popu >=50 and popu<= 100;
select * from tCity where popu BETWEEN 50 and 100;

-- tStaff table에서 joindate 가 2018인 데이터 조회
select * from tStaff where joindate like '2018-%';
select * from tStaff where joindate BETWEEN '2018-01-01' and '2018-12-31';

-- tCity table에서 region이 경상 또는 전라인 데이터 조회
select * from tCity where region in('경상','전라');
-- tCity table에서 region이 경상 또는 전라가 아닌 데이터 조회
select * from tCity where region not in('경상','전라');

-- tCity table에서 area가 넓은 3개의 데이터를 조회할거야
select * from tCity order by area DESC LIMIT 3;
-- 그 다음 3개를 할 수 있을까?
select * from tCity order by area DESC LIMIT 3,3;

-- tStaff 테이블에서 salary가 12위부터 16위까지 조회
select * from tStaff order by salary LIMIT 4, 5;
select * from tStaff order by salary DESC LIMIT 5 OFFSET 11;

-- tStaff table에서 name과 score 조회를 하는데 score 소수 반올림하자
select name, round(score,0) from tStaff;
-- 글자 수 와 바이트 수 확인하기
select CHAR_LENGTH("문자열"), LENGTH("문자열"); 

-- EMP table에서 HIREDATE가 1981년인 데이터 조회
select * from EMP where HIREDATE like '1981%';
select * from EMP where SUBSTRING(HIREDATE,1,4)='1981'; 
-- EMP table에서 ENAME이 E로 끝나는 사원 정보를 조회
select * from EMP where ENAME like '%E';
select * from EMP where SUBSTRING(ENAME, -1, 1) ='E';
select * from EMP where SUBSTRING(ENAME, CHAR_LENGTH(ENAME), 1) ='E';
-- 만약 ENAME에 한글이름이 있었따면 char_length이용, 영어면 같으니 length 가능
select LENGTH(ENAME) from EMP;
select CHAR_LENGTH(ENAME) from EMP; 

-- EMP 테이블에서 hiredate는 날짜(입사일)을 가지고 있는 컬럽.
select ename, CURRENT_DATE()-hiredate as "근속일수" from EMP;