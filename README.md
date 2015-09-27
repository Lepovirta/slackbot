# slackbot
A bot for Slack. Easy way to add new commands for slack channels.

Uses [slack-api](https://github.com/mpickering/slack-api) for Slack RTM API.

## Installation
Use [stack](https://github.com/commercialhaskell/stack) to install the packages and build the project.

## Commands
Check out existing commands in `SlackBot.Commands`. For new commands please create a PR.

Commands must have public function `cmd :: Command`.

``` Haskell
data Command = Command
    { cName :: Text
    , cDesc :: Text
    , cFunc :: Text -> IO Text
    }
```

Attr  | Meaning
:-----|:-----------
name  | Name of the command. Will be used in Slack like this: `!name blabla`
desc  | Description will be shown by the `help` command.
func  | Function of the command.
