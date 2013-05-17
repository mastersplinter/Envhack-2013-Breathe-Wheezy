-- Create the geom column for EPI data

ALTER TABLE pollution_incidents
ADD COLUMN geom GEOMETRY;

UPDATE pollution_incidents
SET geom = ST_SetSRID(ST_MakePoint(x_conf, y_conf),27700);



