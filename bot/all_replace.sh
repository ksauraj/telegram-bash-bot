#!/bin/bash

all_replace() {
    TRIMMED=${RET_MSG_TEXT#.all_replace }
    echo "${RET_REPLIED_MSG_TEXT}" > sed.txt
    log -d all_replace "sed -i "s/${TRIMMED}/g" sed.txt"
    sed -i "s/${TRIMMED}/g" sed.txt
    text=$(cat sed.txt)
    tg --replymsg "$RET_CHAT_ID" "$RET_REPLIED_MSG_ID" "${text}"
    rm sed.txt
}
