DROP DATABASE IF EXISTS practice;
CREATE DATABASE practice;
USE practice;

-- 테이블 만들기
CREATE TABLE sample_a (a INTEGER);
CREATE TABLE sample_b (b INTEGER);

CREATE TABLE makers (
  maker_code CHAR(4) NOT NULL,
  maker_name VARCHAR(30),
  PRIMARY KEY (maker_code)
);

CREATE TABLE products (
  product_code CHAR(4) NOT NULL,
  product_name VARCHAR(30),
  maker_code CHAR(4),
  price INTEGER,
  category VARCHAR(30),
  PRIMARY KEY (product_code)
);

CREATE TABLE stock (
  product_code CHAR(4),
  in_date DATE,
  qty INTEGER
);

-- 데이터 넣기
INSERT INTO sample_a VALUES (1), (2), (3);
INSERT INTO sample_b VALUES (2), (10), (11);

INSERT INTO makers VALUES ('M001', '메이커1'), ('M002', '메이커2');

INSERT INTO products VALUES
  ('0001', '상품1', 'M001', 100,  '식료품'),
  ('0002', '상품2', 'M001', 200,  '식료품'),
  ('0003', '상품3', 'M002', 1980, '생활용품'),
  ('0009', '추가상품', 'M001', 300,  '식료품');

INSERT INTO stock VALUES
  ('0001', '2014-01-03', 200),
  ('0002', '2014-02-10', 500),
  ('0003', '2014-02-14', 10);


-- UNION
SELECT a FROM sample_a
UNION
SELECT b FROM sample_b;

-- UNION ALL
SELECT a FROM sample_a
UNION ALL
SELECT b FROM sample_b;

-- 교차결합
SELECT * FROM products, stock;

-- INNER JOIN
SELECT p.product_name, s.qty
  FROM products p INNER JOIN stock s
    ON p.product_code = s.product_code;

-- INNER JOIN 
SELECT p.product_name, m.maker_name
  FROM products p INNER JOIN makers m
    ON p.maker_code = m.maker_code;

-- LEFT JOIN 
SELECT p.product_name, s.qty
  FROM products p LEFT JOIN stock s
    ON p.product_code = s.product_code;

-- 트랜잭션 
START TRANSACTION;
DELETE FROM stock;
SELECT * FROM stock;
ROLLBACK;
SELECT * FROM stock;