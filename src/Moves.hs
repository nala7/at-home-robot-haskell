module Moves where

import Board 
import System.IO.Unsafe                                    
import System.Random 


randomNum :: Int -> Int -> Int
{-# NOINLINE randomNum #-}
randomNum min max = unsafePerformIO (getStdRandom (randomR (min, max)))


moveRobot :: (Int, Int, String, Bool) -> Board -> Board
moveRobot (x, y, rob, piled) board
    | posIsDirty (x, y) board = cleanDirt (x, y, dirtObject, False)
    | piled = newBoard1 
    | otherwise = newBoard2 where 
        removedObjBoard = removeObject (x, y, rob, piled) board 

        (newX1, newY1) = moveTwoStepsPos (x, y, rob, piled) removedObjBoard 
        newBoard1 = addObject(newX1, newY1, rob, piled) removedObjBoard

        newBoard2 = moveRobUnpiled (x, y, rob, piled) board


-- recibe la posicion actual del robot y la posicion a la q se quiere mover
moveRobUnpiled :: (Int, Int, String, Bool) -> Board -> Board
moveRobUnpiled (x, y, rob, piled) board
    | objInNewPos == emptyObject 
        = addObject (newX, newY, rob, piled) removedObjBoard
    | kidInPos == kidObject = boardWitPiledKidRob
    | objInNewPos == obstacleObject = board
    | otherwise = newPosObjBoard
    where
        (newX, newY) = moveOneStepPos (x, y, rob, piled) board 
        kidInPos = let list = boardList board in matchPosNType newX newY kidObject list
        objInNewPos = let list = boardList board in getPosType newX newY list

        removedObjBoard = removeObject (x, y, rob, piled) board 
        -- lista con el robot en la posición actualizada
        newPosObjBoard = addObject (newX, newY, rob, piled) removedObjBoard
        
        -- lista con el niño pilado
        pileKidBoard = setObjectToPiled (newX, newY, kidObject, False) removedObjBoard
        -- lista con el niño pilado y robot en la nueva posición pilado
        boardWitPiledKidRob = setObjectToPiled (newX, newY, rob, piled) pileKidBoard


moveRobPiles

moveTwoStepsPos :: (Int, Int, String, Bool) -> Board -> (Int, Int)
moveTwoStepsPos (x, y, objType, piled) board = (twoStepX, twoStepY) where
    (oneStepX, oneStepY) = moveOneStepPos (x, y, objType, piled) board 
    (twoStepX, twoStepY) = moveOneStepPos (oneStepX, oneStepY, objType, piled) board 
        
moveOneStepPos :: (Int, Int, String, Bool) -> Board -> (Int, Int)
moveOneStepPos (x, y, objType, piled) board 
    | rand1 == 0 && rand2 == 0 = (x - 1, y)
    | rand1 == 0 && rand2 == 1 = (x + 1, y)
    | rand1 == 1 && rand2 == 0 = (x, y - 1)
    | rand1 == 1 && rand2 == 1 = (x, y + 1)
    where
            rand1 = randomNum 0 1
            rand2 = randomNum 0 1

