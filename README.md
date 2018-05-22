# Final-Project-Info201
**Group member**: Ryan Chiu, Andrew Sun, Eric Ng  
**Data source**: [Bureau of Economic Analysis Website](https://www.bea.gov/regional/downloadzip.cfm)

## Project Description
The dataset we are going to work on is the **Annual Gross Domestic Product (GDP) by state** from _Bureau of Economic Analysis, U.S. Department of Commerce_.

Through analyzing and visualizing the data, we hope to provide an **insight into the U.S. historical & current economic condition**, for the _general pubic_ who might be interested in the U.S. economy.

Additionally, we will sort out the **TOP 3 industries with highest GDP** in each region, by which we can target _audiences who are equipped with more economic knowledge_ and want to understand the economic trend in each state.

The **following sample questions** can arise:   
1.) How does the U.S. economic performance differ geographically?    
2.) How did the U.S. economy develop over time? By which industry?   
3.) What historical incidents correspond with certain ups and downs in the U.S. economy?


## Technical description
This dataset is a static .csv file but not a live data (api) since GDP is difficult to be provided timely by its nature.   

The dataset can be filtered out depending on what the user wants to view. For example, the dataset can be filtered by a specific year, by states or region, by component, or by industry, etc.

**Libraries that will or potentially be used:**  
shiny, readxl, ggplot2, plotly, RColorBrewer, htmlwidgets, and many data wrangling / graph-creating libraries

**Challenges that we anticipate:**  
1.) Determining what data are useful and be able to extract them from the large data source given.   
2.) Create tables or other visualizing tools in ways that are easily understood by our targeted audience.  
3.) Formatting the UI, interactivity of the map for the user, and being able to manipulate the data to make it informative.
