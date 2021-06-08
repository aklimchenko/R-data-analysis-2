# Server Logic for spotify visualization

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    
    m1_selection <- reactiveVal(NULL)
    pop1_selection <- reactiveVal(NULL)

    m2_selection <- reactiveVal(NULL)
    pop2_selection <- reactiveVal(NULL)
    
    bin_width_selection <- reactiveVal(NULL)
    
    genre_pop_selection <- reactiveVal(NULL)
    
    observeEvent(req(input$m1_name), {
        m1_selection(input$m1_name)
        pop1_selection(input$pop1_slider)
        m2_selection(input$m2_name)
        pop2_selection(input$pop2_slider)
        
        genre_pop_selection(input$genre_slider)
        
        bin_width_selection(input$width_slider)
        
        m1_data()
        m2_data()
    })
        

#   pull market 1 data from file    
    m1_data <- reactive({
#        print(market_info[market_info$Name== input$m1_name, 2])
        
        temp_path <- file.path("./artist_market_data/", paste(market_info[market_info$Name== input$m1_name, 2], ".csv", sep=""))
  #      print(temp_path)
        m1_data <- readr::read_csv(temp_path)
        
#        print(head(m1_data))
        return(m1_data)
    })

#   pull market 2 data from file    
    m2_data <- reactive({
 #       print(market_info[market_info$Name== input$m2_name, 2])
        
        temp_path <- file.path("./artist_market_data/", paste(market_info[market_info$Name== input$m2_name, 2], ".csv", sep=""))
 #       print(temp_path)
        m2_data <- readr::read_csv(temp_path)
        
 #       print(head(m2_data))
        return(m2_data)
    })
    
#    function to show box plot
    output$pop_plot <- renderPlot({
#        print(input$width_slider)

        # prepare the data for plotting
        m1_df <- m1_data() %>% 
            filter(between(popularity, input$pop1_slider[1], input$pop1_slider[2])) # %>%
#            mutate( bin=cut_width(popularity, width=10, boundary=0))
        m2_df <- m2_data() %>% 
            filter(between(popularity, input$pop2_slider[1], input$pop2_slider[2])) # %>%
#            mutate( bin=cut_width(popularity, width=10, boundary=0))
        
        m1_df$Group <- input$m1_name
        m2_df$Group <- input$m2_name
        
        big_df <- rbind(m1_df, m2_df)

        combo_df <- data.frame(big_df$popularity, big_df$Group, big_df$followers)
        

        combo_df %>% 
            mutate(bin=cut_width(big_df.popularity, width=input$width_slider, boundary=0)) %>%
            ggplot(aes(x=bin, y=big_df.followers, fill=big_df.Group) ) +
            geom_boxplot(color = "black") +
            # stat_summary()
            theme(panel.grid.major = element_line(color="#191414", size=0.5),
                  panel.grid.minor = element_line(color="#191414", size=0.5),
                  plot.title = element_text(color = "black", size = 30),
                  axis.text.x = element_text(color = "black", size = 15),
                  axis.text.y = element_text(color = "black", size = 15),
                  axis.title.x = element_text(color = "black", size = 20),
                  axis.title.y = element_text(color = "black", size = 20),
                  legend.title = element_text(color = "black", size = 20),
                  legend.text = element_text(color = "black", size = 20),
                  legend.justification = c(1,0),
                  legend.position = c(1,0)
            ) +
            #  theme(panel.background = element_rect(fill = "#191414")) +
            scale_y_continuous(trans="log10") +
            labs(title = "Artist Followers vs Popularity", 
                 x= "Popularity Intervals",
                 y = "Followers (log10 scale)",
                 fill = "Markets")
            # xlab("Popularity") + 
            # ylab("Followers (log10 scale)")
    #        scale_y_continuous(labels = comma)
    })
    
    # display the market table
    output$table1 <- renderDataTable({
        m1_data()
    })
    output$table2 <- renderDataTable({
        m2_data()
    })
    
    
    # display the genre boxplot
    output$genre_plot <- renderPlot({
#        print(input$genre_slider)
        genre_info %>% 
            filter(between(popularity, input$genre_slider[1], input$genre_slider[2])) %>%
            ggplot(aes(x=popularity)) +
            geom_histogram(binwidth=1, fill="#1DB954",  color = "black") +
            # stat_summary() 
            theme(panel.grid.major = element_line(color="#191414", size=0.5),
                  panel.grid.minor = element_line(color="#191414", size=0.5),
                  plot.title = element_text(color = "black", size = 30),
                  axis.text.x = element_text(color = "black", size = 15),
                  axis.text.y = element_text(color = "black", size = 15),
                  axis.title.x = element_text(color = "black", size = 20),
                  axis.title.y = element_text(color = "black", size = 20)
            ) +
            #  theme(panel.background = element_rect(fill = "#191414")) +
            labs(title = "Genres Distribution by Popularity", 
                 x= "Popularity Intervals",
                 y = "Number of Genres")
    })
    
    
    
    
    # display the genre tables
    output$mode_1 <- renderDataTable({
        genre_info %>% filter(mode == 1) %>% arrange(desc(popularity))
    })
    output$mode_0 <- renderDataTable({
        genre_info %>% filter(mode == 0) %>% arrange(desc(popularity))
    })
    
    # display market info (for testing reference)
    output$all_markets <- renderDataTable(
        market_info
    )
    

})