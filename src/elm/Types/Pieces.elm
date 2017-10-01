module Types.Pieces exposing (..)

import Types.Player exposing (..)


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

generateSrc : Piece -> String
generateSrc piece =
  let
      baseClass = \p -> case p.colour of
        White -> "static/img/white"
        Black -> "static/img/black"
  in
      
    case piece of
        Pawn player ->
            (baseClass player) ++ "Pawn.png"

        Rook player ->
            (baseClass player) ++ "Rook.png"

        Knight player ->
            (baseClass player) ++ "King.png"

        Bishop player ->
            (baseClass player) ++ "Bishop.png"

        King player ->
            (baseClass player) ++ "King.png"

        Queen player ->
            (baseClass player) ++ "Queen.png"


getOwner : Piece -> Player
getOwner piece =
    case piece of
        Pawn owner ->
            owner

        Rook owner ->
            owner

        Knight owner ->
            owner

        Bishop owner ->
            owner

        King owner ->
            owner

        Queen owner ->
            owner
