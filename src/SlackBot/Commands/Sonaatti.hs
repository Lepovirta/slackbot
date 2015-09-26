{-# LANGUAGE OverloadedStrings #-}
module SlackBot.Commands.Sonaatti
    (cmd) where

import Data.Text (Text)
import SlackBot.Types
import SonaattiMenu (findMenus)
import qualified Data.Text as T

name :: Text
name = "s"

-- Format Menu list for slack.
formatMenus :: [(Text,Text)] -> Text
formatMenus =
    let format (t,d) = T.concat [t, ":\n", (T.replace ", " "\n" d)]
        wrap x = T.concat ["```\n",  x, "\n```"]
    in T.intercalate "\n" . map (wrap . format)

-- Command function using SonaattiMenu library.
func :: Text -> IO Text
func input = do
    menus <- findMenus $ filter (/= " ") $ T.splitOn " " input
    return (formatMenus menus)

cmd :: Command
cmd = Command name func
