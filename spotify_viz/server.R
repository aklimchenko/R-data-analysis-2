# Server Logic for spotify visualization

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    
    market_selection <- reactiveVal(NULL)
    
    observeEvent(req(input$m_name), {
        market_selection(input$n_name)
        market_data()
    })
        

    
    market_data <- reactive({
        print(market_info[market_info$Name== input$m_name, 2])
        
        temp_path <- file.path("./artist_market_data/", paste(market_info[market_info$Name== input$m_name, 2], ".csv", sep=""))
        print(temp_path)
        market_data <- readr::read_csv(temp_path)
        
        # for (data in list.files(path = './artist_market_data')){
        #     if(market_info[market_info$Name== input$m_name, 2] == tools::file_path_sans_ext(data)){
        #         market_data <- readr::read_csv(temp_path)
        #     }
        # }
        print(head(market_data))
        return(market_data)
    })
    
#    function to show box plot
    output$pop_plot <- renderPlot({
        market_data() %>% mutate( bin=cut_width(popularity, width=10, boundary=0)) %>%
            ggplot( aes(x=bin, y=followers) ) +
            geom_boxplot(color = "black", fill="#1DB954") +
            theme(panel.grid.minor = element_line(colour="white", size=0.5)) +
            theme(panel.grid.major = element_line(colour="#191414", size=0.5)) +
            #  theme(panel.background = element_rect(fill = "#191414"))
            scale_y_continuous(trans="log10") +
            xlab("Popularity") + 
            ylab("Followers")
    })
    
    # display the market table
    output$table <- renderDataTable({
        market_data()
    })
    
    output$all_markets <- renderDataTable(
        market_info
    )

#    main <- reactive({})
    
    
#     artists_delay <- reactive({
#         artists %>%
#             filter(origin == input$origin & foreign == input$foreign) %>%
#             group_by(popularity) %>%
#             summarise(n = n(),
#                       # number of times artist appears in the foreign market
#                       departure = mean(dep_delay),
#             )
#     })
# 
# 
#     output$count <- renderPlot(
#         artists_delay() %>%
#             ggplot(aes(x = popularity, y = n)) +
#             geom_col(fill = "lightblue") +
#             ggtitle("Number of foreign markets")
#     )
# 
# 
#     output$delay <- renderPlot(
# 
#         artists_delay()  %>% pivot_longer(
#             arrival:departure,
#             names_to = "Artist",
#             values_to = "delay"
#         ) %>% ggplot() +
#             geom_col(
#                 aes(x=carrier, y = delay, fill=type),
#                 position = "dodge"
#             )
#     )
# 

# 
# })

    
})