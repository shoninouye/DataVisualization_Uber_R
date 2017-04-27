# UBER PICKUPS IN NEW YORK CITY
## Data visualization using R  



## Contributors:
+ Shon Inouye
+ Edward Kim


## Introduction
This repo is dedicated to create data visualization for uber and other for-hire vehicle pickups in New York City. We used datasets from [Kaggle](https://www.kaggle.com/fivethirtyeight/uber-pickups-in-new-york-city). The goal of this project was to visualize the data in different ways and point out any interesting discoveries.
One thing we sought to discover was the meaning behind the base codes that accompanied each uber pickup. A quick search led to these codes being associated with several of Uber's bases.


Base Code | Base Name
---|---------
B02512 | Unter
B02598 | Hinter
B02617 | Weiter
B02682 | Schmecken
B02764 | Danach-NY
B02765 | Grun
B02835 | Dreist
B02836 | Drinnen

These are Uber's bases located in New York. Each uber pickup is affiliated with a TLC (Taxi and Limousine Commission) company base. 

## Loading Packages

    library(ggplot2)
    library(plotly) #used along with ggplot2 for data visualization.
    library(ggmap)  #used for geocoding
    library(plyr)   #used along with dplyr to aggregate data
    library(dplyr)


## Plot of Total Uber Pickups
First, we read the data taken from Kaggle.com. In order to keep the plot simple, we only used Uber pickup data from April 2014. 

    # Read data
    uber_apr14 <- read.csv("/Users/Shon/Documents/MyProjects/Data Science/uber data visualization/uber-pickups-in-new-york-city/uber-raw-data-apr14.csv")

After reading the data, added a column for the day of the week. This will be used later on to plot the data over the course of the month.

    # Remove minutes and seconds from Date.Time and create Day column
    uber_apr14$Date.Time <- as.Date(uber_apr14$Date.Time, "%m/%d/%Y")
    uber_apr14$Day <- format(as.Date(uber_apr14$Date.Time, format = "%m/%d/%Y"), "%d") #adds a Day column

We then got a map of New York City using the ggmap package. 

    # Get map of New York City
    NY <- get_map(location = c(lon = mean(uber_apr14$Lon), lat = mean(uber_apr14$Lat)), 
                 zoom = 10, 
                 maptype = "roadmap", 
                 color = "bw")
    NYmap <- ggmap(NY)
    
Using the map of New York City as the background, we plotted the Uber pickup locations. Because we used the "city" zoom value for our map of New York City, we decided that all pickup locations outside the map would be labeled as outliers.

    # Plot Uber pickup locations on top of New York map
    fullMap <- NYmap + geom_point(data = uber_apr14,
                                     aes(x = Lon, y = Lat),
                                     colour = '#000066',
                                     size = 0.1, alpha = 0.5, na.rm = TRUE)
    fullMap


![](https://github.com/Inouyesan/DataVisualization_Uber_R/blob/master/IMAGES/Uber_plot_all2.png?raw=true)


## Plot of Uber Pickups by TLC Base Code
With every Uber pickup, there is a TLC base company code that is associated with it. To get a better understanding of what these codes mean, we created a bar graph of the number of pickups for each base code.

    # SEPARATING DATA BASED ON UBER BASE 
    uber_baseB02512 <- filter(uber_apr14, Base == "B02512")
    uber_baseB02598 <- filter(uber_apr14, Base == "B02598")
    uber_baseB02617 <- filter(uber_apr14, Base == "B02617")
    uber_baseB02682 <- filter(uber_apr14, Base == "B02682")
    uber_baseB02764 <- filter(uber_apr14, Base == "B02764")

    # CREATE BAR GRAPH OF UBER DATA BY BASE
    numrow_B02512 <- nrow(uber_baseB02512)
    numrow_B02598 <- nrow(uber_baseB02598)
    numrow_B02617 <- nrow(uber_baseB02617)
    numrow_B02682 <- nrow(uber_baseB02682)
    numrow_B02764 <- nrow(uber_baseB02764)

    # Create bar graph using plotly
    basedata <- plot_ly(x = c("B02512", "B02598", "B02617", "B02682", "B02764"),
                    y = c(numrow_B02512, numrow_B02598, numrow_B02617, numrow_B02682, numrow_B02764),
                    name = "Uber Pickups by TLC Base Code",
                    type = "bar")
    basedata

![](IMAGES/Uber_base_bargraph_plotly.png)

Here, we can see that there is a very large difference between the number of pickups for each base code. Base codes B02682 (Schmecken) and B02598 (Hinter) have over 150,000 pickups in the month of April while base codes B02512 (Unter) and B02764 (Danach-NY) do not even reach 50,000 pickups.
Now, we can plot the pickup points on a map and distinguish them based on their base codes.

    # PLOT BY BASES
    base_plot <- NYmap + 
      geom_point(data = uber_apr14, 
             mapping = aes(x = Lon, y = Lat, colour = factor(uber_apr14$Base)), 
             size = 0.1, alpha = 0.4, na.rm = TRUE) + 
    scale_color_manual(values = c("#CA226B", "#7F462c", "#FF0033", "#2B60DE", "#008080"))

    base_plot

![](https://github.com/Inouyesan/DataVisualization_Uber_R/blob/master/IMAGES/Uber_base_bargraph_plotly.png?raw=true)

## Plot of Uber Pickups for each Individual Base Code
We can also plot the pickups for each base individually in order to see which areas these codes cover.

    ### PLOT DATA BY UBER BASE ###
    #Base B02512
    base_B02512 <- nyMap + 
      geom_point(data = uber_baseB02512, 
             mapping = aes(x = Lon, y = Lat,  colour = factor(uber_baseB02512$Base)), 
             alpha = 0.4, na.rm = TRUE) +
      scale_color_manual(values = c("#008080"))

    #Base B02598
    base_B02598 <- nyMap + 
      geom_point(data = uber_baseB02598, 
             mapping = aes(x = Lon, y = Lat,  colour = factor(uber_baseB02598$Base)), 
             alpha = 0.4, na.rm = TRUE) +
      scale_color_manual(values = c("#7F462c"))

    #Base B02617
    base_B02617 <- nyMap + 
      geom_point(data = uber_baseB02617, 
             mapping = aes(x = Lon, y = Lat,  colour = factor(uber_baseB02617$Base)), 
             alpha = 0.4, na.rm = TRUE) +
      scale_color_manual(values = c("#FF2400"))

    #Base B02682
    base_B02682 <- nyMap + 
      geom_point(data = uber_baseB02682, 
             mapping = aes(x = Lon, y = Lat,  colour = factor(uber_baseB02682$Base)), 
             alpha = 0.4, na.rm = TRUE) +
      scale_color_manual(values = c("#2B60DE"))

    #Base B02764
    base_B02764 <- nyMap + 
      geom_point(data = uber_baseB02764, 
             mapping = aes(x = Lon, y = Lat,  colour = factor(uber_baseB02764$Base)), 
             alpha = 0.4, na.rm = TRUE) +
      scale_color_manual(values = c("#CA226B"))

    plot(base_B02512)
    plot(base_B02598)
    plot(base_B02617)
    plot(base_B02682)
    plot(base_B02764)

![](https://github.com/Inouyesan/DataVisualization_Uber_R/blob/master/IMAGES/Uber_base_B02512.PNG?raw=true)
![](https://github.com/Inouyesan/DataVisualization_Uber_R/blob/master/IMAGES/Uber_base_B02598.PNG?raw=true)
![](https://github.com/Inouyesan/DataVisualization_Uber_R/blob/master/IMAGES/Uber_base_B02617.PNG?raw=true)
![](https://github.com/Inouyesan/DataVisualization_Uber_R/blob/master/IMAGES/Uber_base_B02682.PNG?raw=true)
![](https://github.com/Inouyesan/DataVisualization_Uber_R/blob/master/IMAGES/Uber_base_B02764.PNG?raw=true)

### Using Plotly to See Pickups Over Time  
    uber_apr14$Date.Time <- as.Date(uber_apr14$Date.Time, "%m/%d/%Y")
    uber_apr14$Day <- format(as.Date(uber_apr14$Date.Time, format = "%m/%d/%Y"), "%d") #adds a Day column
    #counting the rides for each day
    newber <- count(uber_apr14, as.numeric(Day))
    colnames(newber)[1] <- "Day"
    colnames(newber)[2] <- "Number of Rides"


    line <- ggplot(newber, aes(x = Day, y = `Number of Rides`)) +
     geom_area(alpha = 1, position = position_dodge(width = 0.05), color = '#99cc00', fill = '#787a76') +
    xlab("Day") + ylab("Total Rides per Day") +
    ggtitle("Total Uber Rides in New York City in the month of April") + 
    theme_minimal()

    ggplotly(line)
We created a new column in our dataset that had each uber pickup with the day it occured. This was necessary because the original date was in a format that was not compatible. Once we had the day for each pickup, we could sum the number of rides on for a particular day and graph it to create an interactive linegraph.
![](https://github.com/Inouyesan/DataVisualization_Uber_R/blob/master/Images/Uber_TotalRidesperDayPlotly.png?raw=true)

We chose specifically the month of april, not for any particular reason, in order to showcase a linegraph produced through plotly. We see that across the course of the month, the total number of rides fluctuate between highs and lows, and we see that at the end of the month there is a spike in usage.

## Conclusion

Given our dataset, we produced points on a map, a histogram, and a line graph. Our original goal was to visualize the data in order to see any interesting observations. By geocoding, we were able to clearly see which areas of New York were more dense in activity. If the maps by base were not enough, the histogram clearly shows which Uber bases complete more pickups. Finally, the line graph allows us to see if there are any trends within the pickup activity. 


