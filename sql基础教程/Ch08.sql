### 8-1�����ں���
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

#### ʲô�Ǵ��ں���

#### ���ں������﷨

#### �﷨�Ļ���ʹ�÷�������ʹ��RANK����
-- ���ݲ�ͬ����Ʒ���࣬�������۵��۴ӵ͵��ߵ�˳�򴴽������
SELECT product_name, product_type, sale_price,
RANK () OVER (PARTITION BY product_type
ORDER BY sale_price) AS ranking
FROM Product;

#### ����ָ��PARTITION-BY
-- ��ָ��PARTITION BY
SELECT product_name, product_type, sale_price,
RANK () OVER (ORDER BY sale_price) AS ranking
FROM Product;

-- �Ƚ�RANK�� DENSE_RANK�� ROW_NUMBER�Ľ��
SELECT product_name, product_type, sale_price,
RANK () OVER (ORDER BY sale_price) AS ranking,
DENSE_RANK () OVER (ORDER BY sale_price) AS dense_ranking,
ROW_NUMBER () OVER (ORDER BY sale_price) AS row_num
FROM Product;

#### ר�ô��ں���������

#### ���ں��������÷�Χ

#### ��Ϊ���ں���ʹ�õľۺϺ���
-- ��SUM������Ϊ���ں���ʹ��
SELECT product_id, product_name, sale_price,
SUM(sale_price) OVER (ORDER BY product_id) AS current_sum
FROM Product;

#### �����ƶ�ƽ��
-- ��AVG������Ϊ���ں���ʹ��
SELECT product_id, product_name, sale_price,
AVG(sale_price) OVER (ORDER BY product_id) AS current_avg
FROM Product;

-- ָ���������3�С���Ϊ���ܶ���
SELECT product_id, product_name, sale_price,
AVG (sale_price) OVER (ORDER BY product_id
ROWS 2 PRECEDING) AS moving_avg
FROM Product;

-- ����ǰ��¼��ǰ������Ϊ���ܶ���
SELECT product_id, product_name, sale_price,
AVG (sale_price) OVER (ORDER BY product_id
ROWS BETWEEN 1 PRECEDING AND
1 FOLLOWING) AS moving_avg
FROM Product;

#### ����ORDER-BY
-- �޷���֤����SELECT���Ľ��������˳��
SELECT product_name, product_type, sale_price,
RANK () OVER (ORDER BY sale_price) AS ranking
FROM Product;

### 8-2��GROUPING�����

#### ͬʱ�õ��ϼ���
-- ʹ��GROUP BY�޷��õ��ϼ���
SELECT product_type, SUM(sale_price)
FROM Product
GROUP BY product_type;

-- �ֱ������ϼ��кͻ��ܽ����ͨ��UNION ALL��������
SELECT '�ϼ�' AS product_type, SUM(sale_price)
FROM Product
UNION ALL
SELECT product_type, SUM(sale_price)
FROM Product
GROUP BY product_type;

#### ROLLUP����ͬʱ�ó��ϼƺ�С��
-- ʹ��ROLLUPͬʱ�ó��ϼƺ�С��
SELECT product_type, SUM(sale_price) AS sum_price
FROM Product
GROUP BY product_type WITH ROLLUP;

-- ��GROUP BY����ӡ��Ǽ����ڡ�����ʹ��ROLLUP��
SELECT product_type, regist_date, SUM(sale_price) AS sum_price
FROM Product
GROUP BY product_type, regist_date;

-- ��GROUP BY����ӡ��Ǽ����ڡ���ʹ��ROLLUP��
SELECT product_type, regist_date, SUM(sale_price) AS sum_price
FROM Product
GROUP BY product_type, regist_date WITH ROLLUP;

#### GROUPING����������NULL�������׷ֱ�
-- ʹ��GROUPING�������ж�NULL
SELECT GROUPING(product_type) AS product_type,
GROUPING(regist_date) AS regist_date, SUM(sale_price) AS sum_price
FROM Product
GROUP BY product_type, regist_date WITH ROLLUP;

-- �ڳ��������¼�ļ�ֵ�в���ǡ�����ַ���
SELECT CASE WHEN GROUPING(product_type) = 1
THEN '��Ʒ���� �ϼ�'
ELSE product_type END AS product_type,
CASE WHEN GROUPING(regist_date) = 1
THEN '�Ǽ����� �ϼ�'
ELSE regist_date END AS regist_date,
SUM(sale_price) AS sum_price
FROM Product
GROUP BY product_type, regist_date WITH ROLLUP;

#### ��ϰ��
8.1	 ��˵����Ա�����ʹ�õ� Product����Ʒ����ִ������ SELECT ������ܵõ��Ľ����

SELECT product_id, product_name, sale_price,
MAX(sale_price) OVER (ORDER BY product_id) AS  current_max_price
FROM Product;

������ SELECT ���ĺ����ǡ�������Ʒ��ţ�product_id���������������
�����������ǰ�е�������۵��ۡ�����ˣ�����ʾ��������۵��۵�ͬʱ�����ں�
���ķ��ؽ��Ҳ��仯��

8.2	 ����ʹ��Product����������յǼ����ڣ� regist_date������������еĸ����ڵ����۵��ۣ� sale_price�����ܶ��������Ҫ���Ǽ�����Ϊ NULL �ġ��˶� T ������¼���ڵ� 1 λ��Ҳ���ǽ��俴�����������ڶ��磩��

�ٺ͢����ַ���������ʵ�֡�
�� regist_date Ϊ NULL ʱ����ʾ��1 �� 1 �� 1 �ա�
SELECT regist_date, product_name, sale_price,
SUM(sale_price) 
OVER (ORDER BY COALESCE(regist_date, CAST('0001-01-01' AS DATE))) 
AS current_sum_price
FROM Product;

�� regist_date Ϊ NULL ʱ�����ü�¼������ǰ��ʾ
SELECT regist_date, product_name, sale_price,
SUM(sale_price) 
OVER (order by IF(ISNULL(regist_date),0,1), regist_date) 
AS current_sum_price
FROM Product;