use mino;
show tables;

-- 현재 유저 확인
SELECT USER();
-- 현재 사용중인 데이터베이스 확인
SELECT DATABASE();
-- MySQL은 매개변수가 없는 함수는 이름만으로 수행이 가능함

-- EMP 테이블에서 ENAME과 COMM, SAL을 조회하고 싶다.
SELECT ENAME, COMM, SAL FROM EMP;
-- 조회결과, COMM에는 NULL인 데이터가 존재한다.
-- EMP 테이블에서 ENAME과 SAL, COMM 그리고 SAL+COMM을 조회
SELECT ENAME, SAL, COMM, SAL+COMM FROM EMP;
-- NULL과 연산을 하면 NULL이 나오기 때문에 다르게 해줘야 한다.
-- COMM이 NULL이면 0으로 하자.
SELECT ENAME, SAL, COMM, SAL+IFNULL(COMM, 0) FROM EMP;

-- COMM이 NULL이 아니면 COMM을, COMM이 NULL이고 SAL이 NULL이 아니면 SAL을 리턴
SELECT COALESCE(COMM,SAL) FROM EMP;

-- EMP 테일블의 데이터 개수를 조회해보자.
-- EMP 테이블에서 EMPNO가 NULL이 아닌 데이터 개수 조회
SELECT COUNT(EMPNO) FROM EMP;
-- NULL이 아닌 COMM 데이터 개수를 조회한 것
SELECT COUNT(COMM) FROM EMP;
-- 그래서 COUNT는 아래와 같이 쓰는 것이 허용됨
-- 모든 컬럼이 NULL이 아닌 데이터의 개수
SELECT COUNT(*) AS CNT FROM EMP;

-- EMP 테이블에서 SAL의 평균
SELECT ROUND(AVG(SAL),2) FROM EMP;
-- EMP 테이블에서 COMM의 평균은?
-- 4개 데이터는 NOT NULL, 10개는 NULL
SELECT ROUND(AVG(COMM),2) FROM EMP;
-- 2개의 결과가 너무 다르다.
SELECT ROUND(AVG(IFNULL(COMM,0)),0) FROM EMP;
-- 오류를 내보자.
-- SELECT ENAME FROM EMP WHERE AVG(SAL)>100;

-- ENAME과 데이터 개수를 조회해보자. - 에러
-- ENAME은 14개, COUNT(*)는 1개여서 못함
-- MARIADB는 그럼 ENAME에서 맨앞 1개를 출력해서 맞춤
-- SELECT ENAME, COUNT(*) FROM EMP;

-- EMP 테이블에서 DEPTNO별로 SAL의 평균을 조회해보자.
SELECT DEPTNO, AVG(SAL) FROM EMP GROUP BY DEPTNO;
-- SELECT ~ FROM 에 있는 데이터의 개수는 같아야 하며,
-- GROUP화된 값들만 들어갈 수 있다.
-- tCity 테이블에서 REGION별 POPU이 합계를 조회
SELECT region "지역" ,SUM(popu) "인구합계" FROM tCity GROUP BY region;
-- 2개 이상의 컬럼으로 그룹화가 가능
-- tStaff 테이블에서 depart, gender별로 데이터 개수 조회
select depart, gender,  count(*) 인원수 from tStaff group by depart, gender order by 인원수; 

-- emp 테이블에서..
select DEPTNO, count(*) from EMP group by DEPTNO ;
-- emp 테이블에서 deptno가 5번 이상 나오는 경우, deptno 와 sal의 평균 조회
-- 그룹화가 되기 전에 그룹 함수를 사용해서 에러남
-- select deptno, count(*) from EMP where count(deptno)>=5 group by deptno;
-- group 함수를 이용한 조건은 having 저레 기재해야 합니다.
select deptno, avg(sal) from EMP group by deptno having count(deptno)>=5;

-- tStaff 테이블에서 depart별로 salary 평균이 340이 넘는 부선의 depart와 salary 평균 조회
select depart, avg(salary) from tStaff group by depart having avg(salary)>340;
-- tStaff 테이블이서 depart가 인사과나 영업부인 데이터의 depart의 salary의 최대값 조회
-- 잘못 만든 예시 (결과는 맞긴 함)
select depart 부서 , max(salary) "최대 급여" from tStaff group by depart having depart in("영업부","인사과");
-- 이렇게 해도 된다.
select depart 부서 , max(salary) "최대 급여" from tStaff where depart in("영업부", "인사과") group by depart
-- 과연 어떤 것으로 써야 하는 것일까? where? having?
-- where로 쓰는 것이 좋다. where, having은 필터링이고
-- 필터링은 먼저 하는 것이 좋다.
-- 집계함수를 쓸 때만 having에서 거르는 것이다.

