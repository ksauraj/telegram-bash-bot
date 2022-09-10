#!/bin/bash

#Clear & Clean terminal before starting
clear
rm log  > /dev/null 2>&1
## Sourcing stuffs (Our functions, extra functions ans aliases, etc)
source util.sh
source .token.sh
echo "STARTING BOT"


# Defining constants
readonly sauraj_discussion_groupid=-1001470915975
readonly msg_spam_words=(
	crypto
	bitcoin
	forex
	"t.me/joinchat/"
	drеаmswhales
	"meet you all"
	"very happy"
	"new comer"
	invest
	"t.me/+"
	ᴛʀᴀᴅɪɴɢ
	ɪɴᴠᴇsᴛ
	trading
	trade
	usdt
	btc
)

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
spam_protector() {
	if [ -z "$RET_LOWERED_MSG_TEXT" ]; then
		# Nothing to do
		return
	fi

	# For now, this feature is restricted to Sauraj's discussion group
	if [ "$RET_CHAT_ID" != "$sauraj_discussion_groupid" ]; then
		echo "spam_protector: Not sauraj discussion group, skipped checking"
		return
	fi

	for word in "${msg_spam_words[@]}"; do
		if echo "$RET_LOWERED_MSG_TEXT" | grep -q "$word"; then
			if is_admin "$RET_CHAT_ID" "$MSGGER"; then
				echo "spam_protector: Found match, but user is admin"
				echo "                Skipping actions"
				return
			fi

			local user_escaped_name=$(echo "$FIRST_NAME" | sed 's/[`~!@#$%^&*()-_=+{}\|;:",<.>/?'"'"']/\\&/g')
			local word_escaped=$(echo "$word" | sed 's/[`~!@#$%^&*()-_=+{}\|;:",<.>/?'"'"']/\\&/g')

			tg --delmsg "$RET_CHAT_ID" "$RET_MSG_ID" &
			tg --ban "$RET_CHAT_ID" "$MSGGER" &
			tg --sendmarkdownv2msg "$RET_CHAT_ID" "Banned user [$user_escaped_name](tg://user?id=$MSGGER)
Blacklist match in message: \`$word_escaped\`"
			return
		fi
	done
}
purge() {
	echo "Purge called"
	if [ "$RET_REPLIED_MSG_ID" = null ]; then
		tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Reply to a message plox"
		return
	fi

	if ! is_admin "$RET_CHAT_ID" "$MSGGER"; then
		tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "You are not an admin"
		return
	elif ! is_admin "$RET_CHAT_ID" "$BOT_ID"; then
		tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "I am not an admin"
		return
	fi

	tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Purging"
	local purge_start_time=$(date +%s.%N)
	echo "purge ret rep $RET_REPLIED_MSG_ID"
	echo "purge sent $SENT_MSG_ID"
	echo "purge seq debug: $(seq "$RET_REPLIED_MSG_ID" $((SENT_MSG_ID - 1)))"
	for message_id in $(seq "$RET_REPLIED_MSG_ID" $((SENT_MSG_ID - 1))); do # -1 because we don't want to delete the "Purging" message
		echo "Deleting message $message_id"
		tg --delmsg "$RET_CHAT_ID" "$message_id" &
	done
	wait # make sure all background jobs are finished
	local purge_end_time=$(date +%s.%N)
	local purge_time_diff=$(echo "$purge_end_time - $purge_start_time" | bc)

	if [ -z "$(echo "$RET_LOWERED_MSG_TEXT" | tr -d '^.purge')" ]; then
		tg --editmsg "$RET_CHAT_ID" "$SENT_MSG_ID" "Purged $((SENT_MSG_ID - 1 - RET_REPLIED_MSG_ID)) messages in $(round "$purge_time_diff" 2)s."
	else
		tg --editmsg "$RET_CHAT_ID" "$SENT_MSG_ID" "Purged $((SENT_MSG_ID - 1 - RET_REPLIED_MSG_ID)) messages in $(round "$purge_time_diff" 2)s.
Reason: $(echo "$RET_LOWERED_MSG_TEXT" | tr -d '^.purge')"
	fi
}
all_replace() {
	TRIMMED=${RET_MSG_TEXT#.all_replace }
	echo "${RET_REPLIED_MSG_TEXT}" > sed.txt
	echo "sed -i "s/${TRIMMED}/g" sed.txt"
	sed -i "s/${TRIMMED}/g" sed.txt
	text=$(cat sed.txt)
	tg --replymsg "$RET_CHAT_ID" "$RET_REPLIED_MSG_ID" "${text}"
	rm sed.txt
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
pfp() {
	if [ "${RET_REPLIED_MSGGER_ID}" != "null" ]; then
		tg --getuserpfp "${RET_REPLIED_MSGGER_ID}"
		tg --downloadfile "$FILE_ID" "pfp.jpg"
	else
		tg --getuserpfp "${MSGGER}"
		tg --downloadfile "$FILE_ID" "pfp.jpg"
	fi
	tg --replyfile "$RET_CHAT_ID" "$RET_MSG_ID" "pfp.jpg"
	rm pfp.jpg
}
iq() {
	if [[ $USERNAME == 'Ksauraj' ]]; then
		iq=$(shuf -i 0-8 -n1)
		iq=$(expr 180 - "$iq")
		tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Calculating your IQ, wait plox..."
		tg --editmsg "$RET_CHAT_ID" "$SENT_MSG_ID" "@${USERNAME} calculated IQ Score is ${iq}."
	else
		tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Calculating your IQ, wait plox..."
		sha=$(echo "${FIRST_NAME}" | sha1sum | grep -Eo "[[:digit:]]{2}" | head -n1)
		md5=$(echo "${USERNAME}" | md5sum | grep -Eo "[[:digit:]]{2}" | head -n1)
		num1=$(expr "${sha}" + "${md5}" | head -n1)
		num2=$(shuf -i 0-5 -n1)
		f=$(expr "${num1}" - "${num2}" )
		iq=$(expr 180 - "$f" )
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
	if [ "${RET_REPLIED_MSGGER_ID}" != "null" ]; then
		USERNAME=$(echo "$USERNAME" | sed 's/[`~!@#$%^&*()-_=+{}\|;:",<.>/?'"'"']/\\&/g')
		FIRST_NAME=$( echo "$FIRST_NAME" | sed 's/[`~!@#$%^&*()-_=+{}\|;:",<.>/?'"'"']/\\&/g')
		LAST_NAME=$(echo "$LAST_NAME" | sed 's/[`~!@#$%^&*()-_=+{}\|;:",<.>/?'"'"']/\\&/g')
		RET_REPLIED_MSGGER_FIRST_NAME=$(echo "$RET_REPLIED_MSGGER_FIRST_NAME" | sed 's/[`~!@#$%^&*()-_=+{}\|;:",<.>/?'"'"']/\\&/g')
		RET_REPLIED_MSGGER_LAST_NAME=$(echo "$RET_REPLIED_MSGGER_LAST_NAME" | sed 's/[`~!@#$%^&*()-_=+{}\|;:",<.>/?'"'"']/\\&/g')
		RET_REPLIED_MSGGER_USERNAME=$(echo "$RET_REPLIED_MSGGER_USERNAME" | sed 's/[`~!@#$%^&*()-_=+{}\|;:",<.>/?'"'"']/\\&/g')
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
replace() {
	TRIMMED=${RET_MSG_TEXT#.replace }
	echo "${RET_REPLIED_MSG_TEXT}" > sed.txt
	echo "sed -i \"s/${TRIMMED}/\" sed.txt"
	sed -i "s/${TRIMMED}/" sed.txt
	text=$(cat sed.txt)
	tg --replymsg "$RET_CHAT_ID" "$RET_REPLIED_MSG_ID" "${text}"
	rm sed.txt
}
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
log() {
	if is_botowner; then
		tg --replyfile "$RET_CHAT_ID" "$RET_MSG_ID" log
	else
		tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Only owner can use this command."
	fi
}
reset_log() {
	if is_botowner; then
		rm log > /dev/null 2>&1
		tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Log handler reset succesfully."
	else
		tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Only owner can use this command."
	fi
}
## While loop
while true; do
	# Refresh stuff
	update
	[ "$RET_MSG_TEXT" ] && echo "$RET_MSG_TEXT" | tee -a log
	RET_LOWERED_MSG_TEXT=$(tr '[:upper:]' '[:lower:]' <<<"$RET_MSG_TEXT")

	case $RET_LOWERED_MSG_TEXT in

	'/start'*) start | tee -a log ;;
	'.all_replace'*) all_replace  | tee -a log ;;
	'.calc'*) calc  | tee -a log ;;
	'.iq'*) iq  | tee -a log ;;
	'.info'*) info  | tee -a log ;;
	'.magisk'*) magisk  | tee -a log ;;
	'.neofetch'*) neo_fetch  | tee -a log ;;
	'.pfp'*) pfp | tee -a log ;;
	'.replace'*) replace  | tee -a log ;;
	'.weath'*) weath  | tee -a log ;;
	'.log'*) log ;;
	'.reset_log'*) reset_log ;;
	'.purge'*) purge ;;
	esac

	# Always run this
	spam_protector

	unset RET_MSG_TEXT RET_REPLIED_MSG_ID
done


