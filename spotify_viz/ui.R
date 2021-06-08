# ui for spotify viz Shiny app


shinyUI(dashboardPage(
  dashboardHeader(title='Spotify Market Analysis'),
  dashboardSidebar( sidebarUserPanel("Exploring Global Markets", 
                                     image = "Spotify_Icon_RGB_Green.png" ),
                  sidebarMenu(
                    menuItem("Information", tabName = "info", icon = icon("info")),
                    menuItem("Market Plots", tabName = "plots", icon = icon("bar-chart-o")),
                    menuItem("Genre Data", tabName = "genres", icon = icon("guitar")),
                    menuItem("Market Data", tabName = "data", icon = icon("database")),
                    menuItem("Market Ref", tabName = "markets", icon = icon("map"))
                  ),
        
                  selectizeInput(inputId = "m1_name", 
                                 label = "Select Market 1",
                                 choices=unique(market_info$Name),
                                 selected = "United States"
                                 ),
                  selectizeInput(inputId = "m2_name", 
                                 label = "Select Market 2",
                                 choices=unique(market_info$Name),
                                 selected = "United Kingdom"
                                )
                  
                  
                  ),
  
  dashboardBody(
      tabItems(
        tabItem(tabName = "info",
            fluidPage(
              fluidRow(
                  column(width = 6, h1(tags$b("World of Sound")))
              ),
              br(),
              fluidRow(
                  box(width=7, h3(tags$b("Introduction")), background = "black",
                    p("It is crucial for an artist to understand their market. 
                      This market is influenced by many factors, such as the artists' personal styles,
                      music style, country, cultural scene, etc. Furthermore, competition within a market
                      can also influence whether an artist's career rises or bottoms out. This dashboard 
                      will visually explore some of the aspects that artists or labels may take into account
                      when deciding which markets to target."),
                    p("First, we revisit the relationship between an artist's popularity and
                      their follower count. This relationship can be compared across different country markets,
                      letting us see if the same trend is observed in each."),
                    p("Next, we take a look at the most popular genres (as based on the US market), which 
                      could help direct an artist towards developing a particular style of sound."),
                    p("Finally, our analyses will allow us to direct 
                      our focus towards unexplored areas and future work.")
                  )
              ),
              fluidRow(
                box(width=3, h3(tags$b("Surfing Global Markets")), background = "black",
                    p("As can be seen from the Market Plots, there is no discernable difference in popularity
                      versus followers across any country's market. It seems as though every country showed artists
                      gaining an exponential amount of followers with each increase in popularity. However, 
                      the considerable overlap between number of followers and adjacent popularity intervals means
                      more analysis is required to confirm the existence of any correlation between artist popularity
                      and follower count.
                        ")
                ),
                box(width=3, h3(tags$b("Tuned to Genre")), background = "black",
                    p("As can be seen from the Market Plots, there is no discernable difference in popularity
                      versus followers across any country's market. It seems as though every country showed artists
                      gaining an exponential amount of followers with each increase in popularity. However, 
                      the considerable overlap between number of followers and adjacent popularity intervals means
                      more analysis is required to confirm the existence of any correlation between artist popularity
                      and follower count.
                        ")
                )
              ),
              fluidRow(
                box(width=7, h3(tags$b("Concluding Remarks")), background = "black",
                    p("As mentioned above, we looked at several factors that impact artists: country market, followers,
                    popularity, and genre."), 
                    p("There didn't seem to a noticeable difference between countries 
                    in terms of artist popularity vs followers, so we did not get insight as to a country that could be 
                    targetted by labels or rising artists; growing popularity will do more for artist follower counts than
                    touring in any particular country."),
                    p("Seeing which genres are most popular was more helpful, but only in a broad sense. This information can be used
                      to help artists redirect their music styles, and it can help labels predict which genres are more likely
                      to be successful. However, some missing information limits our ability to make full use of the analysis:
                      these genres were limited to US market data, so we don't know whether foreign markets follow similar tastes;
                      each genre's popularity was calculated from all artist popularities, which may have influenced the results
                      due to the distribution of artists at each popularity; many artists did not have any genres assigned,
                      and this may have impacted our results."),
                    p("We can continue our analysis in several different directions. For instance, we could explore whether the genres popular in
                      the US have similar popularity in other countries. In addition, we can examine the relationship between number of artists
                      within a genre and the genres popularity; are genres more popular due to a smaller number of artists available to listeners?
                      Another option would be to organize genres into groups and subgenres, through which we may gain a useful metric by which to
                      predict artist popularity.")
                )
              ),
              fluidRow(
                box(width=6, h4("Sources and Info"),
                    p("Shiny App Author: Aleksey Klimchenko"),
                    br(),
                    p("All data taken from spotify kaggle datasets:"),
                    p("US Market Source: https://www.kaggle.com/yamaerenay/spotify-dataset-19212020-160k-tracks"),
                    p("Foreign Market Source: https://www.kaggle.com/yamaerenay/spotify-artists-dataset-19222021"),
                    p("Source Dataset Author: Yamac Eren Ay")
                    
                )
              )
            )
        
          ),
        tabItem(tabName = 'genres',
                tabBox(width = 12,
                       tabPanel("Distribution of Genres",
                                fluidRow(
                                  column(8, plotOutput("genre_plot"),
                                         )
                                ),
                                fluidRow(
                                  column(3,
                                         sliderInput("genre_slider",
                                                     label = h3("Genre Popularity Range"),
                                                     min = 0,
                                                     max = 100,
                                                     value = c(0, 100)
                                         )
                                  ),
                                )
                       ),
                       tabPanel("Modality 1 (Major)",
                                DTOutput("mode_1")
                       ),
                       tabPanel("Modality 0 (Minor)",
                                DTOutput("mode_0")
                       )
                )
        ),        
        tabItem(tabName = "plots",
                  tabBox(width = 8,
                         tabPanel("Artist Followers vs Popularity",
                                  fluidRow(
                                    column(12, plotOutput("pop_plot"),
                                          )
                                          ),
                                  fluidRow(
                                    column(3,
                                           sliderInput("pop1_slider",
                                                       label = h3("Market 1 Popularity Range"),
                                                       min = 1,
                                                       max = 100,
                                                       value = c(50, 100)
                                           )
                                    ),
                                    column(3,
                                          sliderInput("pop2_slider",
                                                      label = h3("Market 2 Popularity Range"),
                                                      min = 1,
                                                      max = 100,
                                                      value = c(50, 100)
                                                      )
                                          ),
                                    column(3,
                                           sliderInput("width_slider",
                                                       label = h3("Interval Size"),
                                                       min = 1,
                                                       max = 10,
                                                       value = 5
                                           )
                                    )
                                    
                                          )
                                )
                         )
                  ),
          tabItem(tabName = 'data',
                  tabBox(width = 12,
                         tabPanel("Market 1",
                                  DTOutput("table1")
                                  ),
                         tabPanel("Market 2",
                                  DTOutput("table2")
                                  )
                         )
                  ),        
          tabItem(tabName = "markets", DTOutput("all_markets"))

      ),
  )
))