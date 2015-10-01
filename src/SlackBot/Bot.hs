{-# LANGUAGE OverloadedStrings #-}
module SlackBot.Bot
    (run) where

import Control.Monad.IO.Class (liftIO)
import Data.Maybe (fromMaybe)
import Data.Text (Text)
import SlackBot.Command (runCommand)
import SlackBot.Types
import System.Environment (lookupEnv)
import Web.Slack
import Web.Slack.Message
import qualified Data.Text as T

-- Create SlackConfig for bot.
slackConf :: Text -> SlackConfig
slackConf apiToken = SlackConfig
    { _slackApiToken = T.unpack apiToken
    }

-- SlackBot that handles commands starting with '!'.
commandBot :: SlackBot ()
commandBot (Message cid _ msg _ _ _) = do
    mResult <- liftIO $ runCommand msg
    maybe (return ()) (sendMessage cid) mResult
commandBot _ = return ()

-- Run bot.
run :: BotConfig -> IO ()
run conf = do
    let apiToken = bToken conf
    runBot (slackConf apiToken) commandBot ()
