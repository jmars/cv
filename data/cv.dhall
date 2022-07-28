let Tags = ./tags.dhall

let Experience : Type =
      {
            company : Text
      ,     years : List Natural
      ,     title : Text
      ,     description : Text
      ,     tags : List Tags.Tag
      }

let Personal : Type =
      { firstName : Text
      , middleName : Text
      , lastName : Text
      , email : Text
      , github : Text
      , bio : Text
      }

let CV : Type =
      {
            personal : Personal
      ,     experience : List Experience
      }

let cv : CV =
      { personal = { firstName = "Jaye"
                   , middleName = "Timothy"
                   , lastName = "Marshall"
                   , email = "jaye@blackarts.tech"
                   , github = "jmars"
                   , bio = ''
                        I am an experienced programmer who doesn't take myself too seriously. Comfortable in many different environments and technology stacks. I follow the principle of KISS (Keep It Simple Stupid) when possible after seeing many instances where simple and understandable beats clever and elegant.
                        
                        I have an interest and good understanding of how computer systems operate at a low level as well as more abstract and formalized computer science concepts. Although experiments and exploration related to this is done on my own time and left out of product work. I believe that the breadth of my knowledge and experience allows me to make more pragmatic decisions, identify problems and communicate more clearly to stakeholders.
                  ''
                   }
      , experience = [
            { company = "Nexteam"
            , years = [2021, 2022]
            , title = "Frontend / Mobile Lead"
            , description = "Various consulting projects for startups in the US, mostly react apps with some machine learning work."
            , tags = [Tags.react, Tags.nest, Tags.typescript, Tags.node]
            },
            { company = "Tesco"
            , years = [2021, 2022]
            , title = "Full Stack Engineer"
            , description = "Tesco groceries site, microfrontend project. React and vanilla javascript, also setting up build pipelines and CI using k8s working closely with the dedicated DevOps team."
            , tags = [Tags.typescript, Tags.react, Tags.graphql, Tags.node, Tags.kubernetes, Tags.AWS]
            },
            { company = "Munii"
            , years = [2020]
            , title = "Frontend Lead"
            , description = "Frontend Lead for a fintech startup in London, building out a banking frontend with a small team in react and managing CI and deployments to GCP with k8s."
            , tags = [Tags.typescript, Tags.react, Tags.node, Tags.GCP, Tags.kubernetes]
            },
            { company = "Various"
            , years = [2020]
            , title = "Frontend Lead"
            , description = "Own startup work (beaten to market by competitor with VC funding). Using Figma, flutter and cloudflare workers along with typescript."
            , tags = [Tags.typescript, Tags.react, Tags.node]
            },
            { company = "News UK"
            , years = [2018, 2019, 2020]
            , title = "Frontend Developer"
            , description = "GraphQL server to aggregate distributed services using AWS lambda, The Times mobile app in react native, as the only react developer on that team."
            , tags = [Tags.reactNative, Tags.react, Tags.javascript, Tags.typescript, Tags.AWS]
            },
            { company = "JustPark"
            , years = [2018]
            , title = "Frontend Developer"
            , description = "JustPark web app, performance work and custom animations for maps integration."
            , tags = [Tags.react, Tags.javascript, Tags.canvas, Tags.d3]
            },
            { company = "Babylon Health"
            , years = [2017]
            , title = "Frontend Developer"
            , description = "Internal system for epidemiologists to enter probability data for diagnostic engine, various demos for media coverage, including for BBC horizon."
            , tags = [Tags.react, Tags.javascript, Tags.d3, Tags.reasonML, Tags.reactNativeWeb]
            },
            { company = "Bright Analytics"
            , years = [2015, 2016]
            , title = "Frontend Developer"
            , description = "Analytics dashboard with real time updates in meteor, custom charts and charting library integrations."
            , tags = [Tags.meteor, Tags.javascript]
            },
            { company = "Social Finance"
            , years = [2015, 2016]
            , title = "Frontend Developer"
            , description = "Web application for public health workers to identify children at risk using markov chains and pattern recognition."
            , tags = [Tags.elm, Tags.javascript, Tags.canvas]
            },
            { company = "Beyond Analysis"
            , years = [2015]
            , title = "Fullstack Developer"
            , description = "Business intelligence dashboard for large corporates, custom charts and performance work."
            , tags = [Tags.node, Tags.canvas, Tags.angular, Tags.riot]
            },
            { company = "Gamesys"
            , years = [2013, 2014]
            , title = "Frontend Developer"
            , description = "Main menu for game selection, web app."
            , tags = [Tags.javascript, Tags.backbone, Tags.wire, Tags.marionette]
            },
            { company = "Blackarts"
            , years = [2010, 2011, 2012, 2013]
            , title = "Fullstack Developer"
            , description = "Consulting work for agency client, a mostly static website with a small amount of interactivity added."
            , tags = [Tags.coffeescript, Tags.javascript, Tags.backbone, Tags.node]
            }
            ]
      }

in  cv
