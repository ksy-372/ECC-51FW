-- =====================================================
-- 6장. 데이터베이스 객체 작성과 삭제 - 연습 쿼리
-- 01_schema.sql 을 먼저 실행한 뒤 사용
-- =====================================================

-- ---------- 26강. 테이블 작성·삭제·변경 ----------

-- 구조 확인
DESC sample62;

-- 열 추가
ALTER TABLE sample62 ADD newcol INTEGER;
DESC sample62;

-- 열 속성 변경 (자료형 변경)
ALTER TABLE sample62 MODIFY newcol VARCHAR(20);
DESC sample62;

-- 열 이름 변경
ALTER TABLE sample62 CHANGE newcol c VARCHAR(20);
DESC sample62;

-- 열 삭제
ALTER TABLE sample62 DROP c;
DESC sample62;

-- 데이터는 두고 전체 행만 빠르게 비우고 싶을 때 (DELETE보다 빠름)
-- TRUNCATE TABLE sample62;


-- ---------- 27강. 제약 ----------

-- 열 제약 추가/삭제 연습 (sample631의 c열)
ALTER TABLE sample631 MODIFY c VARCHAR(30) NOT NULL;   -- NOT NULL 추가
ALTER TABLE sample631 MODIFY c VARCHAR(30);             -- NOT NULL 삭제

-- 테이블 제약(기본키) 추가/삭제 연습
ALTER TABLE sample631 ADD CONSTRAINT pkey_sample631 PRIMARY KEY (a);
ALTER TABLE sample631 DROP PRIMARY KEY;

-- 기본키 제약 동작 확인: sample634
INSERT INTO sample634 VALUES (1, '첫째줄');
INSERT INTO sample634 VALUES (2, '둘째줄');
INSERT INTO sample634 VALUES (3, '셋째줄');
SELECT * FROM sample634;

-- 기본키 중복 → 에러 발생 확인용 (p=2가 이미 있음)
-- INSERT INTO sample634 VALUES (2, '넷째줄');

-- 기본키 중복이 되는 UPDATE → 에러 발생 확인용
-- UPDATE sample634 SET p = 2 WHERE p = 3;

-- 복합 기본키 동작 확인: sample632 (no, sub_no 조합이 유일하면 OK)
INSERT INTO sample632 (no, sub_no, name) VALUES (1, 1, 'A');
INSERT INTO sample632 (no, sub_no, name) VALUES (1, 2, 'B');
INSERT INTO sample632 (no, sub_no, name) VALUES (2, 1, 'C');
SELECT * FROM sample632;

-- 복합 기본키 중복 → 에러 발생 확인용 (no=1, sub_no=1이 이미 있음)
-- INSERT INTO sample632 (no, sub_no, name) VALUES (1, 1, 'D');


-- ---------- 28~29강. 인덱스 ----------

-- 인덱스 작성
CREATE INDEX isample62 ON sample62 (no);

-- 실행계획 확인: 인덱스가 사용되는지
EXPLAIN SELECT * FROM sample62 WHERE no = 1;

-- 인덱스 대상이 아닌 조건 → possible_keys / key가 NULL인지 비교
EXPLAIN SELECT * FROM sample62 WHERE a = 'x';

-- 인덱스 삭제
DROP INDEX isample62 ON sample62;


-- ---------- 30강. 뷰 작성과 삭제 ----------

-- 뷰 작성: sample54 전체를 보여주는 뷰
CREATE VIEW sample_view_54 AS
SELECT * FROM sample54;

SELECT * FROM sample_view_54;

-- 뷰 열에 별명 지정
CREATE VIEW sample_view_54_doubled (n, v, v2) AS
SELECT no, a, a * 2 FROM sample54;

SELECT * FROM sample_view_54_doubled WHERE n = 1;

-- 뷰 삭제
DROP VIEW sample_view_54;
DROP VIEW sample_view_54_doubled;
