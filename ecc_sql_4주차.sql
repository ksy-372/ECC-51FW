SELECT * FROM sample
UNION
SELECT * FROM sample2;

SELECT NAME FROM sample
UNION
SELECT price FROM sample2
UNION
SELECT a FROM sample3;

SELECT birthday AS c FROM sample
UNION
SELECT b AS c FROM sample3 order by c;

SELECT no FROM sample
UNION ALL
SELECT no FROM sample2;

SELECT * FROM sample2, sample3 
  WHERE sample2.`no`= sample3.no
    AND sample2.quantity = 10;
    
SELECT *
  FROM sample2 INNER JOIN sample3
    ON sample2.`no`= sample3.no
  WHERE sample2.quantity = 10;