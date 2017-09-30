module Components.Board.Main exposing (..)

import Types.Space exposing (..)
import Types.Player exposing (..)
import Types.Pieces exposing (..)
import List as L
import Html exposing (..)
import Components.Board.Styles exposing (..)


renderSpace : Space -> Html a
renderSpace space =
    let
        -- colour =
        --     Player.colorToString space.colour

        colour =
            case space.colour of
                White -> .white
                Black -> .black

        piece =
            \mPiece ->
                case mPiece of
                    Just piece ->
                        generateText piece

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
        [ class .grid ]
        (L.map (\row -> ul [] (renderRow row)) grid)
