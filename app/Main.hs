module Main where

import Board
import Objects
import Lib
import AgentMoves

main :: IO ()
main = run board 0

board02 = Board 5 6 [(1, 2, kidObject, False)]
board03 = addObject (1, 3, kidObject, False) board02
board04 = addObject (2, 1, robotObject, False) board03
board05 = addObject (3, 3, robotObject, False) board04
board = addObject (3, 1, obstacleObject, False) board05



