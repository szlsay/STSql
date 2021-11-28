/* 用HAVING子句进行子查询：求众数(求中位数时也用本代码) */
CREATE TABLE Graduates(
name   VARCHAR(16) PRIMARY KEY,
income INTEGER NOT NULL)
DEFAULT CHARSET=utf8;

INSERT INTO Graduates VALUES('桑普森', 400000);
INSERT INTO Graduates VALUES('迈克',     30000);
INSERT INTO Graduates VALUES('怀特',   20000);
INSERT INTO Graduates VALUES('阿诺德', 20000);
INSERT INTO Graduates VALUES('史密斯',     20000);
INSERT INTO Graduates VALUES('劳伦斯',   15000);
INSERT INTO Graduates VALUES('哈德逊',   15000);
INSERT INTO Graduates VALUES('肯特',     10000);
INSERT INTO Graduates VALUES('贝克',   10000);
INSERT INTO Graduates VALUES('斯科特',   10000);

/* 用关系除法运算进行购物篮分析 */
CREATE TABLE Items(
item VARCHAR(16) PRIMARY KEY)
DEFAULT CHARSET=utf8;
 
CREATE TABLE ShopItems(
shop VARCHAR(16),
item VARCHAR(16),
PRIMARY KEY(shop, item))
DEFAULT CHARSET=utf8;

INSERT INTO Items VALUES('啤酒');
INSERT INTO Items VALUES('纸尿裤');
INSERT INTO Items VALUES('自行车');

INSERT INTO ShopItems VALUES('仙台',  '啤酒');
INSERT INTO ShopItems VALUES('仙台',  '纸尿裤');
INSERT INTO ShopItems VALUES('仙台',  '自行车');
INSERT INTO ShopItems VALUES('仙台',  '窗帘');
INSERT INTO ShopItems VALUES('东京',  '啤酒');
INSERT INTO ShopItems VALUES('东京',  '纸尿裤');
INSERT INTO ShopItems VALUES('东京',  '自行车');
INSERT INTO ShopItems VALUES('大阪',  '电视');
INSERT INTO ShopItems VALUES('大阪',  '纸尿裤');
INSERT INTO ShopItems VALUES('大阪',  '自行车');

/* 寻找缺失的编号 */
CREATE TABLE SeqTbl(
seq  INTEGER PRIMARY KEY,
name VARCHAR(16) NOT NULL)
DEFAULT CHARSET=utf8;

INSERT INTO SeqTbl VALUES(1,	'迪克');
INSERT INTO SeqTbl VALUES(2,	'安');
INSERT INTO SeqTbl VALUES(3,	'莱露');
INSERT INTO SeqTbl VALUES(5,	'卡');
INSERT INTO SeqTbl VALUES(6,	'玛丽');
INSERT INTO SeqTbl VALUES(8,	'本');

/* 查询不包含NULL的集合 */
CREATE TABLE Students(
student_id   INTEGER PRIMARY KEY,
dpt          VARCHAR(16) NOT NULL,
sbmt_date    DATE)
DEFAULT CHARSET=utf8;

INSERT INTO Students VALUES(100,  '理学院',   '2005-10-10');
INSERT INTO Students VALUES(101,  '理学院',   '2005-09-22');
INSERT INTO Students VALUES(102,  '文学院',   NULL);
INSERT INTO Students VALUES(103,  '文学院',   '2005-09-10');
INSERT INTO Students VALUES(200,  '文学院',   '2005-09-22');
INSERT INTO Students VALUES(201,  '工学院',   NULL);
INSERT INTO Students VALUES(202,  '经济学院', '2005-09-25');