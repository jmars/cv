module Site exposing (config)

import DataSource
import Head
import MimeType
import Pages.Manifest as Manifest
import Pages.Url
import Path
import Route
import SiteConfig exposing (SiteConfig)


type alias Data =
    ()


config : SiteConfig Data
config =
    { data = data
    , canonicalUrl = "https://jaye.blackarts.tech"
    , manifest = manifest
    , head = head
    }


data : DataSource.DataSource Data
data =
    DataSource.succeed ()


head : Data -> List Head.Tag
head static =
    [ Head.sitemapLink "/sitemap.xml"
    , Head.icon [ ( 64, 64 ) ] MimeType.Png (Path.fromString "/me.png" |> Pages.Url.fromPath)
    ]


manifest : Data -> Manifest.Config
manifest static =
    Manifest.init
        { name = "Jaye Marshall"
        , description = "Jaye Marshalls digital CV"
        , startUrl = Route.Index |> Route.toPath
        , icons =
            []
        }
