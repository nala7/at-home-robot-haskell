module Main where

import Board
import Objects
import Lib
import Moves

main :: IO ()
main = putStrLn (printBoard board)

kid1 = (1, 2, kidObject, False)
kid2 = (1, 3, kidObject, False)
rob1 = (2, 1, robotObject, False)
rob2 = (2, 2, robotObject, False)
obs1 = (3, 3, obstacleObject, False)

board = Board 5 6 [kid1, kid2, rob1, rob2, obs1]