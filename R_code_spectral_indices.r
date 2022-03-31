library(raster)
install.packages("rgdal")
library(rgdal)
# abbiamo richiamato la libreria raster che ci serve
# sttiamo la wd per windows nel mio caso
setwd("C:/lab/")

import the first file -> defor1_1.jpg -> give it the name l1992

l1992 <- brick("defor1_.jpg")

# plottiamo la foto per capire quali bande ci sono
plotRGB(l1992, r=1, g=2, b=3, stretch= "lin")
nel rosso c'è una banda dove riflette molto quindi l'infrarosso vicino (la banda # 1 è la NIR)
# layer 1= NIR
# layer 2= red
# layer 3= green

# facciamo la stessa operazione per la seconda: import the second file -> defor2_.jpg -> give it the name l2006
l2006 <- brick("defor2_.jpg")
plotRGB(l2006, r=1, g=2, b=3, stretch= "lin")
excercise: plot in a multiframe the two images

par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# DVI differecne vegetation index per i due anni
dvi1992 = l1992 [[1]] - l1992 [[2]]

# plottiamo il dato del 1992
dvi1992
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot (dvi1992, col =cl)

dvi2006 = l2006[[1]] - l2006[[2]]

# plottiamo il dato del 2006
dvi2006
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot (dvi2006, col =cl)
# altro metodo per calcolare il dvi invece di usare gli elemnti potremmo usare i nomi.

# NDVIsi fa per standartizzare l'indice
# range DVI (8 bit): -255 a 255                                                                      
# range NDVI (8 bit): -1 a 1 
# in un immagine a 8 bit ho 256 valori mentre con una a 16 bit ne ho 65535 
# range DVI (16 bit): -65535 a 65535                                                                       
# range NDVI (16 bit) : - 1 a 1
# il range NDVI in entrambe è uguale quindi io avendo lo stesso valore posso fare confronti e può essere usato con immagini con risoluzione radioometrica differente. ( risoluzone radiometrica ovvero quanti bit ci sono dispobibili a dispozione all'intenro di un immagine)
# carichiamo con la funzione brick ( che carica un intero blocco di bande) la foto del 1992                                                                        
l1992 <- brick("defor1_.jpg")     
# ora carico la foto del 2006 con lo stesso procedimento
l2006 <- brick("defor2_.jpg")                                                                        
# per calcolare il DVI o uso i nomi o uso gli elemento all'interno
dvi1992 = l1992[[1]] - l1992[[2]]
# mi calcolo l'NDVI:
ndvi1992 = dvi1992 / (l1992[[1]] + l1992[[2]])                                                                        
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot (ndvi1992, col =cl) 
# multiframe con il plotRGB dell'immagine sopra
# e l'ndvi sotto
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin") 
plot (ndvi1992, col =cl)                                                                         
# eseguo lo stesso procedimento per la foto del 2006                                                                        
dvi2006 = l2006[[1]] - l2006[[2]]                                                                   
ndvi2006 = dvi2006 / (l2006[[1]] + l2006[[2]])                                                                                                   
par(mfrow=c(2,1))
plot (ndvi2006, col =cl)   
plot (ndvi1992, col =cl)                                                                         
# automatic spectrale indices by the spectralIndices 
library (RStoolbox)                                                                        
si1992 <- spectralIndices(l1992, green=3, red=2, nir=1)
plot(si1992,col=cl)                                                                      
# ci da tutti gli indici possibili calcolabili per un immagine.                                                                     
# rifacciamo la stessa operazione per il 2006
si2006 <- spectralIndices(l1992, green=3, red=2, nir=1)
plot(si2006,col=cl)                                                                        
install.packages("rasterdiv")                                                                        
library(rasterdiv)                                                                       
plot (copNDVI)                                                                        
                                                                        
