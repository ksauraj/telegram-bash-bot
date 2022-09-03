#!/bin/bash

TOKEN=""
BOT_OWNER_ID=""
SYNTAX_CHECK="True"
INTERACTIVE="True"
touch .token.sh

if [ "$INTERACTIVE" == "True" ]; then
    read -p "Enter Bot Token : " TOKEN
    echo "#!/bin/bash" >> .token.sh
    echo TOKEN="$TOKEN" >> .token.sh
    read -p "Enter Owner ID : " BOT_OWNER_ID
    echo BOT_OWNER_ID="$BOT_OWNER_ID" >> .token.sh
    read -p "Enable Syntax Checking [True/False] : " SYNTAX_CHECK
else
	echo "Using Non-Interactive Mode."
	echo "#!/bin/bash" >> .token.sh
    echo TOKEN="$TOKEN" >> .token.sh
    echo BOT_OWNER_ID="$BOT_OWNER_ID" >> .token.sh
fi

pr_blue() {
	echo -e "\e[1;34m$*\e[0m"
}

if [[ "$SYNTAX_CHECK" == "True" ]]; then

	SCRIPTS=$(find -iname '*.sh')
	echo "$0"
	for script in $SCRIPTS; do
		[ "$script" = "$0" ] && continue
		pr_blue "LINT (SHELLCHECK): $script"
		shellcheck -ax "$script"
	done

	read -n1 -t5 -p "Proceed with shfmt?[y/N]: " SHFMT_PROMPT

	[ "$SHFMT_PROMPT" = "y" ] && {
		echo
		for script in $SCRIPTS; do
			pr_blue "LINT (SHFMT): $script"
			shfmt -w "$script"
		done
	}
else
	pr_blue Skipping Syntax Checking.
fi

read -n1 -t20 -p "Start Bot? [y/N]: " START_BOT
[ "$START_BOT" = "y" ] && {
bash tgbot.sh
}
