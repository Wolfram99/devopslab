#1/bin/bash

if [[ "$#" -ge 2 && "$#" -le 3 ]]; then

    while read apikeyfile 
    do
        echo "$apikeyfile"
    done < $2

    if [[ $(curl -s "api.openweathermap.org/data/2.5/weather?q=$1&appid=$apikeyfile" | jq -r ".cod") != 200 ]]; then
        echo "Error. Check the entered data"
        exit 1
    elif [ -z "$2" ]; then
        echo "You have not entered the name of the file where the API key is stored"
        exit 1
    else 
        if [ -n "$3" ] ;then
            if [ "$3" == "c" ]; then 
                units="metric"
            elif [ "$3" == "k" ]; then 
                units="standard"
            elif [ "$3" == "f" ]; then
                units="imperial"
            else 
                units="metric"
            fi
        else
            units="metric"
        fi
    fi

    Weather=$(curl -s "api.openweathermap.org/data/2.5/weather?q=$1&units=$units&appid=$apikeyfile" | jq -r ".weather[0].main")
    Temperature=$(curl -s "api.openweathermap.org/data/2.5/weather?q=$1&units=$units&appid=$apikeyfile" | jq -r ".main.temp")
    feels_like=$(curl -s "api.openweathermap.org/data/2.5/weather?q=$1&units=$units&appid=$apikeyfile" | jq -r ".main.feels_like")
    echo -e "Current weather in $1: $Weather\nTemperature is $Temperature, but feels like $feels_like"
 
else
    echo "Error. Entered less/more than the ewquired number of arguments"
    exit 1
fi