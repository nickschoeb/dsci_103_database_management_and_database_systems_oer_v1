-- Many to Many Relationship
CREATE TABLE Students (
    StudentId INT GENERATED ALWAYS AS IDENTITY  PRIMARY KEY,
    CollegeIdNumber VARCHAR(255),
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255) NOT NULL
);

CREATE TABLE Courses (
    CourseId INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    CourseName VARCHAR(255) NOT NULL,
    Division VARCHAR(4) NOT NULL,
    CourseNumber INT NOT NULL,
    SectionNumber INT NOT NULL
);

-- Create the "linking" table
CREATE TABLE Enrollments (
    StudentId INT,
    CourseId INT,
    PRIMARY KEY (StudentId, CourseId),
    CONSTRAINT FK_StudentId FOREIGN KEY (StudentId) REFERENCES Students(StudentId),
    CONSTRAINT FK_CourseId FOREIGN KEY (CourseId) REFERENCES Courses(CourseId)
);

-- DATA
INSERT INTO students (CollegeIdNumber, LastName, FirstName) VALUES
('H009123456', 'Bergstrom', 'Deanna'),
('H008654321', 'Kemmer', 'Marcos'),
('H005754658', 'Yost', 'Jaycee'),
('H004183745', 'Larkin', 'Carlos'),
('H003387684', 'Strosin', 'Alvena');

INSERT INTO courses (CourseName, Division, CourseNumber, SectionNumber) VALUES
('Fundamentals of Programming', 'CIS', 115, 1),
('Fundamentals of Programming', 'CIS', 115, 2),
('Fundamentals of Programming', 'CIS', 115, 3),
('Databases', 'DSCI', 103, 1),
('English 101', 'ENG', 101, 1),
('English 101', 'ENG', 101, 2),
('English 101', 'ENG', 101, 3);

INSERT INTO enrollments (StudentId, CourseId) VALUES

((SELECT StudentId FROM students where CollegeIdNumber = 'H009123456'),
(SELECT CourseId FROM courses where Division = 'CIS' AND
CourseNumber = 115 AND
SectionNumber = 1)),

((SELECT StudentId FROM students where CollegeIdNumber = 'H005754658'),
(SELECT CourseId FROM courses where Division = 'CIS' AND
CourseNumber = 115 AND
SectionNumber = 2)),

((SELECT StudentId FROM students where CollegeIdNumber = 'H004183745'),
(SELECT CourseId FROM courses where Division = 'CIS' AND
CourseNumber = 115 AND
SectionNumber = 3)),

((SELECT StudentId FROM students where CollegeIdNumber = 'H005754658'),
(SELECT CourseId FROM courses where Division = 'DSCI' AND
CourseNumber = 103 AND
SectionNumber = 1)),

((SELECT StudentId FROM students where CollegeIdNumber = 'H004183745'),
(SELECT CourseId FROM courses where Division = 'DSCI' AND
CourseNumber = 103 AND
SectionNumber = 1)),

((SELECT StudentId FROM students where CollegeIdNumber = 'H005754658'),
(SELECT CourseId FROM courses where Division = 'ENG' AND
CourseNumber = 101 AND
SectionNumber = 2)),

((SELECT StudentId FROM students where CollegeIdNumber = 'H004183745'),
(SELECT CourseId FROM courses where Division = 'ENG' AND
CourseNumber = 101 AND
SectionNumber = 2));
