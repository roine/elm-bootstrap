module Main exposing (..)

import Browser exposing (Document)
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


type alias Model =
    ()


type alias Flags =
    ()


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( (), Cmd.none )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Document Msg
view model =
    { title = "hello title", body = [ div [] [ text "hello world" ] ] }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- INIT


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
