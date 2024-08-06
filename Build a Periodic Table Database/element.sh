#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
  then
    echo "Please provide an element as an argument."   

else
  # ELEMENT_QUERY=$1
  ELEMENT_QUERY=$(echo $1 | sed -E 's/\s//g')

    # test for atomic number
    if [[ $ELEMENT_QUERY =~ ^[0-9]+$ ]]
      then
        # get record with atomic_number
        FETCH_ELEMENT_RECORD=$($PSQL "SELECT atomic_number, symbol, name FROM elements WHERE atomic_number = $ELEMENT_QUERY;")

    # test for element symbol
    elif [[ ${#ELEMENT_QUERY} -eq 1 || ${#ELEMENT_QUERY} -eq 2 ]]
      then
        # get record with symbol
        FETCH_ELEMENT_RECORD=$($PSQL "SELECT atomic_number, symbol, name FROM elements WHERE symbol ILIKE '$ELEMENT_QUERY';")

    # test for element name
    else
        # get record with symbol
        FETCH_ELEMENT_RECORD=$($PSQL "SELECT atomic_number, symbol, name FROM elements WHERE name ILIKE '$ELEMENT_QUERY';")
    fi

    # if no record found
    if [[ -z $FETCH_ELEMENT_RECORD ]]
      then
        echo -e "I could not find that element in the database."
    else
      # unstring element record
      IFS="|" read ATOMIC_NUMBER ATOMIC_SYMBOL ATOMIC_NAME <<< "$FETCH_ELEMENT_RECORD"
      # echo $ATOMIC_NUMBER $ATOMIC_SYMBOL $ATOMIC_NAME

      # fetch the properties
      FETCH_PROPERTIES_RECORD=$($PSQL "SELECT p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type
                                        FROM properties AS p
                                        INNER JOIN types AS t
                                          USING(type_id)
                                        WHERE atomic_number = $ATOMIC_NUMBER;")
      
      # unstring properties record
      IFS="|" read ATOMIC_MASS MELTING_POINT BOILING_POINT METAL_TYPE <<< "$FETCH_PROPERTIES_RECORD"
      # echo -e "test>>Atomic number = $ATOMIC_NUMBER then mass = $ATOMIC_MASS  melting = $MELTING_POINT boiling = $BOILING_POINT metal type = $METAL_TYPE"
      # echo -e "\nThe element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius."
      echo -e "The element with atomic number $ATOMIC_NUMBER is $ATOMIC_NAME ($ATOMIC_SYMBOL). It's a $METAL_TYPE, with a mass of $ATOMIC_MASS amu. $ATOMIC_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi

fi
