/*
	World Cup Database
	database setup
	connect => connect => psql --username=freecodecamp --dbname=postgres
	extract => pg_dump -cC --inserts -U freecodecamp worldcup > worldcup.sql
	import	=> psql -U postgres < worldcup.sql
*/
CREATE DATABASE worldcup;

CREATE TABLE teams();
ALTER TABLE teams ADD COLUMN team_id SERIAL PRIMARY KEY;
ALTER TABLE teams ADD COLUMN name VARCHAR(20) UNIQUE NOT NULL;

CREATE TABLE games();

ALTER TABLE games ADD COLUMN game_id SERIAL PRIMARY KEY;
ALTER TABLE games ADD COLUMN year INT NOT NULL;
ALTER TABLE games ADD COLUMN round VARCHAR(20) NOT NULL;

ALTER TABLE games ADD COLUMN winner_id INT NOT NULL;
ALTER TABLE games ADD COLUMN opponent_id INT NOT NULL;
--ALTER TABLE games ALTER COLUMN winner_id SET NOT NULL;
--ALTER TABLE games ALTER COLUMN opponent_id SET NOT NULL;

ALTER TABLE games ADD FOREIGN KEY(winner_id) REFERENCES teams(team_id);
ALTER TABLE games ADD FOREIGN KEY(opponent_id) REFERENCES teams(team_id);


ALTER TABLE games ADD COLUMN winner_goals INT NOT NULL;
ALTER TABLE games ADD COLUMN opponent_goals INT NOT NULL;