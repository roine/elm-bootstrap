module Main exposing (..)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Html exposing (Html, a, button, div, li, text, ul)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick)
import Page.About
import Page.Home
import Route
import Url


type Model
    = HomePage Page.Home.Model
    | AboutPage Page.About.Model
    | NotFoundPage { key : Nav.Key }


type alias Flags =
    ()


init : Flags -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    toRoute url key


toRoute : Url.Url -> Nav.Key -> ( Model, Cmd Msg )
toRoute url key =
    case Route.fromUrl url of
        Nothing ->
            ( NotFoundPage { key = key }, Cmd.none )

        Just Route.Home ->
            let
                ( homeModel, cmd ) =
                    Page.Home.init key
            in
            ( HomePage homeModel, Cmd.map HomeMsg cmd )

        Just Route.About ->
            let
                ( aboutModel, cmd ) =
                    Page.About.init key
            in
            ( AboutPage aboutModel, Cmd.map AboutMsg cmd )



-- UPDATE


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChange Url.Url
    | HomeMsg Page.Home.Msg
    | AboutMsg Page.About.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( UrlRequested urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl (getKey model) (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        ( UrlChange url, _ ) ->
            toRoute url (getKey model)

        ( HomeMsg subMsg, HomePage home ) ->
            let
                ( newModel, cmd ) =
                    Page.Home.update subMsg home
            in
            ( HomePage newModel, Cmd.map HomeMsg cmd )

        ( AboutMsg subMsg, AboutPage about ) ->
            let
                ( newModel, cmd ) =
                    Page.About.update subMsg about
            in
            ( AboutPage newModel, Cmd.map AboutMsg cmd )

        ( _, _ ) ->
            ( model, Cmd.none )


getKey : Model -> Nav.Key
getKey model =
    case model of
        HomePage m ->
            Page.Home.getKey m

        AboutPage m ->
            Page.About.getKey m

        NotFoundPage m ->
            m.key



-- VIEW


view : Model -> Document Msg
view model =
    { title = "hello title"
    , body =
        [ navView model
        , bodyView model
        ]
    }


navView : Model -> Html Msg
navView model =
    ul []
        [ li [] [ a [ href (Route.toString Route.Home) ] [ text "Home page" ] ]
        , li [] [ a [ href (Route.toString Route.About) ] [ text "About" ] ]
        ]


bodyView : Model -> Html Msg
bodyView model =
    case model of
        HomePage m ->
            Html.map HomeMsg (Page.Home.view m)

        AboutPage m ->
            Html.map AboutMsg (Page.About.view m)

        NotFoundPage _ ->
            text "Page not found"



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- INIT


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        , onUrlRequest = UrlRequested
        , onUrlChange = UrlChange
        }
