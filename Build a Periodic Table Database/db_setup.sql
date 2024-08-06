/*
	Build a Periodic Table Database
	
	connect => psql --username=freecodecamp --dbname=periodic_table
	extract => pg_dump -cC --inserts -U freecodecamp periodic_table > periodic_table.sql
	import => psql -U postgres < periodic_table.sql
*/

/*
                       Table "public.properties"
    Column     |         Type          | Collation | Nullable | Default 
---------------+-----------------------+-----------+----------+---------
 atomic_number | integer               |           | not null | 
 type          | character varying(30) |           |          | 
 weight        | numeric(9,6)          |           | not null | 
 melting_point | numeric               |           |          | 
 boiling_point | numeric               |           |          | 
Indexes:
    "properties_pkey" PRIMARY KEY, btree (atomic_number)
    "properties_atomic_number_key" UNIQUE CONSTRAINT, btree (atomic_number)
*/

ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;
ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;
ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;

ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;
ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;

ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;
ALTER TABLE elements ALTER COLUMN name SET NOT NULL;

ALTER TABLE elements ADD CONSTRAINT symbol_name UNIQUE(symbol,name);

ALTER TABLE properties ADD FOREIGN KEY(atomic_number) REFERENCES elements(atomic_number);

CREATE TABLE types();
ALTER TABLE types ADD COLUMN type_id SERIAL PRIMARY KEY;
ALTER TABLE types ADD COLUMN type VARCHAR(30) NOT NULL;

INSERT INTO types(type) VALUES('nonmetal');
INSERT INTO types(type) VALUES('metal');
INSERT INTO types(type) VALUES('metalloid');

ALTER TABLE properties ADD COLUMN type_id;
ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL;
ALTER TABLE properties ADD FOREIGN KEY(type_id) REFERENCES types(type_id);

ALTER TABLE properties ALTER COLUMN atomic_mass TYPE NUMERIC;

INSERT INTO elements(atomic_number, symbol, name) VALUES(9,'F','Fluorine');
INSERT INTO elements(atomic_number, symbol, name) VALUES(10,'Ne','Neon');

INSERT INTO properties(atomic_number,type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES(9,'nonmetal',18.998,-220,-188.1,1);
INSERT INTO properties(atomic_number,type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES(10,'nonmetal',20.18,-248.6,-246.1,1);


UPDATE properties SET atomic_mass = 1.008 WHERE atomic_number = 1; 
UPDATE properties SET atomic_mass = 4.0026 WHERE atomic_number = 2; 
UPDATE properties SET atomic_mass = 6.94 WHERE atomic_number = 3; 
UPDATE properties SET atomic_mass = 9.0122 WHERE atomic_number = 4; 
UPDATE properties SET atomic_mass = 10.81 WHERE atomic_number = 5; 
UPDATE properties SET atomic_mass = 12.011 WHERE atomic_number = 6; 
UPDATE properties SET atomic_mass = 14.007 WHERE atomic_number = 7; 
UPDATE properties SET atomic_mass = 15.999 WHERE atomic_number = 8; 
UPDATE properties SET atomic_mass = 18.998 WHERE atomic_number = 9; 
UPDATE properties SET atomic_mass = 20.18 WHERE atomic_number = 10; 

ALTER TABLE properties DROP COLUMN type;