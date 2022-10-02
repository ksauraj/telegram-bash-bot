## Telegram Bash Bot
A telegram bot written in bash, which can perfor various functions over [Telegram Bot API](https://core.telegram.org/bots/api). You can take this project as a template for making your own bot.
> Uses https://core.telegram.org/bots/api for API calls.

### What is Telegram Bot ?
Telegram bots are small programs that can embed in Telegram chats or public channels and perform a specific function. They can offer customized keyboards, produce cat memes on demand, or even accept payments and act as a digital storefront.

### How to make telegram bot?
So we are here to help you. We are providing you this template for creating your own bot written in `bash`.

### How to run this bot?
All you need is `bash` to be installed in your system with some other dependencies listed below. We even have Docker support _(Beta)_.

#### Dependencies
- curl
- jq
- bc
> Some other Dependencies too but mostly they are pre-installed on most systems. Full list will be updated soon.

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

### How to Create Your own Bot using this ?
Well, this would be lot easier if you are using this template. Below are guides to get started.

#### Adding your own features to bot.

All functions of bot are present in `bot/` which are sourced to tgbot.sh. By this way we make our code look simpler and more human readable.

#### How to utilise `util.sh`?
We made calling [Telegram Bot API](https://core.telegram.org/bots/api) simpler with help of `util.sh`. Like, You can send message by `tg --sendmsg "<chat id>"` and edit message by `tg --editmsg "<chat id>" "<message id>"`.
__We would be adding more Documentation on this topic in future__.
> Above commands will only work when you have your `Bot token` stored in `.token` file of current directory.

#### Adding more methods to call Telegram Bot API.

All functions related to [Telegram Bot API](https://core.telegram.org/bots/api) are present in  `util.sh`. You can add new methods following the current style of `variable names` to look it simpler.

## Contributions
Feel free to contribute to any part of this project. _(Like Documentation, Adding more methods and feature and endless possiblities)_.

> By @noobyysauraj & @Hakimi0804
