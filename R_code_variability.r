# santinel lanciato da esa ha una risoluzione di 10 metri
# variazioni geostrutturali e le variazioni ecologiche, landcover, fino ai boschi

# R code variability

# install.packages("viridis")
library(raster)
library(RStoolbox) # for image viewing and variability
library(ggplot2) # for ggplot plotting
library(patchwork)
setwd("C:/lab/")
# Exercise: import the Similaun image
sen <- brick("sentinel.png")
sen
## class      : RasterBrick 
## dimensions : 794, 798, 633612, 4  (nrow, ncol, ncell, nlayers)
## resolution : 1, 1  (x, y)
## extent     : 0, 798, 0, 794  (xmin, xmax, ymin, ymax)
## crs        : NA 
## source     : sentinel.png 
## names      : sentinel.1, sentinel.2, sentinel.3, sentinel.4 
## min values :          0,          0,          0,          0 
## max values :        255,        255,        255,        255

# Exercise: plot the image by the ggRGB function

ggRGB(sen, 1, 2, 3, stretch="lin")
# NIR on g component
ggRGB(sen, 2, 1, 3, stretch="lin")



g1 <- ggRGB(sen, 1, 2, 3)
g2 <- ggRGB(sen, 2, 1, 3)
# now I plot both
g1+g2
# calculation of variability over NIR
nir <- sen[[1]]
plot(nir)
sd1 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
clsd <- colorRampPalette(c("blue", "green", "pink", "magenta", "orange", "brown", "red", "yellow"))(100)
plot(sd1, col=clsd)

# Let's plot with ggplot
ggplot() +
geom_raster(sd, mapping=aes(x=x, y=y, fill=layer))

# withg viridis
# https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
ggplot() +
geom_raster(sd, mapping=aes(x=x, y=y, fill=layer))+
scale_fill_viridis()+
ggtitle("Standard deviationof by viridis")

# with cividis
ggplot() +
geom_raster(sd, mapping=aes(x=x, y=y, fill=layer))+
scale_fill_viridis(option="cividis")+
ggtitle("Standard deviationof by viridis")

# Excerise: make the same calculation with a 7x7 window

sd7 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
clsd <- colorRampPalette(c("blue", "green", "pink", "magenta", "orange", "brown", "red", "yellow"))(100)
plot(sd7, col=clsd)





