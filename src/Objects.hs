class Object  m where 
    position :: m -> (Int, Int)
    objType :: obj -> String


newtype Kid = Kid {
    kidPosition :: (Int, Int)
}

instance Object Kid where
    position = kidPosition
    objType = "Kid"


newtype Robot = Robot {
    robPosition :: (Int, Int)
}

instance Object Robot where
    position = robPosition
    objType = "Robot"


newtype Dirt = Dirt{
    dirtPosition :: (Int, Int)
}

instance Object Dirt where
    position = dirtPosition
    objType = "Dirt"


newtype Crib = Crib {
    cribPosition :: (Int, Int)
}

instance Object Crib where 
    position = cribPosition
    objType = "Crib"


newtype Obstacle = Obstacle {
    obsPosition :: (Int, Int)
}

instance Object Obstacle where
    position = obsPosition
    objType = "Obstacle"
