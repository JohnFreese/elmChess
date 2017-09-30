module Components.Board exposing (..)

import Types.Space exposing (..)
import Types.Player as Player
import Types.Pieces as Piece
import List as L
import Html exposing (..)
import Html.Attributes exposing (..)
import String


renderSpace : Space -> Html a
renderSpace space =
    let
        colour =
            Player.colorToString space.colour

        piece =
            \mPiece ->
                case mPiece of
                    Just piece ->
                        Piece.generateText piece

                    Nothing ->
                        ""
    in
        li
            [ class colour ]
            [ text (piece space.piece) ]


renderRow : List Space -> List (Html a)
renderRow spaces =
    L.map renderSpace spaces


renderGrid : Grid -> Html a
renderGrid grid =
    div
        []
        (L.map (\row -> ul [] (renderRow row)) grid)
