{-# LANGUAGE OverloadedStrings #-}
module SlackBot.Command
    (runCommand) where

import Data.Map (Map)
import Data.Text (Text)
import SlackBot.Types
import qualified Data.Map as M
import qualified Data.Text as T

import SlackBot.Commands.Sonaatti as Sonaatti

-- List containing all available commands
-- Add new commands to this list.
commands :: [Command]
commands = [ helpCmd
           , Sonaatti.cmd
           ]


commandMap :: Map Text Command
commandMap = M.fromList $ map (\ c -> (cName c,c)) commands

-- Command for printing descriptions.
helpCmd :: Command
helpCmd =
    let name = "help"
        description = "Show this help text."
        header = "Available commands:"
        format = \ c -> T.concat ["!", cName c, ": ", cDesc c]
        func = \ _ -> return (T.intercalate "\n" $ header : map format commands)
    in Command name description func

-- Parse command name and arguments from input.
parseInput :: Text -> (Text,Text)
parseInput txt =
    let a = T.takeWhile (/= ' ') $ T.drop 1 txt
        b = T.drop 1 $ T.dropWhile (/= ' ') txt
    in (a,b)

-- Try to run a command.
runCommand :: Text -> IO (Maybe Text)
runCommand txt = do
    let (prefix,arg) = parseInput txt
    case M.lookup prefix commandMap of
         Nothing  -> return (Nothing)
         Just (c) -> do
            result <- cFunc c arg
            return (Just result)
