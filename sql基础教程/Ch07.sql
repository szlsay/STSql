### 7-1����ļӼ���

#### ʲô�Ǽ�������

#### ��ļӷ�����UNION
-- ������Product2����Ʒ2��
CREATE TABLE Product2
(product_id CHAR(4) NOT NULL,
product_name VARCHAR(100) NOT NULL,
product_type VARCHAR(32) NOT NULL,
sale_price INTEGER ,
purchase_price INTEGER ,
regist_date DATE ,
PRIMARY KEY (product_id))
DEFAULT CHARSET=utf8;

-- �����ݲ��뵽��Product2����Ʒ2����
START TRANSACTION; 
INSERT INTO Product2 VALUES ('0001', 'T����' ,'�·�', 1000, 500, '2008-09-20');
INSERT INTO Product2 VALUES ('0002', '�����', '�칫��Ʒ', 500, 320, '2009-09-11');
INSERT INTO Product2 VALUES ('0003', '�˶�T��', '�·�', 4000, 2800, NULL);
INSERT INTO Product2 VALUES ('0009', '����', '�·�', 800, 500, NULL);
INSERT INTO Product2 VALUES ('0010', 'ˮ��', '�����þ�', 2000, 1700, '2009-09-20');
COMMIT;

-- ʹ��UNION�Ա���мӷ�����
SELECT product_id, product_name
FROM Product
UNION
SELECT product_id, product_name
FROM Product2;

#### ���������ע������
-- ������һ��ʱ�ᷢ������
SELECT product_id, product_name
FROM Product
UNION
SELECT product_id, product_name, sale_price
FROM Product2;

-- �������Ͳ�һ��ʱ�ᷢ������
SELECT product_id, sale_price
FROM Product
UNION
SELECT product_id, regist_date
FROM Product2;

-- ORDER BY�Ӿ�ֻ�����ʹ��һ��
SELECT product_id, product_name
FROM Product
WHERE product_type = '�����þ�'
UNION
SELECT product_id, product_name
FROM Product2
WHERE product_type = '�����þ�'
ORDER BY product_id;

#### �����ظ��еļ������㡪��ALLѡ��
-- �����ظ���
SELECT product_id, product_name
FROM Product
UNION ALL
SELECT product_id, product_name
FROM Product2;

#### ѡȡ���й������֡���INTERSECT
-- ʹ��INTERSECTѡȡ�����й�������
SELECT product_id, product_name
FROM Product
INTERSECT
SELECT product_id, product_name
FROM Product2
ORDER BY product_id;

#### ��¼�ļ�������EXCEPT
-- ʹ��EXCEPT�Լ�¼���м�������
SELECT product_id, product_name
FROM Product
EXCEPT
SELECT product_id, product_name
FROM Product2
ORDER BY product_id;

-- �������ͼ���λ�ò�ͬ���õ��Ľ��Ҳ��ͬ
-- ��Product2�ļ�¼�г�ȥProduct�еļ�¼
SELECT product_id, product_name
FROM Product2
EXCEPT
SELECT product_id, product_name
FROM Product
ORDER BY product_id;

### 7-2�����ᣨ����Ϊ��λ�Ա�������ᣩ

#### ʲô������

#### �����ᡪ��INNER-JOIN
-- �����ű����������
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM ShopProduct AS SP INNER JOIN Product AS P 
ON SP.product_id = P.product_id;

-- �������WHERE�Ӿ���ʹ��
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM ShopProduct AS SP INNER JOIN Product AS P 
ON SP.product_id = P.product_id
WHERE SP.shop_id = '000A';

#### �����ᡪ��OUTER-JOIN
-- �����ű����������
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM ShopProduct AS SP RIGHT OUTER JOIN Product AS P
ON SP.product_id = P.product_id;

-- ��д��������Ľ����ȫ��ͬ
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM Product AS P LEFT OUTER JOIN ShopProduct AS SP 
ON SP.product_id = P.product_id;


#### 3�����ϵı������
-- ����InventoryProduct�������в�������
-- DDL ��������
CREATE TABLE InventoryProduct
( inventory_id CHAR(4) NOT NULL,
product_id CHAR(4) NOT NULL,
inventory_quantity INTEGER NOT NULL,
PRIMARY KEY (inventory_id, product_id));

-- DML ����������
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

