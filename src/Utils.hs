module Utils where

import System.IO.Unsafe                                    
import System.Random 
import Objects
import Board

randomNum :: Int -> Int -> Int
{-# NOINLINE randomNum #-}
randomNum min max = unsafePerformIO (getStdRandom (randomR (min, max)))


posIsDirty :: (Int, Int) -> Board -> Bool
posIsDirty (x, y) board = 
    let 
        objectType = matchPosNType x y dirtObject board
    in
    dirtObject == objectType
        

cleanDirt :: (Int, Int, String, Bool) -> Board -> Board
cleanDirt = removeObject


createDirt :: (Int, Int, String, Bool) -> Board -> Board
createDirt (x, y, objType, piled) = addObject (x, y, dirtObject, False)


moveOneStepPos :: (Int, Int, String, Bool) -> Board -> (Int, Int)
moveOneStepPos (x, y, objType, piled) board =
    if newX < xLength || newY < yLength
        then (newX, newY)
        else moveOneStepPos (x, y, objType, piled) board 
    where 
        (newX, newY) = _moveOneStepPos (x, y, objType, piled) board 
        xLength = boardSizeX board
        yLength = boardSizeY board

_moveOneStepPos :: (Int, Int, String, Bool) -> Board -> (Int, Int)
_moveOneStepPos (x, y, objType, piled) board 
    | rand1 == 0 && rand2 == 0 = (x - 1, y)
    | rand1 == 0 && rand2 == 1 = (x + 1, y)
    | rand1 == 1 && rand2 == 0 = (x, y - 1)
    | rand1 == 1 && rand2 == 1 = (x, y + 1)
    where
            rand1 = randomNum 0 1
            rand2 = randomNum 0 1

moveTwoStepsPos :: (Int, Int, String, Bool) -> Board -> (Int, Int)
moveTwoStepsPos (x, y, objType, piled) board = (twoStepX, twoStepY) where
    (oneStepX, oneStepY) = moveOneStepPos (x, y, objType, piled) board 
    (twoStepX, twoStepY) = moveOneStepPos (oneStepX, oneStepY, objType, piled) board 
        

isValidPosition :: (Int, Int) -> Board -> Bool
isValidPosition (x, y) board = 
    x < xLength && y < yLength
    where
        xLength = boardSizeX board
        yLength = boardSizeY board


getKidObjects :: Board -> [(Int, Int, String, Bool)]
getKidObjects board = 
    _getKidObjects list [] where
        list = boardList board


_getKidObjects :: [(Int, Int, String, Bool)] -> [(Int, Int, String, Bool)] -> [(Int, Int, String, Bool)]
_getKidObjects [] kidList = kidList
_getKidObjects (head:tail) kidList =
    if isKidObj 
        then
            _getKidObjects tail newKidList
        else
            _getKidObjects tail kidList
    where 
        isKidObj = objType == kidObject
        (x, y, objType, piled) = head
        newKidList = (x, y, objType, piled):kidList


getRobotObjects ::  Board -> [(Int, Int, String, Bool)]
getRobotObjects board = 
    _getRobotObjects list [] where
        list = boardList board

_getRobotObjects :: [(Int, Int, String, Bool)] -> [(Int, Int, String, Bool)] -> [(Int, Int, String, Bool)]
_getRobotObjects [] robList = robList
_getRobotObjects ((x, y, objType, piled):tail) robList =
    let isRobObj = objType == robotObject in
        if isRobObj 
            then
                _getRobotObjects tail ((x, y, objType, piled):robList)
            else
                _getRobotObjects tail robList

