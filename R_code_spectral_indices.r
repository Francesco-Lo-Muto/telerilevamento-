library(raster)
install.packages("rgdal")
library(rgdal)
# recall library raster
# setting my windows working directory
setwd("C:/lab/")
# import the first file -> defor1_1.jpg -> give it the name l1992
l1992 <- brick("defor1_.jpg")
# plottiamo la foto per capire quali bande ci sono. plot the image to understand what bands are contained
plotRGB(l1992, r=1, g=2, b=3, stretch= "lin")
# the vegetation reflects the infrared very much, the first band is NIR
# layer 1= NIR
# layer 2= red
# layer 3= green

# I replay the same procedure to import the second file -> defor2_.jpg -> give it the name l2006. 
l2006 <- brick("defor2_.jpg")
plotRGB(l2006, r=1, g=2, b=3, stretch= "lin")
# excercise: plot in a multiframe the two images

par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# DVI differecne vegetation index, is the difference between near infrared and red
dvi1992 = l1992 [[1]] - l1992 [[2]]

# plot 1992 image
dvi1992
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot (dvi1992, col =cl)
# same procedure for 2006
dvi2006 = l2006[[1]] - l2006[[2]]

# plot 2006 image
dvi2006
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot (dvi2006, col =cl)
# another way to calculate dvi index is by name
# NDVI is done to standardize the index
# range DVI (8 bit): -255 a 255                                                                      
# range NDVI (8 bit): -1 a 1 
# in an 8 bit image I have 256 values while in a 16 bit image I have 65535
# range DVI (16 bit): -65535 a 65535                                                                       
# range NDVI (16 bit) : - 1 a 1
# in both photos NDVI range is the same so if I have the same value I can make comparisons. It can be used with images with different radiometric resolution (how many bits are available within an image).
# upload through brick function (which loads a whole block of bands) the 1992 photo                                                                        
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
# DVI difference between 1992-2006
dvi_dif = dvi1992 - dvi2006
cld <- ColorRampPalette(c('blue', 'white', 'red'))(100)
# I use dev.off() to close previous window
dev.off()
# plot dvi_diff with new ColorRampPaeltte
plot (dvi_dif, col =cld)

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
                                                                        
