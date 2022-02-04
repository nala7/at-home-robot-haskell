module Board where

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

get3rd (_, _, c, _) = c

objExists :: Int -> Int -> [(Int, Int, String, Bool)] -> String
objExists x y [] = " - "
objExists x y (head:tail) = 
    let (x1, y1, objType, piled) = head
    in if x1 == x && y1 == y then objType else objExists x y tail

printBoard :: Board -> String
printBoard board = _printBoard x y board where
    x = boardSizeX board
    y = boardSizeY board

_printBoard  :: Int -> Int -> Board -> String
_printBoard 0 m _ = ""
_printBoard n 0 board = "\n" ++ _printBoard (n-1) y board
    where
        y = boardSizeY board
_printBoard n m board = "|" ++ objExists x y boardObjects ++ "|" ++ _printBoard n (m-1) board
    where
        x = boardSizeX board - n
        y = boardSizeY board - m
        boardObjects = boardList board


-- objExists :: Object a => (Int, Int) -> [a] -> Bool
-- objExists (x, y) [] = False
--     |


-- addObject :: Object -> Bool
-- addObject
