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

#The Normalized Burn Ratio (NBR)




