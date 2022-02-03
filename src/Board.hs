module Board where

import Objects

-- data ObjectType = Kid | Robot | Obstacle | Dirt | Crib

-- instance Enum ObjectType where
--     fromEnum = fromJust . flip lookup table
--     toEnum = fromJust . flip lookup (map swap table)
-- table = [(Kid, "Kid"), (Robot, "Robot"), (Obstacle, "Obstacle"), (Dirt, "Dirt"), (Crib, "Crib")]


data Board = Board {
    boardSize :: (Int, Int),
    boardList :: []
}


-- objExists :: Object a => (Int, Int) -> [a] -> Bool
-- objExists (x, y) [] = False
--     |


-- addObject :: Object -> Bool
-- addObject
