module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Login
import LeaderBoard


type alias Model =
    { page : Page
    , leaderBoard : LeaderBoard.Model
    , login : Login.Model
    }


initModel : Model
initModel =
    { page = LeaderBoardPage
    , login = Login.initModel
    , leaderBoard = LeaderBoard.initModel
    }


type Page
    = LoginPage
    | LeaderBoardPage


type Msg
    = ChangePage Page
    | LeaderBoardMsg LeaderBoard.Msg
    | LoginMsg Login.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangePage page ->
            { model
                | page = page
            }

        LeaderBoardMsg lbMsg ->
            { model
                | leaderBoard = LeaderBoard.update lbMsg model.leaderBoard
            }

        LoginMsg lgMsg ->
            { model | login = Login.update lgMsg model.login }


view : Model -> Html Msg
view model =
    let
        page =
            case model.page of
                LeaderBoardPage ->
                    Html.map LeaderBoardMsg
                        (LeaderBoard.view model.leaderBoard)

                LoginPage ->
                    Html.map LoginMsg
                        (Login.view model.login)
    in
        div []
            [ div []
                [ a
                    [ href "#"
                    , onClick (ChangePage LeaderBoardPage)
                    ]
                    [ text "Leaderboard" ]
                , span [] [ text " | " ]
                , a
                    [ href "#"
                    , onClick (ChangePage LoginPage)
                    ]
                    [ text "Login" ]
                ]
            , hr [] []
            , page
            ]


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = initModel, view = view, update = update }
