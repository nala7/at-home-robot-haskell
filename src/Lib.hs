module Lib where

import Board
import Objects
import AgentMoves
import KidMoves
import Utils
import Control.Concurrent



run :: Board -> IO()
run board = do
    putStrLn (printBoard board)
    
    let board01 = moveAgents board
    putStrLn (printBoard board01)

    threadDelay 2000000

    let board02 = moveAgents board01
    putStrLn (printBoard board02)

    threadDelay 2000000

    let board03 = moveAgents board02
    putStrLn (printBoard board03)

    threadDelay 2000000

    let board04 = moveAgents board03
    putStrLn (printBoard board04)
    
    threadDelay 2000000

    let envChangedBoard = changeEnv board04
    putStrLn (printBoard envChangedBoard)

    threadDelay 3000000



    run envChangedBoard

moveAgents :: Board -> Board
moveAgents board = _moveAgents robList board where
    robList = getRobotObjects board

_moveAgents :: [(Int, Int, String, Bool)] -> Board -> Board
_moveAgents [] board = board
_moveAgents ((x, y, objType, piled):tail) board = _moveAgents tail newBoard 
    where
        newBoard = moveRobot (x, y, objType, piled) board


changeEnv :: Board -> Board
changeEnv board = _changeEnv kidList board where
    kidList = getKidObjects board


_changeEnv :: [(Int, Int, String, Bool)] -> Board -> Board
_changeEnv [] board = board
_changeEnv ((x, y, objType, piled):tail) board = _changeEnv tail newBoard 
    where
        newBoard = moveKid (x, y, objType, piled) board


sleep :: IO ()
sleep =
    if stepByStep
    then threadDelay 3000000
    else putStr ""
    where
        stepByStep = True