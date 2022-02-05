module AgentMoves where

import Board 
import Objects
import Utils

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



