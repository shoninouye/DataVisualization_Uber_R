# DataVisualization_Uber_R

## Contributors:
+ Shon Inouye
+ Edward Kim
+ Megan Nguyen
+ Eri Kawakami

## Abstract
This repo is dedicated to create data visualization for uber and other for-hire vehicle pickups in New York City. We used datasets from [Kaggle](https://www.kaggle.com/fivethirtyeight/uber-pickups-in-new-york-city).


## Code

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

##Output
![poke](http://24.media.tumblr.com/tumblr_lz7ewsL0Sg1rp2r43o1_1280.jpg)
