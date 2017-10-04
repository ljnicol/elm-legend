module Main exposing (..)

import Html exposing (Html, text, div, img, table, tr, th, td)
import Html.Attributes exposing (src, class)
import List exposing (..)
import Debug exposing (log)


---- MODEL ----


type alias Model =
    { colours : List String
    , labels : List Int
    }


initModel : Model
initModel =
    { colours = [ "#ffffe0", "#e3e3d5", "#c6c6cb", "#aaaac0", "#8e8eb5", "#7171ab", "#5555a0", "#393995", "#1c1c8b", "#000080" ]
    , labels = [ 0, 5, 9, 13, 17, 20, 25, 31, 63, 121, 3699 ]
    }


init : ( Model, Cmd Msg )
init =
    ( initModel
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ table [ class "legend" ]
            [ tr []
                (colours model.colours)
            , tr []
                (labels model.labels)
            ]
        ]


colours : List String -> List (Html Msg)
colours cs =
    let
        width =
            (toString <| 100 / (toFloat <| List.length cs)) ++ "%"
    in
        List.map (colour width) cs


labels : List Int -> List (Html Msg)
labels ls =
    let
        lastAt =
            (length ls) - 1

        first =
            take lastAt ls

        last =
            drop lastAt ls

        x =
            Debug.log ("last") last
    in
        List.map (label "label") first
            ++ List.map (label "label last") last


label : String -> Int -> Html Msg
label c l =
    td [ class c ] [ text <| toString l ]


colour : String -> String -> Html Msg
colour width c =
    th [ class "color", Html.Attributes.style [ ( "background-color", c ), ( "width", width ) ] ] []



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
