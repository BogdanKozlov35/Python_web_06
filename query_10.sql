SELECT
    s.st_name,
    t.teach_name,
    sub.subject AS course
FROM
    students s
JOIN
    grades g ON s.id = g.student_id
JOIN
    subjects sub ON g.subject_id = sub.id
JOIN
    teachers t ON sub.teacher_id = t.id
WHERE
    s.st_name = %s
    AND t.teach_name = %s;