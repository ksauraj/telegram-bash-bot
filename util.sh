#!/bin/bash
source .token.sh

if [ -z "$TOKEN" ]; then
	echo "Cannot load token, exiting"
	exit 1
fi

API="https://api.telegram.org/bot$TOKEN"
tg() {
	case $1 in
	--editmsg | --editmarkdownv2msg)
		local PARAM=$1
		shift
		local CHAT_ID=$1
		local MSG_ID=$2
		local NEW_TEXT=$3
		if [[ "$PARAM" =~ "--editmarkdownv2msg" ]]; then
			curl -s "$API/editMessageText" -d "chat_id=$CHAT_ID" -d "message_id=$MSG_ID" -d "text=$NEW_TEXT" -d "parse_mode=MarkdownV2" | jq .
		else
			curl -s "$API/editMessageText" -d "chat_id=$CHAT_ID" -d "message_id=$MSG_ID" -d "text=$NEW_TEXT" | jq .
		fi
		;;
		--editmsgurl)
		local PARAM=$1
		shift
		local CHAT_ID=$1
		local MSG_ID=$2
		local NEW_TEXT=$3
		curl -s "$API/editMessageText" -F "chat_id=$CHAT_ID" -F "message_id=$MSG_ID" -F "text=$NEW_TEXT" | jq .
		;;
	--sendmsg)
		shift
		local CHAT_ID=$1
		local MSG=$2
		local RESULT=$(curl -s "$API/sendMessage" -d "chat_id=$CHAT_ID" -d "text=$MSG")
		SENT_MSG_ID=$(echo "$RESULT" | jq '.result | .message_id')
		;;
	--sendmarkdownv2msg)
		shift
		local CHAT_ID=$1
		local MSG=$2
		local RESULT=$(curl -s "$API/sendMessage" -d "chat_id=$CHAT_ID" -d "parse_mode=MarkdownV2" -d "text=$MSG")
		SENT_MSG_ID=$(echo "$RESULT" | jq '.result | .message_id')
		;;
	--replymsg)
		shift
		local CHAT_ID=$1
		local MSG_ID=$2
		local MSG=$3
		local RESULT=$(curl -s "$API/sendMessage" -d "chat_id=$CHAT_ID" -d "reply_to_message_id=$MSG_ID" -d "text=$MSG" | jq .)
		SENT_MSG_ID=$(echo "$RESULT" | jq '.result | .message_id')
		;;
	--replyfile)
		shift
		local CHAT_ID=$1
		local MSG_ID=$2
		local MSG=$3
		local RESULT=$(curl -s "$API/sendDocument" -F "chat_id=$CHAT_ID" -F "reply_to_message_id=$MSG_ID" -F "document=@\"$MSG\"" | jq .)
		SENT_MSG_ID=$(echo "$RESULT" | jq '.result | .message_id')
		;;
	--replymsghtml)
		shift
		local CHAT_ID=$1
		local MSG_ID=$2
		local MSG=$3
		local RESULT=$(curl -s "$API/sendMessage" --form "chat_id=$CHAT_ID" --form "reply_to_message_id=$MSG_ID" --form "text=$MSG" | jq .)
		SENT_MSG_ID=$(echo "$RESULT" | jq '.result | .message_id')
		;;
	--replymsgmarkdown)
		shift
		local CHAT_ID=$1
		local MSG_ID=$2
		local MSG=$3
		local RESULT=$(curl -s "$API/sendMessage" -d "chat_id=$CHAT_ID" -d "reply_to_message_id=$MSG_ID" --data-urlencode "text=$MSG" | jq .)
		SENT_MSG_ID=$(echo "$RESULT" | jq '.result | .message_id')
		;;
	--replymarkdownv2msg)
		shift
		local CHAT_ID=$1
		local MSG_ID=$2
		local MSG=$3
		local RESULT=$(curl -s "$API/sendMessage" -d "chat_id=$CHAT_ID" -d "reply_to_message_id=$MSG_ID" -d "text=$MSG" -d "parse_mode=MarkdownV2" | jq .)
		SENT_MSG_ID=$(echo "$RESULT" | jq '.result | .message_id')
		echo "$RESULT"
		;;
	--delmsg)
		shift
		local CHAT_ID=$1
		local MSG_ID=$2
		curl -s "$API/deleteMessage" -d "chat_id=$CHAT_ID" -d "message_id=$MSG_ID" | jq .
		;;
	--sendsticker | --replysticker)
		local PARAM=$1
		shift
		local CHAT_ID=$1
		local FILE_ID=$2
		if [[ "$PARAM" =~ "--replysticker" ]]; then
			local MSG_ID=$2
			local FILE_ID=$3
			curl -s "$API/sendSticker" -d "chat_id=$CHAT_ID" -d "sticker=$FILE_ID" -d "reply_to_message_id=$MSG_ID" | jq .
		else
			curl -s "$API/sendSticker" -d "chat_id=$CHAT_ID" -d "sticker=$FILE_ID" | jq .
		fi
		;;
	--fwdmsg | --cpmsg)
		local PARAM=$1 # Save this to check for --cpmsg
		shift
		local FROM=$1
		local TO=$2
		local MSG_ID=$3
		if [ "$PARAM" = "--cpmsg" ]; then
			local MODE=copyMessage
		else
			local MODE=forwardMessage
		fi
		curl -s "$API/$MODE" -d "from_chat_id=$FROM" -d "chat_id=$TO" -d "message_id=$MSG_ID"
		;;
	--pinmsg)
		shift
		local CHAT_ID=$1
		local MSG_ID=$2
		curl -s "$API/pinChatMessage" -d "chat_id=$CHAT_ID" -d "message_id=$MSG_ID"
		;;
	--unpinmsg)
		shift
		local CHAT_ID=$1
		local MSG_ID=$2
		curl -s "$API/unpinChatMessage" -d "chat_id=$CHAT_ID" -d "message_id=$MSG_ID"
		;;
	--getuserpfp) #pfp -> Profile Photo
		shift
		local USER_ID=$1
		local RESULT=$(curl -s "$API/getUserProfilePhotos" -d "user_id=$USER_ID" | jq . )
		echo $RESULT
		FILE_ID=$(echo "$RESULT" | jq -r '.result.photos[0][0].file_id')
		FILE_PATH=$(echo "$RESULT" | jq -r '.result.photos[0][0].file_path')
		;;
	# --downloadfile -> OUTPUT_FILE should be complete name of file including MIME type / extension.
	--downloadfile)
		shift
		local FILE_ID=$1
		local OUTPUT_FILE=$2
		local RESULT=$(curl -s "$API/getFile" -d "file_id=$FILE_ID" | jq .)
		echo $RESULT
		FILE_ID=$(echo "$RESULT" | jq -r '.result.file_id')
		FILE_PATH=$(echo "$RESULT" | jq -r '.result.file_path')
		curl -s "https://api.telegram.org/file/bot$TOKEN/$FILE_PATH" -o $OUTPUT_FILE
	esac
}

