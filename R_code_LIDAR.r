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
dsm_2004 #premo invio
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
# visualizzo una immagine in cui ogni colore rappresenta diverse altezze
# colori chiari chiari rappresentano il suolo, colori tendenti al verde sono le piante

# per l'anno 2013

dsm_2013 <- raster("2013Elevation_DigitalElevationModel-0.5m.tif")
dsm_2013 # premendo invio si ottengono le seguenti informazioni

## class      : RasterLayer 
## dimensions : 2094, 3224, 6751056  (nrow, ncol, ncell)
## resolution : 0.5, 0.5  (x, y)
## extent     : 677857.8, 679469.8, 5155695, 5156742  (xmin, xmax, ymin, ymax)
## crs        : +proj=utm +zone=32 +ellps=GRS80 +units=m +no_defs 
## source     : 2013Elevation_DigitalElevationModel-0.5m.tif 
## names      : X2013Elevation_DigitalElevationModel.0.5m 

dtm_2013 <- raster("2013Elevation_DigitalElevationModel-0.5m.tif")
dtm_2013 # premendo invio si ottengono le seguenti informazioni

## class      : RasterLayer 
## dimensions : 2094, 3224, 6751056  (nrow, ncol, ncell)
## resolution : 0.5, 0.5  (x, y)
## extent     : 677857.8, 679469.8, 5155695, 5156742  (xmin, xmax, ymin, ymax)
## crs        : +proj=utm +zone=32 +ellps=GRS80 +units=m +no_defs 
## source     : 2013Elevation_DigitalTerrainModel-0.5m.tif 
## names      : X2013Elevation_DigitalTerrainModel.0.5m 

chm_2013 <- dsm_2013 - dtm_2013
# l'immagine visualizzata ha maggior risoluzione rispetto a quella ottenuta nel 2004
# confronto valori di resolution per dsm e dtm dei vari anni

dif_chm <- chm_2013 - chm_2004 # non funzionerà perchè ho diversa risoluzione different resolution,error
# portiamo i due raster alla stessa risoluzione: dobbiamo ricampionare resample
# portiamo la risoluzione di chm_2013 a quella di chm_2004

chm_2013_resample <- resample(chm_2013, chm_2004) # necessita rgdal o RStoolbox per svolgere questo calcolo
dif_chm <- chm_2013_resample - chm_2004

ggplot() +
  geom_raster(dif_chm, mapping =aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis() +
  ggtitle("CHM difference")

point_cloud <- readLAS("point_cloud.laz")
plot(point_cloud)
