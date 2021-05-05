-- Question 1
SELECT a.AccountID,a.Email,a.Fullname,d.DepartmentNAME FROM `account` a
INNER JOIN department d ON a.DepartmentID=d.DepartmentID;

-- Question 2
SELECT * 
FROM `account` ac
WHERE CreateDate > '2010-12-20';
-- Question 3
SELECT a.AccountID,a.Fullname,p.PositionName FROM `account` a
INNER JOIN position p ON a.PositionID = p.PositionID 
WHERE PositionName='Dev';

-- Question 4
SELECT d.DepartmentNAME,count(a.DepartmentID) FROM `account` a 
INNER JOIN `department` d ON a.DepartmentID =d.DepartmentID 
GROUP BY a.DepartmentID HAVING count(a.DepartmentID)>3;

-- Question 5 
 SELECT *,COUNT(qt.QuestionID) AS number_of_uses
 FROM `question` q
 INNER JOIN `examquestion` qt ON q.QuestionID = qt.QuestionID 
 GROUP BY qt.QuestionID 
 ORDER BY COUNT(qt.QuestionID) DESC;
 
 -- Question 6
 SELECT qt.CategoryID,cq.CategoryName,COUNT(qt.CategoryID) AS number_of_uses
 FROM `categoryquestion` cq
 INNER JOIN `question` qt ON cq.CategoryID = qt.CategoryID
 GROUP BY qt.CategoryID;
 
 -- Question 7
 SELECT qt.QuestionID,qt.Content,qt.CategoryID,COUNT(qt.CategoryID) AS number_of_uses
 FROM `question` qt
 INNER JOIN `exam` ex ON qt.CategoryID = ex.CategoryID
  GROUP BY qt.CategoryID;
  
  -- Question 8
  SELECT *,COUNT(an.QuestionID) AS number_of_uses
  FROM `answer` an
  INNER JOIN `question` qt ON an.QuestionID = qt.QuestionID
  GROUP BY an.QuestionID
 ORDER BY COUNT(an.QuestionID) DESC
 LIMIT 1;
 
WITH CTE_GetMaxQues AS(
SELECT MAX(coutques) AS maxques
FROM (SELECT COUNT(an.QuestionID) AS coutques FROM `answer`AS an
GROUP BY an.QuestionID) AS counttble
)
 SELECT an.QuestionID,an.AnswerID,qt.Content,COUNT(an.QuestionID) AS number_of_uses
 FROM `answer` an
 INNER JOIN `question` qt ON an.QuestionID = qt.QuestionID
 GROUP BY an.QuestionID
 HAVING COUNT(an.QuestionID) =(SELECT * FROM `CTE_GetMaxQues`);
  
  -- Question 9
  SELECT gra.GroupID,COUNT(acc.AccountID) AS number_of_account
  FROM `account` acc
  INNER JOIN `groupaccount` gra ON acc.AccountID = gra.AccountID
  GROUP BY gra.GroupID;
  
  -- Queston 10
  WITH CTE_GetMinPosition AS (
  SELECT MIN(countmin) AS minpos
  FROM (SELECT COUNT(acc.PositionID) AS countmin FROM `account` AS acc
  GROUP BY acc.PositionID) AS couttable
  )
  
SELECT pt.PositionID,pt.PositionName,COUNT(acc.PositionID)  AS Number_of_accounts
FROM `account` acc
INNER JOIN `position` pt ON acc.PositionID = pt.PositionID
GROUP BY acc.PositionID
HAVING COUNT(acc.PositionID) = (SELECT * FROM CTE_GetMinPosition);
 
 -- Question 11
  SELECT *
  FROM `account` acc;
  
  -- Question 12
  SELECT qt.QuestionID,qt.Content,tqt.TypeName,cqt.CategoryName,acc.Username,acc.FullName,an.Content
  FROM `question` qt
  INNER JOIN typequestion tqt ON  qt.TypeID = tqt.TypeID
  INNER JOIN categoryquestion cqt ON cqt.CategoryID = qt.CategoryID
  INNER JOIN `account` acc ON acc.AccountID = qt.CreatorID
  INNER JOIN `answer` an ON an.QuestionID = qt.QuestionID;
  
  -- Question 
  