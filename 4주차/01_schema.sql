-- =====================================================
-- SQL 첫걸음 7~8장 실습용 스키마
-- 대상: MySQL
-- 기존 동일 이름 테이블이 있으면 먼저 지우고 새로 만든다
-- =====================================================

-- ---------- 7장. 복수의 테이블 다루기 ----------

-- 31강. 집합 연산 연습용
DROP TABLE IF EXISTS sample71_a;
CREATE TABLE sample71_a (
    no   INTEGER,
    name VARCHAR(30)
);

INSERT INTO sample71_a (no, name) VALUES
(1, 'A'),
(2, 'B'),
(3, 'C');

DROP TABLE IF EXISTS sample71_b;
CREATE TABLE sample71_b (
    no   INTEGER,
    name VARCHAR(30)
);

INSERT INTO sample71_b (no, name) VALUES
(2, 'B'),
(3, 'C'),
(4, 'D');


-- 32강. 테이블 결합 연습용 (상품 / 재고수 / 메이커)
DROP TABLE IF EXISTS maker;
CREATE TABLE maker (
    maker_no INTEGER NOT NULL,
    maker_name VARCHAR(30),
    CONSTRAINT pkey_maker PRIMARY KEY (maker_no)
);

INSERT INTO maker (maker_no, maker_name) VALUES
(1, '가나전자'),
(2, '다라식품'),
(3, '마바가구');

DROP TABLE IF EXISTS product;
CREATE TABLE product (
    product_no INTEGER NOT NULL,
    product_name VARCHAR(30),
    maker_no INTEGER,
    CONSTRAINT pkey_product PRIMARY KEY (product_no)
);

INSERT INTO product (product_no, product_name, maker_no) VALUES
(1, '냉장고', 1),
(2, '세탁기', 1),
(3, '라면', 2),
(4, '식탁', 3),
(5, '정체불명상품', NULL);   -- 메이커 미지정 상품 (외부결합 확인용)

DROP TABLE IF EXISTS stock;
CREATE TABLE stock (
    product_no INTEGER NOT NULL,
    quantity INTEGER,
    CONSTRAINT pkey_stock PRIMARY KEY (product_no)
);

INSERT INTO stock (product_no, quantity) VALUES
(1, 10),
(2, 5),
(3, 100);
-- product_no = 4, 5는 재고 데이터 없음 (외부결합 확인용)


-- ---------- 8장. 데이터베이스 설계 ----------

-- 35강. 정규화 예제 (주문 / 주문상품 / 상품 / 고객)
DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
    customer_no INTEGER NOT NULL,
    customer_name VARCHAR(30),
    customer_addr VARCHAR(100),
    CONSTRAINT pkey_customer PRIMARY KEY (customer_no)
);

INSERT INTO customer (customer_no, customer_name, customer_addr) VALUES
(1, '김소연', '서울시 서대문구'),
(2, '이영희', '서울시 강남구');

DROP TABLE IF EXISTS item;
CREATE TABLE item (
    item_no INTEGER NOT NULL,
    item_name VARCHAR(30),
    item_price INTEGER,
    CONSTRAINT pkey_item PRIMARY KEY (item_no)
);

INSERT INTO item (item_no, item_name, item_price) VALUES
(1, '노트북', 1200000),
(2, '마우스', 15000),
(3, '키보드', 45000);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_no INTEGER NOT NULL,
    order_date DATE,
    customer_no INTEGER,
    CONSTRAINT pkey_orders PRIMARY KEY (order_no)
);

INSERT INTO orders (order_no, order_date, customer_no) VALUES
(1, '2024-03-01', 1),
(2, '2024-03-02', 2);

DROP TABLE IF EXISTS order_item;
CREATE TABLE order_item (
    order_no INTEGER NOT NULL,
    item_no  INTEGER NOT NULL,
    quantity INTEGER,
    CONSTRAINT pkey_order_item PRIMARY KEY (order_no, item_no)
);

INSERT INTO order_item (order_no, item_no, quantity) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1);


-- 36강. 트랜잭션 연습용 (발주처리 흉내용 테이블)
DROP TABLE IF EXISTS tx_orders;
CREATE TABLE tx_orders (
    order_no INTEGER NOT NULL,
    order_date DATE,
    customer_no INTEGER,
    CONSTRAINT pkey_tx_orders PRIMARY KEY (order_no)
);

DROP TABLE IF EXISTS tx_order_item;
CREATE TABLE tx_order_item (
    order_no INTEGER NOT NULL,
    item_no  INTEGER NOT NULL,
    quantity INTEGER,
    CONSTRAINT pkey_tx_order_item PRIMARY KEY (order_no, item_no)
);
