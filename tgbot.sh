#!/bin/bash

#Clear & Clean terminal before starting
clear
rm log  > /dev/null 2>&1
## Sourcing stuffs (Our functions, extra functions and aliases, etc)
source bot/all_replace.sh
source bot/calc.sh
source bot/info.sh
source bot/iq.sh
source bot/log.sh
source bot/magisk.sh
source bot/neofetch.sh
source bot/pfp.sh
source bot/purge.sh
source bot/replace.sh
source bot/reset_log.sh
source bot/round.sh
source bot/spam_protector.sh
source bot/start.sh
source bot/weath.sh
source .token.sh
source util.sh

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


