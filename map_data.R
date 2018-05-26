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

years_choice_map <- list("1997" = "X1997", "1998" = "X1998", "1999" = "X1999",
              "2000" = "X2000", "2001" = "X2001", "2002" = "X2002",
              "2003" = "X2003", "2004" = "X2004", "2005" = "X2005",
              "2006" = "X2006", "2007" = "X2007", "2008" = "X2008",
              "2009" = "X2009", "2010" = "X2010", "2011" = "X2011",
              "2012" = "X2012", "2013" = "X2013", "2014" = "X2014",
              "2015" = "X2015", "2016" = "X2016", "2017" = "X2017")


# Convert string numbers to int
index <- 3
for(i in map_all_industry[, -(1:2)]) {
  map_all_industry[, index] <- as.numeric(i)
  index <- index + 1
}
