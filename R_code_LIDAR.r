# R code for visualising and analysing LIDAR data


#install.packages("lidR")
library(raster)
library(rgdal)
library(viridis)
library(RStoolbox)
library(ggplot2)
library(lidR)
setwd("C:/lab/")


dsm_2004 <- raster("2004Elevation_DigitalElevationModel-2.5m.tif")
dsm_2004

## class      : RasterLayer 
## dimensions : 418, 644, 269192  (nrow, ncol, ncell)
## resolution : 2.5, 2.5  (x, y)
## extent     : 677858.8, 679468.8, 5155696, 5156741  (xmin, xmax, ymin, ymax)
## crs        : +proj=utm +zone=32 +ellps=GRS80 +units=m +no_defs 
## source     : 2004Elevation_DigitalElevationModel-2.5m.tif 
## names      : X2004Elevation_DigitalElevationModel.2.5m 

dtm_2004 <- raster("2004Elevation_DigitalElevationModel-2.5m.tif")
dtm_2004
## class      : RasterLayer 
## dimensions : 418, 644, 269192  (nrow, ncol, ncell)
## resolution : 2.5, 2.5  (x, y)
## extent     : 677858.8, 679468.8, 5155696, 5156741  (xmin, xmax, ymin, ymax)
## crs        : +proj=utm +zone=32 +ellps=GRS80 +units=m +no_defs 
## source     : 2004Elevation_DigitalTerrainModel-2.5m.tif 
## names      : X2004Elevation_DigitalTerrainModel.2.5m 

plot(dsm_2004)
plot(dtm_2004)

chm_2004 <- dsm_2004 - dtm_2004
plot(chm_2004) 
# each color represents different altitudes
# the light colors = soil
# green color = plants

#  year 2013

dsm_2013 <- raster("2013Elevation_DigitalElevationModel-0.5m.tif")
dsm_2013 

## class      : RasterLayer 
## dimensions : 2094, 3224, 6751056  (nrow, ncol, ncell)
## resolution : 0.5, 0.5  (x, y)
## extent     : 677857.8, 679469.8, 5155695, 5156742  (xmin, xmax, ymin, ymax)
## crs        : +proj=utm +zone=32 +ellps=GRS80 +units=m +no_defs 
## source     : 2013Elevation_DigitalElevationModel-0.5m.tif 
## names      : X2013Elevation_DigitalElevationModel.0.5m 

dtm_2013 <- raster("2013Elevation_DigitalElevationModel-0.5m.tif")
dtm_2013 

## class      : RasterLayer 
## dimensions : 2094, 3224, 6751056  (nrow, ncol, ncell)
## resolution : 0.5, 0.5  (x, y)
## extent     : 677857.8, 679469.8, 5155695, 5156742  (xmin, xmax, ymin, ymax)
## crs        : +proj=utm +zone=32 +ellps=GRS80 +units=m +no_defs 
## source     : 2013Elevation_DigitalTerrainModel-0.5m.tif 
## names      : X2013Elevation_DigitalTerrainModel.0.5m 

chm_2013 <- dsm_2013 - dtm_2013
# the image has a higher resolution than the one obtained in 2004


dif_chm <- chm_2013 - chm_2004 
# To resample, the resolution of chm_2013 is the same of chm_2004

chm_2013_resample <- resample(chm_2013, chm_2004) 
dif_chm <- chm_2013_resample - chm_2004

ggplot() +
  geom_raster(dif_chm, mapping =aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis() +
  ggtitle("CHM difference")

point_cloud <- readLAS("point_cloud.laz")
plot(point_cloud)
