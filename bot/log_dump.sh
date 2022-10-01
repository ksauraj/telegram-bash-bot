#!/bin/bash

log_dump() {
    if ! is_botowner; then
        tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Only owner can use this command."
        return
    fi

    local split_msg=($RET_LOWERED_MSG_TEXT) # Purposefully unquoted
    local switch=${split_msg[1]}
    local logtype=${split_msg[2]}
    local tempfile=$(mktemp)
    local tempfile_result=$(mktemp)

    # Check if --exclude or --only is in msg
    local switch_exclude=false
    local switch_only=false
    if [ "${switch}" = --exclude ]; then
        switch_exclude=true
        log -d log_dump "switch_exclude set to true"
    elif [ "${switch}" = --only ]; then
        switch_only=true
        log -d log_dump "switch_only set to true"
    fi

    if [ "$switch_exclude" = true ] && [ "$switch_only" = true ]; then
        tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "--exclude and --only cannot be used together."
        return
    fi

    # Make sure logtype is not empty after --exclude / --only
    if [ "$switch_only" = true ] || [ "$switch_only" = true ]; then
        if [ -z "$logtype" ]; then
            tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Missing log type after $switch"
            return
        fi
    fi

    if [ -z "$switch" ]; then
        tg --replyfile "$RET_CHAT_ID" "$RET_MSG_ID" bot.log
        return
    fi

    # Return log according to the switches
    local IFS=,
    local invalid_logtype=()
    local ltype
    cp "$LOG_FNAME" "$tempfile"
    for lt in $logtype; do
        ltype=$(log::getLogType "$lt")

        # Store invalid log type
        if [ "$?" != 0 ]; then
            invalid_logtype+=("$lt")
            log -w log_dump "User passed invalid log type: $lt"
            continue
        fi

        if [ "$switch_exclude" = true ]; then
            sed -i "/$ltype:/d" "$tempfile"
            log -v log_dump "Excluding log type: $lt"
        elif [ "$switch_only" = true ]; then
            grep "$ltype:" "$LOG_FNAME" >>"$tempfile_result"
            sort -n "$tempfile_result" -o "$tempfile"
            log -v log_dump "Only-Including log type: $lt"
        fi
    done

    {
        tg --replyfile "$RET_CHAT_ID" "$RET_MSG_ID" "$tempfile"
        rm -f "$tempfile" "$tempfile_result"
    } &

    # Let the user know about invalid log type provided (if any).
    [ -n "$invalid_logtype" ] && tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Warning: Invalid log type was provided: ${invalid_logtype[*]}"
}
