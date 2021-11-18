## ��6�¡�������ν�ʡ�CASE���ʽ

### 6-1�����ָ����ĺ���

#### ����������

#### ��������
-- DDL ��������
CREATE TABLE SampleMath
(m NUMERIC (10,3),
n INTEGER,
p INTEGER);

-- DML ����������
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

-- ������ֵ�ľ���ֵ
SELECT m,
ABS(m) AS abs_col
FROM SampleMath;

-- ��������� n �� p��������
SELECT n, p,
MOD(n, p) AS mod_col
FROM SampleMath;

-- ��m�е���ֵ����n��λ�����������봦��
SELECT m, n,
ROUND(m, n) AS round_col
FROM SampleMath;

#### �ַ�������

-- DDL ��������
CREATE TABLE SampleStr
(str1 VARCHAR(40),
str2 VARCHAR(40),
str3 VARCHAR(40))
DEFAULT CHARSET=utf8;

-- DML ����������
START TRANSACTION; 
INSERT INTO SampleStr (str1, str2, str3) VALUES ('opx', 'rt',NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abc', 'def' ,NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('ɽ��', '̫��' ,'����');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('aaa', NULL ,NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES (NULL, 'xyz',NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('@!#$%', NULL ,NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('ABC', NULL ,NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('aBC', NULL ,NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abc̫��', 'abc' ,'ABC');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abcdefabc', 'abc' ,'ABC');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('micmic', 'i' ,'I');
COMMIT;

SELECT * FROM SampleStr;

-- ƴ���ַ���
SELECT str1, str2, str3,
CONCAT(str1, str2, str3) AS str_concat
FROM SampleStr;

-- �����ַ�������
SELECT str1,
LENGTH(str1) AS len_str
FROM SampleStr;

-- ��дת��ΪСд
SELECT str1,
LOWER(str1) AS low_str
FROM SampleStr;

-- �滻�ַ�����һ����
SELECT str1, str2, str3,
REPLACE(str1, str2, str3) AS rep_str
FROM SampleStr;

-- ��ȡ���ַ����е�3λ�͵�4λ���ַ�
SELECT str1,
SUBSTRING(str1 FROM 3 FOR 2) AS sub_str
FROM SampleStr;

-- ��Сдת��Ϊ��д
SELECT str1,
UPPER(str1) AS up_str
FROM SampleStr
WHERE str1 IN ('ABC', 'aBC', 'abc', 'ɽ��');

#### ���ں���
-- ��õ�ǰ����
SELECT CURRENT_DATE;

-- ȡ�õ�ǰʱ��
SELECT CURRENT_TIME;

-- ȡ�õ�ǰ���ں�ʱ��
SELECT CURRENT_TIMESTAMP;

-- ��ȡ����Ԫ��
SELECT CURRENT_TIMESTAMP,
EXTRACT(YEAR FROM CURRENT_TIMESTAMP) AS year,
EXTRACT(MONTH FROM CURRENT_TIMESTAMP) AS month,
EXTRACT(DAY FROM CURRENT_TIMESTAMP) AS day,
EXTRACT(HOUR FROM CURRENT_TIMESTAMP) AS hour,
EXTRACT(MINUTE FROM CURRENT_TIMESTAMP) AS minute,
EXTRACT(SECOND FROM CURRENT_TIMESTAMP) AS second;

#### ת������
-- ���ַ�������ת��Ϊ��ֵ����
SELECT CAST('0001' AS SIGNED INTEGER) AS int_col;

-- ���ַ�������ת��Ϊ��������
SELECT CAST('2009-12-14' AS DATE) AS date_col;

- ��NULLת��Ϊ����ֵ
SELECT COALESCE(NULL, 1) AS col_1,
COALESCE(NULL, 'test', NULL) AS col_2,
COALESCE(NULL, NULL, '2009-11-01') AS col_3;

-- ʹ��SampleStr���е�����Ϊ����
SELECT COALESCE(str2, 'NULL')
FROM SampleStr;

### 6-2��ν��

#### ʲô��ν��

#### LIKEν�ʡ����ַ����Ĳ���һ�²�ѯ
-- DDL ��������
CREATE TABLE SampleLike
( strcol VARCHAR(6) NOT NULL,
PRIMARY KEY (strcol));

-- DML ����������
START TRANSACTION; 
INSERT INTO SampleLike (strcol) VALUES ('abcddd');
INSERT INTO SampleLike (strcol) VALUES ('dddabc');
INSERT INTO SampleLike (strcol) VALUES ('abdddc');
INSERT INTO SampleLike (strcol) VALUES ('abcdd');
INSERT INTO SampleLike (strcol) VALUES ('ddabc');
INSERT INTO SampleLike (strcol) VALUES ('abddc');
COMMIT;

-- ʹ��LIKE����ǰ��һ�²�ѯ
SELECT *
FROM SampleLike
WHERE strcol LIKE 'ddd%';

-- ʹ��LIKE�����м�һ�²�ѯ
SELECT *
FROM SampleLike
WHERE strcol LIKE '%ddd%';

-- ʹ��LIKE���к�һ�²�ѯ
SELECT *
FROM SampleLike
WHERE strcol LIKE '%ddd';

-- ʹ��LIKE��_���»��ߣ����к�һ�²�ѯ
SELECT *
FROM SampleLike
WHERE strcol LIKE 'abc__';

-- ��ѯ��abc+����3���ַ������ַ���
SELECT *
FROM SampleLike
WHERE strcol LIKE 'abc___';

#### BETWEENν�ʡ�����Χ��ѯ
-- ѡȡ���۵���Ϊ100�� 1000��Ԫ����Ʒ
SELECT product_name, sale_price
FROM Product
WHERE sale_price BETWEEN 100 AND 1000;

-- ѡȡ�����۵���Ϊ101 �� 999��Ԫ����Ʒ
SELECT product_name, sale_price
FROM Product
WHERE sale_price > 100
AND sale_price < 1000;

#### IS-NULL��IS-NOT-NULL�����ж��Ƿ�ΪNULL
-- ѡȡ���������ۣ� purchase_price��ΪNULL����Ʒ
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price IS NULL;

-- ѡȡ�������ۣ� purchase_price����ΪNULL����Ʒ
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price IS NOT NULL;

#### INν�ʡ���OR�ļ���÷�
-- ͨ��ORָ������������۽��в�ѯ
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price = 320
OR purchase_price = 500
OR purchase_price = 5000;

-- ͨ��IN��ָ������������۽��в�ѯ
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price IN (320, 500, 5000);

-- ʹ��NOT IN���в�ѯʱָ������ų��Ľ������۽��в�ѯ
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price NOT IN (320, 500, 5000);

#### ʹ���Ӳ�ѯ��ΪINν�ʵĲ���
-- ����ShopProduct���̵���Ʒ�����CREATE TABLE���
CREATE TABLE ShopProduct
(shop_id CHAR(4) NOT NULL,
shop_name VARCHAR(200) NOT NULL,
product_id CHAR(4) NOT NULL,
quantity INTEGER NOT NULL,
PRIMARY KEY (shop_id, product_id))
DEFAULT CHARSET=utf8;

-- ��ShopProduct���в������ݵ�INSERT���

START TRANSACTION; 
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000A', '����', '0001', 30);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000A', '����', '0002', 50);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000A', '����', '0003', 15);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000B', '������', '0002', 30);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000B', '������', '0003', 120);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000B', '������', '0004', 20);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000B', '������', '0006', 10);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000B', '������', '0007', 40);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000C', '����', '0003', 20);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000C', '����', '0004', 50);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000C', '����', '0006', 90);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000C', '����', '0007', 70);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000D', '����', '0001', 100);
COMMIT;

