module Page.About exposing (..)

import Browser.Navigation as Nav
import Html exposing (Html, text)


-- MODEL


type alias Model =
    { key : Nav.Key }


init : Nav.Key -> ( Model, Cmd Msg )
init key =
    ( { key = key }, Cmd.none )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    text "About page"


getKey : Model -> Nav.Key
getKey model =
    model.key
