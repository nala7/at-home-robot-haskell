module Board 
(
    Board,
    addObject,
    removeObject,
    getPosType,
    printBoard
)
 where

import Objects

-- data ObjectType = Kid | Robot | Obstacle | Dirt | Crib

-- instance Enum ObjectType where
--     fromEnum = fromJust . flip lookup table
--     toEnum = fromJust . flip lookup (map swap table)
-- table = [(Kid, "Kid"), (Robot, "Robot"), (Obstacle, "Obstacle"), (Dirt, "Dirt"), (Crib, "Crib")]


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


-- si no hay objType en la posición devuelve emptyObject
matchPosNType :: Int -> Int -> String-> [(Int, Int, String, Bool)] -> Sting
matchPosNType _ _ _ [] = emptyObject
matchPosNType x y objType (head:tail) = 
    let (x1, y1, headType, piled) = head
    in if x1 == x && y1 == y && objType == headType then headType else getPosType x y tail


getPosType :: Int -> Int -> [(Int, Int, String, Bool)] -> String
getPosType x y [] = emptyObject
getPosType x y (head:tail) = 
    let (x1, y1, objType, piled) = head
    in if x1 == x && y1 == y then objType else getPosType x y tail

printBoard :: Board -> String
printBoard board = _printBoard x y board where
    x = boardSizeX board
    y = boardSizeY board

_printBoard  :: Int -> Int -> Board -> String
_printBoard 0 m _ = ""
_printBoard n 0 board = "\n" ++ _printBoard (n-1) y board
    where
        y = boardSizeY board
_printBoard n m board = "|" ++ getPosType x y boardObjects ++ "|" ++ _printBoard n (m-1) board
    where
        x = boardSizeX board - n
        y = boardSizeY board - m
        boardObjects = boardList board


setObjectToPiled :: (Int, Int, String, Bool) -> Board ->Board
setObjectToPiled (x, y, objType, piled) board = newBoard where
    removeObjBoard = removeObject (x, y, objType, piled) board
    newBoard = addObject (x, y, objType, True) removedObjBoard