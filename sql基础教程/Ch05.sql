### 5-1����ͼ

#### ��ͼ�ͱ�
-- ͨ����ͼ��SELECT��䱣������
SELECT product_type, SUM(sale_price), SUM(purchase_price)
FROM Product
GROUP BY product_type;

#### ������ͼ�ķ���

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
WHERE product_type = '�칫��Ʒ';

SELECT product_type, cnt_product 
FROM ProductSumJim;

#### ��ͼ�����Ƣ�-����������ͼʱ����ʹ��ORDER-BY�Ӿ�
-- ����������������ͼ
CREATE VIEW ProductSumNew (product_type, cnt_product)
AS
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type
ORDER BY product_type;


SELECT * FROM ProductSumNew;
#### ��ͼ�����Ƣ�-��������ͼ���и���
-- �� ProductSum ��ͼִ������ INSERT ���
INSERT INTO ProductSumNew VALUES ('������Ʒ', 5);

-- ���Ը��µ���ͼ
CREATE VIEW ProductJim (product_id, product_name, product_type, sale_price, purchase_price, regist_date)
AS
SELECT *
FROM Product
WHERE product_type = '�칫��Ʒ';

-- ����ͼ�����������
INSERT INTO ProductJim VALUES ('0009', 'ӡ��', '�칫��Ʒ', 95, 10, '2009-11-30');

SELECT * FROM ProductJim;
SELECT * FROM Product;

#### ɾ����ͼ
-- ɾ����ͼ
DROP VIEW ProductSum;
### 5-2���Ӳ�ѯ

#### �Ӳ�ѯ����ͼ
��ͼProductSum��ȷ���õ�SELECT���
-- ������Ʒ����ͳ����Ʒ��������ͼ
CREATE VIEW ProductSum (product_type, cnt_product)
AS
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type;

-- ȷ�ϴ����õ���ͼ
SELECT product_type, cnt_product
FROM ProductSum;

-- ��FROM�Ӿ���ֱ����д������ͼ��SELECT���
SELECT product_type, cnt_product
FROM ( SELECT product_type, COUNT(*) AS cnt_product
FROM Product
GROUP BY product_type ) AS ProductSum;

SELECT����ִ��˳��
�� ����ִ�� FROM �Ӿ��е� SELECT ��䣨�Ӳ�ѯ��
SELECT product_type, COUNT(*) AS cnt_product
FROM Product
GROUP BY product_type;
�� ���ݢٵĽ��ִ������ SELECT ���
SELECT product_type, cnt_product
FROM ProductSum;

���������Ӳ�ѯ��Ƕ�ײ���
SELECT product_type, cnt_product
FROM (SELECT *
FROM (SELECT product_type, COUNT(*) AS cnt_product
FROM Product
GROUP BY product_type) AS ProductSum 
WHERE cnt_product = 4) AS ProductSum2;

#### �Ӳ�ѯ������

#### �����Ӳ�ѯ
-- ��WHERE�Ӿ��в���ʹ�þۺϺ���
SELECT product_id, product_name, sale_price
FROM Product
WHERE sale_price > AVG(sale_price);

-- ѡȡ�����۵��ۣ� sale_price������ȫ����Ʒ��ƽ�����۵���Ʒ
SELECT product_id, product_name, sale_price
FROM Product
WHERE sale_price > (SELECT AVG(sale_price)
FROM Product);

#### �����Ӳ�ѯ����дλ��
-- ��SELECT�Ӿ���ʹ�ñ����Ӳ�ѯ
SELECT product_id,
product_name,
sale_price,
(SELECT AVG(sale_price)
FROM Product) AS avg_price
FROM Product;

-- ��HAVING�Ӿ���ʹ�ñ����Ӳ�ѯ
SELECT product_type, AVG(sale_price)
FROM Product
GROUP BY product_type
HAVING AVG(sale_price) > 
(SELECT AVG(sale_price) FROM Product);

#### ʹ�ñ����Ӳ�ѯʱ��ע������
-- ���ڲ��Ǳ����Ӳ�ѯ����˲�����SELECT�Ӿ���ʹ��
SELECT product_id,
product_name,
sale_price,
(SELECT AVG(sale_price)
FROM Product
GROUP BY product_type) AS avg_price
FROM Product;

### 5-3�������Ӳ�ѯ

#### ��ͨ���Ӳ�ѯ�͹����Ӳ�ѯ������
-- ������Ʒ�������ƽ���۸�
SELECT AVG(sale_price)
FROM Product
GROUP BY product_type;

-- ͨ�������Ӳ�ѯ������Ʒ�����ƽ�����۵��۽��бȽ�
SELECT product_type, product_name, sale_price
FROM Product AS P1 
WHERE sale_price > (SELECT AVG(sale_price) FROM Product AS P2 WHERE P1.product_type = P2.product_type GROUP BY product_type);

