module SlackBot.Types where

import Data.Text (Text)

data BotConfig = BotConfig
    { bToken :: Text
    }

data Command = Command
    { cName :: Text
    , cDesc :: Text
    , cFunc :: Text -> IO Text
    }
