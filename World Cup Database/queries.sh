#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals + opponent_goals) from games;")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games;")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals),2)  FROM games;")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games;")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games;")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > 2;")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT b.name 
               FROM games AS g 
               INNER JOIN teams AS b 
                ON b.team_id = g.winner_id 
               WHERE g.year = 2018 
               AND g.round = 'Final';")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT w.name 
                FROM games g
                INNER JOIN teams w
                  on w.team_id = g.winner_id
                WHERE g.year = 2014 
                and g.round = 'Eighth-Final'

                UNION ALL

                SELECT o.name 
                FROM games g
                INNER JOIN teams o
                  on o.team_id = g.opponent_id
                WHERE g.year = 2014 
                and g.round = 'Eighth-Final'
                ORDER BY 1;")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT DISTINCT(w.name) 
               FROM games AS g 
               INNER JOIN teams AS w 
                 ON w.team_id = g.winner_id
               ORDER BY 1;")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT g.year, t.name 
               FROM games AS g
               INNER JOIN teams AS t
                 ON t.team_id = g.winner_id
               WHERE g.round = 'Final'
               ORDER BY g.year;")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name FROM teams WHERE name like 'Co%';")"