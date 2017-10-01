module Engine.MovePiece exposing (..)

import Debug exposing (..)
import Maybe exposing (..)
import Array2D exposing (..)
import Types.Pieces exposing (..)
import Types.Space exposing (..)
import Types.Player exposing (..)


movePiece : Space -> Space -> Model -> Model
movePiece origin destination currentModel =
    --assume origin destination are valid
    let
        (Coordinate ox oy) =
            origin.location

        (Coordinate dx dy) =
            destination.location

        newDestination =
            { destination
                | piece = origin.piece
            }

        newOrigin =
            { origin
                | piece = Nothing
            }

        newGrid =
            currentModel.grid
                |> Array2D.set ox oy newOrigin
                |> Array2D.set dx dy newDestination
    in
        case destination.piece of
            Nothing ->
                { currentModel
                    | grid = newGrid
                    , selectedSpace = Nothing
                }

            Just _ ->
                { currentModel
                    | grid = newGrid
                    , selectedSpace = Nothing
                }
