module Lib where

import Board

someFunc :: IO ()
someFunc = putStrLn "someFunc"

start :: IO()
start = do
    -- putStrLn "Enter amount of columns"
    -- cols <- getLine
    -- putStrLn "Enter amount of rows"
    -- rows <- getLine
    -- putStrLn ("Created Board " ++ cols ++ "x" ++ rows)
    
    board = Board (5, 6) []