module KidMoves where

import Board
import Objects
import Utils


moveKid :: (Int, Int, String, Bool) -> Board -> Board
moveKid (x, y, objType, piled) board
    | piled = board
    | let 
        currentPosInCrib = matchPosNType x y cribObject board 
        nextPosIsRob = matchPosNType newX newY robotObject board
        nextPosIsDirty = matchPosNType newX newY dirtObject board
        nextPosIsKid = matchPosNType newX newY kidObject board
      in
        currentPosInCrib == cribObject ||
        nextPosIsRob == robotObject ||
        nextPosIsDirty == dirtObject ||
        nextPosIsKid == kidObject

        = error "here" board

    | let nextPosIsObstacle = matchPosNType newX newY obstacleObject board in
        nextPosIsObstacle == obstacleObject = 
        if isMovableObstacule (x, y, objType, piled) (dirX, dirY) board
            then 
                let movedObjectBoard = moveKidObs (x, y, objType, piled) (dirX, dirY) board in
                    createDirt (x, y, objType, piled) movedObjectBoard
            else board

    | otherwise = moveKidTo (x, y, objType, piled) (newX, newY) board
    where
        (newX, newY) = moveOneStepPos (x, y, objType, piled) board
        (dirX, dirY) = (newX - x, newY - y)


moveKidTo :: (Int, Int, String, Bool) -> (Int, Int) -> Board -> Board
moveKidTo (x, y, objType, piled) (newX, newY) board = newBoard
    where
        removedObjBoard = removeObject (x, y, objType, piled) board
        dirtyBoard = createDirt (x, y, objType, piled) removedObjBoard
        newBoard = addObject (newX, newY, objType, piled) dirtyBoard


moveObstaculeByKid :: (Int, Int, String, Bool) -> (Int, Int, String, Bool) -> Board -> Board
moveObstaculeByKid (kidX, kidY, kidType, kidPiled) (obsX, obsY, obsType, obsPiled) board =
    let (xDir, yDir) = (obsX - kidX, obsY - kidY) in
        if isMovableObstacule (obsX, obsY, obsType, kidPiled) (xDir, yDir) board
            then moveKidObs (kidX, kidY, kidType, obsPiled) (xDir, yDir) board
            else board

moveKidObs :: (Int, Int, String, Bool) -> (Int, Int) -> Board -> Board
moveKidObs (objX, objY, objType, piled) (dirX, dirY) board 
    |let isEmptySpace = matchPosNType objX objY emptyObject board in
        isEmptySpace == emptyObject = board
    | otherwise = let
            moveNextBoard =  moveKidObs (objX + dirX, objY + dirY, objType, piled) (dirX, dirY) board in
                moveObjTo (objX, objY, objType, piled) (objX + dirX, objY + dirY) moveNextBoard


moveObjTo :: (Int, Int, String, Bool) -> (Int, Int) -> Board -> Board
moveObjTo (x, y, objType, piled) (newX, newY) board = newBoard
    where
        removedObjBoard = removeObject (x, y, objType, piled) board
        newBoard = addObject (newX, newY, objType, piled) removedObjBoard 


isMovableObstacule :: (Int, Int, String, Bool) -> (Int, Int)-> Board -> Bool
isMovableObstacule (obsX, obsY, obsType, piled) (dirX, dirY) board
    | let nextPosIsObs = matchPosNType nextX nextY obstacleObject board in
        nextPosIsObs == obstacleObject = isMovableObstacule (nextX, nextY, obsType, piled) (dirX, dirY) board
    | let 
        isNextPosValid = isValidPosition (nextX, nextY) board 
        isNextPosRobot = matchPosNType nextX nextY robotObject board in
            isNextPosValid && isNextPosRobot /= robotObject = True
    | otherwise = False
    where 
        (nextX, nextY) = (dirX - obsX, dirY - obsY)