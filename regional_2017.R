library("dplyr")
library(ggplot2)
library(plotly)
library(RColorBrewer)
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
industry_filter <- c("11, 21", 22, 23, "321,327-339", "311-316,322-326", 42, "44-45", "48-49",
                     51, 52, 53, "54, 55, 56", 61, 62, 71, 72, 81)

# Slice data into three categories: all industry, private industry, and Gov
data_regional <- GDP_data %>%
  filter(Description == " Government and government enterprises" |
           IndustryClassification %in% industry_filter) %>%
  mutate(GDP_17_inbillion = X2017 / 1000) %>%
  select(GeoName, Description, GDP_17_inbillion)




# all industry data
all_industry <- GDP_data %>%
  filter(IndustryClassification %in% industry_filter |
           Description == " Government and government enterprises") %>%
  mutate(GDP_17_inbillion = X2017 / 1000) %>%
  select(GeoName, Description, GDP_17_inbillion)





public_filter <- function(industry_choice){
  data <- all_industry %>%
    filter(Description == industry_choice) %>%
    mutate(GDP = GDP_17_inbillion) %>%
    select(GDP)
  colnames(data) <- industry_choice
  data <- as.vector(data)
  data
}

Geo <- data.frame(unique(all_industry$GeoName))
colnames(Geo) <- "region"
regiongeo <- as.vector(Geo)
choice_region <- c("New England (CT, ME, MA, NH, RI, VT)" = "New England",
                   "Mideast (DE, DC, MD, NJ, NY, PA)" = "Mideast",
                   "Great Lakes (IL, IN, MI, OH, WI)" = "Great Lakes",
                   "Plains (IA, KS, MN, MO, NE, ND, SD)" = "Plains",
                   "Southeast (AB, AK, FL, GA, KY, LA, MS, NC, SC, TN, VA, WV)" = "Southeast",
                   "Southwest (AZ, NM, OK, TX)" = "Southwest",
                   "Rocky Mountain (CO, ID, MT, UT, WY)" = "Rocky Mountain",
                   "Far West (AL, CA, HI, NV, OR, WA)" = "Far West")   

all_industry_data <- data.frame(Geo, public_filter("  Utilities"), public_filter("  Construction"),
                                public_filter("   Nondurable goods manufacturing"), public_filter("   Durable goods manufacturing"),
                                public_filter("  Wholesale trade"),
                                public_filter("  Retail trade"), public_filter("  Transportation and warehousing"),
                                public_filter("  Information"), public_filter("   Finance and insurance"),
                                public_filter("   Real estate and rental and leasing"),
                                public_filter("  Professional and business services"), public_filter("   Educational services"),
                                public_filter("   Health care and social assistance"), public_filter("   Arts, entertainment, and recreation"),
                                public_filter("   Accommodation and food services"), public_filter("  Other services (except government and government enterprises)"),
                                public_filter("Natural resources and mining"), public_filter(" Government and government enterprises"))

####Top 10 industry plot
top10_data <- plot_ly(all_industry_data, x = ~region, y = ~X...Real.estate.and.rental.and.leasing,
             type = "bar", name = "Real Estate, Renting, and Leasing") %>%
  add_trace(y = ~X.Government.and.government.enterprises, name = "State and local Government") %>%
  add_trace(y = ~X..Professional.and.business.services, name = "Professional and Business services") %>%
  add_trace(y = ~X...Finance.and.insurance, name = "Finance & Insurance") %>%
  add_trace(y = ~X...Health.care.and.social.assistance, name = "Health Care") %>%
  add_trace(y = ~X...Durable.goods.manufacturing, name = "Durable Manufacturing") %>%
  add_trace(y = ~X..Retail.trade, name = "Retail") %>%
  add_trace(y = ~X..Wholesale.trade, name = "Wholesale") %>%
  add_trace(y = ~X...Nondurable.goods.manufacturing, name = "Nondurable Manufacturing") %>%
  add_trace(y = ~X..Information, name = "Information") %>%
  layout(xaxis = list(title = "Regions"),
         yaxis = list(title = "GDP (In billions)"), barmode = "stack")
  

