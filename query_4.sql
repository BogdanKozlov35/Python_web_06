SELECT
    g.gr_name,
    ROUND(AVG(gr.grade), 2) AS average_grade
FROM
    grades gr
JOIN
    students s ON gr.student_id = s.id
JOIN
    grups g ON s.group_id = g.id
GROUP BY
    g.gr_name
ORDER BY
    average_grade DESC;