#!/bin/bash

# Check if the bot was restarted when sourced
if [ -n "$BOT_RESTARTED" ]; then
    log -i bot_util "Bot was restarted"
    tg --editmsg "$RET_CHAT_ID" "$SENT_MSG_ID" "Bot restarted."
fi

bot_util::restart() {
    tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Restarting bot"
    log -i bot_util "Restarting bot"
    export BOT_RESTARTED=true
    export RET_CHAT_ID
    export SENT_MSG_ID
    exec bash tgbot.sh
}

bot_util::update() {
    tg --replymsg "$RET_CHAT_ID" "$RET_MSG_ID" "Updating bot"
    log -i bot_util "Updating bot"
    log -v bot_util "Adding safe directory to git"
    git config --global --add safe.directory /app
    log -v bot_util "Running git pull"
    git pull || {
        git update-ref -d HEAD
        git pull
    } || local bot_update_error=true

    if [ "$bot_update_error" = true ]; then
        tg --editmsg "$RET_CHAT_ID" "$SENT_MSG_ID" "Failed to update bot."
        log -e bot_util "git pull failed"
    else
        tg --editmsg "$RET_CHAT_ID" "$SENT_MSG_ID" "Bot updated. It is recommended to restart the bot."
        log -i "Bot updated"
        log -d "git pull exited with success"
    fi
}

