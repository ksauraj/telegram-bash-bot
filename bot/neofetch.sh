#!/bin/bash

neo_fetch() {
    tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "This may take a while depending upon host..."
    NEOFETCH_OUTPUT=$(neofetch --stdout)
    tg --editmsg "$RET_CHAT_ID" "$SENT_MSG_ID" "$NEOFETCH_OUTPUT"
}
