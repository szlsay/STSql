CREATE TABLE Products(
name VARCHAR(16) PRIMARY KEY,
price INTEGER NOT NULL)
DEFAULT CHARSET=utf8;

-- 可重排列·排列·组合
DELETE FROM Products;
INSERT INTO Products VALUES('苹果',	50);
INSERT INTO Products VALUES('橘子',	100);
INSERT INTO Products VALUES('香蕉',	80);

-- 排序
DELETE FROM Products;
INSERT INTO Products VALUES('苹果',	50);
INSERT INTO Products VALUES('橘子',	100);
INSERT INTO Products VALUES('葡萄',	50);
INSERT INTO Products VALUES('西瓜',	80);
INSERT INTO Products VALUES('柠檬',	30);
INSERT INTO Products VALUES('香蕉',	50);

-- 不聚合，查看集合的包含关系
DELETE FROM Products;
INSERT INTO Products VALUES('橘子',	100);
INSERT INTO Products VALUES('葡萄',	50);
INSERT INTO Products VALUES('西瓜',	80);
INSERT INTO Products VALUES('柠檬',	30);

-- 查找局部不一致的列
CREATE TABLE Addresses(
name VARCHAR(32),
 family_id INTEGER,
 address VARCHAR(32),
 PRIMARY KEY(name, family_id))
 DEFAULT CHARSET=utf8;

INSERT INTO Addresses VALUES('前田义明', '100', '东京都港区虎之门3-2-29');
INSERT INTO Addresses VALUES('前田由美', '100', '东京都港区虎之门3-2-92');
INSERT INTO Addresses VALUES('加藤茶',   '200', '东京都新宿区西新宿2-8-1');
INSERT INTO Addresses VALUES('加藤胜',   '200', '东京都新宿区西新宿2-8-1');
INSERT INTO Addresses VALUES('福尔摩斯',  '300', '贝克街221B');
INSERT INTO Addresses VALUES('华生',  '400', '贝克街221B');