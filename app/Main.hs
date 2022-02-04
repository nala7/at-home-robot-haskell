module Main where

import Board
import Objects
import Lib
import Moves

main :: IO ()
main = run board

board01 = Board 5 6 []
board02 = addObject (1, 2, kidObject, False) board01
board03 = addObject (1, 3, kidObject, False) board02
board04 = addObject (2, 1, robotObject, False) board03
board05 = addObject (3, 3, robotObject, False) board04
board = addObject (2, 2, obstacleObject, False) board05



