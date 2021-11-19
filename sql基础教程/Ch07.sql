### 7-1　表的加减法

#### 什么是集合运算

#### 表的加法——UNION
-- 创建表Product2（商品2）
CREATE TABLE Product2
(product_id CHAR(4) NOT NULL,
product_name VARCHAR(100) NOT NULL,
product_type VARCHAR(32) NOT NULL,
sale_price INTEGER ,
purchase_price INTEGER ,
regist_date DATE ,
PRIMARY KEY (product_id))
DEFAULT CHARSET=utf8;

-- 将数据插入到表Product2（商品2）中
START TRANSACTION; 
INSERT INTO Product2 VALUES ('0001', 'T恤衫' ,'衣服', 1000, 500, '2008-09-20');
INSERT INTO Product2 VALUES ('0002', '打孔器', '办公用品', 500, 320, '2009-09-11');
INSERT INTO Product2 VALUES ('0003', '运动T恤', '衣服', 4000, 2800, NULL);
INSERT INTO Product2 VALUES ('0009', '手套', '衣服', 800, 500, NULL);
INSERT INTO Product2 VALUES ('0010', '水壶', '厨房用具', 2000, 1700, '2009-09-20');
COMMIT;

-- 使用UNION对表进行加法运算
SELECT product_id, product_name
FROM Product
UNION
SELECT product_id, product_name
FROM Product2;

#### 集合运算的注意事项
-- 列数不一致时会发生错误
SELECT product_id, product_name
FROM Product
UNION
SELECT product_id, product_name, sale_price
FROM Product2;

-- 数据类型不一致时会发生错误
SELECT product_id, sale_price
FROM Product
UNION
SELECT product_id, regist_date
FROM Product2;

-- ORDER BY子句只在最后使用一次
SELECT product_id, product_name
FROM Product
WHERE product_type = '厨房用具'
UNION
SELECT product_id, product_name
FROM Product2
WHERE product_type = '厨房用具'
ORDER BY product_id;

#### 包含重复行的集合运算——ALL选项
-- 保留重复行
SELECT product_id, product_name
FROM Product
UNION ALL
SELECT product_id, product_name
FROM Product2;

#### 选取表中公共部分——INTERSECT
-- 使用INTERSECT选取出表中公共部分
SELECT product_id, product_name
FROM Product
INTERSECT
SELECT product_id, product_name
FROM Product2
ORDER BY product_id;

#### 记录的减法——EXCEPT
-- 使用EXCEPT对记录进行减法运算
SELECT product_id, product_name
FROM Product
EXCEPT
SELECT product_id, product_name
FROM Product2
ORDER BY product_id;

-- 被减数和减数位置不同，得到的结果也不同
-- 从Product2的记录中除去Product中的记录
SELECT product_id, product_name
FROM Product2
EXCEPT
SELECT product_id, product_name
FROM Product
ORDER BY product_id;

### 7-2　联结（以列为单位对表进行联结）

#### 什么是联结

#### 内联结——INNER-JOIN
-- 将两张表进行内联结
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM ShopProduct AS SP INNER JOIN Product AS P 
ON SP.product_id = P.product_id;

-- 内联结和WHERE子句结合使用
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM ShopProduct AS SP INNER JOIN Product AS P 
ON SP.product_id = P.product_id
WHERE SP.shop_id = '000A';

#### 外联结——OUTER-JOIN
-- 将两张表进行外联结
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM ShopProduct AS SP RIGHT OUTER JOIN Product AS P
ON SP.product_id = P.product_id;

-- 改写后外联结的结果完全相同
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM Product AS P LEFT OUTER JOIN ShopProduct AS SP 
ON SP.product_id = P.product_id;


#### 3张以上的表的联结
-- 创建InventoryProduct表并向其中插入数据
-- DDL ：创建表
CREATE TABLE InventoryProduct
( inventory_id CHAR(4) NOT NULL,
product_id CHAR(4) NOT NULL,
inventory_quantity INTEGER NOT NULL,
PRIMARY KEY (inventory_id, product_id));

-- DML ：插入数据
START TRANSACTION; 
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) 
VALUES ('P001', '0001', 0);
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) 
VALUES ('P001', '0002', 120);
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) 
VALUES ('P001', '0003', 200);
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) 
VALUES ('P001', '0004', 3);
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) 
VALUES ('P001', '0005', 0);
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) 
VALUES ('P001', '0006', 99);
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) 
VALUES ('P001', '0007', 999);
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) 
VALUES ('P001', '0008', 200);
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) 
VALUES ('P002', '0001', 10);
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) 
VALUES ('P002', '0002', 25);
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) 
VALUES ('P002', '0003', 34);
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) 
VALUES ('P002', '0004', 19);
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) 
VALUES ('P002', '0005', 99);
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) 
VALUES ('P002', '0006', 0);
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) 
VALUES ('P002', '0007', 0);
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) 
VALUES ('P002', '0008', 18);
COMMIT;

