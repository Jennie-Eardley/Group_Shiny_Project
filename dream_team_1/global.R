library(tidyverse)
library(lubridate)
library(plotly)
library(shinythemes)
library(shiny)
library(tsibble)

# All of the data has been synthesised to protect client privacy
search_engine <- read_csv("data/search_engines.csv")
adverts <- read_csv("data/adverts.csv")
keywords <- read_csv("data/keywords.csv")
social_media <- read_csv("data/social_media.csv")
goal_completion_data <- read_csv(here::here("data/synthesised_goal_completion.csv"))
exit_page_path_df <- read_csv("data/synthesised_exit_page_path.csv")
page_depth_df <- read_csv("data/synthesised_page_depth.csv")
sessions_and_exits_df <- read_csv("data/synthesised_sessions_and_exits.csv")
event_date_data <- read_csv("data/synthesised_event_date_data.csv")


