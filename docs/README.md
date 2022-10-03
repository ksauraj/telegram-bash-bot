# Telegram Bash Bot
- [About this project](about.md)
- [Available Telegram Methods](supported_methods.md)
- [Stored Variables](variables.md)
- [Deploying Bot](#deploying-bot)
- [Contributions](#contributions)

## About
A telegram bot written in bash, which can perform various functions over [Telegram Bot API](https://core.telegram.org/bots/api). You can take this project as a template for making your own bot.
> Uses https://core.telegram.org/bots/api for API calls.

### What is Telegram Bot ?
Telegram bots are small programs that can embed in Telegram chats or public channels and perform a specific function. They can offer customized keyboards, produce cat memes on demand, or even accept payments and act as a digital storefront.

### How to make telegram bot?
So we are here to help you. We are providing you this template for creating your own bot written in `bash`.

### How to create your own Bot using this ?
Well, this would be lot easier if you are using this template. Below are guides to get started.

#### Adding your own features to bot.

All functions of bot are present in `bot/` which are sourced to tgbot.sh. By this way we make our code look simpler and more human readable.

### How to utilise `util.sh`?
We made calling [Telegram Bot API](https://core.telegram.org/bots/api) simpler with help of `util.sh`. Like, You can send message by `tg --sendmsg "<chat id>"` and edit message by `tg --editmsg "<chat id>" "<message id>"`. More information [here](https://noobyysauraj.github.io/telegram_bash_bot/#available-telegram-methods).
__We would be adding more Documentation on this topic in future__.
> Above commands will only work when you have your `Bot token` stored in `.token.sh` file of current directory.

### Adding more methods to call Telegram Bot API.

All functions related to [Telegram Bot API](https://core.telegram.org/bots/api) are present in  `util.sh`. You can add new methods following the current style of `variable names` to look it simpler.


## Available Telegram Methods
All these methods are defined in [util.sh](https://github.com/noobyysauraj/telegram_bash_bot/blob/master/util.sh). If you think some methods are missing and you can add them, please go ahead and don't forget to open a __pull request__ with the changes you made. [Extension of this part](https://noobyysauraj.github.io/telegram_bash_bot/#stored-variables).
> Commands listed below will only work when you have your `Bot token` stored in `.token.sh` file of current directory.

#### `--sendmsg`
- Use this method to send text messages. On success, the sent Message is returned.
> Example :
> ```bash
> tg --sendmsg "<CHAT ID>" "<Text to Send>"
> ```

#### `--sendmarkdownv2msg`
- Same as `--sendmsg` but works with [Telegram Formatting options](https://core.telegram.org/bots/api#formatting-options) __MarkdownV2 style__.
> Example :
> ```bash
> tg --sendmarkdownv2msg "<CHAT ID>" "<Text to Send with markdown>"
> ```

#### `--editmsg `
- Use this method to edit a existing message sent by the bot.
> Example :
> ```bash
> tg --editmsg "<CHAT ID>" "<MESSAGE ID>" "<Text to edit current message>"
> ```

#### `--editmarkdownv2msg`
- Same as `--editmsg` but works with [Telegram Formatting options](https://core.telegram.org/bots/api#formatting-options) __MarkdownV2 style__.
> Example :
> ```bash
> tg --editmarkdownv2msg "<CHAT ID>" "<MESSAGE ID OF MESSAGE>" "<Text with markdown to edit current message>"
> ```


#### `--replymsg`
- Use this method to reply a message.
> Example :
> ```bash
> tg --replymsg "<CHAT ID>" "<MESSAGE ID OF MESSAGE TO REPLY>" "<Text to Reply>"
> ```


#### `--replyfile`
- Use this method to reply a message with file.
> Example :
> ```bash
> tg --replyfile "<CHAT ID>" "<MESSAGE ID OF MESSAGE TO REPLY>" "<Path of file to Reply>"
> ```

#### `--replymsghtml`
- Use this method to reply a message but with `html` formatting.
> Example :
> ```bash
> tg --replymsghtml "<CHAT ID>" "<MESSAGE ID OF MESSAGE TO REPLY>" "<Text to Reply with HTML Formatting>"
> ```

#### `--replymsgmarkdown`
- Same as `--replymsg` but works with [Telegram Formatting options](https://core.telegram.org/bots/api#formatting-options) __MarkdownV2 style__.
> Example :
> ```bash
> tg --replymsgmarkdown "<CHAT ID>" "<MESSAGE ID OF MESSAGE TO REPLY>" "<Text to Reply with markdown Formatting>"
> ```

#### `--delmsg`
- Use this method to delete telegram message.
> Example :
> ```bash
> tg --delmsg "<CHAT ID>" "<MESSAGE ID OF MESSAGE TO DELETE>"
> ```

#### `--sendsticker`
- Use this method to send sticker.
> Example :
> ```bash
> tg --sendsticker "<CHAT_ID>" "<FILE ID OF STICKER TO SEND"
> ```

#### `--replysticker`
- Use thid method to reply a message with sticker.
> Example :
> ```bash
> tg --replysticker "<CHAT ID>" "<MESSAGE ID OF MESSAGE TO REPLY>" "<FILE ID OF STICKER TO REPLY"
> ```

#### `--fwdmsg`
- Use this method to forward messages of any kind. Service messages can't be forwarded. On success, the sent Message is returned.
> Example :
> ```bash
> tg --fwdmsg "<CHAT ID TO FORWARD FROM>" "<CHAT ID TO FORWARD FROM>" "MESSAGE OF MESSAGE TO FORWARD"
> ```

#### `--cpmsg`
- Use this method to copy messages of any kind. Service messages and invoice messages can't be copied. A quiz poll can be copied only if the value of the field correct_option_id is known to the bot. The method is analogous to the method forwardMessage, but the copied message doesn't have a link to the original message. Returns the MessageId of the sent message on success.
> Example :
> ```bash
> tg --cpmsg "<CHAT ID TO FORWARD FROM>" "<CHAT ID TO FORWARD FROM>" "MESSAGE ID OF MESSAGE TO FORWARD"
> ```

#### `--pinmsg`
- Use this method to add a message to the list of pinned messages in a chat. If the chat is not a private chat, the bot must be an administrator in the chat for this to work and must have the 'can_pin_messages' administrator right in a supergroup or 'can_edit_messages' administrator right in a channel. Returns True on success.
> Example :
> ```bash
> tg --pinmsg "<CHAT ID>" "MESSAGE ID OF MESSAGE TO PIN"
> ```


#### `--unpinmsg`
- Use this method to remove a message from the list of pinned messages in a chat.
> Example :
> ```bash
> tg --unpinmsg "<CHAT_ID>" "MESSAGE ID OF MESSAGE TO UNPIN"
> ```

#### `--getuserpfp`
- Use this method to get a list of profile pictures for a user.
> Example :
> ```bash
> tg --getuserpfp "<CHAT ID>" "<USER ID OF USER>"
> ```


#### `--downloadfile`
- Use this method to download a file.
> Example :
> ```bash
> tg --downloadfile "<FILE ID>" "<OUTPUT FILE PATH WITH NAME AND EXTENSION>"
> ```

#### `--ban`
- Use this method to ban a user.
> Example :
> ```bash
> tg --ban "<CHAT ID>" "<USER ID OF USER TO BAN>"
> ```

#### `--unban`
- Use this method to unban a user.
> Example :
> ```bash
> tg --unban "<CHAT ID>" "<USER ID OF USER TO UNBAN>"
> ```

#### `--sendaudiofile`
- Use this method to send audio files, if you want Telegram clients to display them in the music player. Your audio must be in the .MP3 or .M4A format.
> Example :
> ```bash
> tg --sendaudiofile "<CHAT ID>" "<PATH OF AUDIO FILE>" "<CAPTION (Optional)"
> ```

#### `--sendvoicefile`
- Use this method to send audio files, if you want Telegram clients to display the file as a playable voice message. For this to work, your audio must be in an .OGG file encoded with OPUS (other formats may be sent as Audio or Document).
> Example :
> ```bash
> tg --sendvoicefile "<CHAT ID>" "<PATH OF AUDIO FILE>" "<CAPTION (Optional)"
> ```

## Stored Variables
These are the variable stored by [Update Function](https://github.com/noobyysauraj/telegram_bash_bot/blob/cad053027990836c8d5730cc3f2f7a66dc912a8c/util.sh#L187), which is used to get Updates from the bot in the present chats. So, we store all important variable returned by [Telegram Bot API Get Updates](https://core.telegram.org/bots/api#getting-updates).

### 1. All DIfferent IDs

##### RET_MSG_ID

- This Variable Store the __Message ID__ of the message the [Update Function](https://github.com/noobyysauraj/telegram_bash_bot/blob/cad053027990836c8d5730cc3f2f7a66dc912a8c/util.sh#L187) returned.

##### RET_CHAT_ID

- This Variable Store the Chat ID of the Chat the [Update Function](https://github.com/noobyysauraj/telegram_bash_bot/blob/cad053027990836c8d5730cc3f2f7a66dc912a8c/util.sh#L187) returned.

##### RET_CHAT_TYPE

- This Variable Store the __Chat Type__ of the Chat the [Update Function](https://github.com/noobyysauraj/telegram_bash_bot/blob/cad053027990836c8d5730cc3f2f7a66dc912a8c/util.sh#L187) returned.

##### MSGGER

- This Variable Store the __User ID__ of the Messager the [Update Function](https://github.com/noobyysauraj/telegram_bash_bot/blob/cad053027990836c8d5730cc3f2f7a66dc912a8c/util.sh#L187) returned.

##### RET_FILE_ID

- This Variable Store the __File ID__ of the File the [Update Function](https://github.com/noobyysauraj/telegram_bash_bot/blob/cad053027990836c8d5730cc3f2f7a66dc912a8c/util.sh#L187) returned.

### 2. All DIfferent Strings

##### RET_MSG_TEXT

- This Variable Store the __text__ of the Message the [Update Function](https://github.com/noobyysauraj/telegram_bash_bot/blob/cad053027990836c8d5730cc3f2f7a66dc912a8c/util.sh#L187) returned.

##### FIRST_NAME

- This Variable Store the __First Name__ of the Messager the [Update Function](https://github.com/noobyysauraj/telegram_bash_bot/blob/cad053027990836c8d5730cc3f2f7a66dc912a8c/util.sh#L187) returned.

##### LAST_NAME

- This Variable Store the __Last Name__ of the Messager the [Update Function](https://github.com/noobyysauraj/telegram_bash_bot/blob/cad053027990836c8d5730cc3f2f7a66dc912a8c/util.sh#L187) returned.

##### USERNAME

- This Variable Store the __Username__ of the Messager the [Update Function](https://github.com/noobyysauraj/telegram_bash_bot/blob/cad053027990836c8d5730cc3f2f7a66dc912a8c/util.sh#L187) returned.

### 3. Replies


##### RET_REPLIED_MSG_ID

- This Variable Store the __Message ID__ of the message to which the current message have been replied to.

##### RET_REPLIED_MSGGER_ID

- This Variable Store the __User ID__ of the User to which the current message have been replied to.

##### RET_REPLIED_MSGGER_FIRST_NAME

- This Variable Store the __Fisrt Name__ of the Messager to which the current message have been replied to.

##### RET_REPLIED_MSGGER_LAST_NAME

- This Variable Store the __Last Name__ of the Messager to which the current message have been replied to.

##### RET_REPLIED_MSGGER_USERNAME

- This Variable Store the __Username__ of the messager to which the current message have been replied to.

##### RET_REPLIED_MSG_TEXT

- This Variable Store the __Text__ of the message to which the current message have been replied to.

##### RET_REPLIED_FILE_ID

- This Variable Store the __File ID__ of the File to which the current message have been replied to.

### 4. Stickers

##### STICKER_EMOJI

- This Variable Store the __Emoji__ of the Sticker the [Update Function](https://github.com/noobyysauraj/telegram_bash_bot/blob/cad053027990836c8d5730cc3f2f7a66dc912a8c/util.sh#L187) returned.

##### STICKER_FILE_ID

- This Variable Store the __File ID__ of the Sticker the [Update Function](https://github.com/noobyysauraj/telegram_bash_bot/blob/cad053027990836c8d5730cc3f2f7a66dc912a8c/util.sh#L187) returned.

##### STICKER_EMOJI

- This Variable Store the __Name of the Sticker Pack__ the [Update Function](https://github.com/noobyysauraj/telegram_bash_bot/blob/cad053027990836c8d5730cc3f2f7a66dc912a8c/util.sh#L187) returned.

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

> Some other Dependencies too but mostly they are pre-installed on most systems. Full list will be updated soon.
#### Clone this repo
You need to clone this repo for further operations.
```bash
git clone https://github.com/noobyysauraj/telegram_bash_bot && cd telegram_bash_bot
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
- Add [custom variable](https://noobyysauraj.github.io/telegram_bash_bot/#variables) to your project. Check [here](https://docs.railway.app/develop/variables), how to add custom variable in railway.

#### Variables
Add these variables if you want to run the bot in __non-interactive__ mode.
```bash
TOKEN="<Bot Token of your bot>"
BOT_OWNER_ID="<Owner ID>"
WEATH_API_KEY="<Weather Api key>" #https://rapidapi.com/apishub/api/yahoo-weather5 (.weath won't work without this.)
```

### Contributions
Feel free to contribute to any part of this project. _(Like Documentation, Adding more methods and feature and endless possiblities)_.

> By @noobyysauraj and @Hakimi0804


