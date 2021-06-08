# ui for spotify viz Shiny app


shinyUI(dashboardPage(
  dashboardHeader(title='Spotify Artist Markets'),

  dashboardSidebar( sidebarUserPanel("Spotify",
                                     image = "Spotify_Icon_RGB_Green.png" ),
                    sidebarMenu(
#                        menuItem("Map", tabName = "map", icon = "map")
                        menuItem("Markets", tabName = "markets", icon = icon("map")),
                        menuItem("Plots", tabName = "plots", icon = icon("bar-chart-o")),
                        menuItem("Data", tabName = "data", icon = icon("database"))
                        ),
                    
#                    selectizeInput(inputId='origin', label='US Artist',
#                                   choices=unique(artists$origin),
#                                   selected=unique(artists$origin)[1]),
                    selectizeInput(inputId = "m_name", 
                                   label = "Select Market 1",
                                   choices=unique(market_info$Name),
                                   selected = ""
                                   )
  ),
  
  dashboardBody(
      tabItems(
          tabItem(tabName = 'markets', DTOutput("all_markets")),
          tabItem(tabName = 'plots', fluidRow(
            column(7, plotOutput("pop_plot"))
            )),
          tabItem(tabName = 'data', DTOutput("table"))
      )
  )
))