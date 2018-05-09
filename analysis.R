library("dplyr")

#read data
GDP_data <- read.csv(
  file = "./data/gdpstate.csv",
  stringsAsFactors = FALSE
  )

#select columns of interest
GDP_data_interest <- GDP_data %>%
  select(GeoName, Description)
  