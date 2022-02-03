module Objects where

kidObject :: [Char]
kidObject = "Kid"

robotObject :: [Char]
robotObject = "Robot"

dirtObject :: [Char]
dirtObject = "Dirt"

cribObject :: [Char]
cribObject = "Crib"

obstacleObject :: [Char]
obstacleObject = "Obstacle"


class Object a where 
    x :: a -> Int
    y :: a -> Int
    objType :: a -> String
    objPiled :: a -> Bool


data Kid = Kid {
    xKid :: Int,
    yKid :: Int
}


instance Object Kid where
    x a = xKid a
    y a = yKid a
    objType a = kidObject
    objPiled a = False


data Robot = Robot{
    xRobot :: Int,
    yRobot :: Int
}

instance Object Robot where
    x a = xRobot a
    y a = yRobot a
    objType a = robotObject
    objPiled a = False


data Dirt = Dirt{
    xDirt :: Int,
    yDirt :: Int
}

instance Object Dirt where
    x a = xDirt a
    y a = yDirt a
    objType a = dirtObject
    objPiled a = False


data Crib = Crib{
    xCrib :: Int,
    yCrib :: Int
}

instance Object Crib where 
    x a = xCrib a
    y a = yCrib a
    objType a = cribObject
    objPiled a = False


data Obstacle = Obstacle {
    xObstacle :: Int,
    yObstacle :: Int
}

instance Object Obstacle where
    x a = xObstacle a
    y a = yObstacle a
    objType a = obstacleObject
    objPiled a = False