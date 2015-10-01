{-# LANGUAGE OverloadedStrings #-}
module SlackBot.Config (readConf) where

import SlackBot.Types
import qualified Data.Configurator as C

-- Read config file.
readConf :: FilePath -> IO BotConfig
readConf cfgFile = do
  cfg   <- C.load [C.Required cfgFile]
  token <- C.require cfg "slack_api_token"
  return (BotConfig token)