#### All industry plot
a <- plot_ly(all_industry_data, x = ~region, y = ~X...Real.estate.and.rental.and.leasing,
             type = "bar", name = "Real Estate, Renting, and Leasing") %>%
  add_trace(y = ~X.Government.and.government.enterprises, name = "State and local Government") %>%
  add_trace(y = ~X..Professional.and.business.services, name = "Professional and Business services") %>%
  add_trace(y = ~X...Finance.and.insurance, name = "Finance & Insurance") %>%
  add_trace(y = ~X...Health.care.and.social.assistance, name = "Health Care") %>%
  add_trace(y = ~X...Durable.goods.manufacturing, name = "Durable Manufacturing") %>%
  add_trace(y = ~X..Retail.trade, name = "Retail") %>%
  add_trace(y = ~X..Wholesale.trade, name = "Wholesale") %>%
  add_trace(y = ~X...Nondurable.goods.manufacturing, name = "Nondurable Manufacturing") %>%
  add_trace(y = ~X..Information, name = "Information") %>%
  add_trace(y = ~X...Arts..entertainment..and.recreation, name = "Arts & Recreation") %>%
  add_trace(y = ~X..Construction, name = "Construction") %>%
  add_trace(y = ~X..Transportation.and.warehousing, name = "Transportation") %>%
  add_trace(y = ~X...Educational.services, name = "Education") %>%
  add_trace(y = ~X...Accommodation.and.food.services, name = "Accommodation and food services") %>%
  add_trace(y = ~X..Other.services..except.government.and.government.enterprises., name = "Others") %>%
  add_trace(y = ~Natural.resources.and.mining, name = "Natural Resources") %>%
  add_trace(y = ~X..Utilities, name = "Utilities") %>%
  layout(xaxis = list(title = "Regions"),
         yaxis = list(title = "GDP (In billions)"), barmode = "stack")





#####


#private_industry <- all_industry %>%
 # filter(Description == " Private industries") %>%
  #mutate("Private industries" = GDP_17_inbillion) %>%
  #select("Private industries")

#private_industry <- as.vector(private_industry)

#public_industry <- all_industry %>%
 # filter(Description == " Government and government enterprises") %>%
  #mutate(" Government and government enterprises" = GDP_17_inbillion) %>%
  #select(" Government and government enterprises")

#public_industry <- as.vector(public_industry)





#### Public industry plot
#public_industry <- all_industry %>%
#  filter(Description == " Government and government enterprises") %>%
#  mutate(" Government and government enterprises" = GDP_17_inbillion) %>%
#  select(" Government and government enterprises")

#public_industry <- as.vector(public_industry)
#
#gov_data <- data.frame(Geo, public_industry)
#gov <- plot_ly(gov_data, x = ~region, y = ~X.Government.and.government.enterprises,
#              type = "bar", name = "Government - Public Sector") %>%
#  layout(xaxis = list(title = "Regions"),
#        yaxis = list(title = "GDP (In billions)"), barmode = "stack")



## barchart + coord_polar

## Information - Sillicon Valley in CA
GDP_data %>%
  filter(Description == "  Information") %>%
  select(GeoName, X2017, Description)



## Finance - NY(NYSE, NASDAQ)
GDP_data %>%
  filter(Description == "  Finance, insurance, real estate, rental, and leasing", Region == 8) %>%
  select(GeoName, X2017, Description)


## Natural Resource - Texas Oil
GDP_data %>%
  filter(Description == "Natural resources and mining", Region == 6) %>%
  select(GeoName, X2017, Description)



## Art and Recreation
GDP_data %>%
  filter(Description == "   Arts, entertainment, and recreation", Region == 5) %>%
  select(GeoName, X2017, Description)












#private_filter <- function(industry_choice){
#  data <- all_industry %>%
#    filter(Description == industry_choice) %>%
#    mutate(GDP = GDP_17_inbillion) %>%
#    select(GDP)
#  colnames(data) <- industry_choice
#  data <- as.vector(data)
#  data
#}
# public sector data
#public_sector <- GDP_data %>%
#  filter(Description == " Government and government enterprises") %>%
#  mutate(GDP_17_inbillion = X2017 / 1000) %>%
#  select(GeoName, Description, GDP_17_inbillion)

# private sector data
#private_sector <- GDP_data %>%
#  filter(IndustryClassification %in% industry_filter) %>%
#  mutate(GDP_17_inbillion = X2017 / 1000) %>%
#  select(GeoName, Description, GDP_17_inbillion)




