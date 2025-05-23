SELECT 'successe' FROM dual;
SELECT count(*) FROM HR.bigEmployees be ;

CREATE USER "USER1" IDENTIFIED BY "1234";

GRANT ALL ON SHOP.membertbl TO "USER1";
GRANT ALL ON SHOP.producttbl TO "USER1";
GRANT SELECT ON HR.bigEmployees TO "USER1";

SELECT * FROM hr.bigemployees;

CREATE USER "DIRECTOR" IDENTIFIED BY "1234";

ALTER USER "DIRECTOR" account unlock;

GRANT CREATE SESSION TO "DIRECTOR";

GRANT ALL ON SHOP.membertbl TO "DIRECTOR";
GRANT ALL ON SHOP.producttbl TO "DIRECTOR";
GRANT SELECT ON HR.bigemployees TO "DIRECTOR"

SELECT * FROM usertbl;

SELECT * FROM buytbl;

CREATE TABLE buytbl2 AS (SELECT * FROM buytbl);
SELECT * FROM buytbl2;


CREATE TABLE buytbl3 AS (SELECT userid, prodname FROM buytbl);
SELECT * FROM buytbl3;

SELECT userid AS "사용자명", sum(amount) AS "총구매량"
FROM buytbl GROUP BY userid;

SELECT userid AS "사용자명", sum(amount*price) AS "총구매액"
FROM buytbl GROUP BY userid;


SELECT CAST(avg(amount) AS NUMBER(5,3)) AS "평균 구매 수량"
FROM buytbl;

SELECT CAST(avg(amount) AS NUMBER(5,3)) AS "평균 구매 수량"
FROM buytbl GROUP BY userid;

SELECT username, max(height), min(height)
FROM usertbl GROUP BY username;

SELECT username, height FROM USERTBL
WHERE height = (SELECT max(height) FROM usertbl)
OR height = (SELECT min(height) FROM usertbl);


SELECT count(*) FROM usertbl;

SELECT count(mobile1) AS "휴대폰 소유자" FROM usertbl;

SELECT userid AS "사용자명", sum(amount* price) AS "총구매액"
FROM buytbl GROUP BY userid;

SELECT userid AS "사용자명", sum(amount* price) AS "총구매액"
FROM buytbl GROUP BY userid
HAVING sum(price * amount) > 1000
ORDER BY sum(price * amount);

SELECT idnum, groupname, sum(price * amount)
as"비용"
FROM buytbl
GROUP BY rollup(groupname, idnum);

SELECT groupname, sum(price * amount)
AS "비용"
FROM BUYTBL b
GROUP BY rollup(groupname);

SELECT groupname, sum(price * amount)
AS "비용",
GROUPING_ID(groupname) AS "추가행 여부"
FROM BUYTBL b
GROUP BY rollup(groupname);

CREATE TABLE cubetbl(prodname nchar(3), color nchar(2), amount int);

INSERT INTO cubetbl values('컴퓨터', '검정', 11);
INSERT INTO cubetbl values('컴퓨터', '파랑', 22);
INSERT INTO cubetbl values('컴퓨터', '검정', 33);
INSERT INTO cubetbl values('컴퓨터', '파랑', 44);

SELECT * FROM cubetbl;

SELECT prodname, color, sum(amount) AS "수량 합계"
FROM cubetbl
GROUP BY cube(color,prodname)
ORDER BY prodname, color;

CREATE TABLE emptbl (emp nchar(3), manager nchar(3), department nchar(3));

INSERT INTO emptbl VALUES ('나사장', '없음', '없음');
INSERT INTO emptbl VALUES ('김재무', '나사장', '재무부');
INSERT INTO emptbl VALUES ('김부장', '김재무', '재무부');
INSERT INTO emptbl VALUES ('이부장', '김재무', '재무부');
INSERT INTO emptbl VALUES ('우대리', '이부장', '재무부');
INSERT INTO emptbl VALUES ('지사원', '이부장', '재무부');
INSERT INTO emptbl VALUES ('이영업', '나사장', '영업부');
INSERT INTO emptbl VALUES ('한과장', '이영업', '영업부');
INSERT INTO emptbl VALUES ('최정보', '나사장', '정보부');
INSERT INTO emptbl values ('윤차장', '최정보', '정보부');
INSERT INTO emptbl values ('이주임', '윤차장', '정보부');

