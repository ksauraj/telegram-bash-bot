### Adding more methods to call Telegram Bot API.

All functions related to [Telegram Bot API](https://core.telegram.org/bots/api) are present in  `util.sh`. You can add new methods following the current style of `variable names` to look it simpler.


## Available Telegram Methods
All these methods are defined in [util.sh](https://github.com/noobyysauraj/telegram-bash-bot/blob/master/util.sh). If you think some methods are missing and you can add them, please go ahead and don't forget to open a __pull request__ with the changes you made. [Extension of this part](https://noobyysauraj.github.io/telegram-bash-bot/#stored-variables).
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
