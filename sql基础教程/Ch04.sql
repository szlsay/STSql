### 4-1�����ݵĲ��루INSERT����ʹ�÷�����

#### ʲô��INSERT
-- ����ProductIns���CREATE TABLE���
CREATE TABLE ProductIns
(product_id CHAR(4) NOT NULL,
product_name VARCHAR(100) NOT NULL,
product_type VARCHAR(32) NOT NULL,
sale_price INTEGER DEFAULT 0,
purchase_price INTEGER ,
regist_date DATE ,
PRIMARY KEY (product_id))
DEFAULT CHARSET=utf8;

#### INSERT���Ļ����﷨
-- ����в���һ������
INSERT INTO ProductIns (product_id, product_name, product_type, sale_price, purchase_price, regist_date) VALUES ('0001', 'T����', '�·�', 1000, 500, '2009-09-20');

#### ���嵥��ʡ��
ʡ�����嵥
-- �������嵥
INSERT INTO ProductIns (product_id, product_name, product_type, sale_price, purchase_price, regist_date) VALUES ('0005', '��ѹ��', '�����þ�', 6800, 5000, '2009-01-15');
-- ʡ�����嵥
INSERT INTO ProductIns VALUES ('0005', '��ѹ��', '�����þ�', 6800, 5000, '2009-01-15');

#### ����NULL
-- ��purchase_price���в���NULL
INSERT INTO ProductIns (product_id, product_name, product_type, sale_price, purchase_price, regist_date) VALUES ('0006', '����', '�����þ�', 500, NULL, '2009-09-20');

#### ����Ĭ��ֵ
-- ͨ����ʽ�����趨Ĭ��ֵ
INSERT INTO ProductIns (product_id, product_name, product_type, sale_price, purchase_price, regist_date) VALUES ('0007', '���˰�', '�����þ�', DEFAULT, 790, '2009-04-28');

-- ͨ����ʽ�����趨Ĭ��ֵ
INSERT INTO ProductIns (product_id, product_name, product_type, purchase_price, regist_date) VALUES ('0007', '���˰�', '�����þ�', 790, '2009-04-28');

δ�趨Ĭ��ֵ�����
-- ʡ��purchase_price�У���Լ�������ḳ�衰NULL��
INSERT INTO ProductIns (product_id, product_name, product_type, sale_price, regist_date) VALUES ('0008', 'Բ���', '�칫��Ʒ', 100, '2009-11-11');
-- ʡ��product_name�У�������NOT NULLԼ����������
INSERT INTO ProductIns (product_id, product_type, sale_price, purchase_price, regist_date) VALUES ('0009', '�칫��Ʒ', 1000, 500, '2009-12-12');


#### ���������и�������

-- �����������ݵ���Ʒ���Ʊ�
CREATE TABLE ProductCopy
(product_id CHAR(4) NOT NULL,
product_name VARCHAR(100) NOT NULL,
product_type VARCHAR(32) NOT NULL,
sale_price INTEGER ,
purchase_price INTEGER ,
regist_date DATE ,
PRIMARY KEY (product_id))
DEFAULT CHARSET=utf8;

INSERT ... SELECT���
-- ����Ʒ���е����ݸ��Ƶ���Ʒ���Ʊ���
INSERT INTO ProductCopy (product_id, product_name, product_type, sale_price, purchase_price, regist_date)
SELECT product_id, product_name, product_type, sale_price, purchase_price, regist_date
FROM Product;

����ProductType���CREATE TABLE���
-- ������Ʒ������л��ܵı� ��
CREATE TABLE ProductType
(product_type VARCHAR(32) NOT NULL,
sum_sale_price INTEGER ,
sum_purchase_price INTEGER ,
PRIMARY KEY (product_type))
DEFAULT CHARSET=utf8;

-- ���������������ݺϼ�ֵ��INSERT ... SELECT���
INSERT INTO ProductType (product_type, sum_sale_price, sum_purchase_price)
SELECT product_type, SUM(sale_price), SUM(purchase_price)
FROM Product
GROUP BY product_type;

### 4-2�����ݵ�ɾ����DELETE����ʹ�÷�����

#### DROP-TABLE����DELETE���

#### DELETE���Ļ����﷨

#### ָ��ɾ�������DELETE��䣨������DELETE��
-- ɾ�����۵��ۣ� sale_price�����ڵ���4000��Ԫ������
DELETE FROM Product
WHERE sale_price >= 4000;

### 4-3�����ݵĸ��£�UPDATE����ʹ�÷�����

#### UPDATE���Ļ����﷨
-- ���Ǽ�����ȫ������Ϊ��2009-10-10��
UPDATE Product
SET regist_date = '2009-10-10';
#### ָ��������UPDATE��䣨������UPDATE��
-- ����Ʒ����Ϊ�����þߵļ�¼�����۵��۸���Ϊԭ����10��
UPDATE Product
SET sale_price = sale_price * 10
WHERE product_type = '�����þ�';

#### ʹ��NULL���и���
-- ����Ʒ���Ϊ0008�����ݣ�Բ��ʣ��ĵǼ����ڸ���ΪNULL
UPDATE Product
SET regist_date = NULL
WHERE product_id = '0008';

