module Engine.GenMoves exposing (..)

import Engine.Utils exposing (movesToGrid)
import Maybe exposing (..)
import List exposing (..)
import Types.Pieces exposing (..)
import Types.Space exposing (..)
import Types.Player exposing (..)
import Engine.CheckDirections as D exposing (..)


parseMoves : List (Maybe Space) -> Maybe (List Space)
parseMoves spaceList =
    let
        filteredList =
            filterMap identity spaceList
    in
        if List.isEmpty filteredList then
            Nothing
        else
            Just filteredList


checkSpace : Player -> Space -> Maybe Space
checkSpace player space =
    case space.piece of
        Nothing ->
            Nothing

        Just piece ->
            if (getOwner piece).colour == player.colour then
                Nothing
            else
                Just space


pawnMoves : Piece -> Space -> Grid -> List (Maybe Space)
pawnMoves piece space grid =
  let
      curriedInc = \d -> increment (Just space) d grid

      directionPipe = \direction ->
        direction
          |> curriedInc
          |> andThen (checkSpace (getOwner piece))

      emptyOrBust = \spc -> 
        case spc.piece of
          Nothing -> Just spc
          Just pc -> Nothing

      north = (curriedInc North) |> andThen emptyOrBust
      south = (curriedInc South) |> andThen emptyOrBust
  in
    case (getOwner piece).colour of
      White ->
        [NorthEast, NorthWest]
          |> List.map directionPipe
          |> (::) north
      Black->
        [South, SouthEast, SouthWest]
          |> List.map directionPipe
          |> (::) south


rookMoves : Player -> Space -> Grid -> Maybe (List Space)
rookMoves player space grid =
  let
    list = (concatMap (checkLine player space grid) [Horizontal, Vertical])
  in
    if List.isEmpty list then Nothing else Just list
    

bishopMoves : Player -> Space -> Grid -> Maybe (List Space)
bishopMoves player space grid =
  let
    list = (concatMap (checkLine player space grid) [PositiveDiagonal, NegativeDiagonal])
  in
    if List.isEmpty list then Nothing else Just list


queenMoves : Player -> Space -> Grid -> Maybe (List Space)
queenMoves player space grid =
  let
    list = (concatMap (checkLine player space grid) [PositiveDiagonal, NegativeDiagonal, Horizontal, Vertical])
  in
    if List.isEmpty list then Nothing else Just list


kingMoves : Player -> Space -> Grid -> Maybe (List Space)
kingMoves player space grid =
  [North, South, East, West, NorthEast, NorthWest, SouthEast, SouthWest]
    |> List.map (\d -> increment (Just space) d grid)
    |> List.map (andThen (checkSpace player))
    |> parseMoves
      

knightMoves : Player -> Space -> Grid -> Maybe (List Space)
knightMoves player space grid =
  let
      northPole = Just space 
        |> \s -> increment s North grid 
        |> \s -> increment s North grid 

      southPole = Just space
        |> \s -> increment s South grid
        |> \s -> increment s South grid

      eastPole = Just space
        |> \s -> increment s East grid
        |> \s -> increment s East grid

      westPole = Just space
        |> \s -> increment s West grid
        |> \s -> increment s West grid

      incrementEW = \spc -> List.map (\dir -> increment spc dir grid) [East, West]
      incrementNS = \spc -> List.map (\dir -> increment spc dir grid) [North, South]
  in
    [(incrementEW northPole), (incrementEW southPole), (incrementNS eastPole), (incrementNS westPole)]
      |> concatMap identity
      |> List.map (andThen (checkSpace player))
      |> parseMoves  
      

generateMoves : Space -> Grid -> Maybe (Grid, (List Space))
generateMoves space grid =
    case space.piece of
        Nothing ->
            Nothing

        Just piece ->
            let
                moves =
                    case piece of
                        Pawn player ->
                            grid
                                |> pawnMoves piece space
                                |> parseMoves

                        Rook player ->
                            rookMoves player space grid

                        Knight player ->
                            knightMoves player space grid

                        Bishop player ->
                            bishopMoves player space grid

                        Queen player ->
                            queenMoves player space grid

                        King player ->
                            kingMoves player space grid
            in
                case moves of
                    Nothing ->
                        Nothing

                    Just moves ->
                        Just ((movesToGrid moves grid), moves)
