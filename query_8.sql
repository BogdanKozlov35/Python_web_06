SELECT
    t.teach_name,
    sub.subject,
    ROUND(AVG(g.grade), 2) AS average_grade
FROM
    teachers t
JOIN
    subjects sub ON t.id = sub.teacher_id
JOIN
    grades g  ON sub.id = g.subject_id
GROUP BY
    t.teach_name,
    sub.subject
ORDER BY
	average_grade DESC;