## 第6章　函数、谓词、CASE表达式

### 6-1　各种各样的函数

#### 函数的种类

#### 算术函数
-- DDL ：创建表
CREATE TABLE SampleMath
(m NUMERIC (10,3),
n INTEGER,
p INTEGER);

-- DML ：插入数据
START TRANSACTION; 
INSERT INTO SampleMath(m, n, p) VALUES (500, 0, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (-180, 0, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, NULL, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 7, 3);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 5, 2);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 4, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (8, NULL, 3);
INSERT INTO SampleMath(m, n, p) VALUES (2.27, 1, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (5.555,2, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 1, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (8.76, NULL, NULL);
COMMIT;

SELECT * FROM SampleMath;

-- 计算数值的绝对值
SELECT m,
ABS(m) AS abs_col
FROM SampleMath;

-- 计算除法（ n ÷ p）的余数
SELECT n, p,
MOD(n, p) AS mod_col
FROM SampleMath;

-- 对m列的数值进行n列位数的四舍五入处理
SELECT m, n,
ROUND(m, n) AS round_col
FROM SampleMath;

#### 字符串函数

-- DDL ：创建表
CREATE TABLE SampleStr
(str1 VARCHAR(40),
str2 VARCHAR(40),
str3 VARCHAR(40))
DEFAULT CHARSET=utf8;

-- DML ：插入数据
START TRANSACTION; 
INSERT INTO SampleStr (str1, str2, str3) VALUES ('opx', 'rt',NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abc', 'def' ,NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('山田', '太郎' ,'是我');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('aaa', NULL ,NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES (NULL, 'xyz',NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('@!#$%', NULL ,NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('ABC', NULL ,NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('aBC', NULL ,NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abc太郎', 'abc' ,'ABC');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abcdefabc', 'abc' ,'ABC');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('micmic', 'i' ,'I');
COMMIT;

SELECT * FROM SampleStr;

-- 拼接字符串
SELECT str1, str2, str3,
CONCAT(str1, str2, str3) AS str_concat
FROM SampleStr;

-- 计算字符串长度
SELECT str1,
LENGTH(str1) AS len_str
FROM SampleStr;

-- 大写转换为小写
SELECT str1,
LOWER(str1) AS low_str
FROM SampleStr;

-- 替换字符串的一部分
SELECT str1, str2, str3,
REPLACE(str1, str2, str3) AS rep_str
FROM SampleStr;

-- 截取出字符串中第3位和第4位的字符
SELECT str1,
SUBSTRING(str1 FROM 3 FOR 2) AS sub_str
FROM SampleStr;

-- 将小写转换为大写
SELECT str1,
UPPER(str1) AS up_str
FROM SampleStr
WHERE str1 IN ('ABC', 'aBC', 'abc', '山田');

#### 日期函数
-- 获得当前日期
SELECT CURRENT_DATE;

-- 取得当前时间
SELECT CURRENT_TIME;

-- 取得当前日期和时间
SELECT CURRENT_TIMESTAMP;

-- 截取日期元素
SELECT CURRENT_TIMESTAMP,
EXTRACT(YEAR FROM CURRENT_TIMESTAMP) AS year,
EXTRACT(MONTH FROM CURRENT_TIMESTAMP) AS month,
EXTRACT(DAY FROM CURRENT_TIMESTAMP) AS day,
EXTRACT(HOUR FROM CURRENT_TIMESTAMP) AS hour,
EXTRACT(MINUTE FROM CURRENT_TIMESTAMP) AS minute,
EXTRACT(SECOND FROM CURRENT_TIMESTAMP) AS second;

#### 转换函数
-- 将字符串类型转换为数值类型
SELECT CAST('0001' AS SIGNED INTEGER) AS int_col;

-- 将字符串类型转换为日期类型
SELECT CAST('2009-12-14' AS DATE) AS date_col;

- 将NULL转换为其他值
SELECT COALESCE(NULL, 1) AS col_1,
COALESCE(NULL, 'test', NULL) AS col_2,
COALESCE(NULL, NULL, '2009-11-01') AS col_3;

-- 使用SampleStr表中的列作为例子
SELECT COALESCE(str2, 'NULL')
FROM SampleStr;

### 6-2　谓词

#### 什么是谓词

#### LIKE谓词——字符串的部分一致查询
-- DDL ：创建表
CREATE TABLE SampleLike
( strcol VARCHAR(6) NOT NULL,
PRIMARY KEY (strcol));

-- DML ：插入数据
START TRANSACTION; 
INSERT INTO SampleLike (strcol) VALUES ('abcddd');
INSERT INTO SampleLike (strcol) VALUES ('dddabc');
INSERT INTO SampleLike (strcol) VALUES ('abdddc');
INSERT INTO SampleLike (strcol) VALUES ('abcdd');
INSERT INTO SampleLike (strcol) VALUES ('ddabc');
INSERT INTO SampleLike (strcol) VALUES ('abddc');
COMMIT;

-- 使用LIKE进行前方一致查询
SELECT *
FROM SampleLike
WHERE strcol LIKE 'ddd%';

-- 使用LIKE进行中间一致查询
SELECT *
FROM SampleLike
WHERE strcol LIKE '%ddd%';

-- 使用LIKE进行后方一致查询
SELECT *
FROM SampleLike
WHERE strcol LIKE '%ddd';

-- 使用LIKE和_（下划线）进行后方一致查询
SELECT *
FROM SampleLike
WHERE strcol LIKE 'abc__';

-- 查询“abc+任意3个字符”的字符串
SELECT *
FROM SampleLike
WHERE strcol LIKE 'abc___';

#### BETWEEN谓词——范围查询
-- 选取销售单价为100～ 1000日元的商品
SELECT product_name, sale_price
FROM Product
WHERE sale_price BETWEEN 100 AND 1000;

-- 选取出销售单价为101 ～ 999日元的商品
SELECT product_name, sale_price
FROM Product
WHERE sale_price > 100
AND sale_price < 1000;

#### IS-NULL、IS-NOT-NULL——判断是否为NULL
-- 选取出进货单价（ purchase_price）为NULL的商品
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price IS NULL;

-- 选取进货单价（ purchase_price）不为NULL的商品
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price IS NOT NULL;

#### IN谓词——OR的简便用法
-- 通过OR指定多个进货单价进行查询
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price = 320
OR purchase_price = 500
OR purchase_price = 5000;

-- 通过IN来指定多个进货单价进行查询
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price IN (320, 500, 5000);

-- 使用NOT IN进行查询时指定多个排除的进货单价进行查询
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price NOT IN (320, 500, 5000);

#### 使用子查询作为IN谓词的参数
-- 创建ShopProduct（商店商品）表的CREATE TABLE语句
CREATE TABLE ShopProduct
(shop_id CHAR(4) NOT NULL,
shop_name VARCHAR(200) NOT NULL,
product_id CHAR(4) NOT NULL,
quantity INTEGER NOT NULL,
PRIMARY KEY (shop_id, product_id))
DEFAULT CHARSET=utf8;

-- 向ShopProduct表中插入数据的INSERT语句

START TRANSACTION; 
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000A', '东京', '0001', 30);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000A', '东京', '0002', 50);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000A', '东京', '0003', 15);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000B', '名古屋', '0002', 30);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000B', '名古屋', '0003', 120);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000B', '名古屋', '0004', 20);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000B', '名古屋', '0006', 10);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000B', '名古屋', '0007', 40);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000C', '大阪', '0003', 20);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000C', '大阪', '0004', 50);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000C', '大阪', '0006', 90);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000C', '大阪', '0007', 70);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000D', '福冈', '0001', 100);
COMMIT;

-- 使用子查询作为IN的参数
-- 取得“在大阪店销售的商品的销售单价”
SELECT product_name, sale_price
FROM Product
WHERE product_id IN (SELECT product_id
	FROM ShopProduct
	WHERE shop_id = '000C');

-- 使用子查询作为NOT IN的参数
-- 在东京店（000A）以外销售的商品的销售单价
SELECT product_name, sale_price
FROM Product
WHERE product_id NOT IN (SELECT product_id
FROM ShopProduct
WHERE shop_id = '000A');

#### EXIST谓词
-- 使用 EXIST选取出“大阪店在售商品的销售单价”
SELECT product_name, sale_price
FROM Product AS P 
WHERE EXISTS (SELECT *
	FROM ShopProduct AS SP 
	WHERE SP.shop_id = '000C'
	AND SP.product_id = P.product_id);

-- 这样的写法也能得到相同的结果
SELECT product_name, sale_price
FROM Product AS P 
WHERE EXISTS (SELECT 1 -- 这里可以书写适当的常数
FROM ShopProduct AS SP 
WHERE SP.shop_id = '000C'
AND SP.product_id = P.product_id);

-- 使用NOT EXIST读取出“东京店在售之外的商品的销售单价”
SELECT product_name, sale_price
FROM Product AS P 
WHERE NOT EXISTS (SELECT *
FROM ShopProduct AS SP
WHERE SP.shop_id = '000A'
AND SP.product_id = P.product_id);

### 6-3　CASE表达式

#### 什么是CASE表达式

#### CASE表达式的语法

#### CASE表达式的使用方法
-- 通过CASE表达式将A ～ C的字符串加入到商品种类当中
SELECT product_name,
CASE WHEN product_type = '衣服'
THEN CONCAT("A ： ",product_type)
WHEN product_type = '办公用品'
THEN CONCAT("B ： ",product_type)
WHEN product_type = '厨房用具'
THEN CONCAT("C ： ",product_type)
ELSE NULL
END AS abc_product_type
FROM Product;

-- 通常使用GROUP BY也无法实现行列转换
SELECT product_type,
SUM(sale_price) AS sum_price
FROM Product
GROUP BY product_type;

使用CASE表达式进行行列转换
-- 对按照商品种类计算出的销售单价合计值进行行列转换
SELECT SUM(CASE WHEN product_type = '衣服'
THEN sale_price ELSE 0 END) AS sum_price_clothes,
SUM(CASE WHEN product_type = '厨房用具'
THEN sale_price ELSE 0 END) AS sum_price_kitchen,
SUM(CASE WHEN product_type = '办公用品'
THEN sale_price ELSE 0 END) AS sum_price_office
FROM Product;

-- 使用简单CASE表达式的情况
SELECT product_name,
CASE product_type
WHEN '衣服' THEN CONCAT("A ： ",product_type)
WHEN '办公用品' THEN CONCAT("B ： ",product_type)
WHEN '厨房用具' THEN CONCAT("C ： ",product_type)
ELSE NULL
END AS abc_product_type
FROM Product;

-- 使用 CASE表达式的特定语句将字符串A ～ C添加到商品种类中
-- MySQL中使用IF代替CASE表达式
SELECT product_name,
IF( IF( IF(product_type = '衣服',
CONCAT('A ： ', product_type), NULL)
IS NULL AND product_type = '办公用品',
CONCAT('B ： ', product_type),
IF(product_type = '衣服',
CONCAT('A ： ', product_type), NULL))
IS NULL AND product_type = '厨房用具',
CONCAT('C ： ', product_type),
IF( IF(product_type = '衣服',
CONCAT('A： ', product_type), NULL)
IS NULL AND product_type = '办公用品',
CONCAT('B ： ', product_type),
IF(product_type = '衣服',
CONCAT('A ： ', product_type),
NULL))) AS abc_product_type
FROM Product;

#### 练习题

6.1	 对本章中使用的 Product（商品）表执行如下 2 条 SELECT 语句，能够得
到什么样的结果呢？
①
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price NOT IN (500, 2800, 5000);
②
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price NOT IN (500, 2800, 5000, NULL);

6.2	 按照销售单价（ sale_price）对练习 6.1 中的 Product（商品）表中的商品进行如下分类。
● 低档商品：销售单价在1000日元以下（T恤衫、办公用品、叉子、擦菜板、 圆珠笔）
● 中档商品：销售单价在1001日元以上3000日元以下（菜刀）
● 高档商品：销售单价在3001日元以上（运动T恤、高压锅）
	 请编写出统计上述商品种类中所包含的商品数量的 SELECT 语句，结果如下所示。
执行结果
low_price | mid_price | high_price
----------+----------+----------
5 | 1 | 2

SELECT 
SUM(CASE WHEN sale_price <= 1000 THEN 1 ELSE 0 END) as low_price, 
SUM(CASE WHEN sale_price > 1000 AND sale_price <= 3000 THEN 1 ELSE 0 END) as mid_price, 
SUM(CASE WHEN sale_price > 3000 THEN 1 ELSE 0 END) as high_price
FROM Product;

