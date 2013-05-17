DROP TABLE post_code_master;

CREATE TABLE post_code_master (
	postcode character varying (12) NOT NULL,
	easting bigint,
	northing bigint,
	CONSTRAINT post_code_pk PRIMARY KEY (postcode));

ALTER TABLE post_code_master
ADD COLUMN geom GEOMETRY;

UPDATE post_code_master
SET geom =  ST_SetSRID(ST_MakePoint(easting, northing),27700);