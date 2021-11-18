### 4-1　数据的插入（INSERT语句的使用方法）

#### 什么是INSERT
-- 创建ProductIns表的CREATE TABLE语句
CREATE TABLE ProductIns
(product_id CHAR(4) NOT NULL,
product_name VARCHAR(100) NOT NULL,
product_type VARCHAR(32) NOT NULL,
sale_price INTEGER DEFAULT 0,
purchase_price INTEGER ,
regist_date DATE ,
PRIMARY KEY (product_id))
DEFAULT CHARSET=utf8;

#### INSERT语句的基本语法
-- 向表中插入一行数据
INSERT INTO ProductIns (product_id, product_name, product_type, sale_price, purchase_price, regist_date) VALUES ('0001', 'T恤衫', '衣服', 1000, 500, '2009-09-20');

#### 列清单的省略
省略列清单
-- 包含列清单
INSERT INTO ProductIns (product_id, product_name, product_type, sale_price, purchase_price, regist_date) VALUES ('0005', '高压锅', '厨房用具', 6800, 5000, '2009-01-15');
-- 省略列清单
INSERT INTO ProductIns VALUES ('0005', '高压锅', '厨房用具', 6800, 5000, '2009-01-15');

#### 插入NULL
-- 向purchase_price列中插入NULL
INSERT INTO ProductIns (product_id, product_name, product_type, sale_price, purchase_price, regist_date) VALUES ('0006', '叉子', '厨房用具', 500, NULL, '2009-09-20');

#### 插入默认值
-- 通过显式方法设定默认值
INSERT INTO ProductIns (product_id, product_name, product_type, sale_price, purchase_price, regist_date) VALUES ('0007', '擦菜板', '厨房用具', DEFAULT, 790, '2009-04-28');

-- 通过隐式方法设定默认值
INSERT INTO ProductIns (product_id, product_name, product_type, purchase_price, regist_date) VALUES ('0007', '擦菜板', '厨房用具', 790, '2009-04-28');

未设定默认值的情况
-- 省略purchase_price列（无约束）：会赋予“NULL”
INSERT INTO ProductIns (product_id, product_name, product_type, sale_price, regist_date) VALUES ('0008', '圆珠笔', '办公用品', 100, '2009-11-11');
-- 省略product_name列（设置了NOT NULL约束）：错误！
INSERT INTO ProductIns (product_id, product_type, sale_price, purchase_price, regist_date) VALUES ('0009', '办公用品', 1000, 500, '2009-12-12');


#### 从其他表中复制数据

-- 用来插入数据的商品复制表
CREATE TABLE ProductCopy
(product_id CHAR(4) NOT NULL,
product_name VARCHAR(100) NOT NULL,
product_type VARCHAR(32) NOT NULL,
sale_price INTEGER ,
purchase_price INTEGER ,
regist_date DATE ,
PRIMARY KEY (product_id))
DEFAULT CHARSET=utf8;

INSERT ... SELECT语句
-- 将商品表中的数据复制到商品复制表中
INSERT INTO ProductCopy (product_id, product_name, product_type, sale_price, purchase_price, regist_date)
SELECT product_id, product_name, product_type, sale_price, purchase_price, regist_date
FROM Product;

创建ProductType表的CREATE TABLE语句
-- 根据商品种类进行汇总的表 ；
CREATE TABLE ProductType
(product_type VARCHAR(32) NOT NULL,
sum_sale_price INTEGER ,
sum_purchase_price INTEGER ,
PRIMARY KEY (product_type))
DEFAULT CHARSET=utf8;

-- 插入其他表中数据合计值的INSERT ... SELECT语句
INSERT INTO ProductType (product_type, sum_sale_price, sum_purchase_price)
SELECT product_type, SUM(sale_price), SUM(purchase_price)
FROM Product
GROUP BY product_type;

### 4-2　数据的删除（DELETE语句的使用方法）

#### DROP-TABLE语句和DELETE语句

#### DELETE语句的基本语法

#### 指定删除对象的DELETE语句（搜索型DELETE）
-- 删除销售单价（ sale_price）大于等于4000日元的数据
DELETE FROM Product
WHERE sale_price >= 4000;

### 4-3　数据的更新（UPDATE语句的使用方法）

#### UPDATE语句的基本语法
-- 将登记日期全部更新为“2009-10-10”
UPDATE Product
SET regist_date = '2009-10-10';
#### 指定条件的UPDATE语句（搜索型UPDATE）
-- 将商品种类为厨房用具的记录的销售单价更新为原来的10倍
UPDATE Product
SET sale_price = sale_price * 10
WHERE product_type = '厨房用具';

#### 使用NULL进行更新
-- 将商品编号为0008的数据（圆珠笔）的登记日期更新为NULL
UPDATE Product
SET regist_date = NULL
WHERE product_id = '0008';

#### 多列更新
能够正确执行的繁琐的UPDATE语句
-- 一条UPDATE语句只更新一列
UPDATE Product
SET sale_price = sale_price * 10
WHERE product_type = '厨房用具';
UPDATE Product
SET purchase_price = purchase_price / 2
WHERE product_type = '厨房用具';

