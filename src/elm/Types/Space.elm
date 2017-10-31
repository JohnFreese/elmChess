module Types.Space exposing (..)

import Array2D exposing (..)
import Types.Player exposing (..)
import Types.Pieces exposing (Piece)
import Types.Player exposing (Colour)

type alias Model =
    { grid : Grid
    , currentPlayer : Player
    , selectedSpace : Maybe Space
    , activeSpaces : Maybe (List Space)
    }

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
    , active : Bool
    }

--Somewhere
type alias Grid
    = Array2D Space

emptySpace : Space -> Bool
emptySpace space =
 case space.piece of
    Nothing -> True
    Just space -> False