--	Part – A 
--1.	Retrieve all unique departments from the STUDENT table.
	SELECT  DISTINCT STUDEPARTMENT
	FROM STUDENT

--2.	Insert a new student record into the STUDENT table. (9, 'Neha Singh', 'neha.singh@univ.edu', '9876543218', 'IT', '2003-09-20', 2021)
	INSERT INTO STUDENT VALUES (9,'NEHA SINGH','NEHA.SINGH@UNIV.EDU',9876543218,'IT','2003-09-20',2021)

--3.	Change the Email of student 'Raj Patel' to 'raj.p@univ.edu'. (STUDENT table)
	UPDATE STUDENT
	SET STUEMAIL = 'RAJ.P@UNIV.EDU'
	WHERE STUNAME = 'RAJ PATEL'

--4.	Add a new column 'CGPA' with datatype DECIMAL(3,2) to the STUDENT table.
	ALTER TABLE STUDENT
	ADD CGPA DECIMAL(3,2)

--5.	Retrieve all courses whose CourseName starts with 'Data'. (COURSE table)
	SELECT COURSENAME FROM COURSE
	WHERE COURSENAME LIKE 'DATA%'

--6.	Retrieve all students whose Name contains 'Shah'. (STUDENT table)
	SELECT STUNAME FROM STUDENT
	WHERE STUNAME LIKE '%SHAH%'

--7.	Display all Faculty Names in UPPERCASE. (FACULTY table)
	SELECT UPPER(FACULTYNAME) AS FAC_NAME
	FROM FACULTY

--8.	Find all faculty who joined after 2015. (FACULTY table)
	SELECT *
	FROM FACULTY
	WHERE FACULTYJOININGDATE > '2015-12-31'

--9.	Find the SQUARE ROOT of Credits for the course 'Database Management Systems'. (COURSE table)
	SELECT SQRT(COURSECREDITS) AS SQRT_COURSE_CREDIT
	FROM COURSE
	WHERE COURSENAME = 'DATABASE MANAGEMENT SYSTEM'

--10.	Find the Current Date using SQL Server in-built function.
	SELECT GETDATE() AS CURR_DATE

--11.	Find the top 3 students who enrolled earliest (by EnrollmentYear). (STUDENT table)
	SELECT TOP 3 *
	FROM STUDENT
	WHERE STUENROLLMENTYEAR >= (SELECT MIN(STUENROLLMENTYEAR) FROM STUDENT)

--12.	Find all enrollments that were made in the year 2022. (ENROLLMENT table)
	SELECT *
	FROM ENROLLMENT
	WHERE YEAR(ENROLLMENTDATE) = 2022

--13.	Find the number of courses offered by each department. (COURSE table)
	SELECT  COURSEDEPARTMENT,COUNT(COURSEID) AS NUMBER_OF_COURSE 
	FROM COURSE
	GROUP BY COURSEDEPARTMENT

--14.	Retrieve the CourseID which has more than 2 enrollments. (ENROLLMENT table)
	SELECT COURSEID
	FROM ENROLLMENT
	GROUP BY COURSEID
	HAVING COUNT(COURSEID) > 2

--15.	Retrieve all the student name with their enrollment status. (STUDENT & ENROLLMENT table)
	SELECT STUNAME,STUEMAIL,STUPHONE,STUDEPARTMENT,STUDATEOFBIRTH,STUENROLLMENTYEAR,ENROLLMENTSTATUS
	FROM STUDENT
	JOIN ENROLLMENT
	ON STUDENT.STUDENTID = ENROLLMENT.STUDENTID

--16.	Select all student names with their enrolled course names. (STUDENT, COURSE, ENROLLMENT table)
		SELECT STUNAME , COURSENAME
		FROM STUDENT JOIN ENROLLMENT
		ON STUDENT.STUDENTID = ENROLLMENT.STUDENTID
		JOIN COURSE
		ON ENROLLMENT.COURSEID = COURSE.COURSEID

--17.	Create a view called 'ActiveEnrollments' showing only active enrollments with student name and  course name. (STUDENT, COURSE, ENROLLMENT,  table)
	CREATE VIEW ActiveEnrollments
	AS 
	SELECT STUNAME,COURSENAME
	FROM STUDENT
	JOIN ENROLLMENT
	ON STUDENT.StudentID=ENROLLMENT.StudentID
	JOIN COURSE
	ON COURSE.CourseID=ENROLLMENT.CourseID
	WHERE EnrollmentStatus ='ACTIVE';

	SELECT * FROM ActiveEnrollments
	DROP VIEW ActiveEnrollments

--18.	Retrieve the student’s name who is not enrol in any course using subquery. (STUDENT, ENROLLMENT TABLE)
	SELECT STUNAME
	FROM STUDENT
	WHERE STUDENTID NOT IN (SELECT STUDENTID FROM ENROLLMENT)

--19.	Display course name having second highest credit. (COURSE table)
	SELECT COURSENAME AS SECOND_HIGHEST_CREDIT , COURSECREDITS
	FROM COURSE
	WHERE COURSECREDITS < (SELECT MAX(COURSECREDITS) FROM COURSE)

--	Part – B 
--20.	Retrieve all courses along with the total number of students enrolled. (COURSE, ENROLLMENT table)
select COURSENAME,COUNT(STUDENTID) AS TOTAL_STUDENT
FROM COURSE
JOIN ENROLLMENT
ON COURSE.CourseID=ENROLLMENT.CourseID
GROUP BY CourseName
--21.	Retrieve the total number of enrollments for each status, showing only statuses that have more than 2 enrollments. (ENROLLMENT table)
SELECT COUNT(ENROLLMENTID) AS TOTAL_EMP , ENROLLMENTSTATUS
FROM ENROLLMENT
GROUP BY EnrollmentStatus
HAVING COUNT(EnrollmentID)>2

--22.	Retrieve all courses taught by 'Dr. Sheth' and order them by Credits. (FACULTY, COURSE, COURSE_ASSIGNMENT table)
SELECT COURSENAME,COURSECREDITS
FROM Course_Assignment
JOIN COURSE
ON Course_Assignment.CourseID=COURSE.CourseID
JOIN FACULTY
ON Course_Assignment.FacultyID=FACULTY.FacultyID
WHERE FacultyName='DR. SHETH'
ORDER BY CourseCredits DESC;

--Part – C 
--23.	List all students who are enrolled in more than 3 courses. (STUDENT, ENROLLMENT table)

SELECT STUNAME
FROM STUDENT
WHERE StudentID IN(SELECT StudentID
					from ENROLLMENT
					group BY StudentID
					HAVING COUNT(StudentID)>3);

--24.	Find students who have enrolled in both 'CS101' and 'CS201' Using Sub Query. (STUDENT, ENROLLMENT table)
SELECT STUNAME
FROM STUDENT
WHERE StudentID IN(SELECT StudentID
					FROM ENROLLMENT
					WHERE CourseID='CS101') AND 
					StudentID IN
					(SELECT StudentID
					FROM ENROLLMENT
					WHERE CourseID='CS201');
--25.	Retrieve department-wise count of faculty members along with their average years of experience (calculate experience from JoiningDate). (Faculty table)
SELECT COUNT(FACULTYID) AS TOTAL_FACULTY, FACULTYDEPARTMENT,
AVG(DATEDIFF(YEAR,FacultyJoiningDate,GETDATE()))AS AVERAGE
FROM FACULTY
GROUP BY FacultyDepartment
