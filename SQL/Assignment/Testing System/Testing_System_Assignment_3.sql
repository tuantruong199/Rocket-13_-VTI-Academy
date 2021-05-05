-- Question 2
SELECT * 
FROM department;

-- Question 3
SELECT DepartmentID 
FROM department
WHERE DepartmentName ='Sale';

-- Question 4
SELECT * 
FROM `account` 
WHERE length(Fullname) =(SELECT MAX(length(Fullname)) FROM `account`);

-- Question 5
WITH CTE_MaxFullname_Id3 AS(
	SELECT Max(length(Fullname)) 
    FROM `account`
    WHERE DepartmentID =3
)
SELECT * 
FROM `account`
WHERE DepartmentID=3 AND length(Fullname) =(SELECT * FROM CTE_MaxFullname_Id3);

-- Queston 6 
SELECT GroupName 
FROM `group` 
WHERE CreateDate < '2019-12-20'; 

-- Question 7
SELECT AnswerID
FROM answer 
GROUP BY QuestionID HAVING count(QuestionID)>=4;
-- Question 8
SELECT ExamID
FROM exam
WHERE Duration >= 60 AND CreateDate < '2019-12-20';

-- Question 9
SELECT *
FROM `group`
ORDER BY CreateDate DESC LIMIT 5;

-- Question 10
SELECT COUNT(DepartmentID)
FROM `account`
WHERE DepartmentID =2;


-- Question 11
SELECT * 
FROM `account`
WHERE (SUBSTRING_INDEX(Fullname, '' ,-1)) LIKE 'D%O';

-- Question 12
DELETE 
FROM exam WHERE CreateDate < '2019-12-20';

-- Question 13
DELETE
FROM question
WHERE Content LIKE 'câu hỏi%';

-- Question 14
UPDATE 	`account`
SET 			Fullname = N'Nguyễn Bá Lộc',
				Email = 'loc.nguyenba@vti.com.vn'
WHERE 	AccountID = 5;

-- Question 15
UPDATE 	`groupaccount`
SET 			groupID =4 
WHERE 	AccountID = 5;
