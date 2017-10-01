module Main exposing (..)

import Engine.MovePiece exposing (..)
import Maybe exposing (..)
import Engine.Utils exposing (..)
import Engine.GenMoves exposing (..)
import InitialGrid exposing (..)
import Types.Player exposing (..)
import Components.Board.Main exposing (..)
import Types.Space exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes as HA


-- APP


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL

model : Model
model =
    Model initialGrid (Player White 0 True) Nothing Nothing



update : Msg -> Model -> Model
update msg model =
    let
        freshGrid = resetGrid (withDefault [] model.activeSpaces) model.grid
        freshModel = { model | grid = freshGrid}
    in
        case msg of
            GenMoves space ->
                case space.piece of
                    Nothing ->
                        model

                    Just piece ->
                        case (generateMoves space freshGrid) of
                            Nothing ->
                                { model
                                    | selectedSpace = Just space
                                    , activeSpaces = Nothing
                                }

                            Just ( newGrid, moves ) ->
                                { model
                                    | selectedSpace = Just space
                                    , grid = newGrid
                                    , activeSpaces = Just moves
                                }

            MakeMove destination ->
                case model.selectedSpace of
                    Nothing -> model
                    Just origin ->
                        movePiece origin destination freshModel

-- VIEW
-- Html is defined as: elem [ attribs ][ children ]
-- CSS can be applied via class names or inline style attrib


view : Model -> Html Msg
view model =
    div [ class "center" ]
        [ renderGrid model.grid ]
