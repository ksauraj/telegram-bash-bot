#!/bin/bash
shuffle() {
    text=$(echo "${RET_REPLIED_MSG_TEXT}" | sed "s/ /\n/g" | shuf | tr '\n' ' ' | sed 's/[][`~!@#$%^&*()-_=+{}\|;:",<.>/?'"'"']/\\&/g')
    tg --replymarkdownv2msg "$RET_CHAT_ID" "$RET_MSG_ID" "${text}"
}
