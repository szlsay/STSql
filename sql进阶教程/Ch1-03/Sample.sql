-- 1. 约翰年龄是NULL（未知的NULL)
SELECT *
FROM Students
WHERE age = NULL
OR age <> NULL;

/* 查询年龄是20岁或者不是20岁的学生 */
SELECT *
  FROM Students
 WHERE age = 20
    OR age <> 20;
/* 添加第3个条件：年龄是20岁，或者不是20岁，或者年龄未知 */
SELECT *
  FROM Students
 WHERE age = 20
    OR age <> 20
    OR age IS NULL;
		
-- 查询与B 班住在东京的学生年龄不同的A 班学生的SQL语句？
SELECT *
FROM Class_A
WHERE age NOT IN ( SELECT age
FROM Class_B
WHERE city = '东京' );

-- 查询与B 班住在东京的学生年龄不同的A 班学生的SQL 语句？
SELECT *
FROM Class_A
WHERE age NOT IN ( SELECT age
FROM Class_B
WHERE city = '东京' );

-- 1. 执行子查询， 获取年龄列表
SELECT *
FROM Class_A
WHERE age NOT IN (22, 23, NULL);

-- 2. 用NOT 和IN 等价改写NOT IN
SELECT *
FROM Class_A
WHERE NOT age IN (22, 23, NULL);

-- 3. 用OR 等价改写谓词IN
SELECT *
FROM Class_A
WHERE NOT ( (age = 22) OR (age = 23) OR (age = NULL) );

-- 4. 使用德· 摩根定律等价改写
SELECT *
FROM Class_A
WHERE NOT (age = 22) AND NOT(age = 23) AND NOT (age = NULL);

-- 5. 用<> 等价改写 NOT 和 =
SELECT *
FROM Class_A
WHERE (age <> 22) AND (age <> 23) AND (age <> NULL);

-- 6. 对NULL 使用<> 后， 结果为unknown
SELECT *
FROM Class_A
WHERE (age <> 22) AND (age <> 23) AND unknown;

-- 7． 如果AND 运算里包含unknown， 则结果不为true（参考“理论篇”中的矩阵）
SELECT *
FROM Class_A
WHERE false OR unknown;

-- 正确的SQL 语句： 拉里和伯杰将被查询到
SELECT *
FROM Class_A A
WHERE NOT EXISTS ( SELECT *
FROM Class_B B
WHERE A.age = B.age
AND B.city = '东京' );

-- 1. 在子查询里和NULL 进行比较运算
SELECT *
FROM Class_A A
WHERE NOT EXISTS ( SELECT *
FROM Class_B B
WHERE A.age = NULL
AND B.city = '东京' );

-- 2. 对NULL 使用“=”后， 结果为 unknown
SELECT *
FROM Class_A A
WHERE NOT EXISTS ( SELECT *
FROM Class_B B
WHERE unknown
AND B.city = '东京' );

-- 4. 子查询没有返回结果， 因此相反地， NOT EXISTS 为true
SELECT *
FROM Class_A A
WHERE true;

/* 查询比B班住在东京的所有学生年龄都小的A班学生 */
SELECT * 
FROM Class_A
WHERE age < ALL (SELECT age FROM Class_B WHERE city = "东京");

-- 查询比B 班住在东京的年龄最小的学生还要小的A 班学生
SELECT * 
FROM Class_A
WHERE age < (SELECT MIN(age) FROM Class_B WHERE city="东京");

/* 查询比住在东京的学生的平均年龄还要小的A班学生的SQL语句？ */
SELECT * 
FROM Class_A
WHERE age < (SELECT AVG(age) FROM Class_B WHERE city="东京");
