--DROP TABLE prescriptionsBlueInhalers;

CREATE TABLE prescriptionsBlueInhalers AS
SELECT 	prescriptions.sha, 
	prescriptions.pct, 
	prescriptions.practice_ref, 
	prescriptions.bnf_code, 
	prescriptions.bnf_name, 
	prescriptions.items, 
	prescriptions.nic, 
	prescriptions.act_cost, 
	prescriptions.period, 
	prescriptions.filename,
	post_code_master.geom
FROM prescriptions
INNER JOIN gp_master
ON prescriptions.practice_ref = gp_master.practice_ref
INNER JOIN post_code_master
ON post_code_master.postcode = gp_master.post_code -- replace spaces in gp post code
WHERE bnf_name LIKE '%Salbutamol%';


-- '%Terbutaline%'




-- DROP TABLE calcBlueInhalers;

CREATE TABLE calcBlueInhalers AS
SELECT 	identifi0,
	name AS district_name, 
	SUM(b.items) AS count_of_units,
	a.geom
FROM district_region a
CROSS JOIN prescriptionsBlueInhalers b
WHERE ST_Contains(a.geom, b.geom) = TRUE 
GROUP BY identifi0, name, a.geom;

--DROP TABLE prescriptionsBrownInhalers;

CREATE TABLE prescriptionsBrownInhalers AS
SELECT 	prescriptions.sha, 
	prescriptions.pct, 
	prescriptions.practice_ref, 
	prescriptions.bnf_code, 
	prescriptions.bnf_name, 
	prescriptions.items, 
	prescriptions.nic, 
	prescriptions.act_cost, 
	prescriptions.period, 
	prescriptions.filename,
	post_code_master.geom
FROM prescriptions
INNER JOIN gp_master
ON prescriptions.practice_ref = gp_master.practice_ref
INNER JOIN post_code_master
ON post_code_master.postcode = gp_master.post_code -- replace spaces in gp post code
WHERE bnf_name LIKE '%Beclometasone Dipropionate%';

-- DROP TABLE calcBrownInhalers
CREATE TABLE calcBrownInhalers AS
SELECT 	identifi0,
	name AS district_name, 
	SUM(b.items) AS count_of_units,
	a.geom
FROM district_region a
CROSS JOIN prescriptionsBrownInhalers b
WHERE ST_Contains(a.geom, b.geom) = TRUE 
GROUP BY identifi0, name, a.geom;
