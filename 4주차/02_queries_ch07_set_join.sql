-- =====================================================
-- 7장. 복수의 테이블 다루기 - 연습 쿼리
-- 01_schema.sql 을 먼저 실행한 뒤 사용
-- =====================================================

-- ---------- 31강. 집합 연산 ----------

-- UNION: 중복 제거하며 합치기 (no=2,3은 양쪽에 다 있음 → 한 번만 나와야 함)
SELECT no, name FROM sample71_a
UNION
SELECT no, name FROM sample71_b;

-- UNION ALL: 중복 제거 없이 그대로 합치기
SELECT no, name FROM sample71_a
UNION ALL
SELECT no, name FROM sample71_b;

-- ORDER BY는 마지막 SELECT 문에만 붙인다
SELECT no, name FROM sample71_a
UNION
SELECT no, name FROM sample71_b
ORDER BY no DESC;

-- INTERSECT: 교집합 (양쪽에 모두 있는 행) - MySQL 8.0.31 이상
SELECT no, name FROM sample71_a
INTERSECT
SELECT no, name FROM sample71_b;

-- EXCEPT: 차집합 (a에만 있는 행) - MySQL 8.0.31 이상
SELECT no, name FROM sample71_a
EXCEPT
SELECT no, name FROM sample71_b;


-- ---------- 32강. 테이블 결합 ----------

-- 교차결합(CROSS JOIN): 모든 조합 (결과 행 수 = product 5행 × maker 3행 = 15행)
SELECT * FROM product, maker;

-- 위와 동일한 결과를 조건으로 거른 것 (오래된 방식 - 내부결합을 WHERE로 구현)
SELECT * FROM product, maker
WHERE product.maker_no = maker.maker_no;

-- 내부결합(INNER JOIN): 표준 방식 - 메이커가 없는 상품(정체불명상품)은 제외됨
SELECT product.product_name, maker.maker_name
FROM product
INNER JOIN maker ON product.maker_no = maker.maker_no;

-- 상품 + 재고수 내부결합: 재고 데이터가 없는 상품(식탁, 정체불명상품)은 제외됨
SELECT product.product_name, stock.quantity
FROM product
INNER JOIN stock ON product.product_no = stock.product_no;

-- 자기결합(SELF JOIN): 같은 메이커를 가진 상품끼리 짝짓기 (자기 자신과의 짝은 제외)
SELECT p1.product_name AS 상품A, p2.product_name AS 상품B, p1.maker_no
FROM product p1
INNER JOIN product p2
    ON p1.maker_no = p2.maker_no
    AND p1.product_no <> p2.product_no;

-- 외부결합(LEFT JOIN): 재고 데이터가 없어도 상품은 전부 표시, 없는 재고는 NULL
SELECT product.product_name, stock.quantity
FROM product
LEFT JOIN stock ON product.product_no = stock.product_no;

-- 외부결합(LEFT JOIN): 메이커가 없는 상품도 전부 표시
SELECT product.product_name, maker.maker_name
FROM product
LEFT JOIN maker ON product.maker_no = maker.maker_no;

-- RIGHT JOIN: 기준을 반대로 - 재고 테이블 기준으로 전부 표시
SELECT product.product_name, stock.quantity
FROM product
RIGHT JOIN stock ON product.product_no = stock.product_no;
