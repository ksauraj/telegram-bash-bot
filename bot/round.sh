#!/bin/bash
round() {
    # $1 = Your number
    # $2 = Amount of decimal places
    FLOAT=$1
    DECIMAL_POINT=$2
    printf "%.${2:-$DECIMAL_POINT}f" "$FLOAT"
}
round_msg() {
    TRIMMED="${RET_MSG_TEXT#.round}"
    ROUNDED=$(round "$TRIMMED" 2)
    tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "$ROUNDED"
}
