#!/bin/bash

#Clear terminal before starting
clear

## Sourcing stuffs (Our functions, extra functions ans aliases, etc)
source util.sh
source .token.sh
echo "STARTING BOT"


#Defining Function
start() {
    tg --replymarkdownv2msg "$RET_CHAT_ID" "$RET_MSG_ID" "A Simple bot from @Ksauraj and @Hakimi0804\."
}
round() {
	# $1 = Your number
	# $2 = Amount of decimal places
	FLOAT=$1
	DECIMAL_POINT=$2
	printf "%.${2:-$DECIMAL_POINT}f" "$FLOAT"
}
calc() {
    TRIMMED="${RET_MSG_TEXT#.calc}"
    CALCED=$(echo "$TRIMMED" | bc -l 2>&1)
    if ! echo "$CALCED" | grep -q 'syntax error'; then
        ROUNDED=$(round "$CALCED" 2)
        tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "$ROUNDED"
    else
        tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Bruh, did you just entered nonsense, cuz bc ain't happy"
    fi
}
iq() {
	if [[ $USERNAME == 'Ksauraj' ]]; then
		iq=$(shuf -i 0-8 -n1)
		iq=$(expr 180 - $iq)
		tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Calculating your IQ, wait plox..."
		tg --editmsg "$RET_CHAT_ID" "$SENT_MSG_ID" "@${USERNAME} calculated IQ Score is ${iq}."
	else
		tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Calculating your IQ, wait plox..."
		sha=$(echo ${FIRST_NAME} | sha1sum | grep -Eo "[[:digit:]]{2}" | head -n1)
		md5=$(echo ${USERNAME} | md5sum | grep -Eo "[[:digit:]]{2}" | head -n1)
		num1=$(expr ${sha} + ${md5} | head -n1)
		num2=$(shuf -i 0-5 -n1)
		f=$(expr ${num1} - ${num2} )
		iq=$(expr 180 - $f )
		tg --editmsg "$RET_CHAT_ID" "$SENT_MSG_ID" "@${USERNAME} calculated IQ Score is ${iq}."
	fi
}
magisk() {
		tg --sendmsg "$RET_CHAT_ID" "Fetching latest Magisk stable"
		LATEST_STABLE=$(
			curl -s https://api.github.com/repos/topjohnwu/Magisk/releases/latest |
				grep "Magisk-v**.*.apk" |
				cut -d : -f 2,3 |
				tr -d \" |
				cut -d, -f2 |
				tr -d '\n' |
				tr -d ' '
		)
		CANARY="https://raw.githubusercontent.com/topjohnwu/magisk-files/canary/app-debug.apk"
		tg --editmarkdownv2msg "$RET_CHAT_ID" "$SENT_MSG_ID" "[Latest stable]($LATEST_STABLE)
[Latest canary]($CANARY)"
}
info() {
	if [ ${RET_REPLIED_MSGGER_ID} != "null" ]; then
		USERNAME=$(echo $USERNAME | sed 's/[`~!@#$%^&*()-_=+{}\|;:",<.>/?'"'"']/\\&/g')
		FIRST_NAME=$( echo $FIRST_NAME | sed 's/[`~!@#$%^&*()-_=+{}\|;:",<.>/?'"'"']/\\&/g')
		LAST_NAME=$(echo $LAST_NAME | sed 's/[`~!@#$%^&*()-_=+{}\|;:",<.>/?'"'"']/\\&/g')
		RET_REPLIED_MSGGER_FIRST_NAME=$(echo $RET_REPLIED_MSGGER_FIRST_NAME | sed 's/[`~!@#$%^&*()-_=+{}\|;:",<.>/?'"'"']/\\&/g')
		RET_REPLIED_MSGGER_LAST_NAME=$(echo $RET_REPLIED_MSGGER_LAST_NAME | sed 's/[`~!@#$%^&*()-_=+{}\|;:",<.>/?'"'"']/\\&/g')
		RET_REPLIED_MSGGER_USERNAME=$(echo $RET_REPLIED_MSGGER_USERNAME | sed 's/[`~!@#$%^&*()-_=+{}\|;:",<.>/?'"'"']/\\&/g')
		tg --replymarkdownv2msg "$RET_CHAT_ID" "$RET_MSG_ID" "Chat ID \: \`${RET_CHAT_ID}\`
Message ID \: \`${RET_MSG_ID}\`
Chat Type \: \`${RET_CHAT_TYPE}\`

User Name \: \@${USERNAME}
First Name \: \`${FIRST_NAME}\`
Last Name \: \`${LAST_NAME}\`
User ID \: \`${MSGGER}\`

Replied user Username \: \@${RET_REPLIED_MSGGER_USERNAME}
Replied user First Name \: \`${RET_REPLIED_MSGGER_FIRST_NAME}\`
Replied user Last Name \: \`${RET_REPLIED_MSGGER_LAST_NAME}\`
Replied user ID \: \`${RET_REPLIED_MSGGER_ID}\`"
	else
		tg --replymarkdownv2msg "$RET_CHAT_ID" "$RET_MSG_ID" "Chat ID \: \`${RET_CHAT_ID}\`
Chat Type \: \`${RET_CHAT_TYPE}\`

User Name \: \@${USERNAME}
First Name \: \`${FIRST_NAME}\`
Last Name \: \`${LAST_NAME}\`
User ID \: \`${MSGGER}\`"
	fi
}
neo_fetch() {
	tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "This may take a while depending upon host..."
	NEOFETCH_OUTPUT=$(neofetch --stdout)
	tg --editmsg "$RET_CHAT_ID" "$SENT_MSG_ID" "$NEOFETCH_OUTPUT"
}
weath() {
	TRIMMED=${RET_MSG_TEXT#.weath }
	char=$(echo ${TRIMMED} | tr -d '\n' | wc -c)
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
		echo "Showing Results for" ${city}"," ${region}"," ${country} > weath.txt
		echo "Timezone : ${timezone_id}" >> weath.txt
		echo "Wind Speed : ${speed}km/h" >> weath.txt
		echo "Humididty : ${humidity}%" >> weath.txt
		echo "Visibility : ${visibility}%" >> weath.txt
		echo "Pressure : ${pressure} Hg" >> weath.txt
		echo "Day : ${day_1}" >> weath.txt
		echo "Min Temperature : ${low_1}°C" >> weath.txt
		echo "Min Temperature : ${high_1}°C" >> weath.txt
		echo "Weather : ${weather_1}" >> weath.txt
		echo "Sunrise : ${sunrise}" >> weath.txt
		echo "Sunset : ${sunset}" >> weath.txt
		echo "" >> weath.txt
		echo "Forecasts for next 2 days" >> weath.txt
		echo "" >> weath.txt
		echo "            Min Temp.      Max Temp." >> weath.txt
		echo "${day_2}       ${low_2}°C      ${high_2}°C" >> weath.txt
		echo "${day_3}       ${low_3}°C      ${high_3}°C" >> weath.txt
		sed -i s/\"//g weath.txt
		text=$(cat weath.txt)
		tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "${text}"
		rm weath.txt
	fi
}

## While loop
while true; do
	# Refresh stuff
	update
	[ "$RET_MSG_TEXT" ] && echo "$RET_MSG_TEXT"
	RET_LOWERED_MSG_TEXT=$(tr '[:upper:]' '[:lower:]' <<<"$RET_MSG_TEXT")

	case $RET_LOWERED_MSG_TEXT in

	'/start'*) start ;;
	'.calc'*) calc ;;
	'.iq'*) iq ;;
	'.info'*) info ;;
	'.magisk'*) magisk ;;
	'.neofetch'*) neo_fetch ;;
	'.weath'*) weath ;;
	esac

	unset RET_MSG_TEXT RET_REPLIED_MSG_ID
done


