/*
	Build a Bike Rental Shop
	
	connect => psql --username=freecodecamp --dbname=postgres
	extract => pg_dump -cC --inserts -U freecodecamp bikes > mario_database.sql
	import => psql -U postgres < students.sql
	
	data inserts
*/

--bikes
INSERT INTO bikes(type, size) VALUES('Mountain',27);
INSERT INTO bikes(type, size) VALUES('Mountain',28);
INSERT INTO bikes(type, size) VALUES('Mountain',29);
INSERT INTO bikes(type, size) VALUES('Road',27);
INSERT INTO bikes(type, size) VALUES('Road',28);
INSERT INTO bikes(type, size) VALUES('Road',29);
INSERT INTO bikes(type, size) VALUES('BMX',19);
INSERT INTO bikes(type, size) VALUES('BMX',20);
INSERT INTO bikes(type, size) VALUES('BMX',21);