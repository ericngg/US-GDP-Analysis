library("dplyr")

#read data
GDP_data <- read.csv(
  file = "./gdpstate_naics_all/gdpstate_naics_all.csv",
  stringsAsFactors = FALSE
  )
