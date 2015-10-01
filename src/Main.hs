{-# LANGUAGE OverloadedStrings #-}
module Main where

import SlackBot.Config
import SlackBot.Bot

main :: IO ()
main = readConf "bot.cfg" >>= run
