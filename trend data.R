library(dplyr)
library(plotly)
library(ggplot2)
library(leaflet)

#read data
GDP_data <- read.csv(
  file = "./data/gdpstate.csv",
  stringsAsFactors = FALSE
  )

#select columns of interest
GDP_data_interest <- GDP_data %>%
  select(GeoName, Description)

# Map data
map_data <- GDP_data %>%
  filter(Description == "All industry total") %>%
  select(GeoName, X2017)

# Trend data
trend_data <- GDP_data %>%
  filter(GeoName == "United States",
         Description == "All industry total") %>%
  select(paste0("X", 1997:2017)) %>%
  t() %>%
  data.frame() %>%
  mutate(year = c(1997:2017))
colnames(trend_data) <- c("GDP", "Year")
trend_data$GDP <- as.numeric(as.character(trend_data$GDP))

# Trend chart
trend_chart <- plot_ly(trend_data, x = ~Year, y = ~GDP,
             type = "scatter", mode = "lines+markers") %>%
  layout(title = "U.S. GDP Trend (1997-2017)",
         xaxis = list(title = "Year"),
         yaxis = list(title = "GDP (in millions)"))
