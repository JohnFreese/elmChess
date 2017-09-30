module Main exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes as HA
import Html.Events exposing ( onClick )
import CssModules exposing (css)

-- component import example
import Components.Hello exposing ( hello )


-- CssModules example
{ class } =
    css "./test.css"
        { black = "" }




-- APP
main : Program Never Int Msg
main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL
type alias Model = Int

model : number
model = 0


-- UPDATE
type Msg = NoOp | Increment

update : Msg -> Model -> Model
update msg model =
  case msg of
    NoOp -> model
    Increment -> model + 1


-- VIEW
-- Html is defined as: elem [ attribs ][ children ]
-- CSS can be applied via class names or inline style attrib
view : Model -> Html Msg
view model =
  div [ HA.class "container", style [("margin-top", "30px"), ( "text-align", "center" )] ][    -- inline CSS (literal)
    div [ HA.class "row" ][
      div [ HA.class "col-xs-12" ][
        div [ HA.class "jumbotron" ][
          img [ src "static/img/elm.jpg", style styles.img ] []                             -- inline CSS (via var)
          , hello model                                                                     -- ext 'hello' component (takes 'model' as arg)
          , p [] [ text ( "Elm Webpack Starter" ) ]
          , button [ class .black, HA.class "btn btn-primary btn-lg", onClick Increment ] [                  -- click handler
            span[ HA.class "glyphicon glyphicon-star" ][]                                      -- glyphicon
            , span[][ text "FTW!" ]
          ]
        ]
      ]
    ]
  ]


-- CSS STYLES
styles : { img : List ( String, String ) }
styles =
  {
    img =
      [ ( "width", "33%" )
      , ( "border", "4px solid #337AB7")
      ]
  }