-- ʹ���Ӳ�ѯ��ΪIN�Ĳ���
-- ȡ�á��ڴ�������۵���Ʒ�����۵��ۡ�
SELECT product_name, sale_price
FROM Product
WHERE product_id IN (SELECT product_id
	FROM ShopProduct
	WHERE shop_id = '000C');

-- ʹ���Ӳ�ѯ��ΪNOT IN�Ĳ���
-- �ڶ����꣨000A���������۵���Ʒ�����۵���
SELECT product_name, sale_price
FROM Product
WHERE product_id NOT IN (SELECT product_id
FROM ShopProduct
WHERE shop_id = '000A');

#### EXISTν��
-- ʹ�� EXISTѡȡ���������������Ʒ�����۵��ۡ�
SELECT product_name, sale_price
FROM Product AS P 
WHERE EXISTS (SELECT *
	FROM ShopProduct AS SP 
	WHERE SP.shop_id = '000C'
	AND SP.product_id = P.product_id);

-- ������д��Ҳ�ܵõ���ͬ�Ľ��
SELECT product_name, sale_price
FROM Product AS P 
WHERE EXISTS (SELECT 1 -- ���������д�ʵ��ĳ���
FROM ShopProduct AS SP 
WHERE SP.shop_id = '000C'
AND SP.product_id = P.product_id);

