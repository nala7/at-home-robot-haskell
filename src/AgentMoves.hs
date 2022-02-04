module AgentMoves where


import System.IO.Unsafe                                    
import System.Random 
import Board 
import Objects
import Utils

randomNum :: Int -> Int -> Int
{-# NOINLINE randomNum #-}
randomNum min max = unsafePerformIO (getStdRandom (randomR (min, max)))


moveRobot :: (Int, Int, String, Bool) -> Board -> Board
moveRobot (x, y, rob, piled) board
    | posIsDirty (x, y) board = cleanDirt (x, y, dirtObject, False) board
    | piled = moveRobPiled (x, y, rob, piled) board 
    | otherwise = moveRobUnpiled (x, y, rob, piled) board

moveRobUnpiled :: (Int, Int, String, Bool) -> Board -> Board
moveRobUnpiled (x, y, rob, piled) board
    | objInNewPos == emptyObject 
        = addObject (newX, newY, rob, piled) removedObjBoard
    | kidInPos == kidObject && cribInPos /= cribObject = boardWitPiledKidRob
    | objInNewPos == obstacleObject = board
    | otherwise = newPosObjBoard
    where
        (newX, newY) = moveOneStepPos (x, y, rob, piled) board 
        kidInPos = matchPosNType newX newY kidObject board
        cribInPos = matchPosNType newX newY cribObject board
        objInNewPos = getPosType newX newY board

        removedObjBoard = removeObject (x, y, rob, piled) board 
        -- lista con el robot en la posición actualizada
        newPosObjBoard = addObject (newX, newY, rob, piled) removedObjBoard
        
        -- lista con el niño pilado
        pileKidBoard = setObjectToPiled (newX, newY, kidObject, False) removedObjBoard
        -- lista con el niño pilado y robot en la nueva posición pilado
        boardWitPiledKidRob = setObjectToPiled (newX, newY, rob, piled) pileKidBoard


moveRobPiled :: (Int, Int, String, Bool) -> Board -> Board
moveRobPiled (x, y, rob, piled) board
    | let currentPosInCrib = matchPosNType x y cribObject board in
        currentPosInCrib == cribObject = leaveKidBoard
    | nextMoveIsObstacle == obstacleObject || nextMoveIsRobot == nextMoveIsRobot = 
        board
    | otherwise = newPosObjBoard
    where
        unpiledKidBoard = setObjectToUnpiled (x, y, kidObject, piled) board
        leaveKidBoard = setObjectToUnpiled (x, y, robotObject, piled) unpiledKidBoard

        (newX, newY) = moveTwoStepsPos(x, y, rob, piled) board

        nextMoveIsObstacle = matchPosNType newX newY obstacleObject board
        nextMoveIsRobot = matchPosNType newX newY robotObject board
        
        removedObjBoard = removeObject (x, y, rob, piled) board
        newPosObjBoard = addObject (newX, newY, rob, piled) removedObjBoard

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

