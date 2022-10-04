## Deploying Bot
All you need is `bash` to be installed in your system with some other dependencies listed below. We even have Docker support _(Beta)_.

### Deploying Locally
You can easily deploy this bot locally. It can run in termux too without much pain.
####  Dependencies
- git
- curl
- jq
- bc
- shuf
- neofetch
- ffmpeg

> Some other Dependencies too but mostly they are pre-installed on most systems. Full list will be updated soon.
#### Clone this repo
You need to clone this repo for further operations.
```bash
git clone https://github.com/noobyysauraj/telegram-bash-bot && cd telegram-bash-bot
```
#### Running bot (interactive mode)
> Recquired first time for setting up your config.
```bash
bash init.sh
```

#### Running bot (non-interactive)
> Make sure your configs are stored in `.token` before running in non-interactive mode.
```bash
bash tgbot.sh
```

### Deploying on Railway
Hopefully, We have Docker support _(Beta)_. So, it won't be pain to Deploy on [Railway](https://railway.app/).
- Just login.
- Make a project.
- Select this repo/your modified repo.
- Add [custom variable](https://noobyysauraj.github.io/telegram-bash-bot/#variables) to your project. Check [here](https://docs.railway.app/develop/variables), how to add custom variable in railway.

#### Variables
Add these variables if you want to run the bot in __non-interactive__ mode.
```bash
TOKEN="<Bot Token of your bot>"
BOT_OWNER_ID="<Owner ID>"
WEATH_API_KEY="<Weather Api key>" #https://rapidapi.com/apishub/api/yahoo-weather5 (.weath won't work without this.)
```