-- 对3张表进行内联结
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price, IP.inventory_quantity
FROM ShopProduct AS SP INNER JOIN Product AS P ON SP.product_id = P.product_id
INNER JOIN InventoryProduct AS IP ON SP.product_id = IP.product_id
WHERE IP.inventory_id = 'P001';

#### 交叉联结——CROSS-JOIN
-- 将两张表进行交叉联结
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name
FROM ShopProduct AS SP CROSS JOIN Product AS P;

#### 联结的特定语法和过时语法
-- 使用过时语法的内联结
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM ShopProduct SP, Product P
WHERE SP.product_id = P.product_id
AND SP.shop_id = '000A';

-- DDL ：创建表
CREATE TABLE Skills
(skill VARCHAR(32),
PRIMARY KEY(skill));
CREATE TABLE EmpSkills
(emp VARCHAR(32),
skill VARCHAR(32),
PRIMARY KEY(emp, skill))
DEFAULT CHARSET=utf8;

-- DML ：插入数据
START TRANSACTION; 
INSERT INTO Skills VALUES('Oracle');
INSERT INTO Skills VALUES('UNIX');
INSERT INTO Skills VALUES('Java');
INSERT INTO EmpSkills VALUES('相田', 'Oracle');
INSERT INTO EmpSkills VALUES('相田', 'UNIX');
INSERT INTO EmpSkills VALUES('相田', 'Java');
INSERT INTO EmpSkills VALUES('相田', 'C#');
INSERT INTO EmpSkills VALUES('神崎', 'Oracle');
INSERT INTO EmpSkills VALUES('神崎', 'UNIX');
INSERT INTO EmpSkills VALUES('神崎', 'Java');
INSERT INTO EmpSkills VALUES('平井', 'UNIX');
INSERT INTO EmpSkills VALUES('平井', 'Oracle');
INSERT INTO EmpSkills VALUES('平井', 'PHP');
INSERT INTO EmpSkills VALUES('平井', 'Perl');
INSERT INTO EmpSkills VALUES('平井', 'C++');
INSERT INTO EmpSkills VALUES('若田部', 'Perl');
INSERT INTO EmpSkills VALUES('渡来', 'Oracle');
COMMIT;

-- 选取出掌握所有3个领域的技术的员工
SELECT DISTINCT emp
FROM EmpSkills ES1
WHERE NOT EXISTS
(SELECT skill
FROM Skills
EXCEPT
SELECT skill
FROM EmpSkills ES2
WHERE EP1.emp = ES2.emp);

#### 练习题
7.1	 请说出下述 SELECT 语句的结果。
-- 使用本章中的Product表
SELECT *
FROM Product
UNION
SELECT *
FROM Product
INTERSECT
SELECT *
FROM Product
ORDER BY product_id;

会将 Product 表中的 8 行记录原封不动地选取出来。

7.2	 7-2 节的代码清单 7-11 中列举的外联结的结果中，高压锅和圆珠笔 2 条 记录的商店编号（ shop_id）和商店名称（ shop_name）都是 NULL。
请使用字符串“不确定”替换其中的 NULL。期望结果如下所示。
执行结果
shop_id | shop_name | product_id | product_name| sale_price
--|--|--|--|--
000A | 东京 | 0002 | 打孔器 | 500
000A | 东京 | 0003 | 运动T恤 | 4000
000A | 东京 | 0001 | T恤衫 | 1000
000B | 名古屋 | 0006 | 叉子 | 500
000B | 名古屋 | 0002 | 打孔器 | 500
000B | 名古屋 | 0003 | 运动T恤 | 4000
000B | 名古屋 | 0004 | 菜刀 | 3000
000B | 名古屋 | 0007 | 擦菜板 | 880
000C | 大阪 | 0006 | 叉子 | 500
000C | 大阪 | 0007 | 擦菜板 | 880
000C | 大阪 | 0003 | 运动T恤 | 4000
000C | 大阪 | 0004 | 菜刀 | 3000
000D | 福冈 | 0001 | T恤衫 | 1000
不确定 | 不确定 | 0005 | 高压锅 | 6800
不确定 | 不确定 | 0008 | 圆珠笔 | 100

将商店编号和商店名称输出为"不确定"

SELECT COALESCE(s.shop_id, '不确定') as shop_id, 
COALESCE(s.shop_name, '不确定') as shop_name, 
p.product_id, p.product_name, p.sale_price
FROM ShopProduct s RIGHT OUTER JOIN Product p 
ON s.product_id = p.product_id;

