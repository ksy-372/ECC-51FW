-- =====================================================
-- 5장. 집계와 서브쿼리 - 연습 쿼리
-- 01_schema.sql 을 먼저 실행한 뒤 사용
-- =====================================================

-- ---------- 20강. 행 개수 구하기 - COUNT ----------

-- 테이블 전체 행 개수
SELECT COUNT(*) FROM sample51;

-- WHERE 구와 함께: 조건에 맞는 행만 카운트
SELECT COUNT(*) FROM sample51 WHERE name = 'A';

-- 집계함수는 NULL을 무시한다 (no=5, name=4)
SELECT COUNT(no), COUNT(name) FROM sample51;

-- *는 예외: NULL 포함 전체 행 수
SELECT COUNT(*) FROM sample51;

-- DISTINCT로 중복 제거
SELECT DISTINCT name FROM sample51;

-- 집계함수 + DISTINCT: NULL 제외, 중복 없는 개수
SELECT COUNT(ALL name), COUNT(DISTINCT name) FROM sample51;


-- ---------- 21강. COUNT 이외의 집계함수 ----------

SELECT SUM(quantity) FROM sample51;

SELECT AVG(quantity), SUM(quantity) / COUNT(quantity) FROM sample51;

-- NULL을 0으로 간주하고 평균 내기
SELECT AVG(CASE WHEN quantity IS NULL THEN 0 ELSE quantity END) AS avg_with_zero
FROM sample51;

SELECT MIN(quantity), MAX(quantity), MIN(name), MAX(name)
FROM sample51;


-- ---------- 22강. 그룹화 - GROUP BY ----------

-- DISTINCT와 비슷한 효과
SELECT name FROM sample51 GROUP BY name;

-- 그룹별 집계
SELECT name, COUNT(name), SUM(quantity)
FROM sample51
GROUP BY name;

-- WHERE 구에서는 집계함수를 쓸 수 없다 (에러 확인용 - 주석 해제해서 실행해보기)
-- SELECT name, COUNT(name) FROM sample51
-- WHERE COUNT(name) = 1 GROUP BY name;

-- HAVING 구로 집계 결과 필터링
SELECT name, COUNT(name)
FROM sample51
GROUP BY name
HAVING COUNT(name) = 1;

-- 그룹화 후 정렬
SELECT name, COUNT(name), SUM(quantity)
FROM sample51
GROUP BY name
ORDER BY SUM(quantity) DESC;

-- 집계함수를 사용하면 그룹화 열 이외의 열도 SELECT 구에 쓸 수 있다
SELECT MIN(no), name, SUM(quantity)
FROM sample51
GROUP BY name;


-- ---------- 23강. 서브쿼리 ----------

-- WHERE 구에서 서브쿼리: a열 값이 가장 작은 행 찾기
SELECT MIN(a) FROM sample54;

-- 위 서브쿼리를 DELETE에 활용 (실행하면 실제로 삭제되니 주의)
-- DELETE FROM sample54 WHERE a = (SELECT MIN(a) FROM sample54);

-- 스칼라 서브쿼리: SELECT 구에서 사용
SELECT
    (SELECT COUNT(*) FROM sample51) AS sq1,
    (SELECT COUNT(*) FROM sample54) AS sq2;

-- SET 구에서 서브쿼리 사용 (실행하면 전체 행이 갱신되니 주의)
-- UPDATE sample54 SET a = (SELECT MAX(a) FROM sample54);

-- FROM 구에서 서브쿼리 사용 (네스티드 쿼리)
SELECT * FROM (SELECT * FROM sample54) sq;

-- INSERT + 서브쿼리
INSERT INTO sample541 (cnt1, cnt2) VALUES (
    (SELECT COUNT(*) FROM sample51),
    (SELECT COUNT(*) FROM sample54)
);
SELECT * FROM sample541;

-- INSERT SELECT: 같은 구조 테이블 간 데이터 복사
INSERT INTO sample542 SELECT * FROM sample541;
SELECT * FROM sample542;


-- ---------- 24강. 상관 서브쿼리 ----------

-- 준비 상태 확인
SELECT * FROM sample551;
SELECT * FROM sample552;

-- EXISTS: sample552에 대응하는 행이 있으면 '있음'으로 갱신
UPDATE sample551 SET a = '있음'
WHERE EXISTS (
    SELECT * FROM sample552 WHERE sample552.no2 = sample551.no
);

-- NOT EXISTS: 대응하는 행이 없으면 '없음'으로 갱신
UPDATE sample551 SET a = '없음'
WHERE NOT EXISTS (
    SELECT * FROM sample552 WHERE sample552.no2 = sample551.no
);

SELECT * FROM sample551;

-- IN: 집합 안에 값이 있는지 조사
SELECT * FROM sample551 WHERE no IN (3, 5);

-- IN의 오른쪽에 서브쿼리 지정
SELECT * FROM sample551 WHERE no IN (SELECT no2 FROM sample552);
