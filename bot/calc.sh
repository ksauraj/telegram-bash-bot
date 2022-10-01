#!/bin/bash

calc() {
    TRIMMED="${RET_MSG_TEXT#.calc}"
    CALCED=$(echo "$TRIMMED" | bc -l 2>&1)
    if ! echo "$CALCED" | grep -q 'syntax error'; then
        ROUNDED=$(round "$CALCED" 2)
        tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "$ROUNDED"
    else
        tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Bruh, did you just entered nonsense, cuz bc ain't happy"
    fi
}
