DROP DATABASE IF EXISTS school_management;
CREATE DATABASE school_management;
USE school_management;

-- 1. TABLES (12 TOTAL)
-- --------------------------------------------------------

CREATE TABLE department (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(100) NOT NULL,
    head_of_dept VARCHAR(255)
);

CREATE TABLE teacher (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

CREATE TABLE classroom (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(10) NOT NULL,
    building_name VARCHAR(50),
    capacity INT
);

CREATE TABLE course (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(255) NOT NULL,
    credits INT DEFAULT 3,
    teacher_id INT,
    room_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id),
    FOREIGN KEY (room_id) REFERENCES classroom(room_id)
);

CREATE TABLE parent (
    parent_id INT PRIMARY KEY AUTO_INCREMENT,
    parent_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    email VARCHAR(255)
);

CREATE TABLE student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    dob DATE,
    parent_id INT,
    city VARCHAR(100),
    FOREIGN KEY (parent_id) REFERENCES parent(parent_id)
);

CREATE TABLE enrollment (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    semester VARCHAR(20),
    academic_year INT,
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    attendance_date DATE NOT NULL,
    status ENUM('Present', 'Absent', 'Late', 'Excused') NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

CREATE TABLE assessment_type (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50)
);

CREATE TABLE assessment (
    assessment_id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    type_id INT,
    assessment_name VARCHAR(255),
    max_marks DECIMAL(5,2),
    weightage_percent DECIMAL(5,2),
    FOREIGN KEY (course_id) REFERENCES course(course_id),
    FOREIGN KEY (type_id) REFERENCES assessment_type(type_id)
);

CREATE TABLE grade (
    grade_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    assessment_id INT,
    marks_obtained DECIMAL(5,2),
    feedback TEXT,
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (assessment_id) REFERENCES assessment(assessment_id)
);

CREATE TABLE activity (
    activity_id INT PRIMARY KEY AUTO_INCREMENT,
    activity_name VARCHAR(100),
    coach_name VARCHAR(100)
);

