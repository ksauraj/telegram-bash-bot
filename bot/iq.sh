#!/bin/bash

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
