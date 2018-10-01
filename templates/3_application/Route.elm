module Route exposing (..)

import Url
import Url.Parser as Parser exposing ((</>), Parser, s)


type Page
    = Home
    | About


fromUrl : Url.Url -> Maybe Page
fromUrl url =
    -- Treat fragment as path for convenience
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
        |> Parser.parse parser


parser : Parser (Page -> b) b
parser =
    Parser.oneOf
        [ Parser.map Home Parser.top
        , Parser.map About (s "about")
        ]


toString : Page -> String
toString route =
    case route of
        Home ->
            "#/"

        About ->
            "#/about/"
