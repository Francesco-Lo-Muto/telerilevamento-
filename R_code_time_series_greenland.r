# time series analysis of Greenland LST data

library (raster)

# setwd("C:/lab/greenland") 

# I import the data with classic operation and then with a faster method.
# I want to import a single layer by raster function

lst2000 <- raster("lst_2000.tif")
lst2000
# plot lst2000
plot(lst2000)
# exercice: import all the data 
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
# through lapply function I can import everything together
# I create my list files (in this case is important to work with objects). After that lapply function will apply the raster function to all file
# list.files (create a files list)
# import the whole set altogether
rlist <- list.files (pattern="lst")
# ora applico raster a questa lista di files
import <- lapply(rlist, raster)
# si potrebbe fare lo stack ovvero predere i layer e metterle in un singolo file
tgr <- stack (import)
# invece di fare il multiframe, faccio una lista di file, mi applico la funzione lapply che mi applica la funzione raster alla lista e poi faccio lo stack
plot (tgr, col=cl)
# ho lo stesso plot di prima ma senza passare dal multiframeù
# se voglio plottare una singola banda 
plot ( tgr$lst2000, col = cl )
# ho plotto il nome o l'elemento
plot(tgr[[1]], col=cl)
# posso fare un rgb basandomi sui layer del nostro stack
plotRGB(tgr, r=1, g=2, b=3, stretch="lin")
plotRGB(tgr, r=4, g=3, b=2, stretch="lin")
plotRGB(tgr, r=1, g=2, b=4, stretch="lin")

# expamle 2: NO2 decrease during the lockdown period
# setwd("C:/lab/en") # Windows
# importiamo il primo dato 
en01 <- raster ("EN_0001.png")
# plottiamo il nostro dato con una nuova palette
cl <- colorRampPalette(c('red','orange','yellow'))(100)
plot(en01, col=cl)
# importiamo il secondo set e importiamo il 13°
en13 <- raster("EN_0013.png")
plot(en13, col=cl)
# let's import the whole set (altogether!)
# excercise: import the whole as in the greenlan example
# by the following steps: list.files, lapply, stack
rlist <- list.files(pattern="EN")
rlist
# voglio applicare alla funzione rlist la funziona rster e lo faccio con lapply
list_rast <- lapply(rlist, raster)
list_rast
# si fa lo stack, un pacchetto di pezzi (di vettori o immagini ecc) da un dataframe o nel notro caso uno stack di immagini
EN_stack <- stack(list_rast)
EN_stack
# ora plotto i dati con la colorRampPalette
cl <- colorRampPalette(c('red','orange','yellow'))(100)
plot(EN_stack, col=cl)
# exercise: plot EN01 besides EN13
par(mfrow=c(1,2))
plot(en[[1]], col=cl)
plot(en[[3]], col=cl)
# or 
en113 <- stack(en[[1]], en[[3]])
plot(en113, col=cl)
# fare l idfferenza sll'NO2 di azono nella 1 e nella 13
# let's make the difference:
difen <- en[[1]]- en[[13]]
cldif <- colorRampPalette(c('blue','white','red'))(100) #
plot(difen, col=cldif)
