module Utils where

import Objects
import Board

posIsDirty :: (Int, Int) -> Board -> Bool
posIsDirty (x, y) board = 
    let 
        objectType = matchPosNType x y dirtObject board
    in
    dirtObject == objectType
        


cleanDirt :: (Int, Int, String, Bool) -> Board -> Board
cleanDirt = removeObject
