"variant 1"
SELECT
    s.st_name,
    gr.grade
FROM
    students s
JOIN
    grups g ON s.group_id = g.id
JOIN
    grades gr ON s.id = gr.student_id
JOIN
    subjects sub ON gr.subject_id = sub.id
WHERE
    g.gr_name = %s AND
    sub.subject = %s
GROUP BY
    s.st_name,
    gr.grade,
    g.gr_name,
    sub.subject
ORDER BY
    s.st_name;

"variant 2"
SELECT
    s.st_name,
    gr.grade,
    g.gr_name,
	sub.subject
FROM
    students s
JOIN
    grups g ON s.group_id = g.id
JOIN
    grades gr ON s.id = gr.student_id
JOIN
    subjects sub ON gr.subject_id = sub.id
WHERE
    g.gr_name = (
        SELECT gr_name
        FROM grups
        ORDER BY RANDOM()
        LIMIT 1)
         AND
    sub.subject = (
        SELECT subject
        FROM subjects
        ORDER BY RANDOM()
        LIMIT 1)
GROUP BY
    s.st_name,
    gr.grade,
    g.gr_name,
    sub.subject
ORDER BY
    s.st_name;


