module Types.Pieces exposing (..)

import Types.Player exposing (Player)


type Piece
    = Pawn Player
    | Rook Player
    | Knight Player
    | Bishop Player
    | King Player
    | Queen Player


generateText : Piece -> String
generateText piece =
    case piece of
        Pawn _ ->
            "P"

        Rook _ ->
            "R"

        Knight _ ->
            "K"

        Bishop _ ->
            "B"

        King _ ->
            "Ki"

        Queen _ ->
            "Q"
