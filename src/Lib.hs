module Lib where

import Board
import Objects
import Moves

run :: Board -> IO()
run board = do
    putStrLn (printBoard board)

    let newBoard = moveRobot (3, 3, robotObject, True) board
    putStrLn (printBoard newBoard)
