/* 把县编号转换成地区编号（1） */
SELECT CASE pref_name
WHEN '德岛' THEN '四国'
WHEN '香川' THEN '四国'
WHEN '爱媛' THEN '四国'
WHEN '高知' THEN '四国'
WHEN '福冈' THEN '九州'
WHEN '佐贺' THEN '九州'
WHEN '长崎' THEN '九州'
ELSE '其他' END AS district,
SUM(population)
FROM PopTbl

GROUP BY CASE pref_name
WHEN '德岛' THEN '四国'
WHEN '香川' THEN '四国'
WHEN '爱媛' THEN '四国'
WHEN '高知' THEN '四国'
WHEN '福冈' THEN '九州'
WHEN '佐贺' THEN '九州'
WHEN '长崎' THEN '九州'
ELSE '其他' END;

/* 按人口数量等级划分都道府县 */
SELECT CASE WHEN population < 100 THEN '01'
WHEN population >= 100 AND population < 200 THEN '02'
WHEN population >= 200 AND population < 300 THEN '03'
WHEN population >= 300 THEN '04'
ELSE NULL END AS pop_class,
COUNT(*) AS cnt
FROM PopTbl

 GROUP BY CASE WHEN population < 100 THEN '01'
 WHEN population >= 100 AND population < 200 THEN '02'
 WHEN population >= 200 AND population < 300 THEN '03'
 WHEN population >= 300 THEN '04'
 ELSE NULL END;
							 
/* 把县编号转换成地区编号(2)：将CASE表达式归纳到一处 */
SELECT CASE pref_name
WHEN '德岛' THEN '四国'
WHEN '香川' THEN '四国'
WHEN '爱媛' THEN '四国'
WHEN '高知' THEN '四国'
WHEN '福冈' THEN '九州'
WHEN '佐贺' THEN '九州'
WHEN '长崎' THEN '九州'
ELSE '其他' END AS district,
       SUM(population)
FROM PopTbl
GROUP BY district;

/* 用一条SQL语句进行不同条件的统计 */
SELECT pref_name,
       /* 男性人口 */
       SUM( CASE WHEN sex = '1' THEN population ELSE 0 END) AS cnt_m,
       /* 女性人口 */
       SUM( CASE WHEN sex = '2' THEN population ELSE 0 END) AS cnt_f
FROM PopTbl2
GROUP BY pref_name;

/* 用CHECK约束定义多个列的条件关系 */
/* 蕴含式 */
CONSTRAINT check_salary CHECK
( CASE WHEN sex = '2'
       THEN CASE WHEN salary <= 200000
                 THEN 1 ELSE 0 END
       ELSE 1 END = 1 )
			 
			 
/* 用CHECK约束定义多个列的条件关系 */
/* 逻辑与 */
CONSTRAINT check_salary CHECK
( sex = '2' AND salary <= 200000 )


/* 用CASE表达式写正确的更新操作 */
UPDATE Salaries
   SET salary = CASE WHEN salary >= 300000
                     THEN salary * 0.9
                     WHEN salary >= 250000 AND salary < 280000
                     THEN salary * 1.2
                     ELSE salary END;
 
 /* 用CASE表达式调换主键值 */
UPDATE SomeTable
   SET p_key = CASE WHEN p_key = 'a'
                    THEN 'b'
                    WHEN p_key = 'b'
                    THEN 'a'
                    ELSE p_key END
 WHERE p_key IN ('a', 'b');
 
 /* 表的匹配：使用IN谓词 */
SELECT CM.course_name,
       CASE WHEN CM.course_id IN 
                    (SELECT course_id FROM OpenCourses 
                      WHERE month = 200706) THEN '○'
            ELSE '×' END AS "6月",
       CASE WHEN CM.course_id IN 
                    (SELECT course_id FROM OpenCourses
                      WHERE month = 200707) THEN '○'
            ELSE '×' END AS "7月",
       CASE WHEN CM.course_id IN 
                    (SELECT course_id FROM OpenCourses
                      WHERE month = 200708) THEN '○'
            ELSE '×' END  AS "8月"
  FROM CourseMaster CM;
	
	/* 表的匹配：使用EXISTS谓词 */
SELECT CM.course_name,
       CASE WHEN EXISTS
                    (SELECT course_id FROM OpenCourses OC
                      WHERE month = 200706
                        AND CM.course_id = OC.course_id) THEN '○'
            ELSE '×' END AS "6月",
       CASE WHEN EXISTS
                    (SELECT course_id FROM OpenCourses OC
                      WHERE month = 200707
                        AND CM.course_id = OC.course_id) THEN '○'
            ELSE '×' END AS "7月",
       CASE WHEN EXISTS
                    (SELECT course_id FROM OpenCourses OC
                      WHERE month = 200708
                        AND CM.course_id = OC.course_id) THEN '○'
            ELSE '×' END  AS "8月"
  FROM CourseMaster CM;
	
SELECT std_id, MAX(club_id) AS main_club
FROM StudentClub
GROUP BY std_id
HAVING COUNT(*) = 1;

/* 在CASE表达式中使用聚合函数 */
SELECT std_id,
       CASE WHEN COUNT(*) = 1 /* 只加入了一个社团的学生 */
            THEN MAX(club_id)
            ELSE MAX(CASE WHEN main_club_flg = 'Y'
                          THEN club_id
                          ELSE NULL END)
        END AS main_club
 FROM StudentClub
 GROUP BY std_id;