SELECT * FROM emptbl;

WITH empcte(empname, mgrname, dept, emplevel)
AS
(
	(SELECT emp, manager, department, 0
	FROM emptbl
	WHERE manager='없음')
	UNION ALL
	(SELECT emptbl.emp, emptbl.manager, 
	emptbl.department, empcte.emplevel+1
	FROM emptbl INNER JOIN empcte
	ON emptbl.manager = empcte.empname)
)
SELECT * FROM empcte ORDER BY dept, emplevel;

WITH empcte(empname, mgrname, dept, emplevel)
AS
(
	(SELECT emp, manager, department, 0
	FROM emptbl
	WHERE manager='없음')
	UNION ALL
	(SELECT emptbl.emp, emptbl.manager, 
	emptbl.department, empcte.emplevel+1
	FROM emptbl INNER JOIN empcte
	ON emptbl.manager = empcte.empname)
)
SELECT concat(rpad ('ㄴ', emplevel * 2 + 1 ,'ㄴ'), 
empname) AS "직원이름", 
dept AS "직원부서"
FROM empcte ORDER BY dept, emplevel;



WITH empcte(empname, mgrname, dept, emplevel)
AS
(
	(SELECT emp, manager, department, 0
	FROM emptbl
	WHERE manager='없음')
	UNION ALL
	(SELECT emptbl.emp, emptbl.manager, 
	emptbl.department, empcte.emplevel+1
	FROM emptbl INNER JOIN empcte
	ON emptbl.manager = empcte.empname
	WHERE emplevel < 2)
)
SELECT concat(rpad ('ㄴ', emplevel * 2 + 1 ,'ㄴ'), 
empname) AS "직원이름", 
dept AS "직원부서"
FROM empcte ORDER BY dept, emplevel;

CREATE TABLE testtbl1 (id NUMBER(4), username nchar(3), age number(2));
INSERT INTO testtbl1 values(1, '홍길동', 25);
SELECT * FROM testtbl1;
INSERT INTO testtbl1 (id, username) values(2, '설현');
SELECT * FROM testtbl1;
INSERT INTO testtbl1 (username, id, age) VALUES ('지민', 3, 26);
SELECT * FROM testtbl1;


INSERT INTO testtbl1 values(4, 36, '공유');






CREATE TABLE testtbl2 (
id number(4),
username nchar(3),
age number(2),
nation nchar(4) DEFAULT '대한민국'
);
CREATE SEQUENCE idseq2
START WITH 1
INCREMENT BY 1;

INSERT INTO testtbl2 VALUES (idseq2.nextval, '유나', 25, default);

SELECT * FROM testtbl2;

INSERT INTO testtbl2 VALUES (11, '쯔위', 18, '대만');

SELECT * FROM testtbl2;

ALTER SEQUENCE idseq2
INCREMENT BY 10;

INSERT INTO testtbl2 VALUES (idseq2.nextval, '미나', 21, '일본');

SELECT * FROM testtbl2;

ALTER SEQUENCE idseq2
INCREMENT BY 1;

INSERT INTO testtbl2 VALUES (idseq2.nextval, '사나', 21, '일본');

SELECT * FROM testtbl2;

ALTER SEQUENCE idseq2
INCREMENT BY 5;

INSERT INTO testtbl2 VALUES (idseq2.nextval, '채영', 23, default);

SELECT * FROM testtbl2;

SELECT idseq2.currval FROM testtbl2;


CREATE TABLE testtbl3 (id NUMBER(3));
CREATE SEQUENCE cycleseq
START WITH 100
INCREMENT BY 100
MINVALUE 100
MAXVALUE 300
CYCLE
nocache; 
INSERT INTO testtbl3 VALUES (cycleseq.nextval);
INSERT INTO testtbl3 VALUES (cycleseq.nextval);
INSERT INTO testtbl3 VALUES (cycleseq.nextval);INSERT INTO testtbl3 VALUES (cycleseq.nextval);
SELECT * FROM testtbl3;






