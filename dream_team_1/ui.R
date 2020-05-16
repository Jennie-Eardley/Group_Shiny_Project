
source("global.R")

ui <- fluidPage(
    theme = shinytheme("superhero"),
    titlePanel(
        title = tags$h1("Website Traffic Analysis")
    ),
    tabsetPanel(
      tabPanel("User Arrival",
        
        sidebarLayout(
            
          sidebarPanel(
            tags$h5("Select an area of a graph to zoom in. Double click to reset."),
              # adds keyword options in checkbox format
              checkboxGroupInput("keyword", "Select Keywords",
                                 c("Analysis" = "analysis", "Analyst" = "analyst", "Codebase" = "codebase", 
                                   "Company" = "company", "Data" = "data", "
                                   Event" = "event", "Job" = "job", "Open Day" = "open_day","Podcast" = "podcast", 
                                   "Programming" = "programming", "Taster" = "taster"), 
                                 selected = c("analysis", "analyst", "codebase", "company", "data", 
                                              "event", "job", "open_day", "podcast", "programming", "taster"),
                                              ),
              checkboxGroupInput("advert", "Select Advert Type", 
                                 c("Company" = "company_ad", "Coding" = "coding_ad", "Data" = "data_ad", 
                                   "Developer" = "developer_ad","Programming" = "programming_ad","Software" = "software_ad",
                                   "UX" = "ux_ad", "Web" = "web_ad"),
                                 selected = c("company_ad", "coding_ad", "data_ad", "developer_ad", "programming_ad",
                                              "software_ad", "ux_ad", "web_ad"))),
          
    
            mainPanel(
              # creating grid to improve readability
              fluidRow(
                column(6,
                       tags$h4("Search Engine Keywords"),
                  plotlyOutput("keyword_plot")),
                
                column(6,
                       tags$h4("Most Popular Search Engines"),
                  plotlyOutput("search_engine_plot")),), 
              
              fluidRow(
                
                column(6,
                       tags$h4("Clicks by Advert Type"),
                  plotlyOutput("advert_plot")),

              
              column(6,  
                     tags$h4("Clicks by Social Media Company"),
                  plotlyOutput("social_media_plot"))
              )
              
            )
        )
      ),
      
      
      tabPanel(
        "Goal Conversions",
        
        sidebarLayout(
          # adds date options 
          sidebarPanel(
            fluidRow(
              dateRangeInput(
                "date_range",
                label = tags$h5("Date Range"),
                format = "dd-mm-yyyy",
                start = "2019-09-01",
                end = "2020-02-29",
                min = "2019-09-01",
                max = "2020-02-29",
                startview = "year",
                separator = " - "
              )
            ),
            
            fluidRow(
              "Please select dates to see graphs."
            ),
            
            fluidRow(
              "Please hover over the bars to see the page URL.",
              "Select an area of a graph to zoom in. Double click to reset."
            ),
            
            
          ),
        
          mainPanel(
              
              fluidRow(
              # This row is adding titles for the graphs that will be underneath it.
                  column(6,
                      #Title for page of goal completion graph.
                      tags$h4("Page of Goal Completion")
                         
                         
                  ),
                  
                  column(6,
                      # Title for number of pages visited before goal completion graph.
                      tags$h4("Number of Pages Visited before Goal Completion")
                         
                         
                  )
              ),
              
              fluidRow(
              # This row is for the graphs that correspond to the titles above. 
                  column(6,
                      # This is the output for the page of goal completion graph.
                      plotlyOutput("page_of_completion")
                  ),
                  
                  column(6,
                      # This graph shows how many pages users visited before making a booking. 
                      plotlyOutput("pages_visited")
                      
                  )
                  
              ),
              
              fluidRow(
              # This row is for my second row of images. Probably a graph and a table.
                  column(6,
                  # Title for the Page Visited Immediately Before Goal Completion Page.
                      tags$h4("Page Before Goal Completion"),
                      tags$h6("Top 10 pages are displayed")
                      
                  ),
                  
                  # Adds plot showing events against bookings
                  column(6,
                      
                      tags$h4("Events Booked per Day"),
                      tags$h6("The blue lines represent each open evening or info taster session that the company held")
                      
                  )
                  
              ),
              
              fluidRow(
              # Shows which page a user was one before they completed a goal 
                  column(6,
                         
                      plotlyOutput("page_before_completion")
                      
                  ),
                  
                  column(6,
                         
                      plotlyOutput("event_timeseries")
                    
                  )
              )
            )
          )
      ),

      tabPanel("Exits",
               fluidRow(
                 # This row is adding titles for the graphs that will be underneath it.
                 column(6,
                        #Number of Exits per total number of Page Views.
                        tags$h4("Number of Exits per total number of Page Views")
                        
                        
                 ),
                 
                 column(6,
                        # Number of Pages visited before Exit.
                        tags$h4("Number of Pages visited before Exit")
                        
                        
                 )
               ),
               fluidRow(
                   column(6,       
                      plotlyOutput("exit_rates_plot_1"),
                          ),
                   column(6,
                       plotlyOutput("page_depth_plot_1")
                          )
                         ),
               fluidRow(
                 # This row is adding titles for the 3rd graph that will be underneath it.
                 column(6,
                        # Number of Exits per total number of Page Views.
                        tags$h4("Session duration and Exit page")
                        )
                      ),
                
                    column(6,
                        plotlyOutput("sessions_and_exits_plot_1")
                          )
                        
                   )
                   

               
    )
  )

