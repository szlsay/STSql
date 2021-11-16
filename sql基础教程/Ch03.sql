-- 3-1���Ա���оۺϲ�ѯ
-- �ۺϺ���

-- ����������ݵ�����
-- ����ȫ�����ݵ�����
SELECT COUNT(*)
FROM Product;

-- ����NULL֮������ݵ�����
-- ����NULL֮�����������
SELECT COUNT(purchase_price)
FROM Product;

-- ��? ����NULL������Ϊ����ʱ�� COUNT�� *�� ��COUNT��<����>���Ľ��������ͬ
SELECT COUNT(*), COUNT(purchase_price)
FROM Product;

-- ����ϼ�ֵ
-- �������۵��۵ĺϼ�ֵ
SELECT SUM(sale_price)
FROM Product;

-- �������۵��ۺͽ������۵ĺϼ�ֵ
SELECT SUM(sale_price), SUM(purchase_price)
FROM Product;

-- ����ƽ��ֵ
-- �������۵��۵�ƽ��ֵ
SELECT AVG(sale_price)
FROM Product;

-- �������۵��ۺͽ������۵�ƽ��ֵ
SELECT AVG(sale_price), AVG(purchase_price)
FROM Product;

-- ����ֵ��Сֵ
-- �������۵��۵����ֵ�ͽ������۵���Сֵ
SELECT MAX(sale_price), MIN(purchase_price)
FROM Product;

-- ����Ǽ����ڵ����ֵ����Сֵ
SELECT MAX(regist_date), MIN(regist_date)
FROM Product;

-- ʹ�þۺϺ���ɾ���ظ�ֵ���ؼ���DISTINCT��
-- ����ȥ���ظ����ݺ����������
SELECT COUNT(DISTINCT product_type)
FROM Product;

-- �ȼ�������������ɾ���ظ����ݵĽ��
SELECT DISTINCT COUNT(product_type)
FROM Product;

-- ʹ��ʹ��DISTINCTʱ�Ķ������죨 SUM������
SELECT SUM(sale_price), SUM(DISTINCT sale_price)
FROM Product;

-- 3-2���Ա���з���

-- GROUP-BY�Ӿ�
-- ������Ʒ����ͳ����������
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type;

-- �ۺϼ��а���NULL�����
-- ���ս�������ͳ����������
SELECT purchase_price, COUNT(*)
FROM Product
GROUP BY purchase_price;

-- ʹ��WHERE�Ӿ�ʱGROUP-BY��ִ�н��
-- ͬʱʹ��WHERE�Ӿ��GROUP BY�Ӿ�
SELECT purchase_price, COUNT(*)
FROM Product
WHERE product_type = '�·�'
GROUP BY purchase_price;

-- ��ۺϺ�����GROUP-BY�Ӿ��йصĳ�������
-- ��SELECT�Ӿ�����д�ۺϼ�֮��������ᷢ������
SELECT product_name, purchase_price, COUNT(*)
FROM Product
GROUP BY purchase_price;

#1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'shop.Product.product_name' 
which is not functionally dependent on columns in GROUP BY clause

-- GROUP BY�Ӿ���ʹ���еı�������������
SELECT product_type AS pt, COUNT(*)
FROM Product
GROUP BY pt;

-- ������Ʒ����ͳ����������
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type;

-- ��WHERE�Ӿ���ʹ�þۺϺ�������������
SELECT product_type, COUNT(*)
FROM Product
WHERE COUNT(*) = 2
GROUP BY product_type;
-- ERROR: ������WHERE�Ӿ���ʹ�þۺ�

-- DISTINCT��GROUP BY�ܹ�ʵ����ͬ�Ĺ���
SELECT DISTINCT product_type
FROM Product;

SELECT product_type
FROM Product
GROUP BY product_type;

-- 3-3��Ϊ�ۺϽ��ָ������
-- HAVING�Ӿ�
-- �Ӱ�����Ʒ������з����Ľ���У�ȡ������������������Ϊ2�С�����
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type
HAVING COUNT(*) = 2;

-- ��ʹ��HAVING�Ӿ�����
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type;

-- HAVING�Ӿ�Ĺ���Ҫ��
-- HAVING�Ӿ�Ĳ���ȷʹ�÷���
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type
HAVING product_name = 'Բ���';

-- �����HAVING�Ӿ䣬���ʺ�д��WHERE�Ӿ��е�����
-- ��������д��HAVING�Ӿ��е����
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type
HAVING product_type = '�·�';

-- ��������д��WHERE�Ӿ��е����
SELECT product_type, COUNT(*)
FROM Product
WHERE product_type = '�·�'
GROUP BY product_type;

-- 3-4���Բ�ѯ�����������
-- ORDER-BY�Ӿ�
-- ��ʾ��Ʒ��š���Ʒ���ơ����۵��ۺͽ������۵�SELECT���
SELECT product_id, product_name, sale_price, purchase_price FROM Product;

-- �������۵����ɵ͵��ߣ����򣩽�������
SELECT product_id, product_name, sale_price, purchase_price
FROM Product
ORDER BY sale_price;

-- ָ���������
-- �������۵����ɸߵ��ͣ����򣩽�������
SELECT product_id, product_name, sale_price, purchase_price
FROM Product
ORDER BY sale_price DESC;

-- ָ����������
-- �������۵��ۺ���Ʒ��ŵ������������
SELECT product_id, product_name, sale_price, purchase_price
FROM Product
ORDER BY sale_price, product_id;
-- NULL��˳��
-- ���ս������۵������������
SELECT product_id, product_name, sale_price, purchase_price
FROM Product
ORDER BY purchase_price;

-- ���������ʹ����ʾ�õı���
-- ORDER BY�Ӿ��п���ʹ���еı���
SELECT product_id AS id, product_name, sale_price AS sp, purchase_price
FROM Product
ORDER BY sp, id;

-- ORDER-BY�Ӿ��п���ʹ�õ���
-- SELECT�Ӿ���δ��������Ҳ������ORDER BY�Ӿ���ʹ��
SELECT product_name, sale_price, purchase_price
FROM Product
ORDER BY product_id;

-- ORDER BY�Ӿ���Ҳ����ʹ�þۺϺ���
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type
ORDER BY COUNT(*);

-- ��Ҫʹ���б��
ORDER BY�Ӿ��п���ʹ���еı��
-- ͨ������ָ��
SELECT product_id, product_name, sale_price, purchase_price
FROM Product
ORDER BY sale_price DESC, product_id;
-- ͨ���б��ָ��
SELECT product_id, product_name, sale_price, purchase_price
FROM Product
ORDER BY 3 DESC, 1;
