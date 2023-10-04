#!/bin/bash

shuffle() {
    if ( "$RET_REPLIED_MSG_TEXT" == null); 
    then 
        tg --replymarkdownv2msg "$RET_CHAT_ID" "$RET_MSG_ID" "Please reply to some message for using shuffle."
    else
        text=$(echo "${RET_REPLIED_MSG_TEXT}" | sed "s/ /\n/g" | shuf | tr '\n' ' ' | sed 's/[][`~!@#$%^&*()-_=+{}\|;:",<.>/?'"'"']/\\&/g')
        tg --replymarkdownv2msg "$RET_CHAT_ID" "$RET_MSG_ID" "${text}"  
    fi
  }
