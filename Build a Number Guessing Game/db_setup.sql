/*
	Build a Number Guessing Game
	
	connect => psql --username=freecodecamp --dbname=postgres
	extract => pg_dump -cC --inserts -U freecodecamp number_guess > number_guess.sql
	import => psql -U postgres < number_guess.sql
	
*/

CREATE DATABASE number_guess;

CREATE TABLE users();
ALTER TABLE users ADD COLUMN user_id SERIAL PRIMARY KEY;
ALTER TABLE users ADD COLUMN username VARCHAR(22) UNIQUE NOT NULL;
	
CREATE TABLE games();
ALTER TABLE games ADD COLUMN game_id SERIAL PRIMARY KEY;
ALTER TABLE games ADD COLUMN user_id INT;
ALTER TABLE games ADD COLUMN secret_number INT NOT NULL;
ALTER TABLE games ADD COLUMN game_won BOOLEAN NOT NULL DEFAULT(FALSE);
ALTER TABLE games ADD COLUMN number_of_guesses INT NOT NULL DEFAULT(0);
ALTER TABLE games ADD COLUMN start_time TIMESTAMP NOT NULL DEFAULT(CURRENT_TIMESTAMP);
ALTER TABLE games ADD COLUMN end_time timestamp DEFAULT(NULL);


ALTER TABLE games ADD FOREIGN KEY(user_id) REFERENCES users(user_id);

/*
                                              Table "public.games"
      Column       |            Type             | Collation | Nullable |                Default                 
-------------------+-----------------------------+-----------+----------+----------------------------------------
 game_id           | integer                     |           | not null | nextval('games_game_id_seq'::regclass)
 user_id           | integer                     |           |          | 
 secret_number     | integer                     |           | not null | 
 game_won          | boolean                     |           | not null | false
 number_of_guesses | integer                     |           | not null | 0
 start_time        | timestamp without time zone |           | not null | CURRENT_TIMESTAMP
 end_time          | timestamp without time zone |           |          | 
Indexes:
    "games_pkey" PRIMARY KEY, btree (game_id)
Foreign-key constraints:
    "games_user_id_fkey" FOREIGN KEY (user_id) REFERENCES users(user_id)

number_guess=> \d users
                                       Table "public.users"
  Column  |         Type          | Collation | Nullable |                Default                 
----------+-----------------------+-----------+----------+----------------------------------------
 user_id  | integer               |           | not null | nextval('users_user_id_seq'::regclass)
 username | character varying(22) |           | not null | 
Indexes:
    "users_pkey" PRIMARY KEY, btree (user_id)
    "users_username_key" UNIQUE CONSTRAINT, btree (username)
Referenced by:
    TABLE "games" CONSTRAINT "games_user_id_fkey" FOREIGN KEY (user_id) REFERENCES users(user_id)
*/