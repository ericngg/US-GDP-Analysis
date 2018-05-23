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
years <- list("1997" = 1997, "1998" = 1998, "1999" = 1999,
              "2000" = 2000, "2001" = 2001, "2002" = 2002,
              "2003" = 2003, "2004" = 2004, "2005" = 2005,
              "2006" = 2006, "2007" = 2007, "2008" = 2008,
              "2009" = 2009, "2010" = 2010, "2011" = 2011,
              "2012" = 2012, "2013" = 2013, "2014" = 2014,
              "2015" = 2015, "2016" = 2016, "2017" = 2017)

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