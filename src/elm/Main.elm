module Main exposing (..)

import InitialGrid exposing (..)
import Types.Player exposing (..)
import Components.Board exposing (..)
import Types.Space exposing (..)
import Types.Pieces exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes as HA
import Html.Events exposing (onClick)
import CssModules exposing (css)


-- component import example

import Components.Hello exposing (hello)


-- CssModules example
{ class } =
    css "./test.css"
        { black = "" }



-- APP


main : Program Never Grid Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL

model : Grid
model =
    initialGrid



-- UPDATE


type Msg
    = NoOp
    | Increment


update : Msg -> Grid -> Grid
update msg model =
    case msg of
        NoOp ->
            model

        Increment ->
            model



-- VIEW
-- Html is defined as: elem [ attribs ][ children ]
-- CSS can be applied via class names or inline style attrib


view : Grid -> Html Msg
view model =
    renderGrid model

-- CSS STYLES


styles : { img : List ( String, String ) }
styles =
    { img =
        [ ( "width", "33%" )
        , ( "border", "4px solid #337AB7" )
        ]
    }