-- EMP 테이블에서 SAL이 많은 순서부터 일련번호를 부여해서 ENAME과 SAL을 조회하고 싶다.
-- 순위가 없음
SELECT ENAME, SAL FROM EMP ORDER BY SAL DESC;
-- 순위를 넣자.
SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) AS 순위, ENAME, SAL FROM EMP;
-- 이번엔 동일한 값은 동순위를 넣어주자. 
SELECT DENSE_RANK() OVER(ORDER BY SAL DESC) AS 순위, ENAME, SAL FROM EMP;
-- 동순위 다음에는 건너 뛴 순위가 나오게 해줘
SELECT RANK() OVER(ORDER BY SAL DESC) AS 순위, ENAME, SAL FROM EMP;

-- NTILE은 뭐야(N등으로 나눈거임)
SELECT NTILE(2) OVER(ORDER BY SAL DESC) AS 순위, ENAME, SAL FROM EMP;
-- PARTITION은 뭐야
-- EMP 테이블에서 DEPTNO별로 SAL많은 순서부터 동일 값은 동순위 부여해서 ENAME과 SAL 조회
SELECT DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS "순위", DEPTNO 부서코드,ENAME, SAL FROM EMP;

-- EMP 테이블에서 SAL을 내림차순 정렬한 다음, 다음 테이터와의 SAL의 차이를 알고자 하는 경우
SELECT ENAME, SAL,IFNULL(SAL- (LEAD(SAL,1) OVER(ORDER BY SAL DESC)),0) AS "이전 데이터와의 차이" FROM EMP;
-- EMP 테이블에서 SAL을 내림차순 정렬한 다음, 이전 테이터와의 SAL의 차이를 알고자 하는 경우
SELECT ENAME, SAL,IFNULL(SAL-(LAG(SAL,1) OVER(ORDER BY SAL DESC)),0) AS "이전 데이터와의 차이" FROM EMP;

-- EMP 테이블에서 SAL을 내림차순 정렬한 다음, 첫 번쨰 테이터와의 SAL의 차이를 알고자 하는 경우
SELECT ENAME, SAL,IFNULL(SAL- (FIRST_VALUE (SAL) OVER(ORDER BY SAL DESC)),0) AS "첫 데이터와의 차이" FROM EMP;
-- EMP 테이블에서 SAL을 내림차순 정렬한 다음, 마지막 번쨰 테이터와의 SAL의 차이를 알고자 하는 경우
-- 왜 LAST_VALUE를 했을 떄는 0이 나오는거지??
-- 데이터는 행단위로 보고 가기에 항상 LAST_VALUE는 보고 있는 나 자신이기에 SAL-SAL 형태가 되는거임
SELECT DEPTNO ,ENAME, SAL,SAL- (LAST_VALUE (SAL) OVER(PARTITION BY DEPTNO ORDER BY SAL DESC)) AS "마지막 데이터와의 차이"
,IFNULL(SAL- (FIRST_VALUE (SAL) OVER(PARTITION BY DEPTNO ORDER BY SAL DESC)),0) AS "첫 데이터와의 차이" FROM EMP;

-- 급여의 누적 백분율
SELECT ENAME, SAL, CUME_DIST()OVER(ORDER BY SAL DESC)*100 AS "누적 백분율" FROM EMP;

-- JOB 별, DEPTNO별 SAL의 합게를 구하고 싶음
select job, deptno, sum(sal) from EMP group by job, deptno order by job, deptno;
-- 이번엔 pivot을 이용해보자.
select job, sum(if(deptno=10, sal, 0)) as '10',
	sum(if(deptno=20, sal, 0)) as '20',
	sum(if(deptno=30, sal, 0)) as '30',
	sum(sal) as '직업 별 합계'
from EMP group by job;

-- json 출력
select ename, sal from EMP;
select JSON_OBJECT("ENAME",ENAME, "SAL",SAL) AS 'JSON 조회' FROM EMP;


