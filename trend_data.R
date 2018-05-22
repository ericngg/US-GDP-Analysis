library(dplyr)
library(plotly)
library(snakecase)
library(ggplot2)
library(leaflet)

formatting <- function(x){
  as.numeric(as.character(x))
}

#read data
GDP_data <- read.csv(
  file = "./data/gdpstate.csv",
  stringsAsFactors = FALSE
  )

# Industries of interest
top_list <- c(1, 12, 35, 45, 50, 68, 82)
years <- c(1997:2017)

# National Data
ustrend_data <- GDP_data %>%
  filter(GeoName == "United States",
         IndustryId == 1) %>%
  select(paste0("X", 1997:2017))
colnames(ustrend_data) <- c(1997:2017)
rownames(ustrend_data) <- "gdp"
ustrend_data[]<- lapply(ustrend_data[], formatting)

# Trend data
trend_data <- GDP_data %>%
  filter(GeoName == "United States",
         IndustryId %in% top_list) %>%
  select(Description, paste0("X", 1997:2017)) %>%
  t() %>%
  data.frame()
colnames(trend_data) <- to_snake_case(unlist(trend_data["Description",]))
trend_data <- trend_data[!row.names(trend_data)=="Description",]
rownames(trend_data) <- 1997:2017
trend_data <- trend_data %>%
  mutate(year = row.names(trend_data))

trend_data[]<- lapply(trend_data[], formatting)