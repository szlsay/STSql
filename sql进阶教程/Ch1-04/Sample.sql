-- 如果有查询结果， 说明存在缺失的编号
SELECT '存在缺失的编号' AS gap
FROM SeqTbl
HAVING COUNT(*) <> MAX(seq);

-- 查询缺失编号的最小值
SELECT MIN(seq+1) AS gap
FROM SeqTbl
WHERE (seq+1) NOT IN ( SELECT seq FROM SeqTbl);

/* 求众数的SQL语句（1）：使用谓词 */
SELECT income, COUNT(*) AS cnt
FROM Graduates
GROUP BY income
 HAVING COUNT(*) >= ALL (SELECT COUNT(*)
                         FROM Graduates
                         GROUP BY income);
												 
/* 求众数的SQL语句(2)：使用极值函数 */
SELECT income, COUNT(*) AS cnt
  FROM Graduates
 GROUP BY income
HAVING COUNT(*) >=  ( SELECT MAX(cnt)
                        FROM ( SELECT COUNT(*) AS cnt
                                 FROM Graduates
                             GROUP BY income) TMP) ;												 

/* 求中位数的SQL语句：在HAVING子句中使用非等值自连接 */
SELECT AVG(DISTINCT income)
  FROM (SELECT T1.income
          FROM Graduates T1, Graduates T2
      GROUP BY T1.income
               /* S1的条件 */
        HAVING SUM(CASE WHEN T2.income >= T1.income THEN 1 ELSE 0 END) 
                   >= COUNT(*) / 2
               /* S2的条件 */
           AND SUM(CASE WHEN T2.income <= T1.income THEN 1 ELSE 0 END) 
                   >= COUNT(*) / 2 ) TMP;
									 
SELECT COUNT(*), COUNT(col_1)
FROM NullTbl;

/* 查询“提交日期”列内不包含NULL的学院(1)：使用COUNT函数 */
SELECT dpt
FROM Students
GROUP BY dpt
HAVING COUNT(*) = COUNT(sbmt_date);

/* 查询“提交日期”列内不包含NULL的学院(2)：使用CASE表达式 */
SELECT dpt
FROM Students
GROUP BY dpt
HAVING COUNT(*) = SUM(CASE WHEN sbmt_date IS NOT NULL
                           THEN 1
                           ELSE 0 END);
													 
/* 查询啤酒、纸尿裤和自行车同时在库的店铺：错误的SQL语句 */
SELECT DISTINCT shop
  FROM ShopItems
 WHERE item IN (SELECT item FROM Items);	
	
	/* 查询啤酒、纸尿裤和自行车同时在库的店铺：正确的SQL语句 */
SELECT SI.shop
FROM ShopItems SI, Items I
WHERE SI.item = I.item
GROUP BY SI.shop
HAVING COUNT(SI.item) = (SELECT COUNT(item) FROM Items);	

/* COUNT(I.item)的值已经不一定是3了 */
SELECT SI.shop, COUNT(SI.item), COUNT(I.item)
 FROM ShopItems SI, Items I
 WHERE SI.item = I.item
 GROUP BY SI.shop;
	
/* 精确关系除法运算：使用外连接和COUNT函数 */
SELECT SI.shop
  FROM ShopItems AS SI LEFT OUTER JOIN Items AS I
  ON SI.item=I.item
GROUP BY SI.shop
  HAVING COUNT(SI.item) = (SELECT COUNT(item) FROM Items)   /* 条件1 */
     AND COUNT(I.item)  = (SELECT COUNT(item) FROM Items);  /* 条件2 */				
							