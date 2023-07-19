# Code for generating land cover maps from satellite imagery

library(raster)
library(RStoolbox) #  for classification
# install.packages("ggplot2")
# install.packages("patchwork")
library(ggplot2)
library(patchwork)

setwd("C:/lab/") # Windows

l92 <- brick("defor1_.jpg") # Let's plot a satellite image using brick function
plotRGB (l92, 1, 2, 3, stretch="lin")

# Exercise: import defor2 and plot in a single window
l06 <- brick ("defor2_.jpg")
plotRGB (l06, 1, 2, 3, stretch="lin")
par(mfrow=c(2,1))
plotRGB (l92, 1, 2, 3, stretch="lin")
plotRGB (l06, 1, 2, 3, stretch="lin")

# Let's use the ggRGB function to multiframe faster than parmfrow
# Making a simple multifrme with ggplot2
ggRGB(l92, 1, 2, 3, stretch="lin") 
ggRGB(l06, 1, 2, 3, stretch="lin")
# through the patchwork package I can join the 2 images
# First plot = p1 ; Second plot = p2
p1 <- ggRGB(l92, 1, 2, 3, stretch="lin") 
p2 <- ggRGB(l06, 1, 2, 3, stretch="lin")
p1+p2 
p1/p2 
# unsuperClass function , to classify images 
l92c <- unsuperClass (l92, nClasses=2)
l92c
unsuperClass results

*************** Model ******************
$model
K-means clustering with 2 clusters of sizes 8955, 1045

Cluster centroids:
  defor1_.1 defor1_.2 defor1_.3
1  197.5539  22.07214  36.31692
2  202.4995 154.84306 149.96077

Within cluster sum of squares by cluster:
[1] 10486659  7014305

*************** Map ******************
$map
class      : RasterLayer 
dimensions : 478, 714, 341292  (nrow, ncol, ncell)
resolution : 1, 1  (x, y)
extent     : 0, 714, 0, 478  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : memory
names      : class 
values     : 1, 2  (min, max)

plot(l92c$map) #let's plot
# class 1: forest 
# class 2: agricultural areas (+water)

# Exercise: classify the Landsat image from 2006

l06c <- unsuperClass(l06, nClasses=2)
l06c

plot(l06c$map) # Let's plot
# class 1: forest 
# class 2: agricultural areas (+water)

# Freq function generate frequency tables, show how many pixels there are
freq(l92c$map)
 value  count
[1,]     1 306053
[2,]     2  35239
# class 1: 306053 pixels (forest)
# class 2: 35239 pixels (agricultural areas)
tot92 <- 341292
# Proportion of classes
prop_forest_92 <- 306053 / tot92

# Prcent of classes
perc_forest_92 <- 306053 * 100 / tot92

# Exercise: calculate the percentage of agricultural areas in 1992
# method 1:
perc_agr_92 <- 100 - perc_forest_92
# method 2: 
perc_agr_92 <- 35239 * 100 / tot92
# percent_forest_92:  89.67482
# percent_agr_92: 10.32518

freq(l06c$map)
 value  count
[1,]     1 177630
[2,]     2 165096
# class 1: 177630 pixels (forest)
# class 2: 165096 pixels (agricultural areas)
# percentages 2006
tot_06 <- 342726
percent_forest_06 <- 177941 * 100 / tot_06
percent_forest_06
percent_agr_06 <- 100 - percent_forest_06

# percent_forest_06: 51.91932
# percent_agr_06: 48.08068

# FINAL DATA:
# percent_forest_92: 89.67482
# percent_agr_92: 10.32518
# percent_forest_06: 51.91932
# percent_agr_06: 48.08068
# dataframe è una tabella
# Let's built a dataframe with our data
# Columns (fields)
class <- c("Forest", "Agriculture")
percent_1992 <- c(89.67482, 10.32518)
percent_2006 <- c(51.91932, 48.08068)
multitemporal <- data.frame(class, percent_1992, percent_2006)
# 1992
ggplot(multitemporal, aes(x=class, y=percent_1992, color=class))+
geom_bar(stat="identity", fill="white")

# Excercise: make the same graph for 2006

ggplot(multitemporal, aes(x=class, y=percent_2006, color=class))+
geom_bar(stat="identity", fill="white")

# To make a pdf:
pdf("percentages_1992")
ggplot(multitemporal, aes(x=class, y=percent_1992, color=class))+
geom_bar(stat="identity", fill="white")
dev.off()

pdf("percentages_2006")
ggplot(multitemporal, aes(x=class, y=percent_2006, color=class))+
geom_bar(stat="identity", fill="white")
dev.off()




