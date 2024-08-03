/*
	Build a Salon Appointment Scheduler
	
	connect => psql --username=freecodecamp --dbname=postgres
	extract => pg_dump -cC --inserts -U freecodecamp salon > salon_database.sql
	import => psql -U postgres < salon_database.sql
*/

CREATE DATABASE salon;

CREATE TABLE customers();
CREATE TABLE appointments();
CREATE TABLE services();

ALTER TABLE customers ADD COLUMN customer_id SERIAL PRIMARY KEY;
ALTER TABLE appointments ADD COLUMN appointment_id SERIAL PRIMARY KEY;
ALTER TABLE services ADD COLUMN service_id SERIAL PRIMARY KEY;

ALTER TABLE appointments ADD COLUMN customer_id INT;
ALTER TABLE appointments ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

ALTER TABLE appointments ADD COLUMN service_id INT;
ALTER TABLE appointments ADD FOREIGN KEY (service_id) REFERENCES services(service_id);

ALTER TABLE customers ADD COLUMN phone VARCHAR(15) UNIQUE NOT NULL;

ALTER TABLE customers ADD COLUMN name VARCHAR(40) NOT NULL;
ALTER TABLE services ADD COLUMN name VARCHAR(40) NOT NULL;

--ALTER TABLE appointments ADD COLUMN time VARCHAR(5) NOT NULL;
--ALTER TABLE appointments ALTER COLUMN time TYPE VARCHAR(10);
ALTER TABLE appointments ADD COLUMN time VARCHAR(10) NOT NULL; --fixed

INSERT INTO services(name) VALUES('cut');
INSERT INTO services(name) VALUES('color');
INSERT INTO services(name) VALUES('perm');
INSERT INTO services(name) VALUES('style');
INSERT INTO services(name) VALUES('trim');