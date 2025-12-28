--Part – A 
--1.	Create a stored procedure that accepts a date and returns all faculty members who joined on that date.
CREATE OR ALTER PROC PR_RETURNDATE
@JDATE DATE
AS
BEGIN
	SELECT FACULTYNAME
	FROM FACULTY
	WHERE FacultyJoiningDate=@JDATE
END
EXEC PR_RETURNDATE '2010-07-15'
--2.	Create a stored procedure for ENROLLMENT table where user enters either StudentID and returns EnrollmentID, EnrollmentDate, Grade, and Status.
CREATE OR ALTER PROC PR_GETENROLLMENT_INFO
@ID INT
AS
BEGIN
	SELECT *
	FROM ENROLLMENT
	WHERE StudentID=@ID
END
EXEC PR_GETENROLLMENT_INFO 1
--3.	Create a stored procedure that accepts two integers (min and max credits) and returns all courses whose credits fall between these values.
CREATE OR ALTER PROC PR_RETURNCREDIT
@MINC INT,
@MAXC INT
AS
BEGIN 
	SELECT *
	FROM COURSE
	WHERE CourseCredits BETWEEN @MINC AND @MAXC
END
EXEC PR_RETURNCREDIT 2 ,3
--4.	Create a stored procedure that accepts Course Name and returns the list of students enrolled in that course.
CREATE OR ALTER PROC PR_LISTOFSTUDENT
@CNAME VARCHAR(20)
AS
BEGIN
	SELECT STUNAME
	FROM ENROLLMENT
	JOIN STUDENT
	ON ENROLLMENT.StudentID=STUDENT.StudentID
	JOIN COURSE
	ON ENROLLMENT.CourseID=COURSE.CourseID
	WHERE COURSE.CourseName=@CNAME
END
EXEC PR_LISTOFSTUDENT 'Data Structures'
--5.	Create a stored procedure that accepts Faculty Name and returns all course assignments.
CREATE OR ALTER PROC PR_assignments
@NAME VARCHAR(30)
AS
BEGIN
	SELECT FacultyName,CourseName
	FROM COURSE_ASSIGNMENT
	JOIN FACULTY
	ON Course_Assignment.FacultyID=FACULTY.FacultyID
	JOIN COURSE
	ON Course_Assignment.CourseID=COURSE.CourseID
	WHERE FacultyName=@NAME
END
EXEC PR_assignments 'Dr. Sheth'
--6.	Create a stored procedure that accepts Semester number and Year, and returns all course assignments with faculty and classroom details.
CREATE OR ALTER PROC PR_assignments_DETAIL
@SEM INT,@YEAR INT
AS
BEGIN
	SELECT FacultyName,CourseName,ClassRoom
	FROM COURSE_ASSIGNMENT
	JOIN FACULTY
	ON Course_Assignment.FacultyID=FACULTY.FacultyID
	JOIN COURSE
	ON Course_Assignment.CourseID=COURSE.CourseID
	WHERE Semester=@SEM AND YEAR=@YEAR
END
EXEC  PR_assignments_DETAIL 1,2024
--Part – B 
--7.	Create a stored procedure that accepts the first letter of Status ('A', 'C', 'D') and returns enrollment details.
CREATE OR ALTER PROC PR_RETURN_ENROLLMENTSTATUS
@FIRSTLETTER VARCHAR(10)
AS
BEGIN
	SELECT *
	FROM ENROLLMENT
	WHERE EnrollmentStatus LIKE @FIRSTLETTER +'%'
END
EXEC PR_RETURN_ENROLLMENTSTATUS 'D'
--8.	Create a stored procedure that accepts either Student Name OR Department Name and returns student data accordingly.
CREATE OR ALTER PROC PR_RETURN_DATA
@NAME VARCHAR(20)
AS
BEGIN
	SELECT *
	FROM STUDENT
	WHERE StuName=@NAME OR StuDepartment=@NAME
END
EXEC PR_RETURN_DATA 'CSE'
--9.	Create a stored procedure that accepts CourseID and returns all students enrolled grouped by enrollment status with counts.
CREATE OR ALTER PROC PR_status
@COURSEID VARCHAR(30),
@COUNT INT OUT
AS
BEGIN
	SELECT @COUNT=COUNT(STUDENTID)
	FROM ENROLLMENT
	WHERE COURSEID=@COURSEID
	GROUP BY EnrollmentStatus
END
DECLARE @CNT INT
EXEC PR_status 'CS201',@CNT OUT
SELECT @CNT
--Part – C 
--10.	Create a stored procedure that accepts a year as input and returns all courses assigned to faculty in that year with classroom details.
CREATE OR ALTER PROC PR_YEAR
@YEAR INT
AS
BEGIN
	SELECT CourseName,FacultyName,CLASSROOM
	FROM Course_Assignment
	JOIN FACULTY
	ON Course_Assignment.FacultyID=FACULTY.FacultyID
	JOIN COURSE
	ON Course_Assignment.CourseID=COURSE.CourseID
	WHERE YEAR=@YEAR
END
EXEC PR_YEAR 2024
--11.	Create a stored procedure that accepts From Date and To Date and returns all enrollments within that range with student and course details.
CREATE OR ALTER PROC PR_DETAIL
@FDATE DATE,
@TDATE DATE
AS
BEGIN
	SELECT CourseName,StuName,StuEnrollmentYear,EnrollmentDate
	FROM ENROLLMENT
	JOIN STUDENT
	ON ENROLLMENT.StudentID=ENROLLMENT.StudentID
	JOIN COURSE
	ON ENROLLMENT.CourseID=COURSE.CourseID
	WHERE EnrollmentDate BETWEEN @FDATE AND @TDATE
END
EXEC PR_DETAIL '2021-06-01','2023-08-01'
--12.	Create a stored procedure that accepts FacultyID and calculates their total teaching load (sum of credits of all courses assigned).
CREATE OR ALTER PROC PR_LAOD
@FID INT
AS
BEGIN
	SELECT SUM(CourseCredits) AS LOAD,FacultyName
	FROM Course_Assignment
	JOIN FACULTY
	ON Course_Assignment.FacultyID=FACULTY.FacultyID
	JOIN COURSE
	ON Course_Assignment.CourseID=COURSE.CourseID
	WHERE Course_Assignment.FacultyID=@FID
	GROUP BY FacultyName
END
EXEC PR_LAOD 107

