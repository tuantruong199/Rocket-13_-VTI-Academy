-- Question 1
CREATE OR REPLACE VIEW vw_account_Sale AS
SELECT acc.AccountID,acc.Username,acc.FullName,acc.DepartmentID
FROM `account` acc
INNER JOIN department dp ON acc.DepartmentID = dp.DepartmentID
WHERE dp.DepartmentName = 'Sale';
SELECT * FROM vw_account_Sale;
DROP VIEW vw_account_Sale;

-- Question 2
CREATE OR REPLACE VIEW vw_groupaccount AS
WITH CTE_Getmaxacc AS (
		( SELECT MAX(Number_of_group) 
        FROM (SELECT COUNT(ga.GroupID) AS Number_of_group
							FROM `account` ac
							INNER JOIN groupaccount ga ON ac.AccountID = ga.AccountID
							GROUP BY ac.AccountID) AS temp) 
) 
 SELECT ac.AccountID,ac.Username,ac.FullName,COUNT(ga.GroupID) AS Number_of_group
 FROM `account` ac
 INNER JOIN groupaccount ga ON ac.AccountID = ga.AccountID
 GROUP BY ac.AccountID
 HAVING COUNT(ga.AccountID) = (SELECT * FROM CTE_Getmaxacc);
    
SELECT * FROM vw_groupaccount;
DROP VIEW vw_groupaccount;

-- Question 3
CREATE OR REPLACE VIEW vw_delete_content AS
	SELECT *
    FROM `question`
    WHERE length(Content) >300;
DELETE  FROM  vw_delete_content;
DROP VIEW vw_delete_content;

-- Question 4
CREATE OR REPLACE VIEW vw_Getmaxacc AS
WITH CTE_Getmax AS(
		SELECT MAX(maxacc) FROM ( SELECT COUNT(ac.AccountID) AS maxacc
        FROM `account` ac
        INNER JOIN department d ON ac.DepartmentID = d.DepartmentID
		GROUP BY ac.DepartmentID) AS temp
)
SELECT d.DepartmentID,d.DepartmentName,COUNT(ac.AccountID) AS Number_of_account
FROM `account` ac
INNER JOIN department d ON ac.DepartmentID = d.DepartmentID
GROUP BY ac.DepartmentID
HAVING COUNT(ac.AccountID) = (SELECT * FROM CTE_Getmax);

SELECT * FROM vw_Getmaxacc;
DROP VIEW vw_Getmaxacc;

-- Question 5
CREATE OR REPLACE VIEW vw_Getquestion AS
SELECT q.QuestionID,q.Content,a.FullName AS CreatorName
FROM `question` q
INNER JOIN `account` a ON q.CreatorID = a.AccountID
WHERE a.FullName LIKE N'Nguyễn%';
SELECT * FROM vw_Getquestion;
DROP VIEW vw_Getquestion;
