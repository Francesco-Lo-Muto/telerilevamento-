# The purpose of this project is to show the loss of vegetation in the Aspromonte National Park during summer 2021
# The images analyzed refer to May 2021 (before the fire event), September 2021 (after fire event) and two year later (July 2023)

# Loading libraries needed for this work
library(raster)
library(rgdal)
library(ggplot2)

# Setting working directory
setwd("C:/lab/esame telerilevamento 2023")

# Now I will import satellite images downloaded from sentinel 2 and after that I will plot the images 

rlist1 <- list.files(pattern="0529")
import1 <- lapply(rlist1, raster)
p1 <- stack(import1)
p1

class      : RasterStack 
dimensions : 10980, 10980, 120560400, 4  (nrow, ncol, ncell, nlayers)
resolution : 10, 10  (x, y)
extent     : 499980, 609780, 4190220, 4300020  (xmin, xmax, ymin, ymax)
crs        : +proj=utm +zone=33 +datum=WGS84 +units=m +no_defs 
names      : T33SWC_20210529T094029_B02_10m, T33SWC_20210529T094029_B03_10m, T33SWC_20210529T094029_B04_10m, T33SWC_20210529T094029_B08_10m 
min values :                              0,                              0,                              0,                              0 
max values :                          65535,                          65535,                          65535,                          65535 

# May 2021 image
plot(p1)
png("p1.png")
plotRGB(p1, 3, 2, 1, stretch="lin") 
dev.off()


rlist2 <- list.files(pattern="0921")
import2 <- lapply(rlist2, raster)
p2 <- stack(import2)
p2

class      : RasterStack 
dimensions : 10980, 10980, 120560400, 4  (nrow, ncol, ncell, nlayers)
resolution : 10, 10  (x, y)
extent     : 499980, 609780, 4190220, 4300020  (xmin, xmax, ymin, ymax)
crs        : +proj=utm +zone=33 +datum=WGS84 +units=m +no_defs 
names      : T33SWC_20210921T094031_B02_10m, T33SWC_20210921T094031_B03_10m, T33SWC_20210921T094031_B04_10m, T33SWC_20210921T094031_B08_10m 
min values :                              0,                              0,                              0,                              0 
max values :                          65535,                          65535,                          65535,                          65535 

# September 2021 image
plot(p2)
png("p2.png")
plotRGB(p2, 3, 2, 1, stretch="lin") 
dev.off()

rlist3 <- list.files(pattern="0713")
import3 <- lapply(rlist3, raster)
p3 <- stack(import3)
p3

# July 2023 image 
plot(p3)
png("p3.png")
plotRGB(p3, 3, 2, 1, stretch="lin") 
dev.off()

# I plot  RGB images all together
par(mfrow=c(1,3))
plotRGB(p1, 3, 2, 1, stretch="lin")
plotRGB(p2, 3, 2, 1, stretch="lin")
plotRGB(p3, 3, 2, 1, stretch="lin")
dev.off()

# To highlight the differce of vegetated areas before and after the fire season I plot the band B8, B4, B3 (vnir, red, green).
plotRGB(p1, 4, 3, 2, stretch="lin")
plotRGB(p2, 4, 3, 2, stretch="lin")
plotRGB(p3, 4, 3, 2, stretch="lin")

# Through a multiframe I plot the images all together
par(mfrow=c(1,3))
plotRGB(p1, 4, 3, 2, stretch="lin")
plotRGB(p2, 4, 3, 2, stretch="lin")
plotRGB(p3, 4, 3, 2, stretch="lin")
dev.off()


# Let's save images in a png format

png("p1a.png")
plotRGB(p1, 4, 3, 2, stretch="lin")
dev.off()
png("p2a.png")
plotRGB(p2, 4, 3, 2, stretch="lin")
dev.off()
png("p3a.png")
plotRGB(p3, 4, 3, 2, stretch="lin")
dev.off()

# Let's use vegetation index (DVI) to show the difference from vegetated areas to bare soil

dvip1 = p1[[4]] - p1[[3]]      
dvip1
# dvip1 
class      : RasterLayer 
dimensions : 10980, 10980, 120560400  (nrow, ncol, ncell)
resolution : 10, 10  (x, y)
extent     : 499980, 609780, 4190220, 4300020  (xmin, xmax, ymin, ymax)
crs        : +proj=utm +zone=33 +datum=WGS84 +units=m +no_defs 
source     : r_tmp_2023-07-18_173302_9104_70944.grd 
names      : layer 
values     : -6504, 11452  (min, max)

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvip1, col=cl) 
dev.off()

dvip2 = p2[[4]] - p2[[3]]      
dvip2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvip2, col=cl)
dev.off()

dvip3 = p3[[4]] - p3[[3]]      
dvip3
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvip3, col=cl)
dev.off()

# Let's save images in a png format
png("dvip1.png")
plot(dvip1, col=cl)

png("dvip2.png")
plot(dvip2, col=cl)

png("dvip3.png")
plot(dvip3, col=cl)



# Let's plot the imahes with a multiframe
par(mfrow=c(1,3))
plot(dvip1, col=cl)	
plot(dvip2, col=cl)
plot(dvip3, col=cl)
dev.off()


# Let's save images 
png("dvi_p_all.png")
par(mfrow=c(1,3))
plot(dvip1, col=cl)	
plot(dvip2, col=cl)
plot(dvip3, col=cl)

# Normalized difference vegetation index (NDVI) to quantify vegetation loss and health
ndvip1 = dvip1 / (p1[[4]] + p1[[3]])
plot(ndvip1)
dev.off()

ndvip2 = dvip2 / (p2[[4]] + p2[[3]])
plot(ndvip2)
dev.off()

ndvip3 = dvip3 / (p3[[4]] + p3[[3]])
plot(ndvip3)
dev.off()


# save images
png("ndvip1.png")
ndvip1 = dvip1 / (p1[[4]] + p1[[3]])
plot(ndvip1)

png("ndvip2.png")
ndvip2 = dvip2 / (p2[[4]] + p2[[3]])
plot(ndvip2)

png("ndvip3.png")
ndvip3 = dvip3 / (p3[[4]] + p3[[3]])
plot(ndvip3)

# Let's plot  images all together

par(mfrow=c(1,3))
plot(ndvip1, col=cl)	
plot(ndvip2, col=cl)
plot(ndvip3, col=cl)
dev.off()

# DVI difference between May and September 2021
difdvi = dvip1 - dvip2
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld)

