module Engine.GenMoves exposing (..)

import Engine.Utils exposing (movesToGrid)
import Debug exposing (..)
import Maybe exposing (..)
import Array2D exposing (..)
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
            Just space

        Just piece ->
            if (getOwner piece).colour == player.colour then
                Nothing
            else
                Just space



--PAWNS LEFT AND RIGHT SPACES ONLY


tempCheckSpace : Player -> Space -> Maybe Space
tempCheckSpace player space =
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
        (Coordinate row column) =
            space.location

        tempCurryCheck =
            tempCheckSpace (getOwner piece)

        curryCheck =
            checkSpace (getOwner piece)
    in
        case (getOwner piece).colour of
            White ->
                let
                    left =
                        get (row - 1) (column - 1) grid
                            |> andThen tempCurryCheck

                    center =
                        get (row - 1) (column) grid
                            |> andThen curryCheck

                    right =
                        get (row - 1) (column + 1) grid
                            |> andThen tempCurryCheck
                in
                    [ left, center, right ]

            Black ->
                let
                    left =
                        get (row + 1) (column + 1) grid
                            |> andThen tempCurryCheck

                    center =
                        get (row + 1) column grid
                            |> andThen curryCheck

                    right =
                        get (row + 1) (column - 1) grid
                            |> andThen tempCurryCheck
                in
                    [ left, center, right ]


rookMoves : Player -> Space -> Grid -> Maybe (List Space)
rookMoves player space grid =
  let
    _ = Debug.log "rook moves called!" ""
    list = Debug.log "rook moves!" (concatMap (checkLine player space grid) [Horizontal, Vertical])
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
                            Nothing

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
