DROP TABLE prescriptions;
DROP TABLE gp_master;

CREATE TABLE prescriptions (
sha varchar(5),
pct varchar(5),
practice_ref varchar(20),
bnf_code varchar(20),
bnf_name varchar(1000),
items int,
nic double precision,
act_cost double precision,
period varchar(10),
filename varchar(50));

CREATE TABLE gp_master (
practice_ref varchar(20),
practice_name varchar(200),
address1 varchar(500),
address2 varchar(500),
address3 varchar(500),
address4 varchar(500),
post_code varchar(12),
filename varchar(50));











