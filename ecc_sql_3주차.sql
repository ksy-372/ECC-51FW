SELECT COUNT(*) FROM sample2 WHERE price > 100;
SELECT COUNT(NAME), COUNT(birthday) FROM sample;
SELECT COUNT(DISTINCT price) FROM sample2;
SELECT SUM(amount) FROM sample2;
SELECT AVG(price) FROM sample2;
SELECT MIN(quantity) FROM sample2;
SELECT MAX(quantity) FROM sample2;
SELECT price, COUNT(price), SUM(quantity) FROM sample2 GROUP BY price;
DELETE FROM sample2 WHERE quantity = (SELECT MIN(quantity) FROM sample2);
SELECT (SELECT COUNT(*) FROM sample) AS sq1, (SELECT COUNT(*) FROM sample2) AS sq2;
SELECT NO FROM sample2 WHERE EXISTS(SELECT price FROM sample2 WHERE price > 100);
SELECT NO FROM sample2 WHERE price IN (100, 230);


CREATE TABLE sample3(
	NO INTEGER NOT NULL,
	a VARCHAR(30),
	b DATE
  CONSTRAINT sample3 PRIMARY KEY(NO));

DROP TABLE sample3;

ALTER TABLE sample3 ADD newcol INTEGER;
ALTER TABLE sample3 MODIFY newcol VARCHAR(20);
CREATE INDEX sampleIndex ON sample3(NO);
DROP INDEX sampleIndex ON sample3;
CREATE VIEW sampleView AS SELECT * FROM sample;
DROP VIEW sampleView;