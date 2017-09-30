module Types.Space exposing (..)

import Types.Pieces exposing (Piece)
import Types.Player exposing (Colour)


type alias X =
    Int


type alias Y =
    Int


type Coordinate
    = Coordinate X Y


type alias Space =
    { colour : Colour
    , piece : Maybe Piece
    , location : Coordinate
    }

--Somewhere
type alias Grid
    = List (List Space)
