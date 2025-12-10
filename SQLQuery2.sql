--Part – A 
--1.	INSERT Procedures: Create stored procedures to insert records into STUDENT tables (SP_INSERT_STUDENT)
--StuID	Name	Email	Phone	Department	DOB	EnrollmentYear
--10	Harsh Parmar	harsh@univ.edu	9876543219	CSE	2005-09-18	2023
--11	Om Patel	om@univ.edu	9876543220	IT	2002-08-22	2022
CREATE OR ALTER PROC PR_INSERT_STUDENT
@ID INT,
@NAME VARCHAR(20),
@EMAIL VARCHAR(30),
@PHONE VARCHAR(15),
@DEPT VARCHAR(20),
@DOB DATE,
@YEAR INT
AS
BEGIN
	INSERT INTO STUDENT(StudentID,StuName,StuEmail,StuPhone,StuDepartment,StuDateOfBirth,StuEnrollmentYear) VALUES(@ID,@NAME,@EMAIL,@PHONE,@DEPT,@DOB,@YEAR)
END
EXEC PR_INSERT_STUDENT 10,'Harsh Parmar','harsh@univ.edu',9876543219,'CSE','2005-09-18',2023
EXEC PR_INSERT_STUDENT 11,'OM PATEL','om@univ.edu',9876543220,'IT','2002-08-22',2022

SELECT * FROM STUDENT
--2.	INSERT Procedures: Create stored procedures to insert records into COURSE tables 
--(SP_INSERT_COURSE)
--CourseID	CourseName	Credits	Dept	Semester
--CS330	Computer Networks	4	CSE	5
--EC120	Electronic Circuits	3	ECE	2

CREATE OR ALTER PROC PR_INSERT_COURSE
@ID VARCHAR(10),
@CNAME VARCHAR(100),
@CREDIT INT,
@DEPT VARCHAR(5),
@SEM INT
AS
BEGIN
	INSERT INTO COURSE (CourseID,CourseName,CourseCredits,CourseDepartment,CourseSemester) VALUES(@ID,@CNAME,@CREDIT,@DEPT,@SEM)
END
EXEC PR_INSERT_COURSE 'CS330','COMPUTER Networks',4,'CSE',5
EXEC PR_INSERT_COURSE 'EC120','Electronic Circuits',3,'ECE',2
SELECT * FROM COURSE
--3.	UPDATE Procedures: Create stored procedure SP_UPDATE_STUDENT to update Email and Phone in STUDENT table. (Update using studentID)
CREATE OR ALTER PROC PR_UPDATE_STUDENT
@ID INT,@MAIL VARCHAR(50),@PHONE VARCHAR(30)
AS
BEGIN
	UPDATE STUDENT
	SET StuEmail=@MAIL,StuPhone=@PHONE
	WHERE StudentID=@ID
END
EXEC PR_UPDATE_STUDENT 11,'OMPATEL@UNIV.COM','9876543221'

--4.	DELETE Procedures: Create stored procedure SP_DELETE_STUDENT to delete records from STUDENT where Student Name is Om Patel.
CREATE OR ALTER PROC PR_DELETE_STUDENT
@NAME VARCHAR(20)
AS
BEGIN
	DELETE  
	FROM STUDENT
	WHERE StuName=@NAME
END
EXEC PR_DELETE_STUDENT 'OM PATEL'
--5.	SELECT BY PRIMARY KEY: Create stored procedures to select records by primary key (SP_SELECT_STUDENT_BY_ID) from Student table.
CREATE OR ALTER PROC PR_SELECT_STUDENT_BY_ID
@ID INT
AS
BEGIN
	SELECT *
	FROM STUDENT
	WHERE StudentID=@ID
END
EXEC PR_SELECT_STUDENT_BY_ID 1
--6.	Create a stored procedure that shows details of the first 5 students ordered by EnrollmentYear.
CREATE OR ALTER PROC PR_SELECT_TOP5_STUDENT
AS
BEGIN
	SELECT TOP 5 *
	FROM STUDENT
	ORDER BY StuEnrollmentYear
END
EXEC PR_SELECT_TOP5_STUDENT 
--Part – B  
--7.	Create a stored procedure which displays faculty designation-wise count.
CREATE OR ALTER PROC PR_DESIGNATIONCOUNT
AS
BEGIN
	SELECT COUNT(FacultyID),FacultyDesignation
	FROM FACULTY
	GROUP BY FacultyDesignation
END
EXEC PR_DESIGNATIONCOUNT 

--8.	Create a stored procedure that takes department name as input and returns all students in that department.
CREATE OR ALTER PROC PR_RETURN
@DEPTNAME VARCHAR(20)
AS
BEGIN
	SELECT STUNAME
	FROM STUDENT
	WHERE StuDepartment=@DEPTNAME
END
EXEC PR_RETURN 'CSE'
--Part – C 
--9.	Create a stored procedure which displays department-wise maximum, minimum, and average credits of courses.
CREATE OR ALTER PROC PR_CREDIT_RETURN
AS
BEGIN
	SELECT MAX(CourseCredits) AS MAXIMUM ,MIN(CourseCredits) AS MINIUM, AVG(CourseCredits) AS AVERAGE,CourseDepartment
	FROM COURSE
	GROUP BY CourseDepartment
END
EXEC PR_CREDIT_RETURN
--10.	Create a stored procedure that accepts StudentID as parameter and returns all courses the student is enrolled in with their grades.
CREATE OR ALTER PROC PR_GRADE
@ID INT
AS
BEGIN
	SELECT CourseName,GRADE
	FROM ENROLLMENT
	JOIN STUDENT
	ON ENROLLMENT.StudentID=STUDENT.StudentID
	JOIN COURSE
	ON ENROLLMENT.CourseID=COURSE.CourseID
	WHERE ENROLLMENT.StudentID=@ID
END
EXEC PR_GRADE 1