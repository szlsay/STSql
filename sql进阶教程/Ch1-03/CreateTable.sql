/* 1.比较谓词和NULL（1）：排中律不成立 */
CREATE TABLE Students(
name VARCHAR(16) PRIMARY KEY,
age  INTEGER)
DEFAULT CHARSET=utf8;

INSERT INTO Students VALUES('布朗', 22);
INSERT INTO Students VALUES('拉里',   19);
INSERT INTO Students VALUES('约翰',   NULL);
INSERT INTO Students VALUES('伯杰', 21);

/* 3.NOT IN和NOT EXISTS不是等价的 */
CREATE TABLE Class_A(
name VARCHAR(16) PRIMARY KEY,
age  INTEGER,
city VARCHAR(16) NOT NULL)
DEFAULT CHARSET=utf8;;

CREATE TABLE Class_B(
name VARCHAR(16) PRIMARY KEY,
age  INTEGER,
city VARCHAR(16) NOT NULL)
DEFAULT CHARSET=utf8;;

DELETE FROM Class_A;
INSERT INTO Class_A VALUES('布朗', 22, '东京');
INSERT INTO Class_A VALUES('拉里',   19, '埼玉');
INSERT INTO Class_A VALUES('伯杰',   21, '千叶');

DELETE FROM Class_B;
INSERT INTO Class_B VALUES('齐藤',  22,   '东京');
INSERT INTO Class_B VALUES('田尻',  23,   '东京');
INSERT INTO Class_B VALUES('山田',  NULL, '东京');
INSERT INTO Class_B VALUES('和泉',  18,   '千叶');
INSERT INTO Class_B VALUES('武田',  20,   '千叶');
INSERT INTO Class_B VALUES('石川',  19,   '神奈川');

/* 4.限定谓词和NULL */
DELETE FROM Class_A;
INSERT INTO Class_A VALUES('布朗', 22, '东京');
INSERT INTO Class_A VALUES('拉里',   19, '埼玉');
INSERT INTO Class_A VALUES('伯杰',   21, '千叶');

DELETE FROM Class_B;
INSERT INTO Class_B VALUES('齐藤', 22, '东京');
INSERT INTO Class_B VALUES('田尻', 23, '东京');
INSERT INTO Class_B VALUES('山田', 20, '东京');
INSERT INTO Class_B VALUES('和泉', 18, '千叶');
INSERT INTO Class_B VALUES('武田', 20, '千叶');
INSERT INTO Class_B VALUES('石川', 19, '神奈川');

/* 5.限定谓词和极值函数不是等价的 */
DELETE FROM Class_B;
INSERT INTO Class_B VALUES('和泉', 18, '千叶');
INSERT INTO Class_B VALUES('武田', 20, '千叶');
INSERT INTO Class_B VALUES('石川', 19, '神奈川');