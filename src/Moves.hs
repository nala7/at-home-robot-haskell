module Moves where

import Board 
import System.IO.Unsafe                                    
import System.Random 

randomNum :: Int
{-# NOINLINE randomNum #-}
randomNum = unsafePerformIO (getStdRandom (randomR (0, 1)))

-- moveRobot :: (Int, Int, String, Bool) -> Board -> Board
-- moveRobot (x, y, _, piled) board = if piled then
    
--     else
--         | ()
--         where
--             rand1 = genRand
--             rand2 = genRand
        
newPosUnpiledRobot :: (Int, Int, String, Bool) -> Board -> (Int, Int)
newPosUnpiledRobot (x, y, _, _) board 
    | rand1 == 0 && rand2 == 0 = (x - 1, y)
    | rand1 == 0 && rand2 == 1 = (x + 1, y)
    | rand1 == 1 && rand2 == 0 = (x, y - 1)
    | rand1 == 1 && rand2 == 1 = (x, y + 1)
    where
            rand1 = randomNum
            rand2 = randomNum