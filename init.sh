#!/bin/bash

pr_blue() {
	echo -e "\e[1;34m$*\e[0m"
}

TOKEN=""
BOT_OWNER_ID=""
WEATH_API_KEY=""
SYNTAX_CHECK="True"
INTERACTIVE="True"

rm .token.sh
touch .token.sh

if [ "$INTERACTIVE" == "True" ]; then
    read -rsp "Enter Bot Token : " TOKEN
	echo
    echo "#!/bin/bash" >> .token.sh
    echo TOKEN="$TOKEN" >> .token.sh
    read -rp "Enter Owner ID : " BOT_OWNER_ID
    echo BOT_OWNER_ID="$BOT_OWNER_ID" >> .token.sh
    pr_blue "Get API KEY for .weath from https://rapidapi.com/apishub/api/yahoo-weather5"
    read -rsp "Enter API KEY FOR .weath :" WEATH_API_KEY
	echo
    echo WEATH_API_KEY="$WEATH_API_KEY" >> .token.sh
    read -rp "Enable Syntax Checking [True/False] : " SYNTAX_CHECK
else
	echo "Using Non-Interactive Mode."
	{
		echo "#!/bin/bash"
		echo TOKEN="$TOKEN"
		echo WEATH_API_KEY="$WEATH_API_KEY"
		echo BOT_OWNER_ID="$BOT_OWNER_ID"
	} >> .token.sh
fi


if [[ "$SYNTAX_CHECK" == "True" ]]; then

	SCRIPTS=$(find -iname '*.sh')
	echo "$0"
	for script in $SCRIPTS; do
		[ "$script" = "$0" ] && continue
		pr_blue "LINT (SHELLCHECK): $script"
		shellcheck -ax "$script"
	done

	read -r -n1 -t5 -p "Proceed with shfmt?[y/N]: " SHFMT_PROMPT

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

read -r -n1 -t20 -p "Start Bot? [y/N]: " START_BOT
[ "$START_BOT" = "y" ] && {
bash tgbot.sh
}
