### 8-1　窗口函数
CREATE TABLE Product
(product_id      CHAR(4)      NOT NULL,
 product_name    VARCHAR(100) NOT NULL,
 product_type    VARCHAR(32)  NOT NULL,
 sale_price      INTEGER ,
 purchase_price  INTEGER ,
 regist_date     DATE ,
 PRIMARY KEY (product_id)) DEFAULT CHARSET=utf8;;

INSERT INTO Product VALUES ('0001', 'T恤' ,'衣服', 1000, 500, '2009-09-20');
INSERT INTO Product VALUES ('0002', '打孔器', '办公用品', 500, 320, '2009-09-11');
INSERT INTO Product VALUES ('0003', '运动T恤', '衣服', 4000, 2800, NULL);
INSERT INTO Product VALUES ('0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20');
INSERT INTO Product VALUES ('0005', '高压锅', '厨房用具', 6800, 5000, '2009-01-15');
INSERT INTO Product VALUES ('0006', '叉子', '厨房用具', 500, NULL, '2009-09-20');
INSERT INTO Product VALUES ('0007', '擦菜板', '厨房用具', 880, 790, '2008-04-28');
INSERT INTO Product VALUES ('0008', '圆珠笔', '办公用品', 100, NULL, '2009-11-11');

#### 什么是窗口函数

#### 窗口函数的语法

#### 语法的基本使用方法——使用RANK函数
-- 根据不同的商品种类，按照销售单价从低到高的顺序创建排序表
SELECT product_name, product_type, sale_price,
RANK () OVER (PARTITION BY product_type
ORDER BY sale_price) AS ranking
FROM Product;

#### 无需指定PARTITION-BY
-- 不指定PARTITION BY
SELECT product_name, product_type, sale_price,
RANK () OVER (ORDER BY sale_price) AS ranking
FROM Product;

-- 比较RANK、 DENSE_RANK、 ROW_NUMBER的结果
SELECT product_name, product_type, sale_price,
RANK () OVER (ORDER BY sale_price) AS ranking,
DENSE_RANK () OVER (ORDER BY sale_price) AS dense_ranking,
ROW_NUMBER () OVER (ORDER BY sale_price) AS row_num
FROM Product;

#### 专用窗口函数的种类

#### 窗口函数的适用范围

#### 作为窗口函数使用的聚合函数
-- 将SUM函数作为窗口函数使用
SELECT product_id, product_name, sale_price,
SUM(sale_price) OVER (ORDER BY product_id) AS current_sum
FROM Product;

#### 计算移动平均
-- 将AVG函数作为窗口函数使用
SELECT product_id, product_name, sale_price,
AVG(sale_price) OVER (ORDER BY product_id) AS current_avg
FROM Product;

-- 指定“最靠近的3行”作为汇总对象
SELECT product_id, product_name, sale_price,
AVG (sale_price) OVER (ORDER BY product_id
ROWS 2 PRECEDING) AS moving_avg
FROM Product;

-- 将当前记录的前后行作为汇总对象
SELECT product_id, product_name, sale_price,
AVG (sale_price) OVER (ORDER BY product_id
ROWS BETWEEN 1 PRECEDING AND
1 FOLLOWING) AS moving_avg
FROM Product;

#### 两个ORDER-BY
-- 无法保证如下SELECT语句的结果的排列顺序
SELECT product_name, product_type, sale_price,
RANK () OVER (ORDER BY sale_price) AS ranking
FROM Product;

### 8-2　GROUPING运算符

#### 同时得到合计行
-- 使用GROUP BY无法得到合计行
SELECT product_type, SUM(sale_price)
FROM Product
GROUP BY product_type;

-- 分别计算出合计行和汇总结果再通过UNION ALL进行连接
SELECT '合计' AS product_type, SUM(sale_price)
FROM Product
UNION ALL
SELECT product_type, SUM(sale_price)
FROM Product
GROUP BY product_type;

#### ROLLUP——同时得出合计和小计
-- 使用ROLLUP同时得出合计和小计
SELECT product_type, SUM(sale_price) AS sum_price
FROM Product
GROUP BY product_type WITH ROLLUP;

-- 在GROUP BY中添加“登记日期”（不使用ROLLUP）
SELECT product_type, regist_date, SUM(sale_price) AS sum_price
FROM Product
GROUP BY product_type, regist_date;

-- 在GROUP BY中添加“登记日期”（使用ROLLUP）
SELECT product_type, regist_date, SUM(sale_price) AS sum_price
FROM Product
GROUP BY product_type, regist_date WITH ROLLUP;

#### GROUPING函数——让NULL更加容易分辨
-- 使用GROUPING函数来判断NULL
SELECT GROUPING(product_type) AS product_type,
GROUPING(regist_date) AS regist_date, SUM(sale_price) AS sum_price
FROM Product
GROUP BY product_type, regist_date WITH ROLLUP;

-- 在超级分组记录的键值中插入恰当的字符串
SELECT CASE WHEN GROUPING(product_type) = 1
THEN '商品种类 合计'
ELSE product_type END AS product_type,
CASE WHEN GROUPING(regist_date) = 1
THEN '登记日期 合计'
ELSE regist_date END AS regist_date,
SUM(sale_price) AS sum_price
FROM Product
GROUP BY product_type, regist_date WITH ROLLUP;

#### 练习题
8.1	 请说出针对本章中使用的 Product（商品）表执行如下 SELECT 语句所能得到的结果。

SELECT product_id, product_name, sale_price,
MAX(sale_price) OVER (ORDER BY product_id) AS  current_max_price
FROM Product;

本题中 SELECT 语句的含义是“按照商品编号（product_id）的升序进行排序，
计算出截至当前行的最高销售单价”。因此，在显示出最高销售单价的同时，窗口函
数的返回结果也会变化。

8.2	 继续使用Product表，计算出按照登记日期（ regist_date）升序进行排列的各日期的销售单价（ sale_price）的总额。排序是需要将登记日期为 NULL 的“运动 T 恤”记录排在第 1 位（也就是将其看作比其他日期都早）。

①和②两种方法都可以实现。
① regist_date 为 NULL 时，显示“1 年 1 月 1 日”
SELECT regist_date, product_name, sale_price,
SUM(sale_price) 
OVER (ORDER BY COALESCE(regist_date, CAST('0001-01-01' AS DATE))) 
AS current_sum_price
FROM Product;

② regist_date 为 NULL 时，将该记录放在最前显示
SELECT regist_date, product_name, sale_price,
SUM(sale_price) 
OVER (order by IF(ISNULL(regist_date),0,1), regist_date) 
AS current_sum_price
FROM Product;