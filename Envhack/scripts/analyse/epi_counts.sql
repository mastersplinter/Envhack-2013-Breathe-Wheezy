DROP TABLE calc_EPIs;

CREATE TABLE calc_EPIs AS
SELECT 	identifi0,
	name AS district_name, 
	COUNT(*) AS count_of_incidents, 
	(COUNT(*)/ST_Area(a.geom)) AS count_of_incidents_by_area, 
	a.geom
FROM district_region a
CROSS JOIN pollution_incidents b
WHERE ST_Contains(a.geom, b.geom) = TRUE 
GROUP BY identifi0, name, a.geom;