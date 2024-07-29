--universe
CREATE DATABASE universe;

CREATE TABLE local_cluster();
ALTER TABLE local_cluster ADD COLUMN local_cluster_id SERIAL PRIMARY KEY;
ALTER TABLE local_cluster ADD COLUMN name VARCHAR(50);
ALTER TABLE local_cluster ADD COLUMN description TEXT;
ALTER TABLE local_cluster ADD COLUMN cluster_type VARCHAR(50);
ALTER TABLE local_cluster ADD COLUMN has_humans BOOLEAN;

ALTER TABLE local_cluster ALTER COLUMN name SET NOT NULL;
ALTER TABLE local_cluster ALTER COLUMN description SET NOT NULL;

ALTER TABLE local_cluster ADD CONSTRAINT unique_name UNIQUE (name);

ALTER TABLE table_name ALTER COLUMN column_name SET NOT NULL;


CREATE TABLE galaxy();
ALTER TABLE galaxy ADD COLUMN galaxy_id SERIAL PRIMARY KEY;
ALTER TABLE galaxy ADD COLUMN local_cluster_id INT;

ALTER TABLE galaxy ADD FOREIGN KEY(local_cluster_id) REFERENCES local_cluster(local_cluster_id);


CREATE TABLE star();
ALTER TABLE star ADD COLUMN star_id SERIAL PRIMARY KEY;

CREATE TABLE planet();
ALTER TABLE planet ADD COLUMN planet_id SERIAL PRIMARY KEY;

CREATE TABLE moon();
ALTER TABLE moon ADD COLUMN moon_id SERIAL PRIMARY KEY;


ALTER TABLE galaxy ADD COLUMN name TEXT UNIQUE NOT NULL;
ALTER TABLE star ADD COLUMN name TEXT UNIQUE NOT NULL;
ALTER TABLE planet ADD COLUMN name TEXT UNIQUE NOT NULL;
ALTER TABLE moon ADD COLUMN name TEXT UNIQUE NOT NULL;


ALTER TABLE star ADD COLUMN galaxy_id INT REFERENCES galaxy(galaxy_id);
ALTER TABLE planet ADD COLUMN star_id INT REFERENCES star(star_id);
ALTER TABLE moon ADD COLUMN planet_id INT REFERENCES planet(planet_id);

ALTER TABLE galaxy ALTER COLUMN name TYPE VARCHAR(50);
ALTER TABLE star ALTER COLUMN name TYPE VARCHAR(50);
ALTER TABLE planet ALTER COLUMN name TYPE VARCHAR(50);
ALTER TABLE moon ALTER COLUMN name TYPE VARCHAR(50);

--planet => Planet_Order
ALTER TABLE planet ADD COLUMN planet_order INT;

--planet => Star_Distance_in_AU
ALTER TABLE planet ADD COLUMN Star_Distance_in_AU NUMERIC(5,2);

--planet => Min_Temp_Degrees
ALTER TABLE planet ADD COLUMN Min_Temp_Degrees INT;

--planet => Max_Temp_Degrees
ALTER TABLE planet ADD COLUMN Max_Temp_Degrees INT;

--all tables
ALTER TABLE galaxy ADD COLUMN description TEXT;
ALTER TABLE star ADD COLUMN description TEXT;
ALTER TABLE planet ADD COLUMN description TEXT;
ALTER TABLE moon ADD COLUMN description TEXT;

--planet & moon
ALTER TABLE planet ADD COLUMN has_landed BOOLEAN;
ALTER TABLE moon ADD COLUMN has_landed BOOLEAN;

--moon => moon_order
ALTER TABLE moon ADD COLUMN moon_order INT;

--moon => Min_Temp_Degrees
ALTER TABLE moon ADD COLUMN Min_Temp_Degrees INT;

--moon => Max_Temp_Degrees
ALTER TABLE moon ADD COLUMN Max_Temp_Degrees INT;

--star
ALTER TABLE star ADD COLUMN star_type TEXT;
ALTER TABLE star ADD COLUMN age BIGINT;

--galaxy
ALTER TABLE galaxy ADD COLUMN galaxy_type VARCHAR(30);
ALTER TABLE galaxy ADD COLUMN number_of_stars BIGINT;