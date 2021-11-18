### 5-1　视图

#### 视图和表
-- 通过视图等SELECT语句保存数据
SELECT product_type, SUM(sale_price), SUM(purchase_price)
FROM Product
GROUP BY product_type;

#### 创建视图的方法

CREATE VIEW ProductSum (product_type, cnt_product)
AS
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type;

SELECT product_type, cnt_product
FROM ProductSum;

CREATE VIEW ProductSumJim (product_type, cnt_product)
AS
SELECT product_type, cnt_product
FROM ProductSum
WHERE product_type = '办公用品';

SELECT product_type, cnt_product 
FROM ProductSumJim;

#### 视图的限制①-——定义视图时不能使用ORDER-BY子句
-- 不能像这样定义视图
CREATE VIEW ProductSumNew (product_type, cnt_product)
AS
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type
ORDER BY product_type;


SELECT * FROM ProductSumNew;
#### 视图的限制②-——对视图进行更新
-- 对 ProductSum 视图执行如下 INSERT 语句
INSERT INTO ProductSumNew VALUES ('电器制品', 5);

-- 可以更新的视图
CREATE VIEW ProductJim (product_id, product_name, product_type, sale_price, purchase_price, regist_date)
AS
SELECT *
FROM Product
WHERE product_type = '办公用品';

-- 向视图中添加数据行
INSERT INTO ProductJim VALUES ('0009', '印章', '办公用品', 95, 10, '2009-11-30');

SELECT * FROM ProductJim;
SELECT * FROM Product;

#### 删除视图
-- 删除视图
DROP VIEW ProductSum;
### 5-2　子查询

#### 子查询和视图
视图ProductSum和确认用的SELECT语句
-- 根据商品种类统计商品数量的视图
CREATE VIEW ProductSum (product_type, cnt_product)
AS
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type;

-- 确认创建好的视图
SELECT product_type, cnt_product
FROM ProductSum;

-- 在FROM子句中直接书写定义视图的SELECT语句
SELECT product_type, cnt_product
FROM ( SELECT product_type, COUNT(*) AS cnt_product
FROM Product
GROUP BY product_type ) AS ProductSum;

SELECT语句的执行顺序
① 首先执行 FROM 子句中的 SELECT 语句（子查询）
SELECT product_type, COUNT(*) AS cnt_product
FROM Product
GROUP BY product_type;
② 根据①的结果执行外层的 SELECT 语句
SELECT product_type, cnt_product
FROM ProductSum;

尝试增加子查询的嵌套层数
SELECT product_type, cnt_product
FROM (SELECT *
FROM (SELECT product_type, COUNT(*) AS cnt_product
FROM Product
GROUP BY product_type) AS ProductSum 
WHERE cnt_product = 4) AS ProductSum2;

#### 子查询的名称

#### 标量子查询
-- 在WHERE子句中不能使用聚合函数
SELECT product_id, product_name, sale_price
FROM Product
WHERE sale_price > AVG(sale_price);

-- 选取出销售单价（ sale_price）高于全部商品的平均单价的商品
SELECT product_id, product_name, sale_price
FROM Product
WHERE sale_price > (SELECT AVG(sale_price)
FROM Product);

#### 标量子查询的书写位置
-- 在SELECT子句中使用标量子查询
SELECT product_id,
product_name,
sale_price,
(SELECT AVG(sale_price)
FROM Product) AS avg_price
FROM Product;

-- 在HAVING子句中使用标量子查询
SELECT product_type, AVG(sale_price)
FROM Product
GROUP BY product_type
HAVING AVG(sale_price) > 
(SELECT AVG(sale_price) FROM Product);

#### 使用标量子查询时的注意事项
-- 由于不是标量子查询，因此不能在SELECT子句中使用
SELECT product_id,
product_name,
sale_price,
(SELECT AVG(sale_price)
FROM Product
GROUP BY product_type) AS avg_price
FROM Product;

### 5-3　关联子查询

#### 普通的子查询和关联子查询的区别
-- 按照商品种类计算平均价格
SELECT AVG(sale_price)
FROM Product
GROUP BY product_type;

-- 通过关联子查询按照商品种类对平均销售单价进行比较
SELECT product_type, product_name, sale_price
FROM Product AS P1 
WHERE sale_price > (SELECT AVG(sale_price) FROM Product AS P2 WHERE P1.product_type = P2.product_type GROUP BY product_type);

#### 关联子查询也是用来对集合进行切分的

#### 结合条件一定要写在子查询中
-- 错误的关联子查询书写方法
SELECT product_type, product_name, sale_price
FROM Product AS P1
WHERE P1.product_type = P2.product_type
AND sale_price > (SELECT AVG(sale_price)
FROM Product AS P2
GROUP BY product_type);

子查询内的关联名称的有效范围
SELECT product_type, product_name, sale_price
FROM Product AS P1
WHERE sale_price>(SELECT AVG(sale_price)
FROM Product AS P2
WHERE P1.product_type=P2.product_type
GROUP BY product_type);

#### 练习题

5.1	 创建出满足下述三个条件的视图（视图名称为 ViewPractice5_1）。使用 Product（商品）表作为参照表，假设表中包含初始状态的 8 行数据。
条件 1： 销售单价大于等于 1000 日元。
条件 2： 登记日期是 2009 年 9 月 20 日。
条件 3： 包含商品名称、销售单价和登记日期三列。
对该视图执行 SELECT 语句的结果如下所示。
SELECT * FROM ViewPractice5_1;

CREATE VIEW ViewPractice5_1 (product_name, sale_price,regist_date)
AS
SELECT product_name, sale_price, regist_date
FROM Product
WHERE sale_price >= 1000
AND regist_date = '2009-09-20';

SELECT * FROM ViewPractice5_1;

5.2	 向习题 5.1 中创建的视图 ViewPractice5_1 中插入如下数据，会得到什么样的结果呢？
INSERT INTO ViewPractice5_1 VALUES ('刀子', 300, '2009-11-02');

会发生错误。

解答:对视图的更新归根结底是对视图所对应的表进行更新。因此，该 INSERT 语句实质上和下面的 INSERT 语句相同。
INSERT INTO Product (product_id, product_name, product_type, sale_price, purchase_price, regist_date)
VALUES (NULL, '刀子', NULL, 300, NULL, '2009-11-02');

5.3	 请根据如下结果编写 SELECT 语句，其中 sale_price_all 列为全部商品的平均销售单价。

product_id | product_name | product_type | sale_price | sale_price_all
------------+-------------+--------------+------------+----------------------
0001 | T恤衫 | 衣服 | 1000 | 2097.5000000000000000
0002 | 打孔器 | 办公用品 | 500 | 2097.5000000000000000
0003 | 运动T恤 | 衣服 | 4000 | 2097.5000000000000000
0004 | 菜刀 | 厨房用具 | 3000 | 2097.5000000000000000
0005 | 高压锅 | 厨房用具 | 6800 | 2097.5000000000000000
0006 | 叉子 | 厨房用具 | 500 | 2097.5000000000000000
0007 | 擦菜板 | 厨房用具 | 880 | 2097.5000000000000000
0008 | 圆珠笔 | 办公用品 | 100 | 2097.5000000000000000

SELECT product_id, product_name, product_type, sale_price,
(SELECT AVG(sale_price) FROM Product) as sale_price_all
FROM Product;

5.4	 请根据习题 5.1 中的条件编写一条 SQL 语句，创建一幅包含如下数据的视图（名称为 AvgPriceByType）。
执行结果
product_id | product_name | product_type | sale_price | avg_sale_price
------------+-------------+--------------+------------+----------------------
0001 |T恤衫 | 衣服 | 1000 | 2500.0000000000000000
0002 |打孔器 | 办公用品 | 500 | 300.0000000000000000
0003 |运动T恤 | 衣服 | 4000 | 2500.0000000000000000
0004 |菜刀 | 厨房用具 | 3000 | 2795.0000000000000000
0005 |高压锅 | 厨房用具 | 6800 | 2795.0000000000000000
0006 |叉子 | 厨房用具 | 500 | 2795.0000000000000000
0007 |擦菜板 | 厨房用具 | 880 | 2795.0000000000000000
0008 |圆珠笔 | 办公用品 | 100 | 300.0000000000000000
提示：其中的关键是avg_sale_price列。与习题5.3不同，这里需要计算出的是各商品种类的平均销售单价。这与5-3节中使用关联子查询所得到的结果相同。
也就是说，该列可以使用关联子查询进行创建。问题就是应该在什么地方使用这个关联子查询


CREATE VIEW AvgPriceByType(product_id, product_name, product_type, sale_price, avg_sale_price)
AS 
SELECT product_id, product_name, product_type, sale_price, 
(SELECT AVG(sale_price) FROM Product p2 GROUP BY product_type HAVING p1.product_type = p2.product_type)
FROM Product p1;

CREATE VIEW AvgPriceByType
AS 
SELECT product_id, product_name, product_type, sale_price, 
(SELECT AVG(sale_price) 
	FROM Product p2 
	GROUP BY product_type 
	HAVING p1.product_type = p2.product_type) as avg_sale_price
FROM Product p1;


SELECT * FROM AvgPriceByType;

