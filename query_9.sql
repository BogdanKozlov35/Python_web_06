SELECT
    s.st_name,
    sub.subject
FROM
    students s
JOIN
    grades g  ON g.student_id = s.id
JOIN
    subjects sub ON sub.id = g.subject_id
GROUP BY
    s.st_name,
	sub.subject
ORDER BY
	s.st_name DESC;
