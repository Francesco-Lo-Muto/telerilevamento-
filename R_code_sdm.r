# R code for species distribution modelling

# install.packages("raster")
# install.packages("sdm")
# install.packages("rgdal")

# richiamiamo le librerie necessarie
library(raster)
library(sdm)
library(rgdal)

# non usiamo la working directory, ma usiamo la funzione system.file

file <- system.file("external/species.shp", package="sdm")
# produciamo uno shapefile con la funzione del pacchetto raster shapefile()
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

# si tratta di uno oggetto SpatialPointsDataFrame 
# occurrence è la presenza
plot(species, pch=19) # visualizzo una nuvola di punti

# plottiamo un grafico con le occurence: presenze/assenze
species$Occurrence # visualizzo una matrice binomiale di 0 e 1 riportata di seguito

##[1] 1 0 1 1 1 0 0 1 1 1 1 1 1 0 1 1 0 1 1 0 0 1 0 1 1 0 1 0 1 0 1 0 1 1 1 1 0 1 0 0 0 0 0 0 0 1
## [47] 0 0 1 0 1 0 0 0 0 0 1 1 1 1 0 0 1 0 1 0 1 1 1 1 0 0 0 0 0 1 0 0 1 0 1 0 1 1 1 0 0 1 1 0 0 1
## [93] 1 1 1 0 0 0 0 0 0 0 1 1 1 0 0 1 1 0 0 0 1 0 0 1 1 1 1 1 0 0 0 1 1 0 0 1 1 1 1 1 0 0 0 1 0 0
##[139] 1 1 0 1 0 1 0 0 1 1 0 0 1 0 0 1 1 0 0 0 0 1 1 1 0 0 0 0 1 0 0 1 0 1 0 0 0 0 1 0 1 0 1 0 1 0
##[185] 0 0 0 1 1 0 1 0 1 1 0 1 0 0 0 0

# mappiamo solo le presenze
plot(species[species$Occurrence==1,], col="blue", pch=19)
#oppure
occ <- species$Occurrence

# mappiamo insieme presenze e assenze
# con il comando points() visualizzo il grafico realizzato con le presenze precedentemente aggiungendo i punti relativi alle assenze
points(species[species$Occurrence==0,], col="red", pch=19)


# predittori: definisco il percorso dove si trova
path <- system.file("external", package="sdm")

# lista dei predittori
lst <- list.files(path=path, pattern="asc", full.names=T) # si può indicare che è una estensione scrivendo "asc$"
# full.names in questo caso è necessario per mantenere il path
lst # premendo invio ottengo le seguenti informazioni
## [1] "/Library/Frameworks/R.framework/Versions/4.1/Resources/library/sdm/external/elevation.asc"    
## [2] "/Library/Frameworks/R.framework/Versions/4.1/Resources/library/sdm/external/precipitation.asc"
## [3] "/Library/Frameworks/R.framework/Versions/4.1/Resources/library/sdm/external/temperature.asc"  
## [4] "/Library/Frameworks/R.framework/Versions/4.1/Resources/library/sdm/external/vegetation.asc"

preds <- stack(lst) # per importare i file, in questo caso abbiamo importato 4 file
## class      : RasterStack 
## dimensions : 71, 124, 8804, 4  (nrow, ncol, ncell, nlayers)
## resolution : 4219.223, 4219.223  (x, y)
## extent     : 100975.3, 624159, 3988830, 4288395  (xmin, xmax, ymin, ymax)
## crs        : NA 
## names      : elevation, precipitation, temperature, vegetation 

# predittori, variabili ambientali, che ci aiutano a capire dove si troverà più probabilmente nello spazio una specie

cl <- colorRampPalette(c("blue", "orange", "red", "yellow"))(100)
plot(preds, col=cl)
# visualizzo 4 immagini:
# elevation: parte blu meno elevata
# precipitation: nella parte montana ho picchi di precipitazioni
# temperature: parte montana a basse temperature
# NDVI: sopra i 3000 m non ho vegetazione

# plot dei predittori con le presenze

elev <- preds$elevation
prec <- preds$precipitation
temp <- preds$temperature
veg <- preds$vegetation

plot(elev, col=cl)
points(species[species$Occurrence==1,], col="black", pch=19)
# abbiamo una specie a cui non piace vivere a quote elevate

plot(temp, col=cl)
points(species[occ == 1,], pch=19)
# preferisce vivere a temperature non troppo elevate

plot(prec, col=cl)
points(species[occ == 1,], pch=19)
# la specie preferisce temperature medio-alte

plot(veg, col=cl)
points(species[occ == 1,], pch=19)
# la specie preferisce essere protetta da vegetazione, se scarsa non favorevole no habitat favorevole

# settare i dati con il pacchetto sdm
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

# creiamo un modello y = a + b * elev + b * temp
# y sono occurrence
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods="glm")
m1 # premendo invio si ottengono le seguenti informazioni
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

###################################################################
## model performance (per species), using training test dataset:
## -------------------------------------------------------------------------------

 ## species   :  Occurrence 
## =========================
 
## methods    :     AUC     |     COR     |     TSS     |     Deviance 
## -------------------------------------------------------------------------
##glm        :     0.88    |     0.7     |     0.69    |     0.83     

# creare il layer raster di output
p1 <- predict(m1, newdata=preds)
# previsioni sulla maggior probabilità della presenza delle specie maggiore probabilita di prsenza di una certa specie

# output
plot(p1, col=cl)
points(species[occ == 1,], pch=19)
# visualizzo una mappa di previsione della nostro distribuzione della specie
# i punti neri indicano probabilità maggiore di presenza, dove però ho il colore blu allora sarà meno probabile la sua presenza

# plottare modello predittivo e variabili ambientali insieme
par(mfrow=c(2,3))
plot(p1, col=cl)
plot(elev, col=cl)
plot(temp, col=cl)
plot(prec, col=cl)
plot(veg, col=cl)
# visualizzo il modello predittivo e le mappe relative alle variabili ambientali

# oppure posso fare uno stack
final <- stack(preds, p1)
plot(final, col=cl)
