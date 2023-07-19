#Ttime series analysis of Greenland LST data

library (raster)

# Setwd("C:/lab/greenland") 

# I import the data with classic operation and then with a faster method.
# I want to import a single layer by raster function

lst2000 <- raster("lst_2000.tif")
lst2000
# Plot lst2000
plot(lst2000)
# Exercice: import all the data 
lst2005 <- raster("lst_2005.tif")
lst2010 <- raster("lst_2010.tif")
lst2015 <- raster("lst_2015.tif")
# I can make a new colourRampPalette
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
# I make a multiframe for all four layers
par(mfrow=c(2,2))
plot(lst2000, col=cl)
plot(lst2005, col=cl)
plot(lst2010, col=cl)
plot(lst2015, col=cl)
# Through lapply function I can import everything together
# I create my list files (in this case is important to work with objects). After that lapply function will apply the raster function to all file
# List.files (create a files list)
# Import the whole set altogether
rlist <- list.files (pattern="lst")
# Now I use raster function in this files list
import <- lapply(rlist, raster)
# I can use stack function to take the layers and put them in a single file
tgr <- stack (import)
# Instead to use multiframe I can apply lapply funtcion. This funtion applies raster function to the files list
plot (tgr, col=cl)
# I got the same result but without multiframe
# If I plot a single band
plot (tgr$lst2000, col=cl)
# I can use the element or name
plot(tgr[[1]], col=cl)
# I can build an RGB file based on the layers of our stack
plotRGB(tgr, r=1, g=2, b=3, stretch="lin")
plotRGB(tgr, r=4, g=3, b=2, stretch="lin")
plotRGB(tgr, r=1, g=2, b=4, stretch="lin")

# Expamle 2: NO2 decrease during the lockdown period
# Setwd("C:/lab/en") # Windows
# Import first data 
en01 <- raster ("EN_0001.png")
# Plot data with a new colourRampPalette
cl <- colorRampPalette(c('red','orange','yellow'))(100)
plot(en01, col=cl)
# Import thirteenth set
en13 <- raster("EN_0013.png")
plot(en13, col=cl)
# Let's import the whole set (altogether!)
# Excercise: import the whole as in the greenlan example
# By the following steps: list.files, lapply, stack
rlist <- list.files(pattern="EN")
rlist
# Through lapply command I apply raster function to the rlist functionn
list_rast <- lapply(rlist, raster)
list_rast
# Let's make the stack
EN_stack <- stack(list_rast)
EN_stack
# Now I plot data with a colourRampPalette
cl <- colorRampPalette(c('red','orange','yellow'))(100)
plot(EN_stack, col=cl)
# Exercise: plot EN01 besides EN13
par(mfrow=c(1,2))
plot(en[[1]], col=cl)
plot(en[[13]], col=cl)
# or 
en113 <- stack(en[[1]], en[[13]])
plot(en113, col=cl)
# Let's make the difference:
difen <- en[[1]]- en[[13]]
cldif <- colorRampPalette(c('blue','white','red'))(100) 
plot(difen, col=cldif)
# PlotRGB of three files together
plotRGB(en, r=1, g=7, b=13, stretch="lin")
plotRGB(en, r=1, g=7, b=13, stretch="hist")
# Red color is associated with January
# Green color is associated with February
# Blue is associated with March

library(raster)
library(RStoolbox)
# Setting working directory for winwows
setwd("C:/lab/") 
# Import the satellite image
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
so
# I get a variety of information
plotRGB(so, 1, 2, 3, stretch="lin")
plotRGB(so, 1, 2, 3, stretch="hist")

# Classifying the solar data 
soc <- unsuperClass(so, nClasses=3)
soc
cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(soc$map, col=cl)
 
