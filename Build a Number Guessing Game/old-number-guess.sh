#!/bin/bash
# Number guess game
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# generate random number between 1 and 1000
SECRET_RANDOM_NUMBER=$(( $RANDOM % 1000 + 1 ))

# get the username
echo -e "\nEnter your username:"
read INPUT_USERNAME

# possibly sanitize for spaces in the beginning and end
# INPUT_USERNAME=$(echo $INPUT_USERNAME | sed 's/^ *| *$//g')

# query db with $INPUT_USERNAME for existence
QUERY_USERNAME_RESULT=$($PSQL "SELECT username FROM users WHERE username = '$INPUT_USERNAME';")

# check if already exists
if [[ -z $QUERY_USERNAME_RESULT ]]
    then
        # if new username then display welcome message
        echo -e "\nWelcome, $INPUT_USERNAME! It looks like this is your first time here."

        # insert user in db
        INSERT_NEW_USERNAME=$($PSQL "INSERT INTO users(username) VALUES('$INPUT_USERNAME');")

else
    # TODO! get games played (count * where user_id)
    # added - only count games that were completed
    FETCH_USER_GAMES_RESULT=$($PSQL "SELECT COUNT(g.game_id)
                                    FROM users AS u
                                    LEFT OUTER JOIN games AS g
                                        USING(user_id)
                                    WHERE u.username = '$INPUT_USERNAME'
                                    AND g.game_won = TRUE;")

    # echo "$FETCH_USER_GAMES_RESULT"
    IFS="|" read GAMES_PLAYED <<< "$FETCH_USER_GAMES_RESULT"

    # TODO! get best game played - best_game(agg calculate) - doing this seperate for abandoned games
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

    # echo "$FETCH_BEST_GAME_RESULT
    IFS="|" read BEST_GAME <<< "$FETCH_BEST_GAME_RESULT"


    # query db with $INPUT_USERNAME for games_played(count * where user_id) and 
    echo -e "\nWelcome back, $INPUT_USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."

fi

# fetch user_id from users
FETCH_USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$INPUT_USERNAME';")

# test variables so far
# echo -e "\nThe secret number is => " $SECRET_RANDOM_NUMBER
#echo -e "\nThe username is => " $INPUT_USERNAME

# initialize loop variables
USER_GUESS=0
GUESS_COUNTER=0
GAME_OVER=1

# going to put down a game record and update in the loop instead
INSERT_GAMES_RESULT=$($PSQL "INSERT INTO games(user_id, secret_number, game_won, number_of_guesses, start_time, end_time) 
                             VALUES($FETCH_USER_ID, $SECRET_RANDOM_NUMBER, FALSE, $GUESS_COUNTER, CURRENT_TIMESTAMP, NULL);")

# get the current game_id of the user to update games record in the loop
FETCH_CURRENT_GAME_ID=$($PSQL "SELECT MAX(game_id)
                               FROM games
                               WHERE user_id = $FETCH_USER_ID
                               AND game_won = FALSE
                               AND end_time IS NULL;")

# test current game id
# echo -e "\nCurrent game id:$FETCH_CURRENT_GAME_ID!"

# Ask user for USER_GUESS
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
                # increment
				GUESS_COUNTER=$(( GUESS_COUNTER + 1 ))
				# test remove
                # echo -e "guesses so far =>"$GUESS_COUNTER
				# high => if the guess is above the secret number
				echo -e "\nIt's lower than that, guess again:"
                read USER_GUESS

                # update the current game in the scenario the user abandons the game
                UPDATE_CURRENT_GAME=$($PSQL "UPDATE games 
                                             SET number_of_guesses = $GUESS_COUNTER
                                             WHERE game_id = $FETCH_CURRENT_GAME_ID
                                             AND user_id = $FETCH_USER_ID;")
				
        elif [[ $USER_GUESS -lt $SECRET_RANDOM_NUMBER ]]
            then
                # increment
                GUESS_COUNTER=$(( GUESS_COUNTER + 1 ))
				# test remove
                # echo -e "guesses so far =>"$GUESS_COUNTER
				# low => if the guess is below the secret number
                echo -e "\nIt's higher than that, guess again:"
                read USER_GUESS

                # update the current game in the scenario the user abandons the game
                UPDATE_CURRENT_GAME=$($PSQL "UPDATE games 
                                             SET number_of_guesses = $GUESS_COUNTER
                                             WHERE game_id = $FETCH_CURRENT_GAME_ID
                                             AND user_id = $FETCH_USER_ID;")
        else
			# final increment
            GUESS_COUNTER=$(( GUESS_COUNTER + 1 ))
			# test remove
            # echo -e "final guess count ="$GUESS_COUNTER
			
            # update the current game in the scenario the user abandons the game
            UPDATE_CURRENT_GAME=$($PSQL "UPDATE games 
                                         SET game_won = TRUE, 
                                             number_of_guesses = $GUESS_COUNTER,
                                             end_time = CURRENT_TIMESTAMP
                                         WHERE game_id = $FETCH_CURRENT_GAME_ID
                                         AND user_id = $FETCH_USER_ID;")

			# success message
            echo -e "\nYou guessed it in $GUESS_COUNTER tries. The secret number was $SECRET_RANDOM_NUMBER. Nice job!"

            # end the loop
            GAME_OVER=0
			

        fi
    fi
done