#### ���и���
�ܹ���ȷִ�еķ�����UPDATE���
-- һ��UPDATE���ֻ����һ��
UPDATE Product
SET sale_price = sale_price * 10
WHERE product_type = '�����þ�';
UPDATE Product
SET purchase_price = purchase_price / 2
WHERE product_type = '�����þ�';

�����٣������嵥4-19���������嵥4-18�Ĵ���ϲ�Ϊһ��UPDATE���
-- ʹ�ö��Ŷ��н��зָ�����
UPDATE Product
SET sale_price = sale_price * 10,
purchase_price = purchase_price / 2
WHERE product_type = '�����þ�';

�����ڣ������嵥4-20���������嵥4-18�Ĵ���ϲ�Ϊһ��UPDATE��� ��mysql��֧�֣�
-- ������()���������嵥��ʽ
UPDATE Product
SET (sale_price, purchase_price) = (sale_price * 10, purchase_price / 2)
WHERE product_type = '�����þ�';

### 4-4������

#### ʲô������

#### ��������
START TRANSACTION;
-- ���˶�T�������۵��۽���1000��Ԫ
UPDATE Product
SET sale_price = sale_price - 1000
WHERE product_name = '�˶�T��';
-- ��T���������۵����ϸ�1000��Ԫ
UPDATE Product
SET sale_price = sale_price + 1000
WHERE product_name = 'T����';
COMMIT;

����ع�������
START TRANSACTION;
-- ���˶�T�������۵��۽���1000��Ԫ
UPDATE Product
SET sale_price = sale_price - 1000
WHERE product_name = '�˶�T��';
-- ��T���������۵����ϸ�1000��Ԫ
UPDATE Product
SET sale_price = sale_price + 1000
WHERE product_name = 'T����';
ROLLBACK;
#### ACID����

#### ��ϰ��
4.1	 A �������Լ��ļ���������ԣ��ϣ�ʹ�� CREATE TABLE ��䴴������һ�ſյ� Product����Ʒ������ִ�������µ� SQL ��������в������ݡ�
START TRANSACTION;
INSERT INTO Product VALUES ('0001', 'T����', '�·�', 1000, 500, '2008-09-20');
INSERT INTO Product VALUES ('0002', '�����', '�칫��Ʒ', 500, 320, '2008-09-11');
INSERT INTO Product VALUES ('0003', '�˶�T��', '�·�', 4000, 2800, NULL);

�����ţ�B ����ʹ�������ļ���������ϸ����ݿ⣬ִ�������� SELECT ��䡣��ʱ B �����ܵõ������Ĳ�ѯ����أ�
SELECT * FROM Product;
��ʾ���������ʹ��DELETE��䣬�Ϳ��Զ�ͨ��CREATE TABLE��䴴�����Ŀձ�ִ�иò����ˡ�

û��һ�����ݣ�����û���ύ

CREATE TABLE Product
(product_id      CHAR(4)      NOT NULL,
 product_name    VARCHAR(100) NOT NULL,
 product_type    VARCHAR(32)  NOT NULL,
 sale_price      INTEGER ,
 purchase_price  INTEGER ,
 regist_date     DATE ,
 PRIMARY KEY (product_id)) DEFAULT CHARSET=utf8;
 
DELETE FROM Product;
INSERT INTO Product VALUES ('0001', 'T����', '�·�', 1000, 500, '2008-09-20');
INSERT INTO Product VALUES ('0002', '�����', '�칫��Ʒ', 500, 320, '2008-09-11');
INSERT INTO Product VALUES ('0003', '�˶�T��', '�·�', 4000, 2800, NULL);

SELECT * FROM Product;

4.2	 ��һ�Ű��� 3 ����¼�� Product ��
ʹ�����µ� INSERT ��临���� 3 �����ݣ�Ӧ�þ��ܹ������е���������Ϊ 6 �С���˵��������ִ�н����

INSERT INTO Product SELECT * FROM Product;

Duplicate entry '0001' for key 'PRIMARY'

4.3	 ����ϰ 4.2 �е� Product ��Ϊ�������ٴ�������һ�Ű��������е��±�ProductMargin����Ʒ���󣩡�
-- ��Ʒ�����
CREATE TABLE ProductMargin
(product_id CHAR(4) NOT NULL,
product_name VARCHAR(100) NOT NULL,
sale_price INTEGER,
purchase_price INTEGER,
margin INTEGER,
PRIMARY KEY(product_id));

��д�����������в����������ݵ� SQL ��䣬���е�������Լ򵥵�ͨ���� Product ���е����ݽ��м��㣨���۵��� - �������ۣ��ó���
product_id product_name sale_price purchase_price margin
0001 T���� 1000 500 500
0002 ����� 500 320 180
0003 �˶�T�� 4000 2800 1200

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


4.4	 ����ϰ 4.3 �е� ProductMargin ������ݽ������¸��ġ�
1. ���˶� T �������۵��۴� 4000 ��Ԫ�µ��� 3000 ��Ԫ��
2. ������������ٴμ����˶� T ��������
���ĺ��ProductMargin��������ʾ����д���ܹ�ʵ�ָñ����SQL���

UPDATE ProductMargin
SET sale_price = 3000
WHERE product_name = '�˶�T��';

UPDATE ProductMargin
SET margin = sale_price - purchase_price
WHERE product_name = '�˶�T��';