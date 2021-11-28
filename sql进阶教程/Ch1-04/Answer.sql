练习题1-4-1 ： 修改编号缺失的检查逻辑， 使结果总是返回一行数据
在“寻找缺失的编号”部分， 我们写了一条 SQL 语句， 让程序只在存在缺失的编号时返回结果。 请将 SQL 语句修改成始终返回一行结果， 即存在缺失的编号时返回“存在缺失的编号”， 不存在缺失的编号
时返回“不存在缺失的编号”。

/* 练习题1-4-1：修改编号缺失的检查逻辑，使结果总是返回一行数据 */
SELECT ' 存在缺失的编号' AS gap
  FROM SeqTbl
HAVING COUNT(*) <> MAX(seq)
UNION ALL
SELECT ' 不存在缺少的编号' AS gap
  FROM SeqTbl
HAVING COUNT(*) = MAX(seq);

/* 练习题1-4-1：修改编号缺失的检查逻辑，使结果总是返回一行数据 */
SELECT CASE WHEN COUNT(*) <> MAX(seq)
            THEN '存在缺失的编号'
            ELSE '不存在缺失的编号' END AS gap
  FROM SeqTbl;
	
●练习题1-4-2 ： 练习“特征函数”
这里我们使用正文中的表 Students， 稍微练习一下特征函数的用法吧。 请想出一条查询“全体学生都在 9 月份提交了报告的学院”的 SQL语句。 
满足条件的只有经济学院。 理学院学号为 100 的学生是 10 月份提交的报告， 所以不满足条件。 
文学院和工学院还有学生尚未提交报告， 所以也不满足条件。

SELECT * FROM Students;


/* 练习题1-4-2：练习“特征函数” 
   查找所有学生都在9月份提交完成的学院（1）：使用BETWEEN谓词 */
SELECT dpt
  FROM Students
 GROUP BY dpt
HAVING COUNT(*) = SUM(CASE WHEN sbmt_date BETWEEN '2005-09-01' AND '2005-09-30'
                           THEN 1 ELSE 0 END);

/* 练习题1-4-2：练习“特征函数” 
   查找所有学生都在9月份提交完成的学院（2）：使用EXTRACT函数 */
SELECT dpt
  FROM Students
 GROUP BY dpt
HAVING COUNT(*) = SUM(CASE WHEN  YEAR(sbmt_date) = 2005
                            AND  MONTH(sbmt_date) = 09
                           THEN 1 ELSE 0 END);
													 
●练习题1-4-3 ： 购物篮分析问题的一般化
在“用关系除法运算进行购物篮分析”部分， 返回结果只选择了满足条件的店铺。 但是有时候会有不同的需求， 比如对于没有备齐全部商品类型的店铺， 我们也希望返回的一览表能展示这些店铺缺少多少种商品。
请修改正文中的 SQL 语句， 使程序能够返回下面这样展示了全部店铺的结果的一览表。 my_item_cnt 是店铺的现有库存商品种类数， diff_cnt 是不足的商品种类数

/* 练习题1-4-3：购物篮分析问题的一般化 */
SELECT SI.shop,
       COUNT(SI.item) AS my_item_cnt,
       (SELECT COUNT(item) FROM Items) - COUNT(SI.item) AS diff_cnt
  FROM ShopItems SI, Items I
 WHERE SI.item = I.item
 GROUP BY SI.shop;	