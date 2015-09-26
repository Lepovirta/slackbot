{-# LANGUAGE OverloadedStrings #-}
module SlackBot.Bot
    (run) where

import Control.Monad.IO.Class (liftIO)
import Data.Maybe (fromMaybe)
import SlackBot.Command (runCommand)
import System.Environment (lookupEnv)
import Web.Slack
import Web.Slack.Message

-- Create SlackConfig for bot.
botConfig :: String -> SlackConfig
botConfig apiToken = SlackConfig
    { _slackApiToken = apiToken
    }

-- Error for missing token.
tokenError :: String
tokenError = error "SLACK_API_TOKEN not set"

-- SlackBot that handles commands starting with '!'.
commandBot :: SlackBot ()
commandBot (Message cid _ msg _ _ _) = do
    mResult <- liftIO $ runCommand msg
    maybe (return ()) (sendMessage cid) mResult
commandBot _ = return ()

-- Run bot.
run :: IO ()
run = do
    apiToken <- fromMaybe tokenError <$> lookupEnv "SLACK_API_TOKEN"
    runBot (botConfig apiToken) commandBot ()
