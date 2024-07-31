/*
	Build a Student Database - Part 1
*/
--connect to postgres
psql --username=freecodecamp --dbname=postgres

--DATA SETUP
--majors
INSERT INTO majors (major) VALUES ('Database Administration');

--courses
INSERT INTO courses (course) VALUES ('Data Structures and Algorithms');

--junction => majors_courses
INSERT INTO majors_courses (major_id, course_id) VALUES (1,1);

--students

INSERT INTO students (first_name, last_name, major_id, gpa) VALUES ('Rhea','Kellems',1,2.5);