-- ��3�ű����������
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price, IP.inventory_quantity
FROM ShopProduct AS SP INNER JOIN Product AS P ON SP.product_id = P.product_id
INNER JOIN InventoryProduct AS IP ON SP.product_id = IP.product_id
WHERE IP.inventory_id = 'P001';

#### �������ᡪ��CROSS-JOIN
-- �����ű���н�������
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name
FROM ShopProduct AS SP CROSS JOIN Product AS P;

#### ������ض��﷨�͹�ʱ�﷨
-- ʹ�ù�ʱ�﷨��������
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM ShopProduct SP, Product P
WHERE SP.product_id = P.product_id
AND SP.shop_id = '000A';

-- DDL ��������
CREATE TABLE Skills
(skill VARCHAR(32),
PRIMARY KEY(skill));
CREATE TABLE EmpSkills
(emp VARCHAR(32),
skill VARCHAR(32),
PRIMARY KEY(emp, skill))
DEFAULT CHARSET=utf8;

-- DML ����������
START TRANSACTION; 
INSERT INTO Skills VALUES('Oracle');
INSERT INTO Skills VALUES('UNIX');
INSERT INTO Skills VALUES('Java');
INSERT INTO EmpSkills VALUES('����', 'Oracle');
INSERT INTO EmpSkills VALUES('����', 'UNIX');
INSERT INTO EmpSkills VALUES('����', 'Java');
INSERT INTO EmpSkills VALUES('����', 'C#');
INSERT INTO EmpSkills VALUES('����', 'Oracle');
INSERT INTO EmpSkills VALUES('����', 'UNIX');
INSERT INTO EmpSkills VALUES('����', 'Java');
INSERT INTO EmpSkills VALUES('ƽ��', 'UNIX');
INSERT INTO EmpSkills VALUES('ƽ��', 'Oracle');
INSERT INTO EmpSkills VALUES('ƽ��', 'PHP');
INSERT INTO EmpSkills VALUES('ƽ��', 'Perl');
INSERT INTO EmpSkills VALUES('ƽ��', 'C++');
INSERT INTO EmpSkills VALUES('���ﲿ', 'Perl');
INSERT INTO EmpSkills VALUES('����', 'Oracle');
COMMIT;

-- ѡȡ����������3������ļ�����Ա��
SELECT DISTINCT emp
FROM EmpSkills ES1
WHERE NOT EXISTS
(SELECT skill
FROM Skills
EXCEPT
SELECT skill
FROM EmpSkills ES2
WHERE EP1.emp = ES2.emp);

#### ��ϰ��
7.1	 ��˵������ SELECT ���Ľ����
-- ʹ�ñ����е�Product��
SELECT *
FROM Product
UNION
SELECT *
FROM Product
INTERSECT
SELECT *
FROM Product
ORDER BY product_id;

�Ὣ Product ���е� 8 �м�¼ԭ�ⲻ����ѡȡ������

7.2	 7-2 �ڵĴ����嵥 7-11 ���оٵ�������Ľ���У���ѹ����Բ��� 2 �� ��¼���̵��ţ� shop_id�����̵����ƣ� shop_name������ NULL��
��ʹ���ַ�������ȷ�����滻���е� NULL���������������ʾ��
ִ�н��
shop_id | shop_name | product_id | product_name| sale_price
--|--|--|--|--
000A | ���� | 0002 | ����� | 500
000A | ���� | 0003 | �˶�T�� | 4000
000A | ���� | 0001 | T���� | 1000
000B | ������ | 0006 | ���� | 500
000B | ������ | 0002 | ����� | 500
000B | ������ | 0003 | �˶�T�� | 4000
000B | ������ | 0004 | �˵� | 3000
000B | ������ | 0007 | ���˰� | 880
000C | ���� | 0006 | ���� | 500
000C | ���� | 0007 | ���˰� | 880
000C | ���� | 0003 | �˶�T�� | 4000
000C | ���� | 0004 | �˵� | 3000
000D | ���� | 0001 | T���� | 1000
��ȷ�� | ��ȷ�� | 0005 | ��ѹ�� | 6800
��ȷ�� | ��ȷ�� | 0008 | Բ��� | 100

���̵��ź��̵��������Ϊ"��ȷ��"

SELECT COALESCE(s.shop_id, '��ȷ��') as shop_id, 
COALESCE(s.shop_name, '��ȷ��') as shop_name, 
p.product_id, p.product_name, p.sale_price
FROM ShopProduct s RIGHT OUTER JOIN Product p 
ON s.product_id = p.product_id;