方法①：代码清单4-19　将代码清单4-18的处理合并为一条UPDATE语句
-- 使用逗号对列进行分隔排列
UPDATE Product
SET sale_price = sale_price * 10,
purchase_price = purchase_price / 2
WHERE product_type = '厨房用具';

方法②：代码清单4-20　将代码清单4-18的处理合并为一条UPDATE语句 （mysql不支持）
-- 将列用()括起来的清单形式
UPDATE Product
SET (sale_price, purchase_price) = (sale_price * 10, purchase_price / 2)
WHERE product_type = '厨房用具';

### 4-4　事务

#### 什么是事务

#### 创建事务
START TRANSACTION;
-- 将运动T恤的销售单价降低1000日元
UPDATE Product
SET sale_price = sale_price - 1000
WHERE product_name = '运动T恤';
-- 将T恤衫的销售单价上浮1000日元
UPDATE Product
SET sale_price = sale_price + 1000
WHERE product_name = 'T恤衫';
COMMIT;

事务回滚的例子
START TRANSACTION;
-- 将运动T恤的销售单价降低1000日元
UPDATE Product
SET sale_price = sale_price - 1000
WHERE product_name = '运动T恤';
-- 将T恤衫的销售单价上浮1000日元
UPDATE Product
SET sale_price = sale_price + 1000
WHERE product_name = 'T恤衫';
ROLLBACK;
#### ACID特性

#### 练习题
4.1	 A 先生在自己的计算机（电脑）上，使用 CREATE TABLE 语句创建出了一张空的 Product（商品）表，并执行了如下的 SQL 语句向其中插入数据。
START TRANSACTION;
INSERT INTO Product VALUES ('0001', 'T恤衫', '衣服', 1000, 500, '2008-09-20');
INSERT INTO Product VALUES ('0002', '打孔器', '办公用品', 500, 320, '2008-09-11');
INSERT INTO Product VALUES ('0003', '运动T恤', '衣服', 4000, 2800, NULL);

紧接着，B 先生使用其他的计算机连接上该数据库，执行了如下 SELECT 语句。这时 B 先生能得到怎样的查询结果呢？
SELECT * FROM Product;
提示：如果可以使用DELETE语句，就可以对通过CREATE TABLE语句创建出的空表执行该操作了。

没有一行数据，事务没有提交

CREATE TABLE Product
(product_id      CHAR(4)      NOT NULL,
 product_name    VARCHAR(100) NOT NULL,
 product_type    VARCHAR(32)  NOT NULL,
 sale_price      INTEGER ,
 purchase_price  INTEGER ,
 regist_date     DATE ,
 PRIMARY KEY (product_id)) DEFAULT CHARSET=utf8;
 
DELETE FROM Product;
INSERT INTO Product VALUES ('0001', 'T恤衫', '衣服', 1000, 500, '2008-09-20');
INSERT INTO Product VALUES ('0002', '打孔器', '办公用品', 500, 320, '2008-09-11');
INSERT INTO Product VALUES ('0003', '运动T恤', '衣服', 4000, 2800, NULL);

SELECT * FROM Product;

4.2	 有一张包含 3 条记录的 Product 表。
使用如下的 INSERT 语句复制这 3 行数据，应该就能够将表中的数据增加为 6 行。请说出该语句的执行结果。

INSERT INTO Product SELECT * FROM Product;

Duplicate entry '0001' for key 'PRIMARY'

4.3	 以练习 4.2 中的 Product 表为基础，再创建另外一张包含利润列的新表ProductMargin（商品利润）。
-- 商品利润表
CREATE TABLE ProductMargin
(product_id CHAR(4) NOT NULL,
product_name VARCHAR(100) NOT NULL,
sale_price INTEGER,
purchase_price INTEGER,
margin INTEGER,
PRIMARY KEY(product_id));

请写出向上述表中插入如下数据的 SQL 语句，其中的利润可以简单地通过对 Product 表中的数据进行计算（销售单价 - 进货单价）得出。
product_id product_name sale_price purchase_price margin
0001 T恤衫 1000 500 500
0002 打孔器 500 320 180
0003 运动T恤 4000 2800 1200

CREATE TABLE ProductMargin
(product_id CHAR(4) NOT NULL,
product_name VARCHAR(100) NOT NULL,
sale_price INTEGER,
purchase_price INTEGER,
margin INTEGER,
PRIMARY KEY(product_id))
DEFAULT CHARSET=utf8;

INSERT INTO ProductMargin(product_id, product_name, sale_price, purchase_price, margin) 
SELECT product_id, product_name, sale_price, purchase_price, sale_price - purchase_price
FROM Product;


4.4	 对练习 4.3 中的 ProductMargin 表的数据进行如下更改。
1. 将运动 T 恤的销售单价从 4000 日元下调至 3000 日元。
2. 根据上述结果再次计算运动 T 恤的利润。
更改后的ProductMargin表如下所示。请写出能够实现该变更的SQL语句

UPDATE ProductMargin
SET sale_price = 3000
WHERE product_name = '运动T恤';

UPDATE ProductMargin
SET margin = sale_price - purchase_price
WHERE product_name = '运动T恤';