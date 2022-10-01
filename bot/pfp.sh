#!/bin/bash

pfp() {
    if [ "${RET_REPLIED_MSGGER_ID}" != "null" ]; then
        tg --getuserpfp "${RET_REPLIED_MSGGER_ID}"
        tg --downloadfile "$FILE_ID" "pfp.jpg"
    else
        tg --getuserpfp "${MSGGER}"
        tg --downloadfile "$FILE_ID" "pfp.jpg"
    fi
    tg --replyfile "$RET_CHAT_ID" "$RET_MSG_ID" "pfp.jpg"
    rm pfp.jpg
}
