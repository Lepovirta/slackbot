module SlackBot.Types where

import Data.Text (Text)

data Command = Command
    { cName :: Text
    , cFunc :: Text -> IO Text
    }
