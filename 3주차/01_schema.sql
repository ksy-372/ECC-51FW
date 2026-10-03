-- =====================================================
-- SQL 첫걸음 5~6장 실습용 스키마
-- =====================================================

-- ---------- 5장. 집계와 서브쿼리 ----------

DROP TABLE IF EXISTS sample51;
CREATE TABLE sample51 (
    no       INTEGER,
    name     VARCHAR(30),
    quantity INTEGER
);

INSERT INTO sample51 (no, name, quantity) VALUES
(1, 'A', 1),
(2, 'A', 2),
(3, 'B', 10),
(4, 'C', 3),
(5, NULL, NULL);


DROP TABLE IF EXISTS sample54;
CREATE TABLE sample54 (
    no INTEGER,
    a  INTEGER
);

INSERT INTO sample54 (no, a) VALUES
(1, 100),
(2, 900),
(3, 20),
(4, 80);


-- INSERT 명령 + 서브쿼리 연습용 (23강)
DROP TABLE IF EXISTS sample541;
CREATE TABLE sample541 (
    cnt1 INTEGER,
    cnt2 INTEGER
);

-- INSERT SELECT 복사 연습용 (23강)
DROP TABLE IF EXISTS sample542;
CREATE TABLE sample542 LIKE sample541;


-- 상관 서브쿼리 연습용 (24강)
DROP TABLE IF EXISTS sample551;
CREATE TABLE sample551 (
    no INTEGER,
    a  VARCHAR(10)
);

INSERT INTO sample551 (no, a) VALUES
(1, NULL),
(2, NULL),
(3, NULL),
(4, NULL),
(5, NULL);

DROP TABLE IF EXISTS sample552;
CREATE TABLE sample552 (
    no2 INTEGER
);

INSERT INTO sample552 (no2) VALUES
(3),
(5);


-- ---------- 6장. 데이터베이스 객체 작성과 삭제 ----------

-- 26강. 테이블 작성·삭제·변경 연습용
DROP TABLE IF EXISTS sample62;
CREATE TABLE sample62 (
    no INTEGER NOT NULL,
    a  VARCHAR(30),
    b  DATE
);


-- 27강. 제약 연습용 (열 제약)
DROP TABLE IF EXISTS sample631;
CREATE TABLE sample631 (
    a INTEGER NOT NULL,
    b INTEGER NOT NULL UNIQUE,
    c VARCHAR(30)
);

-- 27강. 제약 연습용 (복합 기본키 = 테이블 제약)
DROP TABLE IF EXISTS sample632;
CREATE TABLE sample632 (
    no     INTEGER NOT NULL,
    sub_no INTEGER NOT NULL,
    name   VARCHAR(30),
    CONSTRAINT pkey_sample632 PRIMARY KEY (no, sub_no)
);

-- 27강. 기본키(단일 열) 연습용
DROP TABLE IF EXISTS sample634;
CREATE TABLE sample634 (
    p INTEGER NOT NULL,
    q VARCHAR(30),
    CONSTRAINT pkey_sample634 PRIMARY KEY (p)
);
