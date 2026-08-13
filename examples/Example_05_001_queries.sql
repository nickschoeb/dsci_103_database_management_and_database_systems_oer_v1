SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM enrollments;

-- Get courses with enrollments
SELECT
students.CollegeIdNumber AS "College ID #",
students.LastName AS "Last Name",
students.FirstName AS "First Name",
courses.Division AS CourseDivision,
courses.CourseNumber AS CourseNumber,
courses.SectionNumber AS SectionNumber
FROM
enrollments
JOIN students on students.StudentId = enrollments.StudentId
JOIN courses on courses.CourseId = enrollments.CourseId
ORDER BY
CourseDivision DESC,
CourseNumber,
SectionNumber DESC;

-- Get course list with students enrolled by adding distinct
SELECT
DISTINCT
courses.Division AS CourseDivision,
courses.CourseNumber AS CourseNumber,
courses.SectionNumber AS SectionNumber
FROM
enrollments
JOIN students on students.StudentId = enrollments.StudentId
JOIN courses on courses.CourseId = enrollments.CourseId
ORDER BY
CourseDivision,
CourseNumber,
SectionNumber;

-- Another way
SELECT
DISTINCT
courses.Division AS CourseDivision,
courses.CourseNumber AS CourseNumber,
courses.SectionNumber AS SectionNumber
FROM courses
LEFT JOIN enrollments ON enrollments.CourseId = courses.CourseId
WHERE enrollments.CourseId IS NOT NULL;

-- Get courses with no enrollments
SELECT
DISTINCT
courses.Division AS CourseDivision,
courses.CourseNumber AS CourseNumber,
courses.SectionNumber AS SectionNumber
FROM courses
LEFT JOIN enrollments ON enrollments.CourseId = courses.CourseId
WHERE enrollments.CourseId IS NULL;