CREATE TABLE bigtbl1
AS 
SELECT LEVEL AS bigid,
round(dbms_random.value(1,500000), 0)
AS numdata
FROM dual
CONNECT BY LEVEL <= 500000;

CREATE TABLE bigtbl2
AS 
SELECT LEVEL AS bigid,
round(dbms_random.value(1,500000), 0)
AS numdata
FROM dual
CONNECT BY LEVEL <= 500000;

CREATE TABLE bigtbl3
AS 
SELECT LEVEL AS bigid,
round(dbms_random.value(1,500000), 0)
AS numdata
FROM dual
CONNECT BY LEVEL <= 500000;

DELETE FROM bigtbl1;

COMMIT;

DROP TABLE bigtbl2;

TRUNCATE TABLE bigtbl3;
DROP TABLE bigtbl1;
DROP TABLE bigtbl3;





CREATE TABLE member1
AS (SELECT userid, username, addr FROM usertbl);

SELECT * FROM member1;

CREATE TABLE changetbl (
userid char(8),
username nvarchar2(10),
addr nchar(2),
changetype nchar(4)
);

INSERT INTO changetbl values('TKV', '태권브이','한국','신규가입');
INSERT INTO changetbl values('LGG', NULL,'제주','주소변경');
INSERT INTO changetbl values('LJB', NULL,'한국','주소변경');
INSERT INTO changetbl values('BBK', NULL,'탈퇴','회원탈퇴');
INSERT INTO changetbl values('SSK', NULL,'탈퇴','회원탈퇴');

SELECT * FROM member1;

MERGE INTO member1 M
USING (SELECT changetype, userid, username, addr FROM changetbl) C
ON (M.userid = C.userid)
WHEN MATCHED THEN
 UPDATE SET M.addr = C.addr
 DELETE WHERE C.changetype = '회원탈퇴'
WHEN NOT MATCHED THEN
 INSERT (userid, username, addr) VALUES (C.userid, C.username, C.addr);

ALTER TABLE HR.MEMBER1 MODIFY USERNAME NVARCHAR2(20) NULL;

SELECT * FROM changetbl;
SELECT * FROM usertbl;
SELECT * FROM member1;



SELECT avg(amount) FROM buytbl;
SELECT CAST(avg(amount) AS number(3)) from buytbl;
SELECT CAST(avg(amount) AS number(3,2)) from buytbl;
SELECT CAST('2025$3$21' AS date) from dual; 

SELECT CAST(price AS char(5)) || 'X ' || CAST(amount AS char(4)) || '==' AS "단
가 X 수량", 
 price * amount AS "구매액"
 FROM buytbl;

SELECT to_char(12345, '$999,999') FROM dual;
SELECT to_char(12345, '$000,999') FROM dual;
SELECT to_char(12345, 'L999,999') FROM dual;
SELECT to_char(sysdate, 'YYYY/MM/DD hh:mm:ss') FROM dual;
SELECT to_char(10, 'X'), to_char(255, 'XX') FROM dual;
SELECT to_number('0123'), to_number('1234.456') FROM dual;



