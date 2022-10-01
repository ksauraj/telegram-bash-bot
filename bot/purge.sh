#!/bin/bash 

purge() {
    echo "Purge called"
    if [ "$RET_REPLIED_MSG_ID" = null ]; then
        tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Reply to a message plox"
        return
    fi

    if ! is_admin "$RET_CHAT_ID" "$MSGGER"; then
        tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "You are not an admin"
        return
    elif ! is_admin "$RET_CHAT_ID" "$BOT_ID"; then
        tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "I am not an admin"
        return
    fi

    tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Purging"
    local purge_start_time=$(date +%s.%N)
    log -d purge "purge ret rep $RET_REPLIED_MSG_ID"
    log -d purge "purge sent $SENT_MSG_ID"
    log -d purge "purge seq debug: $(seq "$RET_REPLIED_MSG_ID" $((SENT_MSG_ID - 1)))"
    for message_id in $(seq "$RET_REPLIED_MSG_ID" $((SENT_MSG_ID - 1))); do # -1 because we don't want to delete the "Purging" message
        log -v purge "Deleting message $message_id"
        tg --delmsg "$RET_CHAT_ID" "$message_id" &
    done
    wait # make sure all background jobs are finished
    local purge_end_time=$(date +%s.%N)
    local purge_time_diff=$(echo "$purge_end_time - $purge_start_time" | bc)

    if [ -z "$(echo "$RET_LOWERED_MSG_TEXT" | tr -d '^.purge')" ]; then
        tg --editmsg "$RET_CHAT_ID" "$SENT_MSG_ID" "Purged $((SENT_MSG_ID - 1 - RET_REPLIED_MSG_ID)) messages in $(round "$purge_time_diff" 2)s."
    else
        tg --editmsg "$RET_CHAT_ID" "$SENT_MSG_ID" "Purged $((SENT_MSG_ID - 1 - RET_REPLIED_MSG_ID)) messages in $(round "$purge_time_diff" 2)s.
Reason: $(echo "$RET_LOWERED_MSG_TEXT" | tr -d '^.purge')"
    fi
}
