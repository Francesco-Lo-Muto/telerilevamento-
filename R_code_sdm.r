# R code for species distribution modelling

# install.packages("raster")
# install.packages("sdm")
# install.packages("rgdal")

# Recall libraries needed to work
library(raster)
library(sdm)
library(rgdal)

# We don't use the working directory but system.file function

file <- system.file("external/species.shp", package="sdm")
species <- shapefile(file)
species #

## class       : SpatialPointsDataFrame 
## features    : 200 
## extent      : 110112, 606053, 4013700, 4275600  (xmin, xmax, ymin, ymax)
## crs         : +proj=utm +zone=30 +datum=WGS84 +units=m +no_defs 
## variables   : 1
## names       : Occurrence 
## min values  :          0 
## max values  :          1 

# SpatialPointsDataFrame 
# Occurrence
plot(species, pch=19) # I see a point cloud

# Let's plot a graph with the occurrences
species$Occurrence # I display a binomial array of 0 and 1

##[1] 1 0 1 1 1 0 0 1 1 1 1 1 1 0 1 1 0 1 1 0 0 1 0 1 1 0 1 0 1 0 1 0 1 1 1 1 0 1 0 0 0 0 0 0 0 1
## [47] 0 0 1 0 1 0 0 0 0 0 1 1 1 1 0 0 1 0 1 0 1 1 1 1 0 0 0 0 0 1 0 0 1 0 1 0 1 1 1 0 0 1 1 0 0 1
## [93] 1 1 1 0 0 0 0 0 0 0 1 1 1 0 0 1 1 0 0 0 1 0 0 1 1 1 1 1 0 0 0 1 1 0 0 1 1 1 1 1 0 0 0 1 0 0
##[139] 1 1 0 1 0 1 0 0 1 1 0 0 1 0 0 1 1 0 0 0 0 1 1 1 0 0 0 0 1 0 0 1 0 1 0 0 0 0 1 0 1 0 1 0 1 0
##[185] 0 0 0 1 1 0 1 0 1 1 0 1 0 0 0 0

plot(species[species$Occurrence==1,], col="blue", pch=19)
occ <- species$Occurrence

# Points command () 
points(species[species$Occurrence==0,], col="red", pch=19)


# Predictors: I define where is the path
path <- system.file("external", package="sdm")

# Predictors list
lst <- list.files(path=path, pattern="asc", full.names=T)
# full.names 
lst 
## [1] "/Library/Frameworks/R.framework/Versions/4.1/Resources/library/sdm/external/elevation.asc"    
## [2] "/Library/Frameworks/R.framework/Versions/4.1/Resources/library/sdm/external/precipitation.asc"
## [3] "/Library/Frameworks/R.framework/Versions/4.1/Resources/library/sdm/external/temperature.asc"  
## [4] "/Library/Frameworks/R.framework/Versions/4.1/Resources/library/sdm/external/vegetation.asc"

preds <- stack(lst) # To import file
## class      : RasterStack 
## dimensions : 71, 124, 8804, 4  (nrow, ncol, ncell, nlayers)
## resolution : 4219.223, 4219.223  (x, y)
## extent     : 100975.3, 624159, 3988830, 4288395  (xmin, xmax, ymin, ymax)
## crs        : NA 
## names      : elevation, precipitation, temperature, vegetation 

# Predictors, environmental variables, help us understand where in space a species is most likely to be found

cl <- colorRampPalette(c("blue", "orange", "red", "yellow"))(100)
plot(preds, col=cl)
# elevation: less elevated blue part
# precipitation: in the mountainous part I have peaks of precipitation
# temperature: mountainous part at low temperatures
# NDVI: above 3000 m I have no vegetation



elev <- preds$elevation
prec <- preds$precipitation
temp <- preds$temperature
veg <- preds$vegetation

plot(elev, col=cl)
points(species[species$Occurrence==1,], col="black", pch=19)
# We have a species that doesn't like living at high altitudes

plot(temp, col=cl)
points(species[occ == 1,], pch=19)
# Prefers to live in temperatures that are not too high

plot(prec, col=cl)
points(species[occ == 1,], pch=19)
# The species prefers medium-high temperatures

plot(veg, col=cl)
points(species[occ == 1,], pch=19)
# The species prefers to be protected by vegetation

# Set the data with the sdm package
datasdm <- sdmData(train=species, predictors=preds)
datasdm # premendo invio otterrò i seguenti dati

## class                                 : sdmdata 
## =========================================================== 
## number of species                     :  1 
## species names                         :  Occurrence 
## number of features                    :  4 
## feature names                         :  elevation, precipitation, temperature, ... 
## type                                  :  Presence-Absence 
## has independet test data?             :  FALSE 
## number of records                     :  200 
## has Coordinates?                      :  TRUE 

# Let's create a model y = a + b * elev + b * temp

m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods="glm")

## class                                 : sdmModels 
## ======================================================== 
## number of species                     :  1 
## number of modelling methods           :  1 
## names of modelling methods            :  glm 
## ------------------------------------------
## model run success percentage (per species)  :
## ------------------------------------------
## method          Occurrence       
## ---------------------- 
## glm        :        100   %



## model performance (per species), using training test dataset:
## -------------------------------------------------------------------------------

 ## species   :  Occurrence 
## =========================
 
## methods    :     AUC     |     COR     |     TSS     |     Deviance 
## -------------------------------------------------------------------------
##glm        :     0.88    |     0.7     |     0.69    |     0.83     

# Create output raster layer
p1 <- predict(m1, newdata=preds)


# Output
plot(p1, col=cl)
points(species[occ == 1,], pch=19)
# Display a forecast map of species distribution
# The black dots indicate a greater probability of its presence, but where the color is blue, its presence will be less likely

# Let's plot all together 
par(mfrow=c(2,3))
plot(p1, col=cl)
plot(elev, col=cl)
plot(temp, col=cl)
plot(prec, col=cl)
plot(veg, col=cl)


# Let's create a stack
final <- stack(preds, p1)
plot(final, col=cl)
