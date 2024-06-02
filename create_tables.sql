DROP TABLE IF EXISTS grups;
CREATE TABLE grups (
    id INT PRIMARY KEY,
    gr_name VARCHAR(50)
    	on delete cascade
);

DROP TABLE IF EXISTS students;
CREATE TABLE students (
    id INT PRIMARY KEY,
    st_name VARCHAR(50) NOT NULL,
    group_id INT,
    FOREIGN KEY (group_id) REFERENCES grups (id)
    	on delete cascade
);

DROP TABLE IF EXISTS teachers;
CREATE TABLE teachers (
    id INT PRIMARY KEY,
    teach_name VARCHAR(50)
    	on delete cascade
);

DROP TABLE IF EXISTS subjects;
CREATE TABLE subjects (
    id INT PRIMARY KEY,
    subject VARCHAR(50),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers (id)
    	on delete cascade
);

DROP TABLE IF EXISTS grades;
CREATE TABLE grades (
    id INT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    grade INT CHECK (grade >= 0 AND grade <= 100),
    grade_date DATE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students (id),
    FOREIGN KEY (subject_id) REFERENCES subjects (id)
    	on delete cascade
);