SELECT * FROM sample WHERE birthday IS NULL ORDER BY NO ASC, address DESC;
SELECT * FROM sample LIMIT 2 OFFSET 2;
SELECT *, price * quantity "금액" FROM sample2;
SELECT * FROM sample2 WHERE price * quantity > 1000;
SELECT *, price * quantity "금액" FROM sample2 ORDER BY price * quantity;
SELECT *, price * quantity "금액" FROM sample2 ORDER BY "금액";
SELECT amount, ROUND(amount) FROM sample2;
SELECT CONCAT(quantity, price) FROM sample2;
SELECT SUBSTRING(NAME, 1, 3) FROM sample;
SELECT TRIM(" trim    ");
SELECT CHARACTER_LENGTH("단어");
SELECT OCTET_LENGTH("단어");
SELECT DATE_FORMAT(CURRENT_DATE, '%y/%m/%d');
SELECT CURRENT_DATE + INTERVAL 1 DAY;
SELECT DATEDIFF('2015-04-17', '2014-06-11');
SELECT birthday, case when birthday IS NULL then 0 ELSE birthday END "birthday(null=0)" FROM sample;
SELECT birthday, COALESCE(birthday, 0) FROM sample;
SELECT no, price, 
    CASE 
        WHEN price IS NULL THEN 0
        WHEN price > 1000 THEN "1000 초과"
        WHEN price < 1000 THEN "1000 미만"
        ELSE "1000"
    END AS "가격"
FROM sample2;
INSERT INTO sample(NO, NAME, birthday, address) VALUES(5, '오사삼', '2020-06-01', '경기도 성남시');
SELECT * FROM sample;
INSERT INTO sample(NO, NAME, birthday, address) VALUES(6, '이가영', '2011-11-23', DEFAULT);
DELETE FROM sample WHERE NO = 7;
UPDATE sample SET birthday = '1990-08-13' WHERE NO = 4;