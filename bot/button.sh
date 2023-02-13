button() {
    tg --replywithinlinebutton "$RET_CHAT_ID" "$RET_MSG_ID" "Press this button before 5 minute to see hidden message." "Press"
    runtime="5 minute"
    endtime=$(date -ud "$runtime" +%s)
    while [[ $(date -u +%s) -le $endtime ]]
    do
        update
        if [ "$CALL_BACK_QUERY_DATA" == "$CALLBACK_DATA" ]; then
            if [ "$CALL_BACK_QUERY_USERNAME" == "$REPLIED_TO" ]; then
                echo "button was pressed"
                tg --editmsg "$QUERY_SENT_CHAT_ID" "$SENT_MSG_ID" "Thanks for pressing the button. You are awsome...."
                break
            else
                tg --answercallbackquery "$QUERY_SENT_CHAT_ID" "This button is not for you." "$CALL_BACK_QUERY_ID"
            fi
        fi
    done
}
