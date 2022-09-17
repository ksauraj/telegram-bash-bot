#!/bin/bash

magisk() {
		tg --sendmsg "$RET_CHAT_ID" "Fetching latest Magisk stable"
		LATEST_STABLE=$(
			curl -s https://api.github.com/repos/topjohnwu/Magisk/releases/latest |
				grep "Magisk-v**.*.apk" |
				cut -d : -f 2,3 |
				tr -d \" |
				cut -d, -f2 |
				tr -d '\n' |
				tr -d ' '
		)
		CANARY="https://raw.githubusercontent.com/topjohnwu/magisk-files/canary/app-debug.apk"
		tg --editmarkdownv2msg "$RET_CHAT_ID" "$SENT_MSG_ID" "[Latest stable]($LATEST_STABLE)
[Latest canary]($CANARY)"
}
