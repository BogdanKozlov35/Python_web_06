select
	s.st_name,
	g.gr_name
FROM
    students s
JOIN
    grups g on s.group_id = g.id
ORDER by
	g.gr_name