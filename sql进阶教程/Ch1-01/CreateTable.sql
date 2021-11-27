/* 将已有编号方式转换为新的方式并统计 */
CREATE TABLE PopTbl(
pref_name VARCHAR(32) PRIMARY KEY,
population INTEGER NOT NULL)
DEFAULT CHARSET=utf8;

INSERT INTO PopTbl VALUES('德岛', 100);
INSERT INTO PopTbl VALUES('香川', 200);
INSERT INTO PopTbl VALUES('爱媛', 150);
INSERT INTO PopTbl VALUES('高知', 200);
INSERT INTO PopTbl VALUES('福冈', 300);
INSERT INTO PopTbl VALUES('佐贺', 100);
INSERT INTO PopTbl VALUES('长崎', 200);
INSERT INTO PopTbl VALUES('东京', 400);
INSERT INTO PopTbl VALUES('群马', 50);

/* 用一条SQL语句进行不同条件的统计 */
CREATE TABLE PopTbl2(
pref_name VARCHAR(32),
sex CHAR(1) NOT NULL,
population INTEGER NOT NULL,
PRIMARY KEY(pref_name, sex))
DEFAULT CHARSET=utf8;

INSERT INTO PopTbl2 VALUES('德岛', '1',	60 );
INSERT INTO PopTbl2 VALUES('德岛', '2',	40 );
INSERT INTO PopTbl2 VALUES('香川', '1',	100);
INSERT INTO PopTbl2 VALUES('香川', '2',	100);
INSERT INTO PopTbl2 VALUES('爱媛', '1',	100);
INSERT INTO PopTbl2 VALUES('爱媛', '2',	50 );
INSERT INTO PopTbl2 VALUES('高知', '1',	100);
INSERT INTO PopTbl2 VALUES('高知', '2',	100);
INSERT INTO PopTbl2 VALUES('福冈', '1',	100);
INSERT INTO PopTbl2 VALUES('福冈', '2',	200);
INSERT INTO PopTbl2 VALUES('佐贺', '1',	20 );
INSERT INTO PopTbl2 VALUES('佐贺', '2',	80 );
INSERT INTO PopTbl2 VALUES('长崎', '1',	125);
INSERT INTO PopTbl2 VALUES('长崎', '2',	125);
INSERT INTO PopTbl2 VALUES('东京', '1',	250);
INSERT INTO PopTbl2 VALUES('东京', '2',	150);

/* 员工工资信息表 */
CREATE TABLE Salaries(
name VARCHAR(32) PRIMARY KEY,
salary INTEGER NOT NULL)
DEFAULT CHARSET=utf8;

INSERT INTO Salaries VALUES('相田', 3000);
INSERT INTO Salaries VALUES('神崎', 2700);
INSERT INTO Salaries VALUES('木村', 2200);
INSERT INTO Salaries VALUES('齐藤', 2900);

/* 在UPDATE语句里进行条件分支 */
CREATE TABLE SomeTable(
p_key CHAR(1) PRIMARY KEY,
col_1 INTEGER NOT NULL, 
col_2 CHAR(2) NOT NULL)
DEFAULT CHARSET=utf8;

INSERT INTO SomeTable VALUES('a', 1, '一');
INSERT INTO SomeTable VALUES('b', 2, '二');
INSERT INTO SomeTable VALUES('c', 3, '三');

/* 表之间的数据匹配 */
CREATE TABLE CourseMaster(
course_id   INTEGER PRIMARY KEY,
course_name VARCHAR(32) NOT NULL) 
DEFAULT CHARSET=utf8;

INSERT INTO CourseMaster VALUES(1, '会计入门');
INSERT INTO CourseMaster VALUES(2, '财务知识');
INSERT INTO CourseMaster VALUES(3, '簿记考试');
INSERT INTO CourseMaster VALUES(4, '税务师');

CREATE TABLE OpenCourses(
month       INTEGER ,
course_id   INTEGER ,
PRIMARY KEY(month, course_id))
DEFAULT CHARSET=utf8;

INSERT INTO OpenCourses VALUES(200706, 1);
INSERT INTO OpenCourses VALUES(200706, 3);
INSERT INTO OpenCourses VALUES(200706, 4);
INSERT INTO OpenCourses VALUES(200707, 4);
INSERT INTO OpenCourses VALUES(200708, 2);
INSERT INTO OpenCourses VALUES(200708, 4);

/* 在CASE表达式中使用聚合函数 */
CREATE TABLE StudentClub(
std_id  INTEGER,
club_id INTEGER,
club_name VARCHAR(32),
main_club_flg CHAR(1),
PRIMARY KEY (std_id, club_id))
DEFAULT CHARSET=utf8;

INSERT INTO StudentClub VALUES(100, 1, '棒球', 'Y');
INSERT INTO StudentClub VALUES(100, 2, '管弦乐', 'N');
INSERT INTO StudentClub VALUES(200, 2, '管弦乐', 'N');
INSERT INTO StudentClub VALUES(200, 3, '羽毛球', 'Y');
INSERT INTO StudentClub VALUES(200, 4, '足球', 'N');
INSERT INTO StudentClub VALUES(300, 4, '足球', 'N');
INSERT INTO StudentClub VALUES(400, 5, '游泳', 'N');
INSERT INTO StudentClub VALUES(500, 6, '围棋', 'N');

/* 用CHECK约束定义多个列的条件关系 */
CREATE TABLE TestSal(
sex CHAR(1) ,
salary INTEGER,
CONSTRAINT check_salary CHECK ( 
	CASE WHEN sex = '2' THEN 
	CASE WHEN salary <= 200000  THEN 1 
	ELSE 0 END
	ELSE 1 END = 1 ))
DEFAULT CHARSET=utf8;

INSERT INTO TestSal VALUES(1, 200000);
INSERT INTO TestSal VALUES(1, 300000);
INSERT INTO TestSal VALUES(1, NULL);
INSERT INTO TestSal VALUES(2, 200000);
INSERT INTO TestSal VALUES(2, 300000);
INSERT INTO TestSal VALUES(2, NULL);
INSERT INTO TestSal VALUES(1, 300000);

