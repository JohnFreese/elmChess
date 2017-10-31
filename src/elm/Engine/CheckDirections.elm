module Engine.CheckDirections exposing (..)

import Maybe exposing (..)
import Array2D exposing (..)
import List exposing (..)
import Types.Space exposing (..)
import Types.Player exposing (..)
import Engine.Utils exposing(..)

--TODO export just the Line type and the checkLine function

type Direction 
  = North 
  | South 
  | East 
  | West 
  | NorthEast 
  | NorthWest 
  | SouthEast 
  | SouthWest

type Line 
  = Vertical 
  | Horizontal 
  | PositiveDiagonal 
  | NegativeDiagonal


adder : Player -> Maybe Space -> List Space -> List Space
adder player space spcs =
  case (Maybe.map (checkSpace player) space) of
    Nothing -> spcs
    Just mSpc -> 
      case mSpc of
        Nothing -> spcs
        Just spc -> spc :: spcs

parseSpace : Maybe Space -> Player -> Bool
parseSpace space player =
  space 
    |> Maybe.map emptySpace
    |> withDefault False


increment : Maybe Space -> Direction -> Grid -> Maybe Space
increment space direction grid =
  case space of
    Nothing -> Nothing
    Just spc -> 
      let
          (Coordinate row col) = spc.location
      in
        case direction of
          North -> get (row - 1) col grid
          South -> get (row + 1) col grid
          West -> get row (col - 1) grid 
          East -> get row (col + 1) grid
          NorthEast -> get (row - 1) (col - 1) grid
          NorthWest -> get (row - 1) (col + 1) grid
          SouthEast -> get (row + 1) (col - 1) grid
          SouthWest -> get (row + 1) (col + 1) grid 

p_checkLine : Player -> Maybe Space -> Maybe Space -> Grid -> List Space -> Line -> List Space
p_checkLine player first second grid spaces line =
  let
      firstBool = parseSpace first player
      secondBool = parseSpace second player

      newSpaces = 
        spaces
          |> adder player first 
          |> adder player second

      nextFirst = if firstBool
        then
          case line of
            Vertical -> increment first South grid
            Horizontal -> increment first West grid
            PositiveDiagonal -> increment first SouthWest grid
            NegativeDiagonal -> increment first NorthWest grid
        else Nothing

      nextSecond = if secondBool
        then
          case line of
            Vertical -> increment second North grid
            Horizontal -> increment second East grid
            PositiveDiagonal -> increment second NorthEast grid
            NegativeDiagonal -> increment second SouthEast grid
        else Nothing
  in
    if (not firstBool) && (not secondBool)
      then newSpaces
    else p_checkLine player nextFirst nextSecond grid newSpaces line
      

checkLine : Player -> Space -> Grid -> Line -> List Space
checkLine player space grid line = 
  let
    first = 
        case line of
          Vertical -> increment (Just space) South grid
          Horizontal -> increment (Just space) West grid
          PositiveDiagonal -> increment (Just space) SouthWest grid
          NegativeDiagonal -> increment (Just space) NorthWest grid

    second =
        case line of
          Vertical -> increment (Just space) North grid
          Horizontal -> increment (Just space) East grid
          PositiveDiagonal -> increment (Just space) NorthEast grid
          NegativeDiagonal -> increment (Just space) SouthEast grid
  in
    p_checkLine player first second grid [] line


    