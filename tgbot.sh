#!/bin/bash
## Sourcing stuffs (Our functions, extra functions ans aliases, etc)
source util.sh
echo "STARTING BOT"
clear

#Defining Function
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
start() {
    tg --replymarkdownv2msg "$RET_CHAT_ID" "$RET_MSG_ID" "A Simple bot from @Ksauraj and @Hakimi0804\."
}



## While loop
while true; do
	# Refresh stuff
	update
	[ "$RET_MSG_TEXT" ] && echo "$RET_MSG_TEXT"
	RET_LOWERED_MSG_TEXT=$(tr '[:upper:]' '[:lower:]' <<<"$RET_MSG_TEXT")

	case $RET_MSG_TEXT in

	'/start'*) start ;;
	'.calc'*) calc ;;
	esac

	unset RET_MSG_TEXT RET_REPLIED_MSG_ID
done


