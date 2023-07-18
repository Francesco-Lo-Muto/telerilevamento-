# exam telerilevamento 2023
library(raster)
library(rgdal)
library(ggplot2)
library(patchwork)
library(viridis)
setwd("C:/lab/esame telerilevamento 2023")
#
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


plot(p1)
png("p1.png")
plotRGB(p1, 3, 2, 1, stretch="lin") 
dev.off()

#
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

plot(p2)
png("p2.png")
plotRGB(p2, 3, 2, 1, stretch="lin") 
dev.off()

rlist3 <- list.files(pattern="0713")
import3 <- lapply(rlist3, raster)
p3 <- stack(import3)
p3
#
plot(p3)
png("p3.png")
plotRGB(p3, 3, 2, 1, stretch="lin") 
dev.off()

# I plot images all together
par(mfrow=c(1,3))
plotRGB(p1, 3, 2, 1, stretch="lin")
plotRGB(p2, 3, 2, 1, stretch="lin")
plotRGB(p3, 3, 2, 1, stretch="lin")
dev.off()

#  difference
plotRGB(p1, 4, 3, 2, stretch="lin")
plotRGB(p2, 4, 3, 2, stretch="lin")
plotRGB(p3, 4, 3, 2, stretch="lin")

#all together
par(mfrow=c(1,3))
plotRGB(p1, 4, 3, 2, stretch="lin")
plotRGB(p2, 4, 3, 2, stretch="lin")
plotRGB(p3, 4, 3, 2, stretch="lin")
dev.off()


# save the images

png("p1a.png")
plotRGB(p1, 4, 3, 2, stretch="lin")
dev.off()
png("p2a.png")
plotRGB(p2, 4, 3, 2, stretch="lin")
dev.off()
png("p3a.png")
plotRGB(p3, 4, 3, 2, stretch="lin")
dev.off()

# DVI
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

dvip2 = p2[[4]] - p2[[3]]      
dvip2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvip2, col=cl)

p3 = p3[[4]] - p3[[3]]      
dvip3
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvip3, col=cl)

# save image 
png("dvip1.png")
plot(dvip1, col=cl)

png("dvip2.png")
plot(dvip2, col=cl)

png("dvip2.png")
plot(dvip2, col=cl)



#
par(mfrow=c(1,3))
plot(dvip1, col=cl)	
plot(dvip2, col=cl)
plot(dvip3, col=cl)


#save tutti insieme
png("dvi_p_all.png")
par(mfrow=c(1,3))
plot(dvip1, col=cl)	
plot(dvip2, col=cl)
plot(dvip3, col=cl)

#NDVI
ndvip1 = dvip1 / (p1[[4]] + p1[[3]])
plot(ndvip1)
ndvip2 = dvip2 / (p2[[4]] + p2[[3]])
plot(ndvip2)
ndvip3 = dvip3 / (p3[[4]] + p3[[3]])
plot(ndvip3)


# save 
png("ndvip1.png")
ndvip1 = dvip1 / (p1[[4]] + p1[[3]])
plot(ndvip1)

png("ndvip2.png")
ndvip2 = dvip2 / (p2[[4]] + p2[[3]])
plot(ndvip2)

png("ndvip3.png")
ndvip3 = dvip3 / (p3[[4]] + p3[[3]])
plot(ndvip3)

# plotto isieme

par(mfrow=c(1,3))
plot(ndvip1, col=cl)	
plot(ndvip2, col=cl)
plot(ndvip3, col=cl)

#salvo insieme
png("ndvi_p_all.png")
par(mfrow=c(1,3))
plot(ndvip1, col=cl)	
plot(ndvip2, col=cl)
plot(ndvip3, col=cl)
