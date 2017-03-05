library(ggplot2)
library(plotly)
library(data.table)
library(stats)
library(ISLR)
library(ggmap)
library(plyr)
library(dplyr)

uber_apr14 <- read.csv("/Users/Shon/Documents/MyProjects/Data Science/uber data visualization/uber-pickups-in-new-york-city/uber-raw-data-apr14.csv")

apr14_plot <- ggplot(data = uber_apr14,  
               aes(x = Lat,
                   y = Lon)) +
  geom_point()

apr14_plot

nyMap <- qmap("New York City")

nyMap + 
  geom_point(data = uber_apr14, mapping = aes(x = Lon, y = Lat), colour = 'red',
             alpha = 0.5, na.rm = TRUE)

main_plot <- nyMap + 
  geom_point(data = uber_apr14, 
             mapping = aes(x = Lon, y = Lat,  colour = factor(uber_apr14$Base)), 
             alpha = 0.4, na.rm = TRUE) +
  scale_color_manual(values = c("#008080", "#7F462c", "#FF2400", "#2B60DE", "#CA226B"))
#COLOR:
# + scale_fill_manual(values = c("__", "___", "___"))

uber_baseB02512 <- filter(uber_apr14, Base == "B02512")
uber_baseB02598 <- filter(uber_apr14, Base == "B02598")
uber_baseB02617 <- filter(uber_apr14, Base == "B02617")
uber_baseB02682 <- filter(uber_apr14, Base == "B02682")
uber_baseB02764 <- filter(uber_apr14, Base == "B02764")

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

par(mfrow=c(2,3))
plot(main_plot)
plot(base_B02512)
plot(base_B02598)
plot(base_B02617)
plot(base_B02682)
plot(base_B02764)

ggplot(data = uber_apr14, 
           aes(x = Lon, y = Lat,  colour = factor(uber_apr14$Base))) +
  geom_point(alpha = 0.4, na.rm = TRUE) +
  scale_color_manual(values = c("#008080", "#7F462c", "#FF2400", "#2B60DE", "#CA226B")) + 
  facet_wrap(~ Base) +
  theme_bw()


#Plotyly to plot map data?

table(uber_apr14$Base)
table(uber_baseB02512$Base)
