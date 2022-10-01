#!/bin/bash

reset_log() {
    if is_botowner; then
        rm log > /dev/null 2>&1
        tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Log handler reset succesfully."
    else
        tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Only owner can use this command."
    fi
}
