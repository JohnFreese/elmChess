module Engine.GenMoves exposing (..)

import Engine.Utils exposing (movesToGrid)
import Debug exposing (..)
import Maybe exposing (..)
import Array2D exposing (..)
import List exposing (..)
import Types.Pieces exposing (..)
import Types.Space exposing (..)
import Types.Player exposing (..)


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
                            Nothing

                        Knight player ->
                            Nothing

                        Bishop player ->
                            Nothing

                        Queen player ->
                            Nothing

                        King player ->
                            Nothing
            in
                case moves of
                    Nothing ->
                        Nothing

                    Just moves ->
                        Just ((movesToGrid moves grid), moves)
