library(ggplot2)
library(plotly)
library(ggmap)
library(plyr)
library(dplyr)

uber_apr14 <- read.csv("/Users/Shon/Documents/MyProjects/Data Science/uber data visualization/uber-pickups-in-new-york-city/uber-raw-data-apr14.csv")

apr14_plot <- geom_point(data = uber_apr14, 
                         aes(x = Lon, y = Lat), 
                         colour = '#000066',
                         size = 0.1, alpha = 0.5, na.rm = TRUE)

apr14_plot

nyMap <- qmap("New York City")

fullMap <- nyMap + apr14_plot
fullMap


###PLOT BY BASES
base_plot <- nyMap + 
  geom_point(data = uber_apr14, 
             mapping = aes(x = Lon, y = Lat, colour = factor(uber_apr14$Base)), 
             size = 0.1, alpha = 0.4, na.rm = TRUE) + 
  scale_color_manual(values = c("#008080", "#7F462c", "#FF2400", "#2B60DE", "#CA226B"))

base_plot

#COLOR:
# + scale_fill_manual(values = c("__", "___", "___"))

### SEPARATING DATA BASED ON UBER BASE ###
uber_baseB02512 <- filter(uber_apr14, Base == "B02512")
uber_baseB02598 <- filter(uber_apr14, Base == "B02598")
uber_baseB02617 <- filter(uber_apr14, Base == "B02617")
uber_baseB02682 <- filter(uber_apr14, Base == "B02682")
uber_baseB02764 <- filter(uber_apr14, Base == "B02764")

## CREATE BAR GRAPH OF UBER DATA BY BASE ###

numrow_B02512 <- nrow(uber_baseB02512)
numrow_B02598 <- nrow(uber_baseB02598)
numrow_B02617 <- nrow(uber_baseB02617)
numrow_B02682 <- nrow(uber_baseB02682)
numrow_B02764 <- nrow(uber_baseB02764)

basedata <- plot_ly(x = c("B02512", "B02598", "B02617", "B02682", "B02764"),
                    y = c(numrow_B02512, numrow_B02598, numrow_B02617, numrow_B02682, numrow_B02764),
                    name = "Uber Pickups by TLC Base Code",
                    type = "bar")
basedata


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

ggplot(data = uber_apr14, 
           aes(x = Lon, y = Lat,  colour = factor(uber_apr14$Base))) +
  geom_point(size = 0.1, alpha = 0.4, na.rm = TRUE) +
  scale_color_manual(values = c("#008080", "#7F462c", "#FF2400", "#2B60DE", "#CA226B")) + 
  facet_wrap(~ Base) 

#Plotyly to plot map data?

table(uber_apr14$Base)
table(uber_baseB02512$Base)
