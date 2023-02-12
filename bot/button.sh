button() {
    tg --sendwithinlinebutton "$RET_CHAT_ID" "Press this button before 5 minute to see hidden message." "Press"
    runtime="5 minute"
    endtime=$(date -ud "$runtime" +%s)
    while [[ $(date -u +%s) -le $endtime ]]
    do
        update
        if [ "$CALL_BACK_QUERY_DATA" == "$CALLBACK_DATA" ]; then
        echo "button was pressed"
        tg --editmsg "$QUERY_SENT_CHAT_ID" "$SENT_MSG_ID" "Thanks for pressing the button. You are awsome...."
        break
        fi
    done
}