-- SET 연산자
-- EMP 테이블에서 DEPTNO를 조회 : 10, 20, 30
SELECT DISTINCT DEPTNO FROM EMP;
-- DEPT 테이블에서 DEPTNO를 조회 : 10, 20, 30, 40
SELECT DISTINCT DEPTNO FROM DEPT;
-- EMP테이블과 DEPT 테이블에서 DEPTNO의 합집합을 구해보자.
SELECT DEPTNO FROM EMP UNION SELECT DEPTNO FROM DEPT;
-- EMP테이블과 DEPT 테이블에서 DEPTNO의 합집합을 구해보자. 다 나오게 하자
SELECT DEPTNO FROM EMP UNION ALL SELECT DEPTNO FROM DEPT;
-- 교집합은?
SELECT DEPTNO FROM EMP INTERSECT SELECT DEPTNO FROM DEPT;
-- DEPT에는 존재하지만, EMP에는 존재하지 않는 DEPTNO는?
SELECT DEPTNO FROM DEPT EXCEPT SELECT DEPTNO FROM EMP;

-- 테이블 구조 확인
DESC EMP;
DESC DEPT;

-- ENAME이 MILLER 인 사람의 DNAME을 조회
SELECT DEPTNO FROM EMP WHERE ENAME='MILLER';
SELECT DNAME FROM DEPT WHERE DEPTNO=10;
-- 여러 번 QUERY 날리는거 안좋다.
SELECT DNAME FROM DEPT WHERE DEPTNO=(SELECT DEPTNO FROM EMP WHERE ENAME='MILLER');

-- EMP 테이블에서 SAL의 평균보다 더 많은 SAL을 받는 직원의 ENAME과 SAL을 조회
SELECT ENAME, SAL FROM EMP WHERE SAL>(SELECT AVG(SAL) FROM EMP);
-- emp 테이블에서 miller씨랑 동일한 job을 가진 사람의 이름과 job을 조회 miller는 제외
SELECT ENAME, JOB FROM EMP WHERE JOB=(SELECT JOB FROM EMP WHERE ENAME='MILLER') and ename!='miller';
-- emp 테이블에서 dept 테이블의 loc이 DALLAS인 사람의 ename과 sal을 조회
SELECT ENAME, SAL FROM EMP WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE LOC='DALLAS');

-- EMP 테이블에서 DEPTNO별 SAL의 최대값과 동일한 SAL을 갖는 사원의 EMPNO, ENAME, SAL을 조회하자
-- SELECT EMPNO, ENAME, SAL FROM EMP WHERE SAL=(SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);
-- SUB QUERY 결과가 2개 이상인 경우, 그 중의 하나의 값과 일치하면 됩니다.
SELECT EMPNO, ENAME, SAL, DEPTNO  FROM EMP WHERE SAL IN(SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);

-- EMP 테이블에서 DEPTNO가 30인 데이터들의 SAL보다 큰 데이터의 ENAME과 SAL 조회
SELECT ENAME, SAL FROM EMP WHERE SAL > ALL(SELECT SAL FROM EMP WHERE DEPTNO=30);
-- 하지만 그냥 MAX 가져오면 되는거 아냐?
SELECT ENAME, SAL FROM EMP WHERE SAL > (SELECT MAX(SAL) FROM EMP WHERE DEPTNO=30);
-- 이렇게 되면 DEPTNO30인 애들 데이터들 중에 가장 작은거보다 크다라는 것이다.
SELECT ENAME, SAL FROM EMP WHERE SAL > ANY(SELECT SAL FROM EMP WHERE DEPTNO=30);
-- MIN으로 대체 가능
SELECT ENAME, SAL FROM EMP WHERE SAL > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO=30);


-- EMP 테이블에서 SAL 이 2000이 넘는 데이터가 있으면 ENAME과 SAL을 조회
SELECT ENAME, SAL FROM EMP WHERE EXISTS (SELECT 1 FROM EMP WHERE SAL>2000)

-- CARTESIA PRODUCT (교차 곱)
-- EMP 8열 14행, DEPT 3열 4행
-- 결과는 11열 56행
SELECT * FROM EMP, DEPT;

