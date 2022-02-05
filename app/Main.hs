module Main where

import Board
import Objects
import Lib
import AgentMoves

main :: IO ()
main = run board

board02 = Board 5 6 [(2, 5, kidObject, False)]
board03 = addObject (1, 2, kidObject, False) board02
board04 = addObject (2, 1, robotObject, False) board03
board05 = addObject (3, 3, robotObject, False) board04
board06 = addObject (2, 3, obstacleObject, False) board05
board07 = addObject (4, 5, cribObject, False) board06
board = addObject (3, 5, cribObject, False) board07


