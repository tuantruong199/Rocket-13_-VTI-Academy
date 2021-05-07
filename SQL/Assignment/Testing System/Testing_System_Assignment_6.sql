-- Question 1
DROP PROCEDURE IF EXISTS sp_GetAccount;
DELIMITER $$
CREATE PROCEDURE sp_GetAccount(IN in_dep VARCHAR(50))
BEGIN 
	SELECT ac.AccountID,ac.Username,ac.FullName FROM `account` ac 
    INNER JOIN department d ON ac.DepartmentID = d.DepartmentID
    WHERE d.DepartmentName = in_dep;
END$$
DELIMITER ;
Call sp_GetAccount('Sale');

-- Question 2
DROP PROCEDURE IF EXISTS sp_GetNumberofacc;
DELIMITER $$
CREATE PROCEDURE sp_GetNumberofacc(IN in_group NVARCHAR(50))
BEGIN
		SELECT gr.GroupID,gr.GroupName,COUNT(ga.AccountID) AS Number_of_account
        FROM `group` gr
        INNER JOIN `groupaccount` ga ON gr.GroupID = ga.GroupID
        WHERE gr.GroupName = in_group;
END$$
DELIMITER ;
CALL sp_GetNumberofacc(N'Testing System');

-- Question 3 
DROP PROCEDURE IF EXISTS sp_GetTypeQues;
DELIMITER $$
CREATE PROCEDURE sp_GetTypeQues()
BEGIN
SELECT *
FROM `question` qt
INNER JOIN typequestion tqt ON qt.TypeID = tqt.TypeID
WHERE month(qt.CreateDate)= month(now() AND year(qt.CreateDate)) =year(now())
GROUP BY qt.CreateDate;
END$$
DELIMITER ;
Call sp_GetTypeQues();

-- Question 4
DROP PROCEDURE IF EXISTS sp_GetMaxTypeQues;
DELIMITER $$
CREATE PROCEDURE sp_GetMaxTypeQues()
BEGIN
		SELECT qt.TypeID,COUNT(qt.TypeID) AS Number_question
        FROM `question` qt
        INNER JOIN answer an ON qt.QuestionID = an.QuestionID
        GROUP BY qt.TypeID
        HAVING COUNT(qt.TypeID) = (SELECT MAX(numbertype) FROM (SELECT COUNT(qt.TypeID) AS numbertype
									FROM `question` qt
									INNER JOIN answer an ON qt.QuestionID = an.QuestionID 
                                    GROUP BY qt.TypeID) AS temp);
END$$
DELIMITER ;
Call sp_GetMaxTypeQues();

-- QUestion 5
DROP PROCEDURE IF EXISTS sp_GetMaxTypeQues;
DELIMITER $$
CREATE PROCEDURE sp_GetMaxTypeQues()
BEGIN
		SELECT tqt.TypeName,COUNT(qt.TypeID) AS Number_question
        FROM `question` qt
        INNER JOIN answer an ON qt.QuestionID = an.QuestionID
        INNER JOIN typequestion tqt ON qt.TypeID = tqt.TypeID
        GROUP BY qt.TypeID
        HAVING COUNT(qt.TypeID) = (SELECT MAX(numbertype) FROM (SELECT COUNT(qt.TypeID) AS numbertype
									FROM `question` qt
									INNER JOIN answer an ON qt.QuestionID = an.QuestionID 
                                    GROUP BY qt.TypeID) AS temp);
END$$
DELIMITER ;
Call sp_GetMaxTypeQues();

-- Question 6
DROP PROCEDURE IF EXISTS sp_Getaccount;
DELIMITER $$
CREATE PROCEDURE sp_Getaccount(IN in_name NVARCHAR(50))
BEGIN
		SELECT g.GroupName,a.AccountID,a.Username
        FROM `groupaccount` ga
        INNER JOIN `group` g ON g.GroupID = g.GroupID
        INNER JOIN `account` a ON ga.AccountID = a.AccountID
        WHERE  g.GroupName LIKE in_name OR a.Username LIKE in_name;
        
END$$
DELIMITER ;
CAll sp_Getaccount(N'VI TI AI');

-- Question 7
DROP PROCEDURE IF EXISTS sp_CreatAcc;
DELIMITER $$
CREATE PROCEDURE sp_CreatAcc(IN in_fullname NVARCHAR(50),IN in_email VARCHAR(50))
BEGIN
		INSERT INTO`account`(`Email`,Username,FullName,DepartmentID,PositionID)
        VALUE (in_email,(SELECT substring_index(in_email,'@',1 )),in_fullname,1,1);
        SELECT * FROM `account`;
END $$
DELIMITER ;
CALL sp_CreatAcc();

-- Question 8
DROP PROCEDURE IF EXISTS sp_GetMaxCont1;
DELIMITER $$
CREATE PROCEDURE sp_GetMaxCont1(IN in_typeques VARCHAR(50))
BEGIN
		WITH CTE_getmaxcontent AS(
				SELECT MAX(maxcont) AS Length_of_content
                FROM (SELECT LENGTH(q.Content) AS maxcont 
						FROM question q 
                        INNER JOIN typequestion t ON q.TypeID = t.TypeID
                        WHERE t.TypeName = in_typeques) AS temp)
        SELECT * FROM CTE_getmaxcontent;
END $$
DELIMITER ;
CALL sp_GetMaxCont1();

-- Question 9
DROP PROCEDURE IF EXISTS sp_DeleteExam;
DELIMITER $$
CREATE PROCEDURE sp_DeleteExam(IN in_examID TINYINT )
BEGIN
		DELETE FROM exam e
        WHERE e.ExamID = in_examID;
        SELECT * FROM exam;
END$$
DELIMITER ;
CALL sp_DeleteExam();

-- Question 10
DROP PROCEDURE IF EXISTS sp_DeleteExamYear;
DELIMITER $$
CREATE PROCEDURE sp_DeleteExamYear()
BEGIN
		SELECT COUNT(ExamID) AS Number_of_record 
        FROM exam e
        WHERE year(e.CreateDate) = year(now())-3;
END$$
DELIMITER ;
CALL sp_DeleteExamYear();

-- Question 11
DROP PROCEDURE IF EXISTS sp_DeleteDepartment;
DELIMITER $$
CREATE PROCEDURE sp_DeleteDepartment(IN in_namedep VARCHAR(50))
BEGIN
		DELETE FROM department d
        WHERE d.DepartmentName = in_namedep;
        UPDATE `account` a
        SET    DepartmentID = DEFAULT
        WHERE a.DepartmentID IS NULL;
END$$
DELIMITER ;
Call sp_DeleteDepartment();

-- Question 12
DROP PROCEDURE IF EXISTS sp_GetNumQuestion;
DELIMITER $$
CREATE PROCEDURE sp_GetNumQuestion()
BEGIN
		SELECT month(q.CreateDate) AS Month_in_year ,COUNT(QuestionID) AS Number_of_question
        FROM question q
        GROUP BY q.CreateDate
        HAVING year(q.CreateDate) = year(now())
        ORDER BY month(q.CreateDate);
END$$
DELIMITER ;