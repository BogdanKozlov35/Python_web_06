SELECT
	t.teach_name,
	sub.subject
FROM
    teachers t
JOIN
    subjects sub ON t.id = sub.teacher_id
ORDER by
	t.teach_name,
    sub.subject;
