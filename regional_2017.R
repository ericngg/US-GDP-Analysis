library("dplyr")
##Data Rangling Section

#read data
GDP_data <- read.csv(
  file = "./data/gdpstate.csv",
  stringsAsFactors = FALSE
)
#select columns of interest
GDP_data <- GDP_data[-c(1:4680, 5401:5403), ]

industry_filter <- c("11, 21", 22, 23, "31-33", 42, "44-45", "48-49",
                     51, "52, 53", "54, 55, 56", 61, 62, 71, 72, 81)

filtered_region_2017 <- GDP_data %>%
  filter(IndustryClassification %in% industry_filter |
           Description == " Government and government enterprises") %>%
  select(GeoName, Description, X2017)


#convert from strings into factors
filtered_region_2017$X2017 <- as.numeric(as.character(filtered_region_2017$X2017))

#get rid of "NA"
Region_2017 <- filtered_region_2017 %>%
  filter(X2017 != "NA")

Region_2017 %>%
  filter(GeoName == "New England") %>%
  summarise(total = sum(X2017))

##Graph Creation Section
library(ggplot2)
library(plotly)

# p <- plot_ly(Region_2017, labels = ~Region_2017$Description[Region_2017$GeoName == input],
  #           values = ~Region_2017$X2017[Region_2017$GeoName == input], type = "pie") %>%
#  layout(title = paste0("United States Regional GDP - ", input," in 2017"),
 #        xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
  #       yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

# Region_2017$X2017[Region_2017$GeoName == "New England"]


#Choice of Region

Region_choice <- unique(Region_2017$GeoName)
  








