#!/bin/bash

replace() {
    TRIMMED=${RET_MSG_TEXT#.replace }
    echo "${RET_REPLIED_MSG_TEXT}" > sed.txt
    echo "sed -i \"s/${TRIMMED}/\" sed.txt"
    sed -i "s/${TRIMMED}/" sed.txt
    text=$(cat sed.txt)
    tg --replymsg "$RET_CHAT_ID" "$RET_REPLIED_MSG_ID" "${text}"
    rm sed.txt
}
