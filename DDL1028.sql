DROP TABLE STUDENT PURGE;

CREATE TABLE STUDENT (
    student_id    INT           PRIMARY KEY,
    name          VARCHAR2(50)  NOT NULL,
    email         VARCHAR2(100) NOT NULL UNIQUE,
    date_of_birth DATE,
    major         VARCHAR2(50)
);

INSERT INTO STUDENT VALUES (2024001001, 'Jennie', 'jennk@tukorea.ac.kr', DATE '2000-05-14', 'IT');
INSERT INTO STUDENT VALUES (2024001002, 'Jisoo',  'jisoo@tukorea.ac.kr', DATE '2001-06-10', 'DS');
INSERT INTO STUDENT VALUES (2024001003, 'Rose',   'rosep@tukorea.ac.kr', DATE '2002-10-01', 'MIS');
INSERT INTO STUDENT VALUES (2024001004, 'Lisa',   'lisa@tukorea.ac.kr',  DATE '2003-11-10', 'CS');

SELECT * FROM STUDENT;
