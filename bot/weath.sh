#!/bin/bash

weath() {
	TRIMMED=${RET_MSG_TEXT#.weath }
	char=$(echo "${TRIMMED}" | tr -d '\n' | wc -c)
	if [ "$char" == 0 ]; then
		tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Please provide argument bisi"
	else
		location=${TRIMMED}
		RESULT=$(curl --request GET \
			--url "https://yahoo-weather5.p.rapidapi.com/weather?location=${location}&format=json&u=c" \
			--header 'x-rapidapi-host: yahoo-weather5.p.rapidapi.com' \
			--header "x-rapidapi-key: ${WEATH_API_KEY}")

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
			echo "Showing Results for ${city}, ${region}, ${country}"
			echo "Timezone : ${timezone_id}"
			echo "Wind Speed : ${speed}km/h"
			echo "Humididty : ${humidity}%"
			echo "Visibility : ${visibility}%"
			echo "Pressure : ${pressure} Hg"
			echo "Day : ${day_1}"
			echo "Min Temperature : ${low_1}°C"
			echo "Min Temperature : ${high_1}°C"
			echo "Weather : ${weather_1}"
			echo "Sunrise : ${sunrise}"
			echo "Sunset : ${sunset}"
			echo ""
			echo "Forecasts for next 2 days"
			echo ""
			echo "            Min Temp.      Max Temp."
			echo "${day_2}       ${low_2}°C      ${high_2}°C"
			echo "${day_3}       ${low_3}°C      ${high_3}°C"
		} > weath.txt
		sed -i s/\"//g weath.txt
		text=$(cat weath.txt)
		tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "${text}"
		rm weath.txt
	fi
}
