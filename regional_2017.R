library("dplyr")
library(ggplot2)
library(plotly)

#read data
GDP_data <- read.csv(
  file = "./data/gdpstate.csv",
  stringsAsFactors = FALSE
)

#select columns of interest
GDP_data <- GDP_data[-c(1:4680, 5401:5403), ] 

#convert 2017 data from strings into numeric factors
GDP_data$X2017 <- as.numeric(as.character(GDP_data$X2017))

#industry interested
industry_filter <- c("11, 21", 22, 23, "31-33", 42, "44-45", "48-49",
                     51, "52, 53", "54, 55, 56", 61, 62, 71, 72, 81)

# Slice data into three categories: all industry, private industry, and Gov
data_regional <- GDP_data %>%
  filter(Description == "All industry total" |
         Description == " Private industries" |
           Description == " Government and government enterprises" |
           IndustryClassification %in% industry_filter) %>%
  mutate(GDP_17_inbillion = X2017 / 1000) %>%
  select(GeoName, Description, GDP_17_inbillion)




# all industry data
all_industry <- GDP_data %>%
  filter(Description == " Private industries" |
           Description == " Government and government enterprises") %>%
  mutate(GDP_17_inbillion = X2017 / 1000) %>%
  select(GeoName, Description, GDP_17_inbillion)

# public sector data
public_sector <- GDP_data %>%
  filter(Description == " Government and government enterprises") %>%
  mutate(GDP_17_inbillion = X2017 / 1000) %>%
  select(GeoName, Description, GDP_17_inbillion)

# private sector data
private_sector <- GDP_data %>%
  filter(IndustryClassification %in% industry_filter) %>%
  mutate(GDP_17_inbillion = X2017 / 1000) %>%
  select(GeoName, Description, GDP_17_inbillion)
  











# ggplot2

NE <- private_sector %>%
  filter(GeoName == "New England") %>%
  summarise(hi = sum(GDP_17_inbillion))

g <- ggplot(NE, aes(x = GeoName, y = X2017)) +
  geom_bar(aes(fill = Description), stat="identity")