CREATE TABLE student_activity (
    student_id INT,
    activity_id INT,
    join_date DATE,
    PRIMARY KEY (student_id, activity_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (activity_id) REFERENCES activity(activity_id)
);

-- 2. DATA INSERTION (SEQUENCED TO AVOID FK ERRORS)
-- --------------------------------------------------------

-- Insert Parents (35 rows)
INSERT INTO parent (parent_name, phone_number) VALUES 
('Raj Sharma', '9000000001'), ('Sita Singh', '9000000002'), ('Amit Gupta', '9000000003'), ('Suresh Nair', '9000000004'), ('Meena Kapoor', '9000000005'),
('Vikram Verma', '9000000006'), ('Kavita Kulkarni', '9000000007'), ('Rahul Bajaj', '9000000008'), ('Priya Jain', '9000000009'), ('Deepak Bhatia', '9000000010'),
('Anil Joshi', '9000000011'), ('Sunita Rao', '9000000012'), ('Ravi Malhotra', '9000000013'), ('Geeta Patel', '9000000014'), ('Arun Saxena', '9000000015'),
('Vijay Wilson', '9000000016'), ('Maya Brown', '9000000017'), ('Sanjay Taylor', '9000000018'), ('Ritu Anderson', '9000000019'), ('Kiran Thomas', '9000000020'),
('Alok Jackson', '9000000021'), ('Nisha White', '9000000022'), ('Pankaj Harris', '9000000023'), ('Sneha Martin', '9000000024'), ('Varun Thompson', '9000000025'),
('Rekha Garcia', '9000000026'), ('Manoj Martinez', '9000000027'), ('Anita Robinson', '9000000028'), ('Rajesh Clark', '9000000029'), ('Pooja Rodriguez', '9000000030'),
('Mohit Lewis', '9000000031'), ('Swati Lee', '9000000032'), ('Gaurav Walker', '9000000033'), ('Indu Hall', '9000000034'), ('Tushar Allen', '9000000035');

-- Insert Students (35 rows)
INSERT INTO student (first_name, last_name, email, parent_id, city) VALUES 
('Aarav', 'Sharma', 's1@edu.com', 1, 'Delhi'), ('Ananya', 'Singh', 's2@edu.com', 2, 'Mumbai'), ('Vivaan', 'Gupta', 's3@edu.com', 3, 'Bangalore'),
('Ishaan', 'Nair', 's4@edu.com', 4, 'Mumbai'), ('Myra', 'Kapoor', 's5@edu.com', 5, 'Pune'), ('Aditi', 'Verma', 's6@edu.com', 6, 'Kolkata'),
('Advait', 'Kulkarni', 's7@edu.com', 7, 'Pune'), ('Kiara', 'Bajaj', 's8@edu.com', 8, 'Hyderabad'), ('Saanvi', 'Jain', 's9@edu.com', 9, 'Chennai'),
('Atharv', 'Bhatia', 's10@edu.com', 10, 'Delhi'), ('Tanya', 'Joshi', 's11@edu.com', 11, 'Hyderabad'), ('Aryan', 'Rao', 's12@edu.com', 12, 'Chennai'),
('Zara', 'Malhotra', 's13@edu.com', 13, 'Jaipur'), ('Reyansh', 'Patel', 's14@edu.com', 14, 'Jaipur'), ('Avni', 'Saxena', 's15@edu.com', 15, 'Pune'),
('Liam', 'Wilson', 's16@edu.com', 16, 'Delhi'), ('Noah', 'Brown', 's17@edu.com', 17, 'Bangalore'), ('Oliver', 'Taylor', 's18@edu.com', 18, 'Mumbai'),
('Elijah', 'Anderson', 's19@edu.com', 19, 'Kolkata'), ('James', 'Thomas', 's20@edu.com', 20, 'Hyderabad'), ('William', 'Jackson', 's21@edu.com', 21, 'Chennai'),
('Benjamin', 'White', 's22@edu.com', 22, 'Mumbai'), ('Lucas', 'Harris', 's23@edu.com', 23, 'Delhi'), ('Henry', 'Martin', 's24@edu.com', 24, 'Pune'),
('Alexander', 'Thompson', 's25@edu.com', 25, 'Jaipur'), ('Sebastian', 'Garcia', 's26@edu.com', 26, 'Gurgaon'), ('Jack', 'Martinez', 's27@edu.com', 27, 'Noida'),
('Samuel', 'Robinson', 's28@edu.com', 28, 'Bangalore'), ('Daniel', 'Clark', 's29@edu.com', 29, 'Kolkata'), ('Matthew', 'Rodriguez', 's30@edu.com', 30, 'Mumbai'),
('Jackson', 'Lewis', 's31@edu.com', 31, 'Hyderabad'), ('David', 'Lee', 's32@edu.com', 32, 'Chennai'), ('Joseph', 'Walker', 's33@edu.com', 33, 'Pune'),
('Carter', 'Hall', 's34@edu.com', 34, 'Jaipur'), ('Owen', 'Allen', 's35@edu.com', 35, 'Delhi');


-- Insert Activities (18 rows total)
INSERT INTO activity (activity_name, coach_name) VALUES 
('Soccer', 'Coach Mike'), ('Chess', 'Grandmaster Lev'), ('Drama', 'Ms. Streep'),
('Robotics Club', 'Mr. Stark'), ('Swimming', 'Coach Phelps'), ('Journalism', 'Ms. Lane'),
('Art & Painting', 'Mr. Ross'), ('Cricket', 'Coach Dravid'), ('Tennis', 'Coach Serena'),
('Volleyball', 'Coach Walsh'), ('Coding Titans', 'Mr. Gates'), ('Debate Society', 'Ms. Cicero'),
('Yoga & Wellness', 'Guru Singh'), ('Photography', 'Mr. Parker'), ('Astronomy Club', 'Dr. Sagan'),
('Music Band', 'Mr. Mercury'), ('Environmental Club', 'Ms. Thunberg'), ('Table Tennis', 'Coach Zhang');

-- Insert Student Activity Participation (40+ rows)
SET SQL_SAFE_UPDATES = 0;
DELETE FROM student_activity;
INSERT INTO student_activity (student_id, activity_id, join_date) VALUES 
(1, 1, '2026-01-01'), (1, 4, '2026-01-01'), (2, 2, '2026-01-01'), (2, 5, '2026-01-01'), 
(3, 3, '2026-01-01'), (3, 6, '2026-01-01'), (4, 4, '2026-01-01'), (4, 7, '2026-01-01'), 
(5, 5, '2026-01-01'), (5, 8, '2026-01-01'), (6, 6, '2026-01-01'), (6, 9, '2026-01-01'), 
(7, 7, '2026-01-01'), (7, 10, '2026-01-01'), (8, 8, '2026-01-01'), (8, 11, '2026-01-01'), 
(9, 9, '2026-01-01'), (9, 12, '2026-01-01'), (10, 10, '2026-01-01'), (10, 13, '2026-01-01'), 
(11, 11, '2026-01-01'), (11, 14, '2026-01-01'), (12, 12, '2026-01-01'), (12, 15, '2026-01-01'), 
(13, 13, '2026-01-01'), (13, 16, '2026-01-01'), (14, 14, '2026-01-01'), (14, 17, '2026-01-01'), 
(15, 15, '2026-01-01'), (15, 18, '2026-01-01'), (16, 1, '2026-01-01'), (17, 2, '2026-01-01'), 
(18, 3, '2026-01-01'), (19, 4, '2026-01-01'), (20, 5, '2026-01-01'), (21, 6, '2026-01-01'), 
(22, 7, '2026-01-01'), (23, 8, '2026-01-01'), (24, 9, '2026-01-01'), (25, 10, '2026-01-01'), 
(26, 11, '2026-01-01'), (27, 12, '2026-01-01'), (28, 13, '2026-01-01'), (29, 14, '2026-01-01'), 
(30, 15, '2026-01-01'), (31, 16, '2026-01-01'), (32, 17, '2026-01-01'), (33, 18, '2026-01-01'), 
(34, 1, '2026-01-01'), (35, 2, '2026-01-01');

-- 4. Turn Safe Updates back ON (Best Practice)
SET SQL_SAFE_UPDATES = 1;

-- Insert Departments, Teachers, Classrooms, Courses
INSERT INTO department (dept_name, head_of_dept) VALUES ('Computer Science', 'Dr. Turing'), ('Mathematics', 'Dr. Gauss'), ('Arts & Humanities', 'Prof. DaVinci');
INSERT INTO teacher (first_name, last_name, email, dept_id) VALUES ('John', 'Smith', 'js@edu.com', 1), ('Maria', 'Garcia', 'mg@edu.com', 2), ('Robert', 'Brown', 'rb@edu.com', 3);
INSERT INTO classroom (room_number, building_name, capacity) VALUES ('101', 'Science Block', 40), ('202', 'Math Wing', 30), ('Auditorium', 'Main Hall', 200);
INSERT INTO course (course_name, credits, teacher_id, room_id) VALUES ('Databases', 4, 1, 1), ('Calculus', 3, 2, 2), ('Art History', 2, 3, 3);

-- Insert Enrollments
INSERT INTO enrollment (student_id, course_id, semester, academic_year)
SELECT student_id, 1, 'Spring', 2026 FROM student WHERE student_id <= 25;

-- Insert Attendance
INSERT INTO attendance (student_id, course_id, attendance_date, status) VALUES 
(1, 1, '2026-03-24', 'Present'), (2, 1, '2026-03-24', 'Present'), (3, 1, '2026-03-24', 'Present'), (4, 1, '2026-03-24', 'Absent'), (5, 1, '2026-03-24', 'Present'),
(6, 1, '2026-03-24', 'Late'), (7, 1, '2026-03-24', 'Present'), (8, 1, '2026-03-24', 'Present'), (9, 1, '2026-03-24', 'Present'), (10, 1, '2026-03-24', 'Present'),
(1, 1, '2026-03-25', 'Present'), (2, 1, '2026-03-25', 'Absent'), (3, 1, '2026-03-25', 'Present'), (4, 1, '2026-03-25', 'Present'), (5, 1, '2026-03-25', 'Present');

-- Insert Assessment Types & Assessments
INSERT INTO assessment_type (type_name) VALUES ('Quiz'), ('Midterm'), ('Final Exam'), ('Lab Report');
INSERT INTO assessment (course_id, type_id, assessment_name, max_marks, weightage_percent) VALUES 
(1, 2, 'SQL Midterm', 100, 30), (1, 3, 'SQL Final', 100, 50), (2, 2, 'Calc Midterm', 100, 40);

-- Insert Grades
INSERT INTO grade (student_id, assessment_id, marks_obtained, feedback) VALUES 
(1, 1, 85, 'Good'), (2, 1, 70, 'Fair'), (3, 1, 95, 'Excel'), (4, 1, 60, 'Review'), (5, 1, 88, 'Good'),
(6, 1, 77, 'Good'), (7, 1, 82, 'Solid'), (8, 1, 91, 'Great'), (9, 1, 44, 'Alert'), (10, 1, 80, 'Good'),
(1, 2, 88, 'Great'), (2, 2, 75, 'Imprv'), (3, 2, 98, 'Best'), (4, 2, 65, 'Fair'), (5, 2, 82, 'Good');




-- Question 1 - 

SELECT s.first_name, COUNT(DISTINCT sa.activity_id) AS total_activities, ROUND(AVG(g.marks_obtained),2) AS avg_marks FROM student s
LEFT JOIN student_activity sa ON s.student_id = sa.student_id
LEFT JOIN grade g ON s.student_id = g.student_id
GROUP BY s.student_id, s.first_name
ORDER BY total_activities DESC;




-- Question 2

SELECT at.type_name AS category, COUNT(*) AS Total_assessment, SUM(g.marks_obtained < 50) AS failure_count 
FROM assessment_type at
JOIN assessment a ON at.type_id = a.type_id
JOIN grade g ON a.assessment_id = g.assessment_id
GROUP BY at.type_name;





-- Question 3

SELECT s.student_id, CONCAT(s.first_name, ' ', s.last_name) AS name, COUNT(*) AS total, SUM(a.status = 'Present') AS present,
ROUND(SUM(a.status = 'Present') * 100 / COUNT(*), 2) AS attendance, ROUND(AVG(g.marks_obtained), 2) AS avg_marks FROM student s
JOIN attendance a USING(student_id)
LEFT JOIN grade g USING(student_id)
GROUP BY s.student_id
ORDER BY attendance DESC, avg_marks DESC;





-- Question 4

SELECT d.dept_name AS department, COUNT(DISTINCT t.teacher_id) AS total_teachers,
SUM(DISTINCT c.credits) AS total_credits_offered, ROUND(AVG(g.marks_obtained), 2) AS avg_dept_performance
FROM department d
JOIN teacher t ON d.dept_id = t.dept_id
JOIN course c ON t.teacher_id = c.teacher_id
JOIN assessment a ON c.course_id = a.course_id
JOIN grade g ON a.assessment_id = g.assessment_id
GROUP BY d.dept_name ORDER BY avg_dept_performance DESC;




-- Question 5

SELECT CONCAT(s.first_name, ' ', s.last_name) AS student_name, p.parent_name, p.phone_number AS parent_contact,
COUNT(att.attendance_id) AS total_classes, ROUND(SUM(att.status = 'Present') * 100 / COUNT(att.attendance_id), 2) AS attendance_pct,
ROUND(AVG(g.marks_obtained), 2) AS avg_grade FROM student s
JOIN parent p ON s.parent_id = p.parent_id
JOIN attendance att ON s.student_id = att.student_id
JOIN grade g ON s.student_id = g.student_id
GROUP BY s.student_id, s.first_name, p.parent_name, p.phone_number
HAVING attendance_pct < 75 OR avg_grade < 75 ORDER BY avg_grade ASC;






-- Question 6

SELECT s.student_id, CONCAT(s.first_name, ' ', s.last_name) AS student_name, COUNT(a.attendance_id) AS total_occurrences, 
SUM(a.status = 'Late') AS times_late, SUM(a.status = 'Absent') AS times_absent, ROUND(AVG(g.marks_obtained), 2) AS avg_marks FROM student s
JOIN attendance a ON s.student_id = a.student_id
LEFT JOIN grade g ON s.student_id = g.student_id
GROUP BY  s.student_id, s.first_name, s.last_name
ORDER BY times_late DESC, avg_marks ASC;






-- Question 7 

SELECT c.course_name, COUNT(g.grade_id) AS total_graded_items, ROUND(AVG(g.marks_obtained), 2) AS average_marks FROM course c
JOIN assessment a ON c.course_id = a.course_id
JOIN grade g ON a.assessment_id = g.assessment_id
GROUP BY c.course_name ORDER BY average_marks DESC;






-- Question 8

 SELECT at.type_name AS assessment_category, a.weightage_percent, ROUND(AVG(g.marks_obtained), 2) AS average_score FROM assessment_type at
JOIN assessment a ON at.type_id = a.type_id
JOIN grade g ON a.assessment_id = g.assessment_id
GROUP BY at.type_name, a.weightage_percent 
ORDER BY a.weightage_percent DESC;





-- Question 9

SELECT c.credits, ROUND(AVG(g.marks_obtained), 2) AS avg_marks, COUNT(a.status) AS total_attendance_records FROM course c
JOIN grade g ON c.course_id = g.assessment_id
LEFT JOIN attendance a ON g.student_id = a.student_id
GROUP BY c.credits;
  
  
  

-- Question 10

SELECT first_name, last_name, ROUND(AVG(marks_obtained),2) AS avg_score FROM student s
JOIN grade g ON s.student_id = g.student_id
GROUP BY s.student_id, first_name, last_name
ORDER BY avg_score DESC LIMIT 5;





-- Sprint 1 
-- 1
SELECT student_id, marks_obtained, NOW() AS report_time FROM grade
WHERE marks_obtained >= 75;


-- 2
SELECT SUBSTR(first_name, 1, 4) AS short_id, student_id FROM student
WHERE student_id > 5;



-- Sprint 2
-- 1
SELECT s.first_name, g.marks_obtained FROM student s
INNER JOIN grade g ON s.student_id = g.student_id
ORDER BY g.marks_obtained DESC;


-- 2
SELECT s.first_name, a.status FROM student s
LEFT JOIN attendance a ON s.student_id = a.student_id
ORDER BY s.first_name ASC;



-- Sprint 3
-- 1
SELECT d.dept_name, ROUND(AVG(g.marks_obtained), 2) AS average_score,
COUNT(g.grade_id) AS total_exams FROM department d
JOIN teacher t ON d.dept_id = t.dept_id
JOIN course c ON t.teacher_id = c.teacher_id
JOIN assessment a ON c.course_id = a.course_id
JOIN grade g ON a.assessment_id = g.assessment_id
GROUP BY d.dept_name
ORDER BY average_score DESC;


-- 2
SELECT s.first_name, COUNT(a.attendance_id) AS classes_attended FROM student s
JOIN attendance a ON s.student_id = a.student_id
GROUP BY s.first_name
HAVING classes_attended < 5;



-- Sprint 4
-- 1
SELECT first_name, marks_obtained FROM student s
JOIN grade g ON s.student_id = g.student_id
WHERE marks_obtained > (SELECT AVG(marks_obtained) FROM grade);


-- 2
SELECT s.first_name, (SELECT COUNT(*) FROM attendance a 
  WHERE a.student_id = s.student_id AND a.status = 'Present') AS days_present
  FROM student s;


-- Sprint 5
-- 1
-- INSERT: Adding a new student
INSERT INTO student (first_name, last_name, email, dob, parent_id, city) 
VALUES ('Arjun', 'Reddy', 'arjun.reddy@example.com', '2005-06-15', 1, 'Hyderabad');
-- UPDATE: Correcting an attendance record
UPDATE attendance SET status = 'Present' 
WHERE student_id = 1 AND attendance_date = '2026-03-28';
-- Delete dependent records
DELETE FROM attendance WHERE student_id = 10;
DELETE FROM grade WHERE student_id = 10;
DELETE FROM enrollment WHERE student_id = 10;
DELETE FROM student_activity WHERE student_id = 10;
 -- DELETE: Removing a student who left
DELETE FROM student WHERE student_id = 10;


-- 2
CREATE INDEX idx_student_email ON student(email);




-- Sprint 6
-- 1
/* Mapping the Tracker (ER Diagrams & Relationships)
Question: If we want to add a "Course" feature to our tracker, how do we illustrate the relationship between a Student (Entity) and a Course (Entity) in an ER diagram? How does this translate into a table structure using Primary and Foreign Keys?

Answer:
Entities: Student (Attributes: student_id, name) and Course (Attributes: course_id, title).
Relationship: One student can enroll in many courses, and one course can have many students (Many-to-Many).
Translation: To handle this in a relational database, we create a "Junction Table" called enrollment that holds the Foreign Keys from both tables. */


-- 2
/* 2. Database Cleanup (Normalization & Redundancy)
Question: In our current tracker, if we store the parent_phone and parent_address directly in the student table for every student, it causes redundancy if two siblings share the same parent. How do we apply Normalization to refine this structure?

Answer:
Identifying Redundancy: Storing the same parent info multiple times wastes space and leads to "Update Anomalies" (if the phone number changes, you have to update it in multiple rows).
Normalization (1NF to 3NF): We move the parent details into a separate parent table.
Integrity: We then link them using a parent_id in the student table. This ensures Consistency because the parent's info exists in only one place. */



-- Sprint 7
-- 1
CREATE TABLE exam_results (
    result_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    email VARCHAR(100) UNIQUE,
    score INT CHECK (score >= 0 AND score <= 100));
-- ALTER to modify the schema
ALTER TABLE exam_results ADD COLUMN feedback TEXT;


-- 2
-- Create a Role or User for the teacher
CREATE USER 'teacher_user'@'localhost' IDENTIFIED BY 'password123';
-- Assign specific permissions
GRANT SELECT, UPDATE ON exam_results TO 'teacher_user'@'localhost';




-- Sprint 8
-- 1
-- Lock the table so no one else can edit during this process
LOCK TABLES grade WRITE;

START TRANSACTION;
-- Set a point to return to if the mark is wrong
SAVEPOINT pre_update;

-- Try updating a grade
UPDATE grade SET marks_obtained = 95 WHERE student_id = 1;

-- If you realize you updated the wrong student, undo it!
ROLLBACK TO pre_update;

-- If everything is correct, save it forever and unlock
COMMIT;
UNLOCK TABLES;



-- 2
-- CREATE TEMPORARY TABLE: Disappears when you close the session
CREATE TEMPORARY TABLE todays_absentees AS
SELECT student_id FROM attendance 
WHERE status = 'Absent' AND attendance_date = CURDATE();

-- CREATE VIEW: A permanent dashboard for the Principal
CREATE VIEW performance_dashboard AS
SELECT s.first_name, AVG(g.marks_obtained) AS avg_mark
FROM student s
JOIN grade g ON s.student_id = g.student_id
GROUP BY s.first_name;



-- Sprint 9
-- 1
DELIMITER //

CREATE TRIGGER GradeChangeAudit
BEFORE UPDATE ON grade
FOR EACH ROW
BEGIN
    -- Error Handling: Prevent negative marks
    IF NEW.marks_obtained < 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: Marks cannot be negative!';
    END IF;

    -- Automated Response: Log the change
    INSERT INTO security_log (student_id, old_score, new_score, log_time)
    VALUES (OLD.student_id, OLD.marks_obtained, NEW.marks_obtained, NOW());
END //

DELIMITER ;



-- 2
DELIMITER //
CREATE PROCEDURE GetStudentProfile(IN s_id INT)
BEGIN
    SELECT first_name, last_name, email FROM student WHERE student_id = s_id;
END //
DELIMITER ;

-- Scheduled Task (Event): Runs automatically
CREATE EVENT WeeklyCleanup
ON SCHEDULE EVERY 1 WEEK
STARTS '2026-03-29 00:00:00'
DO
    DELETE FROM temporary_logs WHERE log_date < NOW() - INTERVAL 7 DAY;



-- Sprint 10
-- 1
-- Creating a table that uses JSON for flexible attributes
CREATE TABLE student_extras (
    student_id INT PRIMARY KEY,
    hobby_data JSON
);

-- Inserting unstructured data
INSERT INTO student_extras (student_id, hobby_data) 
VALUES (1, '{"hobby": "Music", "instrument": "Guitar", "level": "Intermediate"}');

-- Retrieving specific data from the JSON
SELECT hobby_data->>"$.hobby" AS student_hobby 
FROM student_extras;


-- 2
/* Question: How can we use NoSQL-like operations to retrieve a student's flexible "hobby" document without writing traditional SQL SELECT statements, and in what scenario would we use this XDevAPI approach?

Answer (XDevAPI Concept):
The Logic: Instead of standard SQL, you treat your table like a "Collection."
The Operation: You would use a command like db.student_extras.find('student_id == 1').
Use Case: This is best when your tracker needs to connect to a modern web or mobile app where the developers prefer working with JavaScript/JSON objects rather than table rows. */




-- Questions
-- 11
CREATE VIEW LowAttendance AS SELECT student_id,
COUNT(attendance_id) AS total_days FROM attendance
GROUP BY student_id HAVING total_days < 5;


-- 12
CREATE TRIGGER AfterGradeInsert AFTER INSERT ON grade FOR EACH ROW
INSERT INTO logs (message) VALUES ('New performance data added');


-- 13
ALTER TABLE student ADD COLUMN email VARCHAR(100);


-- 14
SHOW TRIGGERS;
START TRANSACTION;
SAVEPOINT BeforeUpdate;
UPDATE grade SET marks_obtained = 90 WHERE student_id = 1;
-- If mistake happens:
ROLLBACK TO BeforeUpdate;
-- If correct:
COMMIT;



-- 15
START TRANSACTION;
DELETE FROM attendance 
WHERE attendance_id > 0;
ROLLBACK;      -- This restores all deleted data


-- 16
START TRANSACTION;
INSERT INTO attendance (student_id, course_id, attendance_date, status) 
VALUES (1, 1, '2026-03-30', 'Present');
COMMIT; -- This saves the data forever


-- 17
CREATE VIEW ParentReport AS
SELECT s.first_name, AVG(g.marks_obtained) AS avg_performance FROM student s
JOIN grade g ON s.student_id = g.student_id
GROUP BY s.first_name;


-- 18
CREATE TEMPORARY TABLE DailyAbsentees AS
SELECT student_id FROM attendance 
WHERE status = 'Absent' AND attendance_date = CURDATE();


-- 19
START TRANSACTION;
INSERT INTO attendance (student_id, course_id, attendance_date, status) 
VALUES (1, 1, '2026-03-30', 'Present');
COMMIT;


-- 20
LOCK TABLES grade READ, student READ;
START TRANSACTION;
CREATE OR REPLACE VIEW FinalReview AS 
SELECT s.first_name, g.marks_obtained FROM student s 
JOIN grade g ON s.student_id = g.student_id;
UNLOCK TABLES;

