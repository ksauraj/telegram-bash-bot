#!/bin/bash

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

    if is_admin "$RET_CHAT_ID" "$MSGGER"; then
        echo "spam_protector: User is admin, skipped checking"
        return
    fi

	for word in "${msg_spam_words[@]}"; do
		if echo "$RET_LOWERED_MSG_TEXT" | grep -q "$word"; then
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
