library("dplyr")

#read data
GDP_data <- read.csv(
  file = "./data/gdpstate.csv",
  stringsAsFactors = FALSE
  )
#select columns of interest
GDP_data <- GDP_data[-c(4681:5403), ]
GDP_data_interest <- GDP_data %>%
  select(GeoName, Description, starts_with("X"))

# all industry data
all_industry <- GDP_data_interest %>%
  filter(Description == "All industry total")

# Nationwide data
nation_data <- GDP_data_interest %>%
  filter(GeoName == "United States")
