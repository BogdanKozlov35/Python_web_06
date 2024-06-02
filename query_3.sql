SELECT
    sub.subject,
    g.gr_name,
    ROUND(AVG(gr.grade), 2) AS average_grade
FROM
    grades gr
JOIN
    students s ON gr.student_id = s.id
JOIN
    grups g ON s.group_id = g.id
JOIN
    subjects sub ON gr.subject_id = sub.id
GROUP BY
    sub.subject,
    g.gr_name
ORDER BY
    sub.subject,
    average_grade DESC;