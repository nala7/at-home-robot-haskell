module Utils where

import Objects
import Board

posIsDirty :: (Int, Int) -> Board -> Bool
posIsDirty (x, y) board = dirtObject == objectType where
    objectType = getPosType x y list where
        list = boardList board


cleanDirt :: (Int, Int, String, Bool) -> Board
cleanDirt = removeObject
