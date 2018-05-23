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




####Private industry plot
private_filter <- function(industry_choice){
  data <- private_sector %>%
    filter(Description == industry_choice) %>%
    mutate(GDP = GDP_17_inbillion) %>%
    select(GDP)
  colnames(data) <- industry_choice
  data <- as.vector(data)
  data
}

Geo <- data.frame(unique(private_sector$GeoName))
colnames(Geo) <- "region"
regiongeo <- as.vector(Geo)

private_data <- data.frame(Geo, private_filter("  Utilities"), private_filter("  Construction"),
       private_filter("  Manufacturing"), private_filter("  Wholesale trade"),
       private_filter("  Retail trade"), private_filter("  Transportation and warehousing"),
       private_filter("  Information"), private_filter("  Finance, insurance, real estate, rental, and leasing"),
       private_filter("  Professional and business services"), private_filter("   Educational services"),
       private_filter("   Health care and social assistance"), private_filter("   Arts, entertainment, and recreation"),
       private_filter("   Accommodation and food services"), private_filter("  Other services (except government and government enterprises)"),
       private_filter("Natural resources and mining"))

p <- plot_ly(private_data, x = ~region, y = ~X..Utilities,
             type = "bar", name = "Utilities") %>%
  add_trace(y = ~X..Construction, name = "Construction") %>%
  add_trace(y = ~X..Manufacturing, name = "Manufacturing") %>%
  add_trace(y = ~X..Wholesale.trade, name = "Wholesale") %>%
  add_trace(y = ~X..Retail.trade, name = "Retail") %>%
  add_trace(y = ~X..Transportation.and.warehousing, name = "Transportation") %>%
  add_trace(y = ~X..Information, name = "Information") %>%
  add_trace(y = ~X..Finance..insurance..real.estate..rental..and.leasing, name = "Finance") %>%
  add_trace(y = ~X..Professional.and.business.services, name = "Professional and business services") %>%
  add_trace(y = ~X...Educational.services, name = "Education") %>%
  add_trace(y = ~X...Arts..entertainment..and.recreation, name = "Arts") %>%
  add_trace(y = ~X...Accommodation.and.food.services, name = "Accommodation and food services") %>%
  add_trace(y = ~X..Other.services..except.government.and.government.enterprises., name = "Others") %>%
  add_trace(y = ~Natural.resources.and.mining, name = "Natural Resources") %>%
  layout(xaxis = list(title = "Regions"),
    yaxis = list(title = "GDP (In billions)"), barmode = "stack")


#### All industry plot
private_industry <- all_industry %>%
  filter(Description == " Private industries") %>%
  mutate("Private industries" = GDP_17_inbillion) %>%
  select("Private industries")

private_industry <- as.vector(private_industry)

public_industry <- all_industry %>%
  filter(Description == " Government and government enterprises") %>%
  mutate(" Government and government enterprises" = GDP_17_inbillion) %>%
  select(" Government and government enterprises")

public_industry <- as.vector(public_industry)

all_industry_data <- data.frame(Geo, private_industry, public_industry)


a <- plot_ly(all_industry_data, x = ~region, y = ~Private.industries,
             type = "bar", name = "Private Industries - Private Sector") %>%
  add_trace(y = ~X.Government.and.government.enterprises, name = "Government - Public Sector") %>%
  layout(xaxis = list(title = "Regions"),
         yaxis = list(title = "GDP (In billions)"), barmode = "stack")
  
#### Public industry plot
gov_data <- data.frame(Geo, public_industry)
gov <- plot_ly(gov_data, x = ~region, y = ~X.Government.and.government.enterprises,
               type = "bar", name = "Government - Public Sector") %>%
  layout(xaxis = list(title = "Regions"),
         yaxis = list(title = "GDP (In billions)"), barmode = "stack")






