library(ggplot2)
library(plotly)
library(data.table)
library(stats)
library(ISLR)
library(ggmap)

uber_apr14 <- read.csv("/Users/Shon/Documents/MyProjects/Data Science/uber data visualization/uber-pickups-in-new-york-city/uber-raw-data-apr14.csv")

apr14_plot <- ggplot(data = uber_apr14,  
               aes(x = Lat,
                   y = Lon)) +
  geom_point()

apr14_plot

nyMap <- qmap("New York City")

nyMap + 
  geom_point(data = uber_apr14, mapping = aes(x = Lon, y = Lat))


