-- Nuestras bases de datos son schemas, para crear un nuevo schema:
-- drop schema university;
drop schema if exists university;
create schema university;

-- Para evitar tener que establecer el schema cada vez que hacemos una query
use university;

-- Tabla course
CREATE TABLE course(
	course_code VARCHAR(6) NOT NULL,
    course_name VARCHAR(255),
    PRIMARY KEY (course_code)
    );
    
-- Tabla Section
CREATE TABLE section(
	id VARCHAR(8) NOT NULL,
    course_code VARCHAR(6),
    room_number INT,
    professor VARCHAR(255),
    PRIMARY KEY (id),
    FOREIGN KEY (course_code) REFERENCES course(course_code)
	);
    
CREATE TABLE grades(
	id INT NOT NULL AUTO_INCREMENT,
    student_name VARCHAR(255),
    section_id VARCHAR(8),
    score INT,
    PRIMARY KEY (id),
    FOREIGN KEY (section_id) REFERENCES section(id)
		);
        
INSERT INTO course VALUES
	('CS101', 'Intro to Java'),
	('CS103', 'Databases');

INSERT INTO section (id, course_code, room_number, professor) VALUES
	('CS101-A', 'CS101', 1802, 'Balderez'),
	('CS101-B', 'CS101',  1650, 'Su'),
	('CS103-A', 'CS103',  1200, 'Rojas'),
	('CS103-B', 'CS103',  1208, 'Tonno');
    
INSERT INTO grades (student_name, section_id, score) VALUES
	('Maya Charlotte', 'CS101-A', 98),
	('James Fields', 'CS101-A', 82),
	('Michael Alcocer', 'CS101-B', 65),
	('Maya Charlotte', 'CS103-A', 89),
	('Tomas Lacroix', 'CS101-A', 99),
	('Sara Bisat', 'CS101-A', 87),
	('James Fields', 'CS101-B', 46),
	('Helena Sepulvida', 'CS103-A', 72);
    
select * from grades;

-- contar datos
select section_id, count(*) from grades group by section_id;

-- calcular la media
select section_id, avg(score) from grades group by section_id;

-- filtrar datos
select section_id, avg(score) from grades group by section_id having avg(score) > 80;

-- filtrar usando where
select * from grades where score < 60;

select * from grades where student_name LIKE '%S%';

-- ejercicios de clase

/*
Use aggregation functions to find:

1. the average grade by student.
2. the total number of courses taken by each student
3. the minimum grade by section
4. the maximum grade by section
5. the total number of courses taken by a student who has more than 1 course taken
*/

-- 1
select student_name as Student, AVG(score) AS Average from grades group by student_name;

-- 2
select student_name, COUNT(section_id) AS "# of courses" from grades group by student_name;

-- 3 
select section_id, MIN(score) AS "Min score" from grades group by section_id;

-- 4

select section_id, MAX(score) AS "Max score" from grades group by section_id;

-- 5
select student_name, COUNT(section_id) AS "# of courses" from grades group by student_name having COUNT(section_id) > 1;

-- LIKE: No exacto pero sí se cumple algún criterio

SELECT * FROM grades WHERE section_id LIKE '%-A';

-- BETWEEN: Un rango de datos
SELECT * FROM grades where score BETWEEN 80 AND 90 OR student_name LIKE "%om%";
SELECT distinct student_name FROM grades where student_name BETWEEN 'L' AND 'R';

-- DISTINCT: nos muestra una sola muestra del dato, no los repetidos

select distinct student_name from grades;

select distinct student_name, score from grades;

-- ORDER BY: para ordenar

select student_name, score from grades ORDER BY score DESC;

select * from grades;



SELECT student_name, score, professor FROM grades LEFT JOIN section ON grades.section_id = section.id;

SELECT g.student_name, g.score FROM grades g 
JOIN section s ON g.section_id = s.id
JOIN course ON s.course_code = course.course_code WHERE course_name = "Databases";








    
    

