module View exposing (View, map, plain)

import Html exposing (Html)


type alias View msg =
    { title : String
    , body : List (Html msg)
    }


map : (msg1 -> msg2) -> View msg1 -> View msg2
map fn doc =
    { title = doc.title
    , body = List.map (Html.map fn) doc.body
    }


plain : String -> List (Html msg) -> View msg
plain title body =
    { title = "Jaye - " ++ title
    , body = body
    }
