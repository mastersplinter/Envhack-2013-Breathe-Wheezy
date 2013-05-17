-- Create the table
DROP TABLE pollution_emissions;
CREATE TABLE pollution_emissions (
OPERATORNAME varchar(500),
MULTIPLIER double precision,
QUANTITYRELEASED double precision,
UNITOFMEASUREDESC varchar(500),
SUBSTANCENAME varchar(500),
RECEIVEDDATE varchar(500),
EASTING bigint,
NORTHING bigint,
ROUTEID int);

-- Add the geometry column
ALTER TABLE pollution_emissions
ADD COLUMN geom GEOMETRY;
UPDATE pollution_emissions
SET geom = ST_SetSRID(ST_MakePoint(EASTING, NORTHING),27700);


-- Create the roll up table against district
DROP TABLE calc_pollution;
CREATE TABLE calc_pollution AS
SELECT 	name AS district_name, 
	SUM(quantityreleased) AS gas_pollution_tonnes,
	a.geom
FROM district_region a
CROSS JOIN pollution_emissions b
WHERE ST_Contains(a.geom, b.geom) = TRUE 
GROUP BY name, a.geom;

-- Join back to get a complete file
DROP TABLE calc_pollution_full;
CREATE TABLE calc_pollution_full AS
SELECT 	a.name AS district_name
	,COALESCE(b.gas_pollution_tonnes, 0) AS gas_pollution_tonnes
	,a.geom
FROM district_region a 
LEFT OUTER JOIN calc_pollution b ON a.name = b.district_name;