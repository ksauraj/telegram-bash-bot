#!/usr/bin/bash

choice(){
  num=$(shuf -i 1-25 -n 1)

  if [ "$num" -lt 5 ]; then
    tg --replymsg "$RET_CHAT_ID" "$RET_REPLIED_MSG_ID" "Strongly Yes"
  elif [ "$num" -lt 9 ]; then
    tg --replymsg "$RET_CHAT_ID" "$RET_REPLIED_MSG_ID" "No"
  elif [ "$num" -lt 13 ]; then
    tg --replymsg "$RET_CHAT_ID" "$RET_REPLIED_MSG_ID" "Partial Yes"
  elif [ "$num" -lt 17 ]; then
    tg --replymsg "$RET_CHAT_ID" "$RET_REPLIED_MSG_ID" "Yes"
  elif [ "$num" -lt 21 ]; then
    tg --replymsg "$RET_CHAT_ID" "$RET_REPLIED_MSG_ID" "Strongly No"
  else
    tg --replymsg "$RET_CHAT_ID" "$RET_REPLIED_MSG_ID" "Cannot decide..."
  fi
}
