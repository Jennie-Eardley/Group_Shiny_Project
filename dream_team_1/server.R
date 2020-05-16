server <- function(input, output) {
   
# tab 1, plot 1
output$keyword_plot <- renderPlotly({
   
   plot1 <- keywords %>%  
      filter(keyword %in% input$keyword) %>% 
      ggplot() +
      geom_col(aes(x = keyword, y = count)) +
      labs(x = "Keyword",
           y = "Number of Searches per keyword") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
  ggplotly(plot1)
   
   })
  
# tab 1, plot 2
  output$search_engine_plot <- renderPlotly({
   
    plot2 <- search_engine %>% 
      filter(n > 1) %>% 
     ggplot() +
     geom_col(aes(x = source, y = n)) +
     labs(x = "Search Engine Name",
       y = "Number of Searches"
     ) +
     theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
    ggplotly(plot2)
    
 })

  # tab 1, plot 3
  output$advert_plot <- renderPlotly({
    
     plot3 <- adverts %>% 
       filter(ad_type %in% input$advert) %>% 
        ggplot() +
        geom_col(aes(x = ad_type, y = count)) +
        labs(x = "Type of Advert",
           y = "Number of Clicks"
        ) +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))
     
     ggplotly(plot3)
     
  })

 # tab 1, plot 4
 output$social_media_plot <- renderPlotly({
   plot4 <- social_media %>% 
     dplyr::filter(n > 1) %>% 
     ggplot() +
     geom_col(aes(x = socialNetwork, y = n)) +
     labs(x = "Social Media Company",
       y = "Number of Clicks"
     )
   
   ggplotly(plot4)
   
 })


 
 # Reactive data for tab 2 plots 1, 2, 3
 date_filtered_goal_completion_data <- reactive({
   
   goal_completion_data %>% 
     filter(date >= input$date_range[1], date <= input$date_range[2])
 }) 
 
 
 # Reactive data for tab 2 plot 4
 
 codeclan_event_dataframe <- reactive({
   
   event_date_data %>% 
     filter(date >= input$date_range[1], date <= input$date_range[2])
   
 })
 
 #tab 2 plot 1
  output$pages_visited <- renderPlotly({
    
    num_pages_visited <- date_filtered_goal_completion_data() %>% 
      select(`number of pages visited before making booking` = step,
             page) %>% 
      group_by(`number of pages visited before making booking`) %>% 
      summarise(`number of users per step` = n()) %>% 
      ggplot(aes(x = `number of pages visited before making booking`, y = `number of users per step`)) +
      geom_col() +
      xlab("Pages Visited Before Making Booking") +
      ylab("Users per Step")
    
    
    ggplotly(num_pages_visited)
    
  })
  
  
  #tab 2 plot 2
  output$page_of_completion <- renderPlotly({
    
      goal_completion_page <- date_filtered_goal_completion_data() %>% 
        filter(step == "0") %>% 
        group_by(page) %>% 
        summarise(count = n()) %>% 
        arrange(desc(count)) %>% 
        mutate(page = fct_reorder(page, desc(count))) %>% 
        ggplot(aes(x = page, y = count)) +
        geom_col() +
        theme(axis.text.x = element_blank()) +
        xlab(label = "Page") +
        ylab(label = "Number who Booked Event from Page")
      
      ggplotly(goal_completion_page)
  })
  
  #tab 2 plot 3
  output$page_before_completion <- renderPlotly({
    
    first_page_before_goal_completed <- date_filtered_goal_completion_data() %>% 
      filter(step == "1") %>% 
      group_by(page) %>% 
      summarise(count = n()) %>% 
      arrange(desc(count)) %>% 
      mutate(page = fct_reorder(page, desc(count))) %>% 
      head(n = 10) %>% 
      ggplot(aes(x = page, y = count)) +
      geom_col() +
      theme(axis.text.x = element_blank()) +
      xlab(label = "Page") +
      ylab(label = "Number Who Visited Page")
    
    
    ggplotly(first_page_before_goal_completed)
    
  })
  
  
  # tab 2 plot 4. Timeseries of number of events booked per day. 
  output$event_timeseries <- renderPlotly({
    
    event_timeseries <- codeclan_event_dataframe() %>% 
      filter(step == 0) %>% 
      mutate(event = as.numeric(event)) %>% 
      group_by(date, event) %>% 
      summarise(goal_completion_count = n()) %>% 
      ggplot()+
      geom_line(aes(x = date, y = goal_completion_count), colour = "#555555") +
      geom_pointrange(aes(x = date, y = event, ymin = 0, ymax = max(goal_completion_count)), colour = "#4C768E", alpha = 0.4) +
      xlab(label = "Date") +
      ylab(label = "Number of Event Bookings")
    
    ggplotly(event_timeseries)
    
    
  })
  
  
  # --  
  # tab 3 plot 1
  # --
  output$exit_rates_plot_1 <- renderPlotly({ 
    
      tab_3_plot1 <- exit_page_path_df  %>% 
      filter(exits > 1000) %>% 
      mutate(exitPagePath = fct_reorder(exitPagePath, desc(exitRate))) %>% 
      ggplot() +
      aes(x = exitPagePath, y = exitRate) +
      geom_col() +
      theme(axis.text.x = element_blank()) +
      xlab("Exit Page") +
      ylab("Exit Rate") 
     
      ggplotly(tab_3_plot1)

  })
  output$page_depth_plot_1 <- renderPlotly({ 
    
    tab_3_plot2 <- page_depth_df  %>% 
    filter(exits > 300) %>%
    filter(!is.na(visits)) %>% 
    mutate(visits = factor(as.character(visits), levels = c("3","2","1"))) %>% 
    mutate(exit_page_path = fct_reorder(exit_page_path, desc(exits))) %>%
    ggplot() +
    aes(x = exit_page_path, y = exits, fill = visits) +
    geom_col() +
    theme(axis.text.x = element_blank()) +
    xlab("Exit Page") +
    ylab("Exits") +
    scale_fill_manual(values = c("1" = "#0C2533","2" = "#073E5D","3" = "#4C768E"))
  
    ggplotly(tab_3_plot2)
    
  })
  # --  
  # tab 3 plot 3
  # --  
  output$sessions_and_exits_plot_1 <- renderPlotly({ 
    
      tab_3_plot3 <- sessions_and_exits_df  %>% 
      mutate(exitPagePath = fct_reorder(exit_page_path, desc(avg_session_duration))) %>%
      ggplot() +
      aes(x = exitPagePath , y = avg_session_duration) +
      geom_col() +
      theme(axis.text.x = element_blank()) +
      xlab("Exit Page") +
      ylab("Time in Seconds") +
      scale_fill_manual(values = c("1" = "#0C2533","2" = "#073E5D","3" = "#4C768E"))  
    
      ggplotly(tab_3_plot3)
    
  }) 
  
}
