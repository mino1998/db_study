use mino;

-- 테이블 생성
-- 테이블 이름은 contact
-- 속성
	-- num은 정수이고 일련번호 그리고 기본키
	-- name은 한글 7글자까지 저장하고 글자 수 는 변경되지 않는다고 가정
	-- address는 한글 100자까지 저장하고 글자 수의 변경이 자주 발생
	-- tel은 숫자로된 문자열 11자리이고 글자 수의 변경은 발생하지 않음
	-- email은 영문 100자 이내이고 글자 수의 변경이 자주 발생
	-- birth 는 날짜만 저장
	-- 주로 조회를 하고 일련번호는 1부터 시작하며, 인코딩은 utf8
CREATE TABLE contact(
	num INTEGER AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(21), -- 변경되지 않기 때문에 VARCHAR의 문제가 없다.
	address TEXT,
	tel VARCHAR(11),
	email CHAR(100),
	birth DATE
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- contact 테이블에 age 컬럼을 정수 자료형으로 추가하기
ALTER TABLE contact ADD age INTEGER;

-- contact 테이블 구조 확인하기
DESC contact;

-- age 컬럼을 삭제해보자.
ALTER TABLE contact DROP age;

-- contact 테이블에서 tel컬럼의 이름을phon으로 자료형은 정수로 수정하자.
ALTER TABLE contact 
CHANGE tel phone INTEGER;

-- conatact 테이블 삭제
DROP TABLE contact;
-- 테이블 삭제 확인
SHOW TABLES;
-- 얘는 EMP TABLE FOREIGN키로 DEPTNO 컬럼 참조하기에 삭제 불가능
-- DROP TABLE DEPT; 

-- not null 제약조건 설정
CREATE TABLE tNullable(
	name CHAR(10) not null,
	age int
);
insert into tNullable(name, age) values("mino","123");
-- 에러
insert into tNullable(age) vaules(44);
drop table tNullable;

-- 기본값 설정
CREATE TABLE tDefault(
	name CHAR(10) not null,
	age INTEGER DEFAULT 24
);
insert into tDefault(name, age) values("mino",26);
insert into tDefault(name) values("mino2");
select * from tDefault;
drop table tDefault;

-- name, gender(성별 - 남, 여), age(나이는 양수)를 속성으로 갖는
-- 테이블 생성
CREATE TABLE tCheck(
	name CHAR(10) NOT NULL,
	gender CHAR(3) CHECK(gender IN('남','여')),
	age INTEGER CHECK(age>=0)
);
INSERT INTO tCheck(name, gender, age) VALUES ('이민호', '남', 26);
INSERT INTO tCheck(name, gender, age) VALUES ('이민호', '남자', 26);
INSERT INTO tCheck(name, gender, age) VALUES ('이민호', '남', -26);
SELECT * FROM tCheck;
DROP TABLE tCheck;

-- 기본키 설정 : 제약조건 이름없이 생성
CREATE TABLE tPK1(
	name char(10) primary key,
	age int
);
-- 기본키 설정 : 제약조건 이름과 함께 생성
CREATE TABLE tPK2 (
	name char(10) PRIMARY KEY,
	age int
);
-- 기본키 설정 : 테이블 제약 조건	
CREATE TABLE tPK3(
	name char(10),
	age int,
	constraint tpk3_pk primary key(name)
);
-- 2개의 컬럼으로 기본키 설정: 테이블 생성 시, primary key는 한번만 사용가능
-- 이건 오류
CREATE TABLE tPK4(
	name char(10) primary key,
	age int primary key,
);
-- 무조건 이건 테이블제약으로 해야함
CREATE TABLE tPK4(
	name char(10),
	age int,
	constraint pk4_pk primary key(name, age)
);
insert into tPK1(name, age) values('mino', 24);
-- 기본키인 name의 값이 같아서 삽입 실패
insert into tPK1(name, age) values('mino', 25);
-- 기본키인 name의 값이 null이라 삽입 실패
insert into tPK1(age) values(26);


-- UNIQUE
create table tUnique(
	name char(10),
	age int unique,
	constraint tunique primary key(name)
);
insert into tUnique(name, age) values('mino', 26);
-- age 중복으로 실패
insert into tUnique(name, age) values('mino2',26);
-- null 들어가짐, null은 중복체크 대상이 아니라서 가능함
insert into tUnique(name) values('mino3');
select * from tUnique;

-- 외래키를 지정하지 않는 2개의 테이블
-- 직원 테이블
create table temployee(
	name char(10) primary key,
	salary int not null,
	addr varchar(30) not null
);
insert into temployee values('mino', 550, '서울');
insert into temployee values('mino2', 750, '경기');
insert into temployee values('mino3', 950, '판교');
select * from temployee;
-- 프로젝트 테이블
-- employee는 프로젝트에 참여한 직원이다.
create table tproject(
	projectID int primary key,
	employee char(10) not null,
	project varchar(30) not null,
	cost int
);
insert into tproject values(1, 'mino', '웹 서비스', 3000);
-- temployee 에 없는 mino4인데 입력되는 상황
insert into tproject values(2, 'mino4', 'microservie 구축', 3000);
select * from tproject;

-- 외래키 설정 : 직우너과 프로젝트의 관계는 1:N이다.
-- 직원 테이블
create table temployee(
	name char(10) primary key,
	salary int not null,
	addr varchar(30) not null
);
insert into temployee values('mino', 550, '서울');
insert into temployee values('mino2', 750, '경기');
insert into temployee values('mino3', 950, '판교');
-- 프로젝트 테이블
-- employee는 프로젝트에 참여한 직원이다.
create table tproject(
	projectID int primary key,
	employee char(10) not null references temployee(name),
	project varchar(30) not null,
	cost int
);
-- 테이블 제약 조건 방식(권장)
create table tproject(
	projectID int primary key,
	employee char(10) not null,
	project varchar(30) not null,
	cost int,
	constraint fk_emp foreign key(employee) references temployee(name)
);
show tables;
insert into tproject values(1, 'mino', '웹 서비스', 3000);
-- temployee 에 없는 mino4인데 입력되는 상황
insert into tproject values(2, 'mino4', 'microservie 구축', 5000);
-- mino2는 입력 프로젝트 테이블에 없다.
delete from temployee where name='mino2';
-- mino는 프로젝트 테이블에도 존재하기에 에러가 난다.
delete from temployee where name='mino';
-- employee테이블은 삭제도 안된다.
drop table temployee;
drop table tproject;
show tables;
select * from temployee;
select * from tproject;

-- 옵션 공부하기
create table temployee(
	name char(10) primary key,
	salary int not null,
	addr varchar(30) not null
);
insert into temployee values('mino', 550, '서울');
insert into temployee values('mino2', 750, '경기');
insert into temployee values('mino3', 950, '판교');
select * from temployee;
-- 삭제 / 수정 시 각 테이블에 있는 데이터가 동일하게 진행되도록
create table tproject(
	projectID int primary key,
	employee char(10) not null,
	project varchar(30) not null,
	cost int,
	constraint fk_emp foreign key(employee) 
	references temployee(name)
	on delete cascade
	on update cascade 
);
insert into tproject values(1, 'mino', '웹 서비스', 3000);
-- mino 가 prjoect에 들어가있음
select * from tproject;
-- 역시나 안됨
insert into tproject values(2, 'mino4', 'microservie 구축', 5000);
-- employee에서 지워진다. 이제
delete from temployee where name='mino';
select * from tproject;
select * from temployee;
UPDATE temployee SET name='minomino' where name='mino';
-- 반대는 안된다.
UPDATE tproject SET employee='minomino' where employee='mino';


drop table tproject;
drop table temployee;

-- 옵션 SET NULL 
create table temployee(
	name char(10) primary key,
	salary int not null,
	addr varchar(30) not null
);
insert into temployee values('mino', 550, '서울');
insert into temployee values('mino2', 750, '경기');
insert into temployee values('mino3', 950, '판교');
select * from temployee;
-- 삭제 / 수정 시 set null
create table tproject(
	projectID int primary key,
	employee char(10), -- set null 할때 not null 빼야해
	project varchar(30) not null,
	cost int,
	constraint fk_emp foreign key(employee) references temployee(name)
	on delete SET NULL on update SET NULL
);
insert into tproject values(1, 'mino', '웹 서비스', 3000);
-- mino 가 prjoect에 들어가있음
select * from tproject;
-- employee에 있는 애를 삭제해보자.
delete from temployee where name='mino';
-- employee에 있는 애를 바꿔보자.
UPDATE temployee SET name='minomino' where name='mino';
select * from tproject;
select * from temployee;
-- 참조 하는 데이터가 값이 수정당하니까 NULL이 되어버렸다.
-- 참조 당하는 데이터는 바로 바뀌었고



-- 일련번호 사용
-- primary key 지정 혹은 unique를 해줘야 합니다.
create table board(
	num int AUTO_INCREMENT PRIMARY KEY,
	title char(100),
	content text
);
-- num을 빼고 넣어도 num은 자동으로 증가되면서 들어가진다.
insert into board(title, content) values("제목", "안녕하세요?");
insert into board(title, content) values("제목2", "안녕하세요?2");
select * from board;
-- 2번 데이터를 삭제하고 하나 넣으면?
delete from board where num=2;
insert into board(title, content) values("제목3", "안녕하세요?3");
select * from board;
-- 이것의 것을 지웠다고 해서 숫자가 줄어드는 것은 아니다.
-- auto_increment 값도 직접 넣을 수 있다. 다음 값은 모르겠다.
insert into board(num, title, content) values(400,"제목4","안녕하세요?4");
insert into board(title, content) values("제목5","안녕하세요?5");
insert into board(title, content) values("제목6", "안녕하세요?6");
select  *from board;
-- 중간에 초기값을 변경할 수 있어요
alter table board auto_increment =1000;
insert into board(title, content) values("제목7", "안녕하세요?7");
select * from board;
drop table board;

select * from information_schema.table_constraints;






-- 데이터 삽입을 위해서 테이블 구조를 확인
DESC tCity;
-- 컬럼 이름을 나열해서 데이터를 삽입하기
insert into tCity(name, area, popu, metro, region) 
values("영등포", 600, 200, 'y', '서울');
-- 모든 컬럼의 값을 순서대로 입력하는 경우는 컬럼 이름 생략이 가능
insert into tCity values('구로', 40,60,'y','서울');
-- not null이 설정된 컬럼을 제외하고는 생략하고 삽입 가능합니다.
insert into tCity(name, area,metro,region) values('양천구',60,'y', '서울');
-- 한꺼번에 삽입도 가능합니다.
insert into tCity(name, area, popu, metro, region) 
values("문래동", 90, 20, 'y', '서울'),('목동',230,29,'y', '서울');
select * from tCity;

-- 데이터 삭제하기
delete from tCity where name in("구로","목동","문래동","양천구","영등포");
select * from tCity;

ㅌ