update() {
	FETCH=$(curl -s "$API/getUpdates" -d "offset=-1" -d "timeout=60" | jq '.result[]')
	UPDATE_ID=$(echo "$FETCH" | jq '.update_id')
	[ -z "$PREV_UPDATE_ID" ] && PREV_UPDATE_ID=$UPDATE_ID

	if [[ $UPDATE_ID -gt $PREV_UPDATE_ID ]]; then
		# IDs
		PREV_UPDATE_ID=$UPDATE_ID
		RET_MSG_ID=$(echo "$FETCH" | jq '.message.message_id')
		RET_CHAT_ID=$(echo "$FETCH" | jq '.message.chat.id')
		RET_CHAT_TYPE=$(echo "$FETCH" | jq -r '.message.chat.type')
		MSGGER=$(echo "$FETCH" | jq '.message.from.id')
		RET_FILE_ID=$(echo "$FETCH" | jq -r '.message.document.file_id')

		# Strings
		RET_MSG_TEXT=$(echo "$FETCH" | jq -r '.message.text')
		FIRST_NAME=$(echo "$FETCH" | jq -r '.message.from.first_name')
		LAST_NAME=$(echo "$FETCH" | jq -r '.message.from.last_name')
		USERNAME=$(echo "$FETCH" | jq  -r '.message.from.username')

		# Replies
		RET_REPLIED_MSG_ID=$(echo "$FETCH" | jq '.message.reply_to_message.message_id')
		RET_REPLIED_MSGGER_ID=$(echo "$FETCH" | jq '.message.reply_to_message.from.id')
		RET_REPLIED_MSGGER_FIRST_NAME=$(echo "$FETCH" | jq -r '.message.reply_to_message.from.first_name')
		RET_REPLIED_MSGGER_LAST_NAME=$(echo "$FETCH" | jq -r '.message.reply_to_message.from.last_name')
		RET_REPLIED_MSGGER_USERNAME=$(echo "$FETCH" | jq -r '.message.reply_to_message.from.username')
		RET_REPLIED_MSG_TEXT=$(echo "$FETCH" | jq -r '.message.reply_to_message.text')
		RET_REPLIED_FILE_ID=$(echo "$FETCH" | jq -r '.message.reply_to_message.document.file_id')

		# Stickers
		STICKER_EMOJI=$(echo "$FETCH" | jq -r '.message.sticker.emoji')
		STICKER_FILE_ID=$(echo "$FETCH" | jq -r '.message.sticker.file_id')
		STICKER_PACK_NAME=$(echo "$FETCH" | jq -r '.message.sticker.set_name')
	fi
}

is_botowner() {
	[ "$MSGGER" = "$BOT_OWNER_ID" ] && return 0
	return 1
}

err_not_botowner() {
	tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "You are not allowed to use this command."
}

