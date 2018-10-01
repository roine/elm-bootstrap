module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


type alias Model =
    ()



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model



-- VIEW


view : Model -> Html Msg
view model =
    div [] [ text "hello world" ]



-- INIT


main : Program () Model Msg
main =
    Browser.sandbox
        { init = ()
        , update = update
        , view = view
        }