#### �����Ӳ�ѯҲ�������Լ��Ͻ����зֵ�

#### �������һ��Ҫд���Ӳ�ѯ��
-- ����Ĺ����Ӳ�ѯ��д����
SELECT product_type, product_name, sale_price
FROM Product AS P1
WHERE P1.product_type = P2.product_type
AND sale_price > (SELECT AVG(sale_price)
FROM Product AS P2
GROUP BY product_type);

�Ӳ�ѯ�ڵĹ������Ƶ���Ч��Χ
SELECT product_type, product_name, sale_price
FROM Product AS P1
WHERE sale_price>(SELECT AVG(sale_price)
FROM Product AS P2
WHERE P1.product_type=P2.product_type
GROUP BY product_type);

#### ��ϰ��

5.1	 ��������������������������ͼ����ͼ����Ϊ ViewPractice5_1����ʹ�� Product����Ʒ������Ϊ���ձ�������а�����ʼ״̬�� 8 �����ݡ�
���� 1�� ���۵��۴��ڵ��� 1000 ��Ԫ��
���� 2�� �Ǽ������� 2009 �� 9 �� 20 �ա�
���� 3�� ������Ʒ���ơ����۵��ۺ͵Ǽ��������С�
�Ը���ͼִ�� SELECT ���Ľ��������ʾ��
SELECT * FROM ViewPractice5_1;

CREATE VIEW ViewPractice5_1 (product_name, sale_price,regist_date)
AS
SELECT product_name, sale_price, regist_date
FROM Product
WHERE sale_price >= 1000
AND regist_date = '2009-09-20';

SELECT * FROM ViewPractice5_1;

5.2	 ��ϰ�� 5.1 �д�������ͼ ViewPractice5_1 �в����������ݣ���õ�ʲô���Ľ���أ�
INSERT INTO ViewPractice5_1 VALUES ('����', 300, '2009-11-02');

�ᷢ������

���:����ͼ�ĸ��¹������Ƕ���ͼ����Ӧ�ı���и��¡���ˣ��� INSERT ���ʵ���Ϻ������ INSERT �����ͬ��
INSERT INTO Product (product_id, product_name, product_type, sale_price, purchase_price, regist_date)
VALUES (NULL, '����', NULL, 300, NULL, '2009-11-02');

5.3	 ��������½����д SELECT ��䣬���� sale_price_all ��Ϊȫ����Ʒ��ƽ�����۵��ۡ�

product_id | product_name | product_type | sale_price | sale_price_all
------------+-------------+--------------+------------+----------------------
0001 | T���� | �·� | 1000 | 2097.5000000000000000
0002 | ����� | �칫��Ʒ | 500 | 2097.5000000000000000
0003 | �˶�T�� | �·� | 4000 | 2097.5000000000000000
0004 | �˵� | �����þ� | 3000 | 2097.5000000000000000
0005 | ��ѹ�� | �����þ� | 6800 | 2097.5000000000000000
0006 | ���� | �����þ� | 500 | 2097.5000000000000000
0007 | ���˰� | �����þ� | 880 | 2097.5000000000000000
0008 | Բ��� | �칫��Ʒ | 100 | 2097.5000000000000000

SELECT product_id, product_name, product_type, sale_price,
(SELECT AVG(sale_price) FROM Product) as sale_price_all
FROM Product;

5.4	 �����ϰ�� 5.1 �е�������дһ�� SQL ��䣬����һ�������������ݵ���ͼ������Ϊ AvgPriceByType����
ִ�н��
product_id | product_name | product_type | sale_price | avg_sale_price
------------+-------------+--------------+------------+----------------------
0001 |T���� | �·� | 1000 | 2500.0000000000000000
0002 |����� | �칫��Ʒ | 500 | 300.0000000000000000
0003 |�˶�T�� | �·� | 4000 | 2500.0000000000000000
0004 |�˵� | �����þ� | 3000 | 2795.0000000000000000
0005 |��ѹ�� | �����þ� | 6800 | 2795.0000000000000000
0006 |���� | �����þ� | 500 | 2795.0000000000000000
0007 |���˰� | �����þ� | 880 | 2795.0000000000000000
0008 |Բ��� | �칫��Ʒ | 100 | 300.0000000000000000
��ʾ�����еĹؼ���avg_sale_price�С���ϰ��5.3��ͬ��������Ҫ��������Ǹ���Ʒ�����ƽ�����۵��ۡ�����5-3����ʹ�ù����Ӳ�ѯ���õ��Ľ����ͬ��
Ҳ����˵�����п���ʹ�ù����Ӳ�ѯ���д������������Ӧ����ʲô�ط�ʹ����������Ӳ�ѯ


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

