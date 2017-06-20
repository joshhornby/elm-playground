module App exposing (..)

import Html exposing (Attribute, Html, div, input, p, text, button)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onSubmit)
import Json.Decode exposing (..)
import Json.Decode.Pipeline


---- MODEL ----


type alias Application =
    { id : Int
    , term : Int
    , amount : Int
    }


type alias Model =
    { application : Application
    }


defaultModel =
    { application = { id = 0 } }


init : Json.Decode.Value -> ( Model, Cmd Msg )
init value =
    case Json.Decode.decodeValue decodeApplication value of
        Ok actualModel ->
            ( { defaultModel | application = actualModel }, Cmd.none )

        Err e ->
            Debug.crash "TODO"



---- UPDATE ----


type Msg
    = SubmitForm
    | UpdateAmount String
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SubmitForm ->
            -- Validate here
            -- Http.send
            Debug.crash "TODO"

        UpdateAmount amount ->
            let
                application =
                    model.application

                updatedApplication =
                    { application | amount = Result.withDefault 0 (String.toInt amount) }
            in
                ( { model | application = updatedApplication }, Cmd.none )

        NoOp ->
            Debug.crash "TODO"



---- VIEW ----


view : Model -> Html Msg
view model =
    Html.form [ onSubmit NoOp ]
        [ input
            [ Html.Attributes.value (toString model.application.amount)
            , Html.Attributes.minlength 4
            , Html.Attributes.maxlength 4
            , onInput UpdateAmount
            ]
            []
        , button []
            [ text "Update" ]
        ]



---- PROGRAM ----


decodeApplication : Json.Decode.Decoder Application
decodeApplication =
    Json.Decode.Pipeline.decode Application
        |> Json.Decode.Pipeline.required "id" (Json.Decode.int)
        |> Json.Decode.Pipeline.required "term" (Json.Decode.int)
        |> Json.Decode.Pipeline.required "amount" (Json.Decode.int)


main : Program Json.Decode.Value Model Msg
main =
    Html.programWithFlags
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }
