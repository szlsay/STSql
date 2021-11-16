-- 3-1　对表进行聚合查询
-- 聚合函数

-- 计算表中数据的行数
-- 计算全部数据的行数
SELECT COUNT(*)
FROM Product;

-- 计算NULL之外的数据的行数
-- 计算NULL之外的数据行数
SELECT COUNT(purchase_price)
FROM Product;

-- 将? 包含NULL的列作为参数时， COUNT（ *） 和COUNT（<列名>）的结果并不相同
SELECT COUNT(*), COUNT(purchase_price)
FROM Product;

-- 计算合计值
-- 计算销售单价的合计值
SELECT SUM(sale_price)
FROM Product;

-- 计算销售单价和进货单价的合计值
SELECT SUM(sale_price), SUM(purchase_price)
FROM Product;

-- 计算平均值
-- 计算销售单价的平均值
SELECT AVG(sale_price)
FROM Product;

-- 计算销售单价和进货单价的平均值
SELECT AVG(sale_price), AVG(purchase_price)
FROM Product;

-- 计算值和小值
-- 计算销售单价的最大值和进货单价的最小值
SELECT MAX(sale_price), MIN(purchase_price)
FROM Product;

-- 计算登记日期的最大值和最小值
SELECT MAX(regist_date), MIN(regist_date)
FROM Product;

-- 使用聚合函数删除重复值（关键字DISTINCT）
-- 计算去除重复数据后的数据行数
SELECT COUNT(DISTINCT product_type)
FROM Product;

-- 先计算数据行数再删除重复数据的结果
SELECT DISTINCT COUNT(product_type)
FROM Product;

-- 使不使用DISTINCT时的动作差异（ SUM函数）
SELECT SUM(sale_price), SUM(DISTINCT sale_price)
FROM Product;

-- 3-2　对表进行分组

-- GROUP-BY子句
-- 按照商品种类统计数据行数
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type;

-- 聚合键中包含NULL的情况
-- 按照进货单价统计数据行数
SELECT purchase_price, COUNT(*)
FROM Product
GROUP BY purchase_price;

-- 使用WHERE子句时GROUP-BY的执行结果
-- 同时使用WHERE子句和GROUP BY子句
SELECT purchase_price, COUNT(*)
FROM Product
WHERE product_type = '衣服'
GROUP BY purchase_price;

-- 与聚合函数和GROUP-BY子句有关的常见错误
-- 在SELECT子句中书写聚合键之外的列名会发生错误
SELECT product_name, purchase_price, COUNT(*)
FROM Product
GROUP BY purchase_price;

#1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'shop.Product.product_name' 
which is not functionally dependent on columns in GROUP BY clause

-- GROUP BY子句中使用列的别名会引发错误
SELECT product_type AS pt, COUNT(*)
FROM Product
GROUP BY pt;

-- 按照商品种类统计数据行数
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type;

-- 在WHERE子句中使用聚合函数会引发错误
SELECT product_type, COUNT(*)
FROM Product
WHERE COUNT(*) = 2
GROUP BY product_type;
-- ERROR: 不能在WHERE子句中使用聚合

-- DISTINCT和GROUP BY能够实现相同的功能
SELECT DISTINCT product_type
FROM Product;

SELECT product_type
FROM Product
GROUP BY product_type;

-- 3-3　为聚合结果指定条件
-- HAVING子句
-- 从按照商品种类进行分组后的结果中，取出“包含的数据行数为2行”的组
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type
HAVING COUNT(*) = 2;

-- 不使用HAVING子句的情况
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type;

-- HAVING子句的构成要素
-- HAVING子句的不正确使用方法
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type
HAVING product_name = '圆珠笔';

-- 相对于HAVING子句，更适合写在WHERE子句中的条件
-- 将条件书写在HAVING子句中的情况
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type
HAVING product_type = '衣服';

-- 将条件书写在WHERE子句中的情况
SELECT product_type, COUNT(*)
FROM Product
WHERE product_type = '衣服'
GROUP BY product_type;

-- 3-4　对查询结果进行排序
-- ORDER-BY子句
-- 显示商品编号、商品名称、销售单价和进货单价的SELECT语句
SELECT product_id, product_name, sale_price, purchase_price FROM Product;

-- 按照销售单价由低到高（升序）进行排列
SELECT product_id, product_name, sale_price, purchase_price
FROM Product
ORDER BY sale_price;

-- 指定升序或降序
-- 按照销售单价由高到低（降序）进行排列
SELECT product_id, product_name, sale_price, purchase_price
FROM Product
ORDER BY sale_price DESC;

-- 指定多个排序键
-- 按照销售单价和商品编号的升序进行排序
SELECT product_id, product_name, sale_price, purchase_price
FROM Product
ORDER BY sale_price, product_id;
-- NULL的顺序
-- 按照进货单价的升序进行排列
SELECT product_id, product_name, sale_price, purchase_price
FROM Product
ORDER BY purchase_price;

-- 在排序键中使用显示用的别名
-- ORDER BY子句中可以使用列的别名
SELECT product_id AS id, product_name, sale_price AS sp, purchase_price
FROM Product
ORDER BY sp, id;

-- ORDER-BY子句中可以使用的列
-- SELECT子句中未包含的列也可以在ORDER BY子句中使用
SELECT product_name, sale_price, purchase_price
FROM Product
ORDER BY product_id;

-- ORDER BY子句中也可以使用聚合函数
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type
ORDER BY COUNT(*);

-- 不要使用列编号
ORDER BY子句中可以使用列的编号
-- 通过列名指定
SELECT product_id, product_name, sale_price, purchase_price
FROM Product
ORDER BY sale_price DESC, product_id;
-- 通过列编号指定
SELECT product_id, product_name, sale_price, purchase_price
FROM Product
ORDER BY 3 DESC, 1;
