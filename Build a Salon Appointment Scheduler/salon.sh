#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~"
echo -e "\nWelcome to My Salon, how can I help you?\n"

MAIN_MENU() {
    if [[ $1 ]]
    then
      echo -e "\n$1"
    fi
        
    # get available services
    AVAILABLE_SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id;")
    echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
    do
      echo "$SERVICE_ID) $(echo $SERVICE_NAME | sed -E 's/^ *| *$//g')"
    done

    read SERVICE_ID_SELECTED

    SERVICE_ID_CHECK=$($PSQL "SELECT service_id FROM services WHERE service_id = $SERVICE_ID_SELECTED;")
    if [[ -z $SERVICE_ID_CHECK ]]
      then
        MAIN_MENU "I could not find that service. What would you like today?"
    else
        # get the service name to pass in variable
        SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED;")
        # remove spacing introduced.
        SERVICE_NAME=$(echo $SERVICE_NAME | sed -E 's/^ *| *$//g')

        # get customer phone number
        echo -e "\nWhat's your phone number?"
        read CUSTOMER_PHONE
        CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE';")

        # if not found
        if [[ -z $CUSTOMER_NAME ]]
          then
          # get customer name
          echo -e "\nI don't have a record for that phone number, what's your name?"
          read CUSTOMER_NAME

          # insert customer record
          INSERT_CUSTOMER_RECORD=$($PSQL "INSERT INTO customers (phone,name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME');")      

        fi

        # get customer id
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE';")
        #CUSTOMER_ID=$(echo $CUSTOMER_ID | sed -E 's/^ *| *$//g')
        # get appointment
        echo -e "\nWhat time would you like your $SERVICE_NAME, $(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')?"
        read SERVICE_TIME  

        # insert appointment record
        INSERT_APPOINTMENT_RECORD=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME');")
        echo "I have put you down for a $SERVICE_NAME at $(echo $SERVICE_TIME | sed -E 's/^ *| *$//g'), $(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')."
    fi

}

MAIN_MENU