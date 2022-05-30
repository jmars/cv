module DataSources.CV exposing (..)

import OptimizedDecoder exposing (Decoder, andMap, field, int, list, map, string)


type alias Tag =
    { name : String
    , icon : String
    , link : String
    }


tagDecoder : Decoder Tag
tagDecoder =
    map Tag (field "name" string)
        |> andMap
            (field "icon" string)
        |> andMap
            (field "link" string)


type alias Experience =
    { company : String
    , years : List Int
    , title : String
    , description : String
    , tags : List Tag
    }


experienceDecoder : Decoder Experience
experienceDecoder =
    map Experience (field "company" string)
        |> andMap (field "years" (list int))
        |> andMap
            (field
                "title"
                string
            )
        |> andMap
            (field
                "description"
                string
            )
        |> andMap (field "tags" (list tagDecoder))


type alias Personal =
    { firstName : String
    , middleName : String
    , lastName : String
    , email : String
    , github : String
    , bio : String
    }


personalDecoder : Decoder Personal
personalDecoder =
    map Personal (field "firstName" string)
        |> andMap (field "middleName" string)
        |> andMap (field "lastName" string)
        |> andMap (field "email" string)
        |> andMap (field "github" string)
        |> andMap (field "bio" string)


type alias CV =
    { personal : Personal
    , experience : List Experience
    }


cVDecoder : Decoder CV
cVDecoder =
    map CV (field "personal" personalDecoder) |> andMap (field "experience" (list experienceDecoder))
