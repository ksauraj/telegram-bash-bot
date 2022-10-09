#!/bin/bash

shell() {
    # Check if msg is empty
    if [ -z "$(echo "$RET_MSG_TEXT" | sed 's/^\.shell//')" ]; then
        tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Give something to run"
        return
    fi

    local cmd=$(echo "$RET_MSG_TEXT" | sed 's/^\.shell//')
    tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Running command"

    log -i shell "Running command"
    log -v shell "Command: $cmd"

    # TODO: Make this command evaluation run in the background
    #       currently it's not being done because of the poor
    #       specs that fly.io gives
    local output
    output=$(eval "$cmd" 2>&1)
    local status=$?

    log -i shell "Command exited with code: $status"
    tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Command exited with status $status, output:
$output"
}
