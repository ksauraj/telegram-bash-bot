#!/bin/bash

clear

## Sourcing stuffs (Our functions, extra functions ans aliases, etc)
source util.sh
echo "STARTING BOT"

## While loop
while true; do
	# Refresh stuff
	update
	[ "$RET_MSG_TEXT" ] && echo "$RET_MSG_TEXT"
	RET_LOWERED_MSG_TEXT=$(tr '[:upper:]' '[:lower:]' <<<"$RET_MSG_TEXT")

	case $RET_LOWERED_MSG_TEXT in
	## Not so useful
	'/start'*) tg --replymarkdownv2msg "$RET_CHAT_ID" "$RET_MSG_ID" "A Simple bot from @Ksauraj and @Hakimi0804\."
	;;

	esac

	unset RET_MSG_TEXT RET_REPLIED_MSG_ID
done

