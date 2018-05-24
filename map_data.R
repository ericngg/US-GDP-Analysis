# Read data
map_GDP_data <- read.csv(
  file = "data/gdpstate.csv",
  stringsAsFactors = FALSE
)

# Select columns of interest
map_GDP_data <- map_GDP_data[-c(4681:5403) ,]
map_GDP_data_interest <- map_GDP_data %>%
  select(GeoName, Description, starts_with("X"))

# All industry data
map_all_industry <- map_GDP_data_interest %>%
  filter(Description == "All industry total")

# Convert string numbers to int
index <- 3
for(i in map_all_industry[, -(1:2)]) {
  map_all_industry[, index] <- as.numeric(i)
  index <- index + 1
}