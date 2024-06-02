SELECT
    s.st_name,
    ROUND(AVG(g.grade), 2) AS average_grade
FROM
    students s
JOIN
    grades g ON s.id = g.student_id
JOIN
    subjects sub ON g.subject_id = sub.id
WHERE
        sub.subject = (
        SELECT subject
        FROM subjects
        ORDER BY RANDOM()
        LIMIT 1
    )
GROUP BY
    s.id, s.st_name
ORDER BY
    average_grade DESC
LIMIT 1;