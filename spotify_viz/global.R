library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)
library(DT)
library(shinydashboard)
library(tidyverse)


market_info <- read.csv(file = "./spotify_market_codes.csv", stringsAsFactors = FALSE)
genre_info <- read.csv(file = "./data_by_genres_o.csv", stringsAsFactors = FALSE)
 