library(dplyr)
library(plotly)
library(snakecase)
library(ggplot2)
library(leaflet)

#read data
GDP_data <- read.csv(
  file = "./data/gdpstate.csv",
  stringsAsFactors = FALSE
  )

# Industries of interest
top_list <- c(1, 12, 35, 45, 50, 68, 82)

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

formatting <- function(x){
  as.numeric(as.character(x))
}
trend_data[]<- lapply(trend_data[], formatting)

# Trend chart
us_trend_chart <- plot_ly(trend_data, x= ~year, y = ~all_industry_total,
                       name = "U.S. GDP",
             type = "scatter", mode = "lines+markers") %>%
  layout(title = "U.S. GDP Trend (1997-2017)",
         xaxis = list(title = "Year"),
         yaxis = list(title = "GDP (in millions)"))

industry_trend_chart <- plot_ly(trend_data, x= ~year, y = ~manufacturing,
                          name = "Manufacturing",
                          type = "scatter", mode = "lines+markers") %>%
  layout(title = "U.S. GDP Trend by industry (1997-2017)",
         xaxis = list(title = "Year"),
         yaxis = list(title = "GDP (in millions)")) %>%
  add_trace(x= ~year, y = ~information,
            name = "Information", mode = "lines+markers") %>%
  add_trace(x= ~year, y = ~retail_trade,
            name = "Retail", mode = "lines+markers") %>%
  add_trace(x= ~year, y = ~finance_insurance_real_estate_rental_and_leasing,
            name = "Finance", mode = "lines+markers")
