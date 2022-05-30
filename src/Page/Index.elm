module Page.Index exposing (Data, Model, Msg, page)

import Array
import DataSource exposing (DataSource, andThen, map2)
import DataSource.File
import DataSource.Port
import DataSources.CV exposing (CV, Experience, Tag, cVDecoder, tagDecoder)
import Head
import Head.Seo as Seo
import Html exposing (Html, a, h1, h2, h3, img, li, ol, p, span, text, ul)
import Html.Attributes exposing (alt, class, height, href, src, title, width)
import Json.Encode exposing (Value)
import OptimizedDecoder exposing (list, string)
import Page exposing (Page, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Shared
import View exposing (View)
import Path


type alias Model =
    ()


type alias Msg =
    Never


type alias RouteParams =
    {}


page : Page RouteParams Data
page =
    Page.single
        { head = head
        , data = data
        }
        |> Page.buildNoState { view = view }


tagsEncoder : List Tag -> Value
tagsEncoder tags =
    let
        string =
            Json.Encode.string

        list =
            Json.Encode.list

        object =
            Json.Encode.object
    in
    list
        (\tag ->
            object
                [ ( "name", string tag.name )
                , ( "icon", string tag.icon )
                , ( "link", string tag.link )
                ]
        )
        tags


replaceTags : List (List Tag) -> CV -> CV
replaceTags tags cv =
    let
        arrayTags =
            Array.fromList tags

        arrayExp =
            Array.fromList cv.experience

        replaced =
            Array.indexedMap
                (\i exp -> { exp | tags = Array.get i arrayTags |> Maybe.withDefault [] })
                arrayExp
    in
    { cv | experience = Array.toList replaced }


data : DataSource Data
data =
    DataSource.File.jsonFile cVDecoder "data/cv.json"
        |> andThen
            (\cv ->
                map2 (\icons qrcode -> replaceTags icons cv |> Data qrcode)
                    (DataSource.Port.get "base64Icons"
                        (Json.Encode.list tagsEncoder (List.map .tags cv.experience))
                        (list (list tagDecoder))
                    )
                    (DataSource.Port.get "qrcode"
                        Json.Encode.null
                        string
                    )
            )


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head static =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "jaye-personal"
        , image =
            { url = Path.fromString "/me.png" |> Pages.Url.fromPath 
            , alt = "logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Jaye Marshalls personal site for stuff"
        , locale = Nothing
        , title = "Ramblings"
        }
        |> Seo.website


type alias Data =
    { qrcode : String, cv : CV }


viewTag : Tag -> Html Msg
viewTag tag =
    li []
        [ a [ href tag.link ]
            [ img [ src tag.icon, width 32, height 32, alt tag.name, title tag.name ] []
            , p [] [ text tag.name ]
            ]
        ]


viewExperience : Experience -> Html Msg
viewExperience exp =
    li [ class "experience" ]
        [ span [ class "company" ]
            [ h3 [] [ text exp.company ]
            , ol [ class "years" ]
                (List.intersperse (text " - ") (List.map (\year -> li [] [ String.fromInt year |> text ]) exp.years))
            ]
        , p [] [ text exp.description ]
        , ul [ class "tags" ] (List.sortBy .name exp.tags |> List.map viewTag)
        ]


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel static =
    View.plain "Index"
        [ h1 []
            [ text static.data.cv.personal.firstName
            , text " "
            , text static.data.cv.personal.middleName
            , text " "
            , text static.data.cv.personal.lastName
            ]
        , a [ href "https://jaye.blackarts.tech" ] [ img [ class "qrcode", src static.data.qrcode ] [] ]
        , h2 []
            [ a [ "mailto: " ++ static.data.cv.personal.email |> href ] [ text static.data.cv.personal.email ]
            ]
        , h2 []
            [ a [ "https://github.com/" ++ static.data.cv.personal.github |> href ]
                [ text "github:"
                , text static.data.cv.personal.github
                ]
            ]
        , p [] [ text static.data.cv.personal.bio ]
        , ol [ class "history" ] (List.map viewExperience static.data.cv.experience)
        ]
