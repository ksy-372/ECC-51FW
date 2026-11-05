-- =====================================================
-- 8장. 데이터베이스 설계 - 연습 쿼리
-- 01_schema.sql 을 먼저 실행한 뒤 사용
-- =====================================================

-- ---------- 35강. 정규화 결과 확인 ----------

-- 정규화된 4개 테이블을 결합해서 "하나의 큰 주문 내역표"처럼 조회하기
-- (정규화 전이라면 이 모든 정보가 한 테이블에 중복 저장되어 있었을 것)
SELECT
    o.order_no,
    o.order_date,
    c.customer_name,
    c.customer_addr,
    i.item_name,
    i.item_price,
    oi.quantity,
    i.item_price * oi.quantity AS 소계
FROM orders o
INNER JOIN customer c   ON o.customer_no = c.customer_no
INNER JOIN order_item oi ON o.order_no = oi.order_no
INNER JOIN item i        ON oi.item_no = i.item_no
ORDER BY o.order_no, i.item_no;

-- 고객별 총 주문 금액 (정규화된 구조이므로 GROUP BY로 쉽게 집계 가능)
SELECT
    c.customer_name,
    SUM(i.item_price * oi.quantity) AS 총주문금액
FROM orders o
INNER JOIN customer c    ON o.customer_no = c.customer_no
INNER JOIN order_item oi ON o.order_no = oi.order_no
INNER JOIN item i        ON oi.item_no = i.item_no
GROUP BY c.customer_name;


-- ---------- 36강. 트랜잭션 ----------

-- 트랜잭션 없이 등록 (중간에 문제가 생기면 주문만 생기고 주문상품은 안 생기는 등 불일치 위험)
INSERT INTO tx_orders (order_no, order_date, customer_no) VALUES (1, '2024-03-10', 1);
INSERT INTO tx_order_item (order_no, item_no, quantity) VALUES (1, 1, 2);
SELECT * FROM tx_orders;
SELECT * FROM tx_order_item;

-- 트랜잭션으로 묶어서 등록 후 COMMIT (정상 케이스)
START TRANSACTION;
INSERT INTO tx_orders (order_no, order_date, customer_no) VALUES (2, '2024-03-11', 2);
INSERT INTO tx_order_item (order_no, item_no, quantity) VALUES (2, 3, 1);
COMMIT;
SELECT * FROM tx_orders;
SELECT * FROM tx_order_item;

-- 트랜잭션으로 묶었다가 ROLLBACK 하는 경우 (아래 두 INSERT는 결과에 반영되지 않아야 함)
START TRANSACTION;
INSERT INTO tx_orders (order_no, order_date, customer_no) VALUES (3, '2024-03-12', 1);
INSERT INTO tx_order_item (order_no, item_no, quantity) VALUES (3, 2, 5);
ROLLBACK;

-- ROLLBACK 결과 확인: order_no = 3은 존재하지 않아야 함
SELECT * FROM tx_orders WHERE order_no = 3;
SELECT * FROM tx_order_item WHERE order_no = 3;

-- 정리: 실습용으로 넣은 트랜잭션 데이터 지우고 싶을 때 (직접 주석 해제해서 실행)
-- DELETE FROM tx_order_item;
-- DELETE FROM tx_orders;
