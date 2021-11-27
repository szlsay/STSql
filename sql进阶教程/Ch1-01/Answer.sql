/* 练习题1-1：多列数据的最大值（练习题1-1-3也会用到） */
CREATE TABLE Greatests(
`key` CHAR(1) PRIMARY KEY,
 x   INTEGER NOT NULL,
 y   INTEGER NOT NULL,
 z   INTEGER NOT NULL);

INSERT INTO Greatests VALUES('A', 1, 2, 3);
INSERT INTO Greatests VALUES('B', 5, 5, 2);
INSERT INTO Greatests VALUES('C', 4, 7, 1);
INSERT INTO Greatests VALUES('D', 3, 3, 8);

SELECT `key`, CASE 
	WHEN x >= y AND x >= z THEN
		x
	WHEN y >= x AND y >= z THEN
		y
	ELSE
		z
END AS greatest
FROM Greatests;

/* 求x和y二者中较大的值 */
SELECT `key`,
       CASE WHEN x < y THEN y
            ELSE x END AS greatest
FROM Greatests;

/* 求x、y和z中的最大值 */
SELECT `key`,
       CASE WHEN CASE WHEN x < y THEN y ELSE x END < z
            THEN z
            ELSE CASE WHEN x < y THEN y ELSE x END
        END AS greatest
FROM Greatests;

/* 转换成行格式后使用MAX函数 */
SELECT `key`, MAX(col) AS greatest
FROM (SELECT `key`, x AS col FROM Greatests
  UNION ALL
  SELECT `key`, y AS col FROM Greatests
  UNION ALL
  SELECT `key`, z AS col FROM Greatests) TMP
GROUP BY `key`;

/* 仅适用于Oracle和MySQL */
SELECT `key`, GREATEST(GREATEST(x,y), z) AS greatest
FROM Greatests;

SELECT CASE 
	WHEN sex = 1 THEN
		'男'
	ELSE
		'女'
END AS '性别',
SUM(population) AS '全国'
FROM PopTbl2
GROUP BY sex;

/* 转换行列——在表头里加入汇总和再揭(p.287) */
SELECT sex,
       SUM(population) AS total,
       SUM(CASE WHEN pref_name = '德岛' THEN population ELSE 0 END) AS col_1,
       SUM(CASE WHEN pref_name = '香川' THEN population ELSE 0 END) AS col_2,
       SUM(CASE WHEN pref_name = '爱媛' THEN population ELSE 0 END) AS col_3,
       SUM(CASE WHEN pref_name = '高知' THEN population ELSE 0 END) AS col_4,
       SUM(CASE WHEN pref_name IN ('德岛', '香川', '爱媛', '高知')
                THEN population ELSE 0 END) AS zaijie
  FROM PopTbl2
 GROUP BY sex;
 
 /* 用ORDER BY生成“排序”列 */
SELECT `key`
 FROM Greatests
 ORDER BY CASE `key`
            WHEN 'B' THEN 1
            WHEN 'A' THEN 2
            WHEN 'D' THEN 3
            WHEN 'C' THEN 4
            ELSE NULL END;

/* 把“排序”列也包括在结果中(p.288) */
SELECT `key`,
       CASE `key`
         WHEN 'B' THEN 1
         WHEN 'A' THEN 2
         WHEN 'D' THEN 3
         WHEN 'C' THEN 4
         ELSE NULL END AS sort_col
 FROM Greatests
 ORDER BY sort_col;