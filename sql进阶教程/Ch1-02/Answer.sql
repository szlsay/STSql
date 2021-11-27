/* 练习题1-2-1：可重组合 */
SELECT P1.name AS name_1, P2.name AS name_2
FROM Products P1, Products P2
WHERE P1.name >= P2.name;

/* 练习题1-2-2：分地区排序 */
CREATE TABLE DistrictProducts
(district  VARCHAR(16) NOT NULL,
 name      VARCHAR(16) NOT NULL,
 price     INTEGER NOT NULL,
 PRIMARY KEY(district, name, price));

INSERT INTO DistrictProducts VALUES('东北', '橘子',	100);
INSERT INTO DistrictProducts VALUES('东北', '苹果',	50);
INSERT INTO DistrictProducts VALUES('东北', '葡萄',	50);
INSERT INTO DistrictProducts VALUES('东北', '柠檬',	30);
INSERT INTO DistrictProducts VALUES('关东', '柠檬',	100);
INSERT INTO DistrictProducts VALUES('关东', '菠萝',	100);
INSERT INTO DistrictProducts VALUES('关东', '苹果',	100);
INSERT INTO DistrictProducts VALUES('关东', '葡萄',	70);
INSERT INTO DistrictProducts VALUES('关西', '柠檬',	70);
INSERT INTO DistrictProducts VALUES('关西', '西瓜',	30);
INSERT INTO DistrictProducts VALUES('关西', '苹果',	20);

/* 练习题1-2-2 分地区排序 */
SELECT district, name, price,
          RANK() OVER(PARTITION BY district 
                      ORDER BY price DESC) AS rank_1
 FROM DistrictProducts;
 
 /* 练习题1-2-2：关联子查询 */
SELECT P1.district, P1.name,
       P1.price,
       (SELECT COUNT(P2.price)
          FROM DistrictProducts P2
         WHERE P1.district = P2.district    /* 在同一个地区内进行比较 */
           AND P2.price > P1.price) + 1 AS rank_1
  FROM DistrictProducts P1;
	
	/* 练习题1-2-2：自连接 */
SELECT P1.district, P1.name,
       MAX(P1.price) AS price, 
       COUNT(P2.name) +1 AS rank_1
  FROM DistrictProducts P1 LEFT OUTER JOIN DistrictProducts P2
    ON  P1.district = P2.district
   AND P1.price < P2.price
 GROUP BY P1.district, P1.name;
 
 /* 练习题1-2-3：更新位次 */
CREATE TABLE DistrictProducts2
(district  VARCHAR(16) NOT NULL,
 name      VARCHAR(16) NOT NULL,
 price     INTEGER NOT NULL,
 ranking   INTEGER,
 PRIMARY KEY(district, name));

INSERT INTO DistrictProducts2 VALUES('东北', '橘子',	100, NULL);
INSERT INTO DistrictProducts2 VALUES('东北', '苹果',	50 , NULL);
INSERT INTO DistrictProducts2 VALUES('东北', '葡萄',	50 , NULL);
INSERT INTO DistrictProducts2 VALUES('东北', '柠檬',	30 , NULL);
INSERT INTO DistrictProducts2 VALUES('关东', '柠檬',	100, NULL);
INSERT INTO DistrictProducts2 VALUES('关东', '菠萝',	100, NULL);
INSERT INTO DistrictProducts2 VALUES('关东', '苹果',	100, NULL);
INSERT INTO DistrictProducts2 VALUES('关东', '葡萄',	70 , NULL);
INSERT INTO DistrictProducts2 VALUES('关西', '柠檬',	70 , NULL);
INSERT INTO DistrictProducts2 VALUES('关西', '西瓜',	30 , NULL);
INSERT INTO DistrictProducts2 VALUES('关西', '苹果',	20 , NULL);

/* 练习题1-2-3：更新位次 */
UPDATE DistrictProducts2 P1
   SET ranking = (SELECT COUNT(P2.price) + 1
                    FROM DistrictProducts2 P2
                   WHERE P1.district = P2.district
                     AND P2.price > P1.price);
/* 练习题1-2-3：仅可用于DB2 */
UPDATE DistrictProducts2
   SET ranking = RANK() OVER(PARTITION BY district
                             ORDER BY price DESC);		

/* 练习题1-2-3：可用于Oracle、SQL Server、PostgreSQL */
UPDATE DistrictProducts2
   SET ranking =
         (SELECT P1.ranking
            FROM (SELECT district , name ,
                         RANK() OVER(PARTITION BY district
                                     ORDER BY price DESC) AS ranking
                    FROM DistrictProducts2) P1
                   WHERE P1.district = DistrictProducts2.district
                     AND P1.name = DistrictProducts2.name);																						