-- EQUI JOIN(동등 조인)
-- FROM 절에 테이블 이름이 2개 이상이고 WHERE 절에 2개 테이블의 공통된 컬럼이 같다는 조인 조건이 있는 경우
-- 몇개가 나올지는 알 수 없다.
SELECT * FROM EMP,DEPT WHERE EMP.DEPTNO =DEPT.DEPTNO ;

-- 한쪽 테이블에만 존재하는 컬럼을 출력할 떄는 컬럼 이름만 써도 되지만, 같은 이름 두 테이블에 있으면 테이블.컬럼 이렇게 쓰자.
-- 그렇게 안해주면 이름이 ABIGIOUS모호해새 어디서 가져올지 몰라 에러남
SELECT ENAME, EMP.DEPTNO, DNAME, LOC FROM EMP, DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;

-- 테이블 이름에 새로운 이름 부여
SELECT ENAME, E.DEPTNO, DNAME, LOC FROM EMP E, DEPT D WHERE E.DEPTNO=D.DEPTNO;


-- HASH JOIN
-- EMP DEPT 중 어떤 것이 데이터가 적을까?DEPT!
SELECT /*+ ORDERED USE_HASH(E) */ ENAME, DNAME, LOC FROM DEPT D, EMP E WHERE D.DEPTNO =E.DEPTNO ;

-- NONE EQUI JOIN
-- EMP 테이블에는 SAL은 급여이다.
-- SALGRADE에서는 LOSAL은 최저급여 HISAL은 최대급여이고 GRADE는 등급
-- EMP 테이블에서 ENAME과 SAL을 조회하고 SAL에 해당하는 GRADE를 조회하는 경우
-- LOSAL HISAL이라서 범위이다. 결국 동등 연산이 아닐 수 있다
SELECT ENAME, SAL, GRADE
FROM EMP, SALGRADE
WHERE SAL BETWEEN LOSAL AND HISAL;


-- SELF JOIN
-- EMP 테이블에서 ENAME이 MILLER인 사원의 관리자 ENAME을 조회하고 싶어
SELECT EMPL.ENAME ,MAN.ENAME 
FROM EMP EMPL,EMP MAN 
WHERE EMPL.MGR=MAN.EMPNO AND EMPL.ENAME='MILLER';


-- ANSI CROSS JOIN
SELECT * FROM EMP CROSS JOIN DEPT;


-- ANSI INNER JOIN
SELECT * FROM EMP INNER JOIN DEPT ON EMP.DEPTNO =DEPT.DEPTNO ;
-- 컬럼 이름이 똑같으면? USING! 얘도 해당 컬럼은 한번만 나오네
SELECT * FROM EMP INNER JOIN DEPT USING(DEPTNO);


-- ANSI NATURAL JOIN
-- NATURAL JOIN은 동일한 컬럼을 1번만 출력함
SELECT * FROM EMP NATURAL JOIN DEPT;

-- ANSI OUTER JOIN 
SELECT DISTINCT DEPTNO FROM EMP; 
SELECT DEPTNO FROM DEPT; 
-- EMP에 존재하는 모든 DEPTNO가 JOIN에 참여
SELECT * 
FROM EMP LEFT OUTER JOIN DEPT 
ON EMP.DEPTNO =DEPT.DEPTNO ; -- 14행
-- DEPT에 존재하는 모든 DEPTNO가 JOIN에 참여
-- DEPT에 존재하지만 EMP에는 존재하지 않던 DEPTNO=40 이 참여
-- 40인 행에서 자신이 가지고 있는 데이터 말고는 다 NULL 이겠지
SELECT * 
FROM EMP RIGHT OUTER JOIN DEPT 
ON EMP.DEPTNO =DEPT.DEPTNO ; -- 15행

-- MySQL은 FULL OUTER JOIN을 지원하지 않습니다.
SELECT *
FROM EMP FULL OUTER JOIN DEPT
ON EMP.DEPTNO =DEPT.DEPTNO; -- 이 쿼리는 오류가 납니다.
-- UNION 으로 FULL OUTER JOIN 해결하기
(SELECT * 
FROM EMP LEFT OUTER JOIN DEPT 
ON EMP.DEPTNO =DEPT.DEPTNO )
UNION
(SELECT * 
FROM EMP RIGHT OUTER JOIN DEPT 
ON EMP.DEPTNO =DEPT.DEPTNO )