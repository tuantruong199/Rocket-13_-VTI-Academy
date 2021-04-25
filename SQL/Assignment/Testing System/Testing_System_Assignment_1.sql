DROP DATABASE IF EXISTS testing_system_assignment_1; 
CREATE DATABASE Testing_System_Assignment_1;
USE Testing_System_Assignment_1;

DROP TABLE IF EXISTS department;
CREATE TABLE Department(
   DepartmentID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
   DepartmentNAME		VARCHAR(50) NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS `Position`;
CREATE TABLE `Position`(
	PositionID		 TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName	 ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS Account;
CREATE TABLE Account(
	AccountID  		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email  			NVARCHAR(50) NOT NULL UNIQUE KEY,
    Username		NVARCHAR(50) NOT NULL UNIQUE KEY CHECK(LENGTH(Username)>=6),
    Fullname		NVARCHAR(50) NOT NULL CHECK(LENGTH(Fullname)>=6),
    DepartmentID 	TINYINT UNSIGNED NOT NULL,
    PositionID		TINYINT UNSIGNED NOT NULL,
    CreatDate       DATETIME DEFAULT NOW(),
    FOREIGN KEY(DepartmentID) REFERENCES department(DepartmentID),
    FOREIGN KEY(PositionID) REFERENCES `position`(PositionID)
);

DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`(
	GroupID  		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GroupName		NVARCHAR(50) NOT NULL UNIQUE KEY,
    CreatorID		TINYINT UNSIGNED NOT NULL,
    CreateDate      DATETIME DEFAULT NOW(),
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);

DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount(
	GroupID 		TINYINT UNSIGNED NOT NULL,
    AccountID 		TINYINT UNSIGNED NOT NULL,
    JoinDate 		DATETIME DEFAULT NOW(),
    PRIMARY KEY(GroupID,AccountID),
    FOREIGN KEY(GroupID)  REFERENCES `Group`(GroupID)
);

DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion(
	TypeID 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TypeName  	ENUM('Essay','Multiple-Choice') NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion(
	CategoryID   	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CategoryName 	NVARCHAR(50) NOT NULL 
);

DROP TABLE IF EXISTS Question;
CREATE TABLE Question(
	QuestionID 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content 		NVARCHAR(50) NOT NULL,
    CategoryID 		TINYINT UNSIGNED NOT NULL,
    TypeID 			TINYINT UNSIGNED  NOT NULl,
    CreatorID 		TINYINT UNSIGNED  NOT NULl,
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY (TypeID) REFERENCES TypeQuestion(TypeID),
    FOREIGN KEY (CreatorID) REFERENCES Account(AccountID)
);

DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer(
	AnswerID 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content 		NVARCHAR(50) NOT NULL,
    QuestionID  	TINYINT UNSIGNED NOT NULL,
    isCorrect   	BIT DEFAULT(1),
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);

DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam(
	ExamID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Code` 			TINYINT UNSIGNED NOT NULL,
    Title  			NVARCHAR(50) NOT NULL,
    CategoryID 		TINYINT UNSIGNED NOT NULL,
    Duration		TINYINT UNSIGNED NOT NULL,
    CreatorID 		TINYINT UNSIGNED NOT NULL,
    CreateDate		DATETIME DEFAULT NOW(),
    FOREIGN KEY(CreatorID) REFERENCES Account(AccountID),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID)
);

DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion(
	ExamID 			TINYINT UNSIGNED NOT NULL,
    QuestionID		TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY(ExamID),
    FOREIGN KEY(ExamID) 	REFERENCES  Exam(ExamID),
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);

INSERT INTO department(DepartmentNAME)
VALUE 	(N'Marketing'),
		(N'Sale'),
		(N'Bảo vệ'),
		(N'Nhân sự'),
		(N'Kỹ thuật'),
		(N'Tài chính'),
		(N'Phó giám đốc'),
		(N'Giám đốc'),
		(N'Thư ký'),
		(N'Bán hàng');

INSERT INTO Position (PositionName)
VALUE	(N'Dev'),
		(N'Test'),
		(N'Scrum Master'),
		(N'PM');



