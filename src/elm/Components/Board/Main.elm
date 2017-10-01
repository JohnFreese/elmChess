module Components.Board.Main exposing (..)

import Array as A
import Types.Space exposing (..)
import Types.Player exposing (..)
import Types.Pieces exposing (..)
import List as L
import Html exposing (..)
import Components.Board.Styles exposing (..)
import Html.Attributes as HA
import Html.Events exposing (onClick)


type Msg
    = GenMoves Space
    | MakeMove Space

renderSpace : Space -> Html Msg
renderSpace space =
    let
        -- colour =
        --     Player.colorToString space.colour
        action =
            case space.active of
                False -> onClick (GenMoves space)
                True -> onClick (MakeMove space)

        colour =
            if space.active then
                .green
            else
                case space.colour of
                    White ->
                        .white

                    Black ->
                        .black

        piece =
            \mPiece ->
                case mPiece of
                    Just piece ->
                        generateText piece

                    Nothing ->
                        ""
    in
        li
            [ class colour , action]
            [ text (piece space.piece) ]


renderRow : A.Array Space -> List (Html Msg)
renderRow spaces =
    A.toList (A.map renderSpace spaces)


renderGrid : Grid -> Html Msg
renderGrid grid =
    div
        [ class .grid ]
        (A.toList (A.map (\row -> ul [] (renderRow row)) grid.data))