-- ʹ��NOT EXIST��ȡ��������������֮�����Ʒ�����۵��ۡ�
SELECT product_name, sale_price
FROM Product AS P 
WHERE NOT EXISTS (SELECT *
FROM ShopProduct AS SP
WHERE SP.shop_id = '000A'
AND SP.product_id = P.product_id);

### 6-3��CASE���ʽ

#### ʲô��CASE���ʽ

#### CASE���ʽ���﷨

#### CASE���ʽ��ʹ�÷���
-- ͨ��CASE���ʽ��A �� C���ַ������뵽��Ʒ���൱��
SELECT product_name,
CASE WHEN product_type = '�·�'
THEN CONCAT("A �� ",product_type)
WHEN product_type = '�칫��Ʒ'
THEN CONCAT("B �� ",product_type)
WHEN product_type = '�����þ�'
THEN CONCAT("C �� ",product_type)
ELSE NULL
END AS abc_product_type
FROM Product;

-- ͨ��ʹ��GROUP BYҲ�޷�ʵ������ת��
SELECT product_type,
SUM(sale_price) AS sum_price
FROM Product
GROUP BY product_type;

ʹ��CASE���ʽ��������ת��
-- �԰�����Ʒ�������������۵��ۺϼ�ֵ��������ת��
SELECT SUM(CASE WHEN product_type = '�·�'
THEN sale_price ELSE 0 END) AS sum_price_clothes,
SUM(CASE WHEN product_type = '�����þ�'
THEN sale_price ELSE 0 END) AS sum_price_kitchen,
SUM(CASE WHEN product_type = '�칫��Ʒ'
THEN sale_price ELSE 0 END) AS sum_price_office
FROM Product;

-- ʹ�ü�CASE���ʽ�����
SELECT product_name,
CASE product_type
WHEN '�·�' THEN CONCAT("A �� ",product_type)
WHEN '�칫��Ʒ' THEN CONCAT("B �� ",product_type)
WHEN '�����þ�' THEN CONCAT("C �� ",product_type)
ELSE NULL
END AS abc_product_type
FROM Product;

-- ʹ�� CASE���ʽ���ض���佫�ַ���A �� C��ӵ���Ʒ������
-- MySQL��ʹ��IF����CASE���ʽ
SELECT product_name,
IF( IF( IF(product_type = '�·�',
CONCAT('A �� ', product_type), NULL)
IS NULL AND product_type = '�칫��Ʒ',
CONCAT('B �� ', product_type),
IF(product_type = '�·�',
CONCAT('A �� ', product_type), NULL))
IS NULL AND product_type = '�����þ�',
CONCAT('C �� ', product_type),
IF( IF(product_type = '�·�',
CONCAT('A�� ', product_type), NULL)
IS NULL AND product_type = '�칫��Ʒ',
CONCAT('B �� ', product_type),
IF(product_type = '�·�',
CONCAT('A �� ', product_type),
NULL))) AS abc_product_type
FROM Product;

#### ��ϰ��

6.1	 �Ա�����ʹ�õ� Product����Ʒ����ִ������ 2 �� SELECT ��䣬�ܹ���
��ʲô���Ľ���أ�
��
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price NOT IN (500, 2800, 5000);
��
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price NOT IN (500, 2800, 5000, NULL);

6.2	 �������۵��ۣ� sale_price������ϰ 6.1 �е� Product����Ʒ�����е���Ʒ�������·��ࡣ
�� �͵���Ʒ�����۵�����1000��Ԫ���£�T�������칫��Ʒ�����ӡ����˰塢 Բ��ʣ�
�� �е���Ʒ�����۵�����1001��Ԫ����3000��Ԫ���£��˵���
�� �ߵ���Ʒ�����۵�����3001��Ԫ���ϣ��˶�T������ѹ����
	 ���д��ͳ��������Ʒ����������������Ʒ������ SELECT ��䣬���������ʾ��
ִ�н��
low_price | mid_price | high_price
----------+----------+----------
5 | 1 | 2

SELECT 
SUM(CASE WHEN sale_price <= 1000 THEN 1 ELSE 0 END) as low_price, 
SUM(CASE WHEN sale_price > 1000 AND sale_price <= 3000 THEN 1 ELSE 0 END) as mid_price, 
SUM(CASE WHEN sale_price > 3000 THEN 1 ELSE 0 END) as high_price
FROM Product;