INSERT INTO Account	(Email, 					Username,		Fullname,				DepartmentID,PositionID)
VALUE				(N'tuantruong99@gmail.com'	,N'tuantruong'	,N'Truong Van Tuan'		,1			,1 			),
					(N'vanminh16@gmail.com'   	,N'minhvan12'	,N'Nguyen Van Minh'		,3			,1 			),
                    (N'vuvanbinh111@gmail.com'	,N'binhvu121'	,N'Vu Van Binh'			,4			,1 			),
					(N'buixuanvi99@gmail.com'	,N'buixuanvi'	,N'Bui Xuan Vi'			,3			,1 			),
                    (N'trantuaphuong@gmail.com'	,N'phuongvan'	,N'Tran Tuan Phuong'	,7			,1 			),
					(N'Nguyenhieu11@gmail.com'	,N'hieunguyen'	,N'Nguyen Minh Hieu'	,5			,1 			),
                    (N'phivanlam123@gmail.com'	,N'philam22'	,N'Phi Van Lam'			,10			,1 			),
					(N'nguyendaoluc9@gmail.com'	,N'ngdaoluc'	,N'Nguyen Dao Luc'		,6			,1 			),
                    (N'phanmaihoa20@gmail.com'	,N'maihoa20'	,N'Phan Mai Hoa'		,8			,1 			),
					(N'nguyenvanbinh@gmail.com'	,N'binhnguyen'	,N'Nguyen Van Binh'		,2			,1 			);
 
 INSERT INTO `Group`	(GroupName			,CreatorID)
 VALUE					(N'Testing System'	,1),
						(N'Marketing 01'	,2),
						(N'Sale 01'			,8),
						(N'Sale 02'			,9),
						(N'Marketing 02'	,7),
						(N'Marketing 03'	,10),
						(N'GroupA'			,6),
						(N'Group B'			,4),
						(N'Group C'			,1),
						(N'Group D'			,9);

INSERT INTO GroupAccount(GroupID,AccountID)
VALUE					(1		,1),
						(2		,2),
						(3		,3),
						(4		,4),
						(5		,5),
						(6		,6),
						(7		,7),
						(8		,8),
						(9		,9),
						(10		,10);
					
INSERT INTO TypeQuestion(TypeName)
VALUE					('Essay'),
						('Multiple-Choice');
          
INSERT INTO CategoryQuestion(CategoryName)
VALUE						('Java'),
							('.NET'),
							('SQL'),
							('Postman'),
							('Ruby'),
							('C++'),
							('C#'),
							('HTML'),
							('CSS'),
							('Javascript');
                            
INSERT INTO Question(Content				,CategoryID	,TypeID	,CreatorID	)
VALUE				(N'Question Java'		,1			,1		,1			),
					(N'Question C#'			,7			,2		,2			),
					(N'Question .NET'		,3			,1		,3			),
					(N'Question SQL'		,4			,1		,4			),
					(N'Question Postman'	,5			,1		,5			),
					(N'Question Ruby'		,6			,1		,6			),
					(N'Question C++'		,7			,1		,7			),
					(N'Question HTML'		,8			,2		,8			),
					(N'Question CSS'		,9			,2		,9			),
					(N'Question Javascript'	,10			,2		,10			);
                    
INSERT INTO Answer  (Content			,QuestionID)
VALUE				('Answer Java'		,1			),
					('Answer Java'		,2			),
					('Answer SQL'		,3			),
					('Answer Java'		,4			),
					('Answer Java'		,5			),
					('Answer Java'		,6			),
					('Answer Java'		,7			),
					('Answer Java'		,8			),
					('Answer Java'		,9			),
					('Answer Java'		,10			);

INSERT INTO Exam(Code	,Title			,CategoryID	,Duration	,CreatorID)
VALUE			(1		,N'Đề thi Java'	,1			,60			,2),
				(2		,N'Đề thi C#'	,7			,90			,3),
				(3		,N'Đề thi Java'	,1			,60			,5),
				(4		,N'Đề thi HTML'	,8			,60			,2),
				(1		,N'Đề thi Java'	,1			,60			,8),
				(5		,N'Đề thi Java'	,1			,60			,9),
				(6		,N'Đề thi Java'	,1			,90			,8),
				(3		,N'Đề thi CSS'	,9			,60			,1),
				(8		,N'Đề thi Java'	,1			,90			,2),
				(9		,N'Đề thi HTML'	,9			,60			,10);

INSERT INTO ExamQuestion(ExamID,QuestionID)
VALUE 					(1		,1),
						(2		,2),
						(3		,4),
						(4		,6),
						(5		,9),
						(6		,7),
						(7		,3),
						(8		,2),
						(9		,6),
						(10		,4);