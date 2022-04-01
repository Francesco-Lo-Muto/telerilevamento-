# time series analysis of Greenland LST data

library (raster)

# setwd("C:/lab/greenland") 

# importiamo i dati prima con l'operazione classica e poi con un metodo più velcoe
# voglio importare un singolo strato tramite la funzione raster, la funzione che importa un layer singolo

lst2000 <- raster("lst_2000.tif")
lst2000
# la plottiamo
plot(lst2000)
# exercice: import all the data 
lst2005 <- raster("lst_2005.tif")
lst2010 <- raster("lst_2010.tif")
lst2015 <- raster("lst_2015.tif")
# ci creiamo una colorRamPalette
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
# facciamo un multifrme con quattro dati
par(mfrow=c(2,2))
plot(lst2000, col=cl)
plot(lst2005, col=cl)
plot(lst2010, col=cl)
plot(lst2015, col=cl)
# vediamo come importare questa funzione tutta insieme con la funzione lapply
# creo la mia lista di file (importante lavorare con gli oggetti) e poi lapply applicherà la funzione raster a tutti i file
# list.files (crea una lista di file)
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
#
