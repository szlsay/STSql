CREATE TABLE Product
(product_id      CHAR(4)      NOT NULL,
 product_name    VARCHAR(100) NOT NULL,
 product_type    VARCHAR(32)  NOT NULL,
 sale_price      INTEGER ,
 purchase_price  INTEGER ,
 regist_date     DATE ,
 PRIMARY KEY (product_id)) DEFAULT CHARSET=utf8;;

INSERT INTO Product VALUES ('0001', 'T��' ,'�·�', 1000, 500, '2009-09-20');
INSERT INTO Product VALUES ('0002', '�����', '�칫��Ʒ', 500, 320, '2009-09-11');
INSERT INTO Product VALUES ('0003', '�˶�T��', '�·�', 4000, 2800, NULL);
INSERT INTO Product VALUES ('0004', '�˵�', '�����þ�', 3000, 2800, '2009-09-20');
INSERT INTO Product VALUES ('0005', '��ѹ��', '�����þ�', 6800, 5000, '2009-01-15');
INSERT INTO Product VALUES ('0006', '����', '�����þ�', 500, NULL, '2009-09-20');
INSERT INTO Product VALUES ('0007', '���˰�', '�����þ�', 880, 790, '2008-04-28');
INSERT INTO Product VALUES ('0008', 'Բ���', '�칫��Ʒ', 100, NULL, '2009-11-11');

SELECT product_id, product_name, purchase_price FROM Product;

SELECT product_id AS "��Ʒ���",
product_name AS "��Ʒ����",
purchase_price AS '��������'
FROM Product;

SELECT product_type
FROM Product;

SELECT DISTINCT regist_date
FROM Product;

SELECT product_name, product_type
FROM Product
WHERE product_type = '�·�';

-- SQL�����Ҳ����ʹ��������ʽ
SELECT product_name, sale_price,
sale_price * 2 AS "sale_price_x2"
FROM Product;

SELECT (purchase_price / 0) AS purchase_price0 FROM Product;
SELECT (purchase_price / NULL) AS purchase_price0 FROM Product;

SELECT (5 / 0) AS P50, (NULL / 0) AS PNull0 FROM Product;

-- ѡȡ��sale_price��Ϊ500�ļ�¼
SELECT product_name, product_type
FROM Product
WHERE sale_price <> 500;

-- ѡȡ�����۵��۴��ڵ���1000��Ԫ�ļ�¼
SELECT product_name, product_type, sale_price
FROM Product
WHERE sale_price >= 1000;

-- ѡȡ���Ǽ�������2009��9��27��֮ǰ�ļ�¼
SELECT product_name, product_type, regist_date
FROM Product
WHERE regist_date < '2009-09-27';

-- WHERE�Ӿ���������ʽ��Ҳ����ʹ�ü�����ʽ
SELECT product_name, sale_price, purchase_price
FROM Product
WHERE sale_price - purchase_price >= 500;

-- ѡȡ��������Ϊ2800��Ԫ�ļ�¼
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price = 2800;

-- ѡȡ���������۲���2800��Ԫ�ļ�¼
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price <> 2800;

-- ѡȡNULL�ļ�¼
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price IS NULL;

-- ѡȡ��ΪNULL�ļ�¼
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price IS NOT NULL;

-- ѡȡ�����۵��۴��ڵ���1000��Ԫ�ļ�¼
SELECT product_name, product_type, sale_price
FROM Product
WHERE sale_price >= 1000;

-- ��ѯ���������NOT�����
SELECT product_name, product_type, sale_price
FROM Product
WHERE NOT sale_price >= 1000;

-- WHERE�Ӿ�Ĳ�ѯ�����Ͳ�ѯ�����ǵȼ۵�
SELECT product_name, product_type
FROM Product
WHERE sale_price < 1000;

-- ��WHERE�Ӿ�Ĳ�ѯ������ʹ��AND�����
SELECT product_name, purchase_price
FROM Product
WHERE product_type = '�����þ�'
AND sale_price >= 3000;

-- ��WHERE�Ӿ�Ĳ�ѯ������ʹ��OR�����
SELECT product_name, purchase_price
FROM Product
WHERE product_type = '�����þ�'
OR sale_price >= 3000;

-- ����ѯ����ԭ�ⲻ����д���������ʽ
SELECT product_name, product_type, regist_date
FROM Product
WHERE product_type = '�칫��Ʒ'
AND regist_date = '2009-09-11'
OR regist_date = '2009-09-20';

-- ͨ��ʹ��������OR���������AND�����ִ��
SELECT product_name, product_type, regist_date
FROM Product
WHERE product_type = '�칫��Ʒ'
AND ( regist_date = '2009-09-11'
OR regist_date = '2009-09-20');

2.1	 ��дһ�� SQL ��䣬�� Product����Ʒ������ѡȡ�����Ǽ����ڣ� regist_date���� 2009 �� 4 �� 28 ��֮�󡱵���Ʒ����ѯ���Ҫ���� product_name �� regist_date ���С�

SELECT product_name, regist_date FROM Product WHERE regist_date > '2009-04-28';

2.2	 ��˵���� Product ��ִ������ 3 �� SELECT ���ʱ�ķ��ؽ����
�� 
SELECT *
FROM Product
WHERE purchase_price = NULL;

�� 
SELECT *
FROM Product
WHERE purchase_price <> NULL;

�� 
SELECT *
FROM Product
WHERE product_name > NULL;

2.3	 �����嵥 2-22��2-2 �ڣ��е� SELECT ����ܹ��� Product ����ȡ�������۵��ۣ� sale_price���Ƚ������ۣ� purchase_price���߳� 500��Ԫ���ϡ�����Ʒ��
��д���������Եõ���ͬ����� SELECT ��䡣ִ�н��������ʾ��

ִ�н��
product_name | sale_price | purchase_price
---------------+-------------+----------------
T���� | 1000 | 500
�˶�T�� | 4000 | 2800
��ѹ�� | 6800 | 5000

SELECT product_name, sale_price, purchase_price FROM Product WHERE (sale_price - purchase_price) >= 500;
SELECT product_name, sale_price, purchase_price FROM Product WHERE NOT (sale_price - purchase_price) < 500;

2.4	 ��д��һ�� SELECT ��䣬�� Product ����ѡȡ�����㡰���۵��۴����֮��������� 100 ��Ԫ�İ칫��Ʒ�ͳ����þߡ������ļ�¼��
��ѯ���Ҫ���� product_name �С� product_type ���Լ����۵��۴����֮������󣨱����趨Ϊ profit����
��ʾ�����۵��۴���ۣ�����ͨ�� sale_price �е�ֵ���� 0.9 ��ã��������ͨ����ֵ��ȥ purchase_price �е�ֵ��á�

SELECT product_name, product_type, (sale_price * 0.9) AS profit 
FROM Product 
WHERE (sale_price * 0.9 - purchase_price) > 100
AND (product_type = '�칫��Ʒ' OR product_type = '�����þ�');