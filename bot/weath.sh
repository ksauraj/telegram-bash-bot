#!/bin/bash

weath() {
    TRIMMED=${RET_MSG_TEXT#.weath}
    local key=$(echo "${WEATH_API_KEY}" | tr -d '\n' | wc -c)
    if [ "$key" -lt 50 ]; then
        log -e weath "Api key is wrong or not found. Please add api key in .token.sh"
    else
        if [ -z "${TRIMMED}" ]; then
            tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Please provide a legit location."
        else
            location=${RET_MSG_TEXT#.weath }
            RESULT=$(curl -s --request GET \
                --url "https://yahoo-weather5.p.rapidapi.com/weather?location=${location}&format=json&u=c" \
                --header 'x-rapidapi-host: yahoo-weather5.p.rapidapi.com' \
                --header "x-rapidapi-key: ${WEATH_API_KEY}")
            echo $RESULT | jq .
            local test=$(echo "$RESULT" | jq '.location')
            if [ "$test" == "null" ]; then
                tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "We only accept location that are present on earth. Are you sure the given location exist on earth?"
            else
                local city=$(echo "$RESULT" | jq '.location | .city')
                local woeid=$(echo "$RESULT" | jq '.location | .woeid')
                local country=$(echo "$RESULT" | jq '.location | .country')
                local region=$(echo "$RESULT" | jq '.location | .region')
                local timezone_id=$(echo "$RESULT" | jq '.location | .timezone_id')
                local speed=$(echo "$RESULT" | jq '.current_observation | .wind | .speed')
                local humidity=$(echo "$RESULT" | jq '.current_observation | .atmosphere | .humidity')
                local visibility=$(echo "$RESULT" | jq '.current_observation | .atmosphere | .visibility')
                local pressure=$(echo "$RESULT" | jq '.current_observation | .atmosphere | .pressure')
                local sunrise=$(echo "$RESULT" | jq '.current_observation | .astronomy | .sunrise')
                local sunset=$(echo "$RESULT" | jq '.current_observation | .astronomy | .sunset')
                local low_1=$(echo "$RESULT" | jq '.forecasts[].low' | sed '1!d')
                local low_2=$(echo "$RESULT" | jq '.forecasts[].low' | sed '2!d')
                local low_3=$(echo "$RESULT" | jq '.forecasts[].low' | sed '3!d')
                local high_1=$(echo "$RESULT" | jq '.forecasts[].high' | sed '1!d')
                local high_2=$(echo "$RESULT" | jq '.forecasts[].high' | sed '2!d')
                local high_3=$(echo "$RESULT" | jq '.forecasts[].high' | sed '3!d')
                local day_1=$(echo "$RESULT" | jq '.forecasts[].day' | sed '1!d')
                local day_2=$(echo "$RESULT" | jq '.forecasts[].day' | sed '2!d')
                local day_3=$(echo "$RESULT" | jq '.forecasts[].day' | sed '3!d')
                local weather_1=$(echo "$RESULT" | jq '.forecasts[].text' | sed '1!d')
                {
                    echo "╭⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯"
                    echo "│ Results For ${city}, ${region}, ${country}"
                    echo "│⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯"
                    echo "│ Timezone : ${timezone_id}"
                    echo "│ Wind Speed : ${speed}km/h"
                    echo "│ Humididty : ${humidity}%"
                    echo "│ Visibility : ${visibility}%"
                    echo "│ Pressure : ${pressure} Hg"
                    echo "│⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯"
                    echo "│ Day : ${day_1}"
                    echo "│ Min Temperature : ${low_1}°C"
                    echo "│ Min Temperature : ${high_1}°C"
                    echo "│ Weather : ${weather_1}"
                    echo "│ Sunrise : ${sunrise}"
                    echo "│ Sunset : ${sunset}"
                    echo "│⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯"
                    echo "│ Forecasts for next 2 days"
                    echo "│"
                    echo "│             Min Temp.      Max Temp."
                    echo "│ DAY 1       ${low_2}°C                ${high_2}°C"
                    echo "│ DAY 2       ${low_3}°C                ${high_3}°C"
                    echo "╰⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯"
                } > weath.txt
                sed -i s/\"//g weath.txt
                text=$(cat weath.txt)
                tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "${text}"
                rm weath.txt
            fi
        fi
    fi
}
