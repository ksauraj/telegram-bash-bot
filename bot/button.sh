button() {
    tg --sendwithinlinebutton "$RET_CHAT_ID" "This is button" "Press"
    while true; do
        update
        if [ $CALL_BACK_QUERY_DATA == "Pressed" ]; then
        echo "button was pressed"
        echo "$RET_CHAT_ID" "$SENT_MSG_ID"
        tg --editmsg "$SENT_CHAT_ID" "$SENT_MSG_ID" "You pressed button."
        break
        fi
    done
}
