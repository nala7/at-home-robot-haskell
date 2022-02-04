module Lib where

import Board
import Objects
import AgentMoves

run :: Board -> Int-> IO()
run board i = do
    putStrLn (printBoard board)

    let newBoard = moveRobot (2, 1, robotObject, False) board
    putStrLn (printBoard newBoard)

-- changeEnv :: Board ->()
-- changeEnv board = 4

