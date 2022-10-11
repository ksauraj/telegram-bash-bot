#!/bin/bash

weath() {
    TRIMMED=${RET_MSG_TEXT#.weath}
    local key=$(echo "${WEATH_API_KEY}" | tr -d '\n' | wc -c)
    if [ "$key" -lt 1 ]; then
        log -e weath "Api key not found. Please add api key in .token.sh"
    else
        local char=$(echo "${TRIMMED}" | tr -d '\n' | wc -c)
        if [ "$char" -lt 1 ]; then
            tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Please provide a legit location."
        else
            location=${RET_MSG_TEXT#.weath }
            RESULT=$(curl -s --request GET \
                --url "https://yahoo-weather5.p.rapidapi.com/weather?location=${location}&format=json&u=c" \
                --header 'x-rapidapi-host: yahoo-weather5.p.rapidapi.com' \
                --header "x-rapidapi-key: ${WEATH_API_KEY}")
            echo $RESULT | jq .
            test=$(echo "$RESULT" | jq '.location')
            if [ "$test" == "null" ]; then
                tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "We only accept location that are present on earth. Are you sure the given location exist on earth?"
            else
                city=$(echo "$RESULT" | jq '.location | .city')
                woeid=$(echo "$RESULT" | jq '.location | .woeid')
                country=$(echo "$RESULT" | jq '.location | .country')
                region=$(echo "$RESULT" | jq '.location | .region')
                timezone_id=$(echo "$RESULT" | jq '.location | .timezone_id')
                speed=$(echo "$RESULT" | jq '.current_observation | .wind | .speed')
                humidity=$(echo "$RESULT" | jq '.current_observation | .atmosphere | .humidity')
                visibility=$(echo "$RESULT" | jq '.current_observation | .atmosphere | .visibility')
                pressure=$(echo "$RESULT" | jq '.current_observation | .atmosphere | .pressure')
                sunrise=$(echo "$RESULT" | jq '.current_observation | .astronomy | .sunrise')
                sunset=$(echo "$RESULT" | jq '.current_observation | .astronomy | .sunset')
                low_1=$(echo "$RESULT" | jq '.forecasts[].low' | sed '1!d')
                low_2=$(echo "$RESULT" | jq '.forecasts[].low' | sed '2!d')
                low_3=$(echo "$RESULT" | jq '.forecasts[].low' | sed '3!d')
                high_1=$(echo "$RESULT" | jq '.forecasts[].high' | sed '1!d')
                high_2=$(echo "$RESULT" | jq '.forecasts[].high' | sed '2!d')
                high_3=$(echo "$RESULT" | jq '.forecasts[].high' | sed '3!d')
                day_1=$(echo "$RESULT" | jq '.forecasts[].day' | sed '1!d')
                day_2=$(echo "$RESULT" | jq '.forecasts[].day' | sed '2!d')
                day_3=$(echo "$RESULT" | jq '.forecasts[].day' | sed '3!d')
                weather_1=$(echo "$RESULT" | jq '.forecasts[].text' | sed '1!d')
                {
                    echo "--------------------------------------------------------"
                    echo "| Showing Results for ${city}, ${region}, ${country}"
                    echo "|-------------------------------------------------------"
                    echo "| Timezone : ${timezone_id}"
                    echo "| Wind Speed : ${speed}km/h"
                    echo "| Humididty : ${humidity}%"
                    echo "| Visibility : ${visibility}%"
                    echo "| Pressure : ${pressure} Hg"
                    echo "|-------------------------------------------------------"
                    echo "| Day : ${day_1}"
                    echo "| Min Temperature : ${low_1}°C"
                    echo "| Min Temperature : ${high_1}°C"
                    echo "| Weather : ${weather_1}"
                    echo "| Sunrise : ${sunrise}"
                    echo "| Sunset : ${sunset}"
                    echo "|-------------------------------------------------------"
                    echo "| Forecasts for next 2 days"
                    echo "| "
                    echo "|             Min Temp.      Max Temp."
                    echo "| DAY 1       ${low_2}°C      ${high_2}°C"
                    echo "| DAY 2       ${low_3}°C      ${high_3}°C"
                    echo "---------------------------------------------------------"
                } > weath.txt
                sed -i s/\"//g weath.txt
                text=$(cat weath.txt)
                tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "${text}"
                rm weath.txt
            fi
        fi
    fi
}