--묵시적 캐스팅
SELECT '100' + '200' FROM dual;
SELECT concat('100','200') FROM dual;
SELECT 100 || '200' FROM dual;
SELECT price FROM buytbl WHERE price >= '500';
SELECT ascii('A'), chr(65), asciistr('한'), unistr('\D55C') FROM dual;
SELECT LENGTH('한글'), length('AB'), lengthb('한글'), lengthb('AB') FROM dual;
SELECT concat('이것이', 'ORACLE이다'), '이것이' || 'ORACLE이다' FROM dual;
SELECT instr('이것이 ORACLE이다. 이것도 ORACLE이다', '이것') FROM dual;
SELECT instr('이것이 ORACLE이다. 이것도 ORACLE이다', '이것', 2) FROM dual;
SELECT lower('abcdEFGH'), upper('abcdEFGH'), initcap('this is oracle') FROM dual;
SELECT replace('이것이 ORACLE이다', '이것이', 'This is') FROM dual;
SELECT translate('이것이 ORACLE이다', '이것이', 'AB') FROM dual;
SELECT substr('대한민국만세', 3, 2) FROM dual;
SELECT reverse('Oracle') FROM dual;
SELECT lpad('이것이', 10, '##'), rpad('이것이', 10, '##') FROM dual;
SELECT ltrim(' 이것이'), rtrim('이것$$$$', '$') FROM dual;
SELECT trim(' 이것이 '), trim(BOTH 'ㅋ' FROM 'ㅋㅋ재밌어요.ㅋㅋㅋㅋㅋㅋㅋㅋ') 
FROM dual;
SELECT regexp_count('이것이 오라클이다','이') FROM dual;



--수학관련 함수
SELECT abs(-100) FROM dual;
SELECT CEIL(4.4), floor(4.4), round(4.4) FROM dual;
SELECT mod(13,4) FROM dual;
SELECT power(2,3) FROM dual;
SELECT sign(100), sign(0), sign(-100.123) FROM dual;
SELECT trunc(12345.12345, 2), trunc(12345.12345, -2) FROM dual;
SELECT add_months('2025-01-01', 5), add_months(sysdate, -5) FROM dual;
SELECT to_date('2025-01-01') + 5, sysdate - 5 FROM dual;
SELECT EXTRACT(YEAR FROM DATE '2025-01-01'), EXTRACT(DAY FROM sysdate) FROM dual;
SELECT last_day('2025-02-01') FROM dual;
SELECT next_day('2025-03-16', '금요일'), next_day(sysdate, '토요일') FROM dual;
SELECT months_between(sysdate, '2004-11-22') FROM dual;


--형 변환 함수
SELECT bin_to_num(1,0), bin_to_num(1,1,1,1) FROM dual;
SELECT bin_to_num(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1) FROM dual;
SELECT NUMTODSINTERVAL(48, 'HOUR'), NUMTODSINTERVAL(360000, 'SECOND') FROM dual;
SELECT NUMTOYMINTERVAL(37, 'MONTH'), NUMTOYMINTERVAL(1.5, 'YEAR') FROM dual;

-- etc
SELECT row_number() 
OVER (ORDER BY height DESC) "키 큰 순위", username, addr, height
FROM usertbl;

SELECT row_number() 
OVER (ORDER BY height ASC) "키 큰 순위", username, addr, height
FROM usertbl;

SELECT addr, row_number() 
OVER (PARTITION BY addr ORDER BY height DESC, username ASC)
"키 큰 순위", username, addr, height FROM usertbl;

SELECT dense_rank() 
OVER (ORDER BY height DESC) 
"키 큰 순위", username, addr, height 
FROM usertbl;

SELECT rank() 
OVER (ORDER BY height DESC) 
"키 큰 순위", username, addr, height 
FROM usertbl;

SELECT NTILE(3) over(ORDER BY height DESC) 
"반번호", username, addr, height FROM USERTBL u ;

SELECT username, addr, height AS "키", 
height - (LEAD(height, 1, 0) 
OVER (ORDER BY height DESC))
AS "다음 사람과의 키 차이" 
FROM USERTBL u ;


SELECT username, addr, height AS "키", 
height - (FIRST_VALUE(height) 
OVER (PARTITION BY addr ORDER BY height DESC))
AS "지역별 최대 키와 차이" 
FROM USERTBL u ;


SELECT username, addr, height AS "키", 
(CUME_DIST() 
OVER (PARTITION BY addr ORDER BY height DESC)) * 100
AS "누적 인원 백분율 (%)" 
FROM USERTBL u ;


--pivotTest
CREATE TABLE pivotTest(
uname nchar(3),
season nchar(2),amount number(3)
);

INSERT INTO PIVOTTEST VALUES ('김범수', '겨울', 10);
INSERT INTO PIVOTTEST VALUES ('윤종신', '여름', 15);
INSERT INTO PIVOTTEST VALUES ('김범수', '가을', 25);
INSERT INTO PIVOTTEST VALUES ('김범수', '봄', 3);
INSERT INTO PIVOTTEST VALUES ('김범수', '봄', 37);
INSERT INTO PIVOTTEST VALUES ('윤종신', '겨울', 40);
INSERT INTO PIVOTTEST VALUES ('김범수', '여름', 14);
INSERT INTO PIVOTTEST VALUES ('김범수', '겨울', 22);
INSERT INTO PIVOTTEST VALUES ('윤종신', '여름', 64);

SELECT * FROM pivotTest;

SELECT * FROM pivotTest
pivot(sum(amount)
FOR season
IN('봄','여름','가을', '겨울'));





--0324 --

CREATE TABLE movietbl (
	movie_id	number(4),
	movie_title nvarchar2(30),
	movie_director nvarchar2(30),
	movie_star	nvarchar2(30),
	movie_script clob,
	movie_film blob
);

SELECT * FROM movietbl;


CREATE TABLE neotbl (
	ID NUMBER(2) NOT NULL,
	NAME NCHAR(3) NOT NULL,
	TEAM NUMBER(2)
);

CREATE SEQUENCE idseqneo;

SELECT * FROM neotbl;

-- 랜덤 팀짜기 방법 1--

MERGE INTO neotbl n
USING (SELECT ntile(8) OVER(ORDER BY DBMS_RANDOM.value(1,17))
AS team, id, name
FROM neotbl) o
ON (n.id = o.id)
WHEN MATCHED THEN
 UPDATE SET n.team = o.team;

SELECT * FROM neotbl;

-- 랜덤 팀짜기 방법 2 -
MERGE INTO neotbl n
USING (SELECT ntile(8)
over(ORDER BY dbms_random.value(1,8))
team, id, name FROM neotbl) o
ON (n.id = o.id)
WHEN MATCHED THEN
	UPDATE SET n.team = o.team;

SELECT * FROM neotbl;

--join
SELECT * FROM BUYTBL b
	INNER JOIN USERTBL u
		ON b.USERID = u.USERID 
	WHERE b.USERID = 'JYP';

SELECT b.userid, username, prodname, addr, mobile1 || mobile2
	AS "연락처" FROM BUYTBL b
	INNER JOIN USERTBL u
		ON b.USERID = u.USERID;

SELECT b.userid, u.username, b.prodname, u.addr, u.mobile1 || u.mobile2
	AS "연락처" FROM BUYTBL b
	INNER JOIN USERTBL u
		ON b.USERID = u.USERID
	WHERE b.USERID = 'EJW';


SELECT b.userid, u.username, b.prodname, u.addr, u.mobile1 || u.mobile2
	AS "연락처" FROM BUYTBL b
	INNER JOIN USERTBL u
		ON b.USERID = u.USERID
	ORDER BY u.USERID;

SELECT DISTINCT u.userid, u.username, u.addr
	FROM BUYTBL b
	INNER JOIN USERTBL u
		ON b.USERID = u.USERID
	ORDER BY u.USERID;


SELECT u.userid, u.username, u.addr
	FROM USERTBL u 
	WHERE exists(
		SELECT * FROM buytbl b
		WHERE u.USERID = b.USERID
	);


--multi table join --
CREATE TABLE stdtbl (
	stdname nchar(5) NOT NULL PRIMARY KEY,
	addr nchar(2) NOT NULL
);

CREATE TABLE clubtbl (
	clubname nchar(5) NOT NULL PRIMARY KEY,
	roomno nchar(4) NOT NULL
);

CREATE SEQUENCE stdclubseq;

CREATE TABLE stdclubtbl (
	idnum number(5) NOT NULL PRIMARY KEY,
	stdname nchar(5) NOT NULL,
	clubname nchar(5) NOT NULL,
	FOREIGN KEY (stdname) REFERENCES stdtbl(stdname),
	FOREIGN KEY (clubname) REFERENCES clubtbl(clubname)
);

SELECT * FROM stdtbl;
SELECT * FROM clubtbl;
SELECT * FROM stdclubtbl;

SELECT s.stdname, s.addr, c.clubname, c.roomno
FROM stdtbl s
	INNER JOIN STDCLUBTBL sc
		ON s.stdname = sc.stdname
	INNER JOIN clubtbl c
		ON sc.clubname = c.clubname
	ORDER BY s.stdname;

SELECT c.clubname, c.roomno, s.stdname, s.addr
FROM stdtbl s
	INNER JOIN stdclubtbl sc
		ON s.stdname = sc.stdname
	INNER JOIN clubtbl c
		ON sc.clubname = c.clubname
	ORDER BY s.stdname;


-- 전체 회원 구매 기록
SELECT u.userid, u.username, b.prodname, u.addr, u.mobile1 || u.mobile2 AS "연락처"
FROM usertbl u
	LEFT OUTER JOIN BUYTBL b
		ON u.userid = b.USERID
	ORDER BY u.USERID;


-- 구매기록이 있는 회원 목록
SELECT u.userid, u.username, b.prodname, u.addr, u.mobile1 || u.mobile2 AS "연락처"
FROM usertbl u
	RIGHT OUTER JOIN BUYTBL b
		ON u.userid = b.USERID
	ORDER BY u.USERID;

--구매기록이 없는 회원 목록
SELECT u.userid, u.username, b.prodname, u.addr, u.mobile1 || u.mobile2 AS "연락처"
FROM usertbl u
	LEFT OUTER JOIN BUYTBL b
		ON u.userid = b.USERID
	WHERE b.prodname IS NULL
	ORDER BY u.USERID;

-- 회원 동아리 목록
SELECT s.stdname, s.addr, c.clubname, c.roomno
FROM stdtbl s
	LEFT OUTER JOIN STDCLUBTBL sc
		ON s.stdname = sc.stdname
	LEFT OUTER join clubtbl c
		ON sc.CLUBNAME = c.clubname
	ORDER BY s.stdname;

--동아리별 회원 목록
SELECT c.clubname, c.roomno, s.stdname, s.addr
FROM stdtbl s
	LEFT OUTER JOIN stdclubtbl sc
		ON sc.STDNAME = s.stdname
	LEFT OUTER JOIN clubtbl c
		ON sc.clubname = c.clubname
	ORDER BY c.clubname;

--회원 동아리 목록 + 동아리별 회원 목록
SELECT s.stdname, s.addr, c.clubname, c.roomno
FROM stdtbl s
	LEFT OUTER JOIN STDCLUBTBL sc
		ON s.stdname = sc.stdname
	LEFT OUTER join clubtbl c
		ON sc.CLUBNAME = c.clubname
UNION
	SELECT c.clubname, c.roomno, s.stdname, s.addr
	FROM stdtbl s
		LEFT OUTER JOIN stdclubtbl sc
			ON sc.stdname = s.stdname
		LEFT OUTER JOIN clubtbl c
			ON sc.clubname = c.clubname;


--CROSS JOIN
SELECT count(*) AS "데이터 개수"
FROM employees e
	CROSS JOIN countries c;
SELECT count(*) FROM EMPLOYEES e;
SELECT count(*) FROM COUNTRIES c;

--SELF JOIN
SELECT a.emp AS "부하직원", b.emp AS "직속상관", b.department AS "직속상관 부서"
FROM emptbl A
	INNER JOIN emptbl b
		ON a.manager = b.emp
	WHERE a.emp = '우대리';

SELECT stdname, addr FROM stdtbl s
UNION ALL 
SELECT clubname, roomno FROM clubtbl c;

SELECT username, concat(mobile1, mobile2) AS "전화번호"
FROM USERTBL u 
	WHERE username NOT in(
		SELECT username FROM USERTBL u
		WHERE mobile1 IS null
	);
	
SELECT username, concat(mobile1, mobile2) AS "전화번호"
FROM USERTBL u 
	WHERE username IN(
		SELECT username FROM USERTBL u
		WHERE mobile1 IS null
	);















