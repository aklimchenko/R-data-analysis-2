library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)
library(DT)
library(shinydashboard)
library(tidyverse)


market_info <- read.csv(file = "./spotify_market_codes.csv", stringsAsFactors = FALSE)

# artist_market_data <- read.csv(file = "./all_markets.csv", stringsAsFactors = FALSE)
# files cleaned in python

