module Types.Player exposing (..)


type Colour
    = White
    | Black


type alias Player =
    { colour : Colour
    , points : Int
    , castle : Bool
    }


colorToString : Colour -> String
colorToString colour =
    case colour of
        White ->
            "white"

        Black ->
            "black"
