#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
# truncate tables
echo $($PSQL "TRUNCATE teams, games;")

# file columns => year,round,winner,opponent,winner_goals,opponent_goals
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $WINNER != 'winner' ]]
    then
    # get winner team_id
    WINNER_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER';")

    # if not found
    if [[ -z $WINNER_TEAM_ID ]]
      then
      # insert winner team
      INSERT_WINNER_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER');")
      if [[ $INSERT_WINNER_TEAM_RESULT == 'INSERT 0 1' ]]
        then
          echo Inserted into teams, $WINNER
      fi
    fi

    # get new winner team_id
    WINNER_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER';")

  fi

  if [[ $OPPONENT != 'opponent' ]]
    then
    # get opponent team_id
    OPPONENT_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT';")

    # if not found
    if [[ -z $OPPONENT_TEAM_ID ]]
      then
      # insert opponent team
      INSERT_OPPONENT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT');")
      if [[ $INSERT_OPPONENT_TEAM_RESULT == 'INSERT 0 1' ]]
        then
          echo Inserted into teams, $OPPONENT
      fi
    fi

    # get new opponent team_id
    OPPONENT_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT';")
  fi
# year,round,winner,opponent,winner_goals,opponent_goals
# YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
  if [[ $YEAR != 'year' && $ROUND != 'round' && $WINNER_GOALS != 'winner_goals' && $OPPONENT_GOALS != 'opponent_goals' ]]
    then
    # get winner_id
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER';")
    # get opponent_id
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT';")
    # get game_id
    GAME_ID=$($PSQL "SELECT game_id 
                     FROM games 
                     WHERE year = $YEAR 
                     AND round = '$ROUND' 
                     AND winner_id = $WINNER_ID 
                     AND opponent_id = $OPPONENT_ID;")

    # if not found
    if [[ -z $GAME_ID ]]
      then
      # insert game
      INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals)
                                  VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS);")
      if [[ $INSERT_GAME_RESULT == 'INSERT 0 1' ]]
        then
          echo Inserted into games, $YEAR, $ROUND, $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS
      fi
    fi

    # get new game_id
    GAME_ID=$($PSQL "SELECT game_id 
                     FROM games 
                     WHERE year = $YEAR 
                     AND round = '$ROUND' 
                     AND winner_id = $WINNER_ID 
                     AND opponent_id = $OPPONENT_ID;")
  fi

done


