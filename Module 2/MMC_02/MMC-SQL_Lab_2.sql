DROP DATABASE IF EXISTS Testing_System_Db;
CREATE DATABASE Testing_System_Db;
USE Testing_System_Db;

----- Question 1: Tối ưu lại assignment trước -----
----- Question 2: Thêm các constraint vào assignment trước -----

DROP TABLE IF EXISTS Department;
CREATE TABLE Department(
	DepartmentID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName 			NVARCHAR(30) NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS `Position`;
CREATE TABLE `Position`(
	PositionID 				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName 			ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL
);

DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account`(
	AccountID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email 				NVARCHAR(50) NOT NULL UNIQUE KEY,
    Username 			NVARCHAR(30) NOT NULL,
    FullName 			NVARCHAR(30) NOT NULL,
    DepartmentID 		TINYINT UNSIGNED NOT NULL,
    PositionID 			TINYINT UNSIGNED NOT NULL,
    CreateDate 			DATETIME DEFAULT NOW(),
    FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID)
);

DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`(
	GroupID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GroupName 			NVARCHAR(30) NOT NULL UNIQUE KEY,
    CreatorID 			TINYINT UNSIGNED NOT NULL,
    CreateDate 			DATETIME DEFAULT NOW(),
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);

DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount(
	GroupID 			TINYINT UNSIGNED NOT NULL,
    AccountID 			TINYINT UNSIGNED NOT NULL,
    JoinDate 			DATETIME DEFAULT NOW(),
    PRIMARY KEY(GroupID, AccountID),
    FOREIGN KEY(GroupID) REFERENCES `Group`(GroupID),
    FOREIGN KEY(AccountID) REFERENCES `Account`(AccountID)
);

DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion(
	TypeID 				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TypeName 			ENUM('Essay', 'Multiple-Choice') NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion(
	CategoryID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CategoryName 		NVARCHAR(30) NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS Question;
CREATE TABLE Question(
	QuestionID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content 			NVARCHAR(300) NOT NULL UNIQUE KEY,
    CategoryID 			TINYINT UNSIGNED NOT NULL,
    TypeID 				TINYINT UNSIGNED NOT NULL,
    CreatorID 			TINYINT UNSIGNED NOT NULL,
    CreateDate 			DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(TypeID) REFERENCES TypeQuestion(TypeID),
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);

DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer(
	AnswerID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content 			NVARCHAR(300) NOT NULL UNIQUE KEY,
    QuestionID 			TINYINT UNSIGNED NOT NULL,
    isCorrect 			BIT DEFAULT 1,
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);

DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam(
	ExamID 				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Code` 				CHAR(10) NOT NULL UNIQUE KEY,
    Title 				NVARCHAR(20) NOT NULL UNIQUE KEY,
    CategoryID 			TINYINT UNSIGNED NOT NULL,
    Duration 			TINYINT UNSIGNED NOT NULL,
    CreatorID 			TINYINT UNSIGNED NOT NULL,
    CreateDate 			DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);

DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion(
	ExamID 				TINYINT UNSIGNED NOT NULL,
    QuestionID 			TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY(ExamID, QuestionID),
    FOREIGN KEY(ExamID) REFERENCES Exam(ExamID),
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);

----- Question 3: Chuẩn bị data cho bài 3 Insert data vào 11 table, mỗi table có ít nhất 5 records -----
INSERT INTO Department					( DepartmentName)
VALUES 									( N'Marketing'	 ),
										( N'Sale'		 ),
										( N'Bảo vệ'		 ),
										( N'Nhân sự'	 ),
										( N'Kỹ thuật'	 ),
										( N'Tài chính'	 ),
										( N'Phó giám đốc'),
										( N'Giám đốc'	 ),
										( N'Thư kí'		 ),
										( N'Bán hàng'	 );

INSERT INTO `Position`					( PositionName)
VALUES 									( 'Dev'			),
										( 'Test'		),
										( 'Scrum Master'),
										( 'PM'			);

INSERT INTO `Account`(Email						,	Username		,	FullName		,	DepartmentID		,	PositionID		, 	CreateDate)
VALUES 				 ('account1@gmail.com'		,	'account1'		,	'Account 1'		,		5				,	1				,	'2020-03-05'),
					 ('account2@gmail.com'		,	'account2'		,	'Account 2'		,		1				,	2				,	'2020-03-06'),
                     ('account3@gmail.com'		,	'account3'		,	'Account 3'		,		2				,	3				,	'2020-03-07'),
                     ('account4@gmail.com'		,	'account4'		,	'Account 4'		,		3				,	4				,	'2020-03-08'),
                     ('account5@gmail.com'		,	'account5'		,	'Account 5'		,		4				,	4				,	'2020-03-09');

INSERT INTO `Group`	(  GroupName	,	CreatorID		,	CreateDate)
VALUES 				(N'Group 1'		,	5				,	'2019-03-05'),
					(N'Group 2'		,	1				,	'2020-03-06'),
                    (N'Group 3'		,	2				,	'2020-03-07'),
                    (N'Group 4'		,	3				,	'2020-03-08'),
                    (N'Group 5'		,	4				,	'2020-03-09');

INSERT INTO `GroupAccount`	(  GroupID	,	AccountID	, JoinDate	 )
VALUES 						(	1		,    1			,'2019-03-05'),
							(	1		,    2			,'2020-03-07'),
							(	3		,    3			,'2020-03-09'),
							(	3		,    4			,'2020-03-10'),
							(	5		,    5			,'2020-03-28');

INSERT INTO TypeQuestion	(TypeName			) 
VALUES 						('Essay'			), 
							('Multiple-Choice'	); 


INSERT INTO CategoryQuestion		(CategoryName	)
VALUES 								('Java'			),
									('ASP.NET'		),
									('ADO.NET'		),
									('SQL'			),
									('ABC.NET'		);
													
INSERT INTO Question	(Content				, CategoryID, 		TypeID		, CreatorID		, CreateDate )
VALUES 					(N'Câu hỏi về Java'		,	1			,   1			,   2			,'2020-04-05'),
						(N'Câu Hỏi về ASP.NET'	,	2			,   2			,   2			,'2020-04-05'),
						(N'Hỏi về ADO.NET'		,	3			,   2			,   3			,'2020-04-06'),
						(N'Hỏi về SQL'			,	4			,   1			,   4			,'2020-04-06'),
						(N'Hỏi về ABC.NET'		,	5			,   1			,   5			,'2020-04-06');

INSERT INTO Answer	(  Content		, QuestionID	, isCorrect	)
VALUES 				(N'Trả lời 01'	,   1			,	0		),
					(N'Trả lời 02'	,   1			,	1		),
                    (N'Trả lời 03'	,   1			,	0		),
                    (N'Trả lời 04'	,   1			,	1		),
                    (N'Trả lời 05'	,   2			,	1		);
	
INSERT INTO Exam	(`Code`			, Title						, CategoryID	, Duration	, CreatorID		, CreateDate )
VALUES 				('VTIQ001'		, N'Đề thi Java'			,	1			,	60		,   5			,'2019-04-05'),
					('VTIQ002'		, N'Đề thi  ASP.NET'		,	2			,	60		,   2			,'2019-04-05'),
                    ('VTIQ003'		, N'Đề thi ADO.NET'			,	3			,	120		,   2			,'2019-04-07'),
                    ('VTIQ004'		, N'Đề thi SQL'				,	4			,	60		,   3			,'2020-04-08'),
                    ('VTIQ005'		, N'Đề thi ABC.NET'			,	5			,	120		,   4			,'2020-04-10');
                    
                    
INSERT INTO ExamQuestion(ExamID	, 	QuestionID	) 
VALUES 					(	1	,		1		),
						(	2	,		2		), 
						(	3	,		3		), 
						(	4	,		4		), 
						(	5	,		5		);
