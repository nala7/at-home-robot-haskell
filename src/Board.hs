module Board where

import Objects

data Board = Board {
    boardSizeX :: Int,
    boardSizeY :: Int,
    boardList :: [(Int, Int, String, Bool)]
} deriving (Show)


addObject :: (Int, Int, String, Bool) -> Board -> Board
addObject a board = newBoard where
    newBoard = Board x y (_addObject a list) where
        x = boardSizeX board
        y = boardSizeY board
        list = boardList board


_addObject :: a -> [a] -> [a]
_addObject a list = a:list



removeObject :: (Int, Int, String, Bool) -> Board -> Board
removeObject a board = newBoard where
    newBoard = Board x y (_removeObject a list) where
        x = boardSizeX board
        y = boardSizeY board
        list = boardList board


_removeObject :: Eq a => a -> [a] -> [a]
_removeObject _ []                 = []
_removeObject x (y:ys) | x == y    = _removeObject x ys
                       | otherwise = y : _removeObject x ys


matchPosNType :: Int -> Int -> String-> Board -> String
matchPosNType x y objType board = 
    let
        list = boardList board
    in 
        _matchPosNType x y objType list


-- si no hay objType en la posición devuelve emptyObject
_matchPosNType :: Int -> Int -> String-> [(Int, Int, String, Bool)] -> String
_matchPosNType _ _ _ [] = emptyObject
_matchPosNType x y objType (head:tail) = 
    let (x1, y1, headType, piled) = head
    in if x1 == x && y1 == y && objType == headType then headType else _matchPosNType x y objType tail


getPosType :: Int -> Int -> Board -> String
getPosType x y board = let list = boardList board in _getPosType x y list 

_getPosType :: Int -> Int -> [(Int, Int, String, Bool)] -> String
_getPosType x y [] = emptyObject
_getPosType x y (head:tail) = 
    let (x1, y1, objType, piled) = head
    in if x1 == x && y1 == y then objType else _getPosType x y tail

printBoard :: Board -> String
printBoard board = _printBoard x y board where
    x = boardSizeX board
    y = boardSizeY board

_printBoard  :: Int -> Int -> Board -> String
_printBoard 0 m _ = ""
_printBoard n 0 board = "\n" ++ _printBoard (n-1) y board
    where
        y = boardSizeY board
_printBoard n m board = "|" ++ getPosType x y board ++ "|" ++ _printBoard n (m-1) board
    where
        x = boardSizeX board - n
        y = boardSizeY board - m


setObjectToPiled :: (Int, Int, String, Bool) -> Board ->Board
setObjectToPiled (x, y, objType, piled) board = newBoard where
    removedObjBoard = removeObject (x, y, objType, piled) board
    newBoard = addObject (x, y, objType, True) removedObjBoard


setObjectToUnpiled :: (Int, Int, String, Bool) -> Board ->Board
setObjectToUnpiled (x, y, objType, piled) board = newBoard where
    removedObjBoard = removeObject (x, y, objType, piled) board
    newBoard = addObject (x, y, objType, False) removedObjBoard