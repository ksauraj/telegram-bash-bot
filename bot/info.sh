#!/bin/bash 

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
