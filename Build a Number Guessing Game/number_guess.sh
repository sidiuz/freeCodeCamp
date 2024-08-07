#!/bin/bash
# Number guess game
echo -e "\n~~~~ Number Guess Game ~~~~\n"

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Get the username
echo -e "Enter your username:"
read INPUT_USERNAME

# Possibly sanitize for spaces in the beginning and end
INPUT_USERNAME=$(echo $INPUT_USERNAME | sed 's/^ *| *$//g')

# Query db with $INPUT_USERNAME for existence
QUERY_USERNAME_RESULT=$($PSQL "SELECT username FROM users WHERE username = '$INPUT_USERNAME';")

# Check if already exists
if [[ -z $QUERY_USERNAME_RESULT ]]
    then
        # If new username then display welcome message
        echo -e "\nWelcome, $(echo $INPUT_USERNAME | sed -r 's/^ *| *$//g')! It looks like this is your first time here."

        # Insert new user in db
        INSERT_NEW_USERNAME=$($PSQL "INSERT INTO users(username) VALUES('$INPUT_USERNAME');")

else
    # Only count games that were completed
    FETCH_USER_GAMES_RESULT=$($PSQL "SELECT COUNT(g.game_id)
                                    FROM users AS u
                                    LEFT OUTER JOIN games AS g
                                        USING(user_id)
                                    WHERE u.username = '$INPUT_USERNAME'
                                    AND g.game_won = TRUE;")

    # Unstring the user games result
    IFS="|" read GAMES_PLAYED <<< "$FETCH_USER_GAMES_RESULT"

    # Get best game played - best_game(agg calculate) - doing this seperate for abandoned games
    FETCH_BEST_GAME_RESULT=$($PSQL "SELECT 
                                        CASE 
                                            WHEN MIN(number_of_guesses) IS NULL 
                                                THEN 0 
                                        ELSE MIN(number_of_guesses)
                                        END 
                                    FROM users AS u
                                    LEFT OUTER JOIN games AS g
                                        USING(user_id)
                                    WHERE u.username = '$INPUT_USERNAME'
                                    AND g.game_won = TRUE;")

    # Unstring best game result
    IFS="|" read BEST_GAME <<< "$FETCH_BEST_GAME_RESULT"

    # Display welcome back message, cleanup variable output
    echo -e "\nWelcome back, $(echo $INPUT_USERNAME | sed -r 's/^ *| *$//g')! You have played $(echo $GAMES_PLAYED | sed -r 's/^ *| *$//g') games, and your best game took $(echo $BEST_GAME | sed -r 's/^ *| *$//g') guesses."
fi

# Fetch user_id for initial game insert
FETCH_USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$INPUT_USERNAME';")

# Generate random number between 1 and 1000
SECRET_RANDOM_NUMBER=$(( $RANDOM % 1000 + 1 ))

# Initialize while loop variables
USER_GUESS=0
GUESS_COUNTER=0
GAME_OVER=1

# Going to put down a game record and update in the loop instead
# updating after each guess is a bad idea, keep the counters in variables and perform a final update (fixed)
INSERT_GAMES_RESULT=$($PSQL "INSERT INTO games(user_id, secret_number, game_won, number_of_guesses, start_time, end_time) 
                             VALUES($FETCH_USER_ID, $SECRET_RANDOM_NUMBER, FALSE, $GUESS_COUNTER, CURRENT_TIMESTAMP, NULL);")

# Get the current game_id of the user to update games record in the loop
FETCH_CURRENT_GAME_ID=$($PSQL "SELECT MAX(game_id)
                               FROM games
                               WHERE user_id = $FETCH_USER_ID
                               AND game_won = FALSE
                               AND end_time IS NULL;")

# Ask user for the girst guess
echo -e "Guess the secret number between 1 and 1000:"

# I trust the user is going to behave with the rules of the game
read USER_GUESS

# start the game loop
while [[ $GAME_OVER == 1 ]]
do
	
	# if input is not a number
    if [[ ! $USER_GUESS =~ ^[0-9]+$ ]]
        then
            echo -e "\nThat is not an integer, guess again:"
            read USER_GUESS
			# no increment
			
	# continue with the game
    else
        if [[ $USER_GUESS -gt $SECRET_RANDOM_NUMBER ]]
            then
				GUESS_COUNTER=$(( GUESS_COUNTER + 1 ))
				echo -e "\nIt's lower than that, guess again:"
                read USER_GUESS
				
        elif [[ $USER_GUESS -lt $SECRET_RANDOM_NUMBER ]]
            then
                GUESS_COUNTER=$(( GUESS_COUNTER + 1 ))
                echo -e "\nIt's higher than that, guess again:"
                read USER_GUESS
        else
			# final increment
            GUESS_COUNTER=$(( GUESS_COUNTER + 1 ))
			
            # update the current game in the scenario the user abandons the game
            UPDATE_CURRENT_GAME=$($PSQL "UPDATE games 
                                         SET game_won = TRUE, 
                                             number_of_guesses = $GUESS_COUNTER,
                                             end_time = CURRENT_TIMESTAMP
                                         WHERE game_id = $FETCH_CURRENT_GAME_ID
                                         AND user_id = $FETCH_USER_ID;")

			# Display the success message
            echo -e "\nYou guessed it in $(echo $GUESS_COUNTER | sed -r 's/^ *| *$//g') tries. The secret number was $(echo $SECRET_RANDOM_NUMBER | sed -r 's/^ *| *$//g'). Nice job!"

            # End the loop
            GAME_OVER=0
        fi
    fi
done
