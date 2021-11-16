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

SELECT product_id, product_name, purchase_price FROM Product;

SELECT product_id AS "商品编号",
product_name AS "商品名称",
purchase_price AS '进货单价'
FROM Product;

SELECT product_type
FROM Product;

SELECT DISTINCT regist_date
FROM Product;

SELECT product_name, product_type
FROM Product
WHERE product_type = '衣服';

-- SQL语句中也可以使用运算表达式
SELECT product_name, sale_price,
sale_price * 2 AS "sale_price_x2"
FROM Product;

SELECT (purchase_price / 0) AS purchase_price0 FROM Product;
SELECT (purchase_price / NULL) AS purchase_price0 FROM Product;

SELECT (5 / 0) AS P50, (NULL / 0) AS PNull0 FROM Product;

-- 选取出sale_price列为500的记录
SELECT product_name, product_type
FROM Product
WHERE sale_price <> 500;

-- 选取出销售单价大于等于1000日元的记录
SELECT product_name, product_type, sale_price
FROM Product
WHERE sale_price >= 1000;

-- 选取出登记日期在2009年9月27日之前的记录
SELECT product_name, product_type, regist_date
FROM Product
WHERE regist_date < '2009-09-27';

-- WHERE子句的条件表达式中也可以使用计算表达式
SELECT product_name, sale_price, purchase_price
FROM Product
WHERE sale_price - purchase_price >= 500;

-- 选取进货单价为2800日元的记录
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price = 2800;

-- 选取出进货单价不是2800日元的记录
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price <> 2800;

-- 选取NULL的记录
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price IS NULL;

-- 选取不为NULL的记录
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price IS NOT NULL;

-- 选取出销售单价大于等于1000日元的记录
SELECT product_name, product_type, sale_price
FROM Product
WHERE sale_price >= 1000;

-- 查询条件中添加NOT运算符
SELECT product_name, product_type, sale_price
FROM Product
WHERE NOT sale_price >= 1000;

-- WHERE子句的查询条件和查询条件是等价的
SELECT product_name, product_type
FROM Product
WHERE sale_price < 1000;

-- 在WHERE子句的查询条件中使用AND运算符
SELECT product_name, purchase_price
FROM Product
WHERE product_type = '厨房用具'
AND sale_price >= 3000;

-- 在WHERE子句的查询条件中使用OR运算符
SELECT product_name, purchase_price
FROM Product
WHERE product_type = '厨房用具'
OR sale_price >= 3000;

-- 将查询条件原封不动地写入条件表达式
SELECT product_name, product_type, regist_date
FROM Product
WHERE product_type = '办公用品'
AND regist_date = '2009-09-11'
OR regist_date = '2009-09-20';

-- 通过使用括号让OR运算符先于AND运算符执行
SELECT product_name, product_type, regist_date
FROM Product
WHERE product_type = '办公用品'
AND ( regist_date = '2009-09-11'
OR regist_date = '2009-09-20');

2.1	 编写一条 SQL 语句，从 Product（商品）表中选取出“登记日期（ regist_date）在 2009 年 4 月 28 日之后”的商品。查询结果要包含 product_name 和 regist_date 两列。

SELECT product_name, regist_date FROM Product WHERE regist_date > '2009-04-28';

2.2	 请说出对 Product 表执行如下 3 条 SELECT 语句时的返回结果。
① 
SELECT *
FROM Product
WHERE purchase_price = NULL;

② 
SELECT *
FROM Product
WHERE purchase_price <> NULL;

③ 
SELECT *
FROM Product
WHERE product_name > NULL;

2.3	 代码清单 2-22（2-2 节）中的 SELECT 语句能够从 Product 表中取出“销售单价（ sale_price）比进货单价（ purchase_price）高出 500日元以上”的商品。
请写出两条可以得到相同结果的 SELECT 语句。执行结果如下所示。

执行结果
product_name | sale_price | purchase_price
---------------+-------------+----------------
T恤衫 | 1000 | 500
运动T恤 | 4000 | 2800
高压锅 | 6800 | 5000

SELECT product_name, sale_price, purchase_price FROM Product WHERE (sale_price - purchase_price) >= 500;
SELECT product_name, sale_price, purchase_price FROM Product WHERE NOT (sale_price - purchase_price) < 500;

2.4	 请写出一条 SELECT 语句，从 Product 表中选取出满足“销售单价打九折之后利润高于 100 日元的办公用品和厨房用具”条件的记录。
查询结果要包括 product_name 列、 product_type 列以及销售单价打九折之后的利润（别名设定为 profit）。
提示：销售单价打九折，可以通过 sale_price 列的值乘以 0.9 获得，利润可以通过该值减去 purchase_price 列的值获得。

SELECT product_name, product_type, (sale_price * 0.9) AS profit 
FROM Product 
WHERE (sale_price * 0.9 - purchase_price) > 100
AND (product_type = '办公用品' OR product_type = '厨房用具');