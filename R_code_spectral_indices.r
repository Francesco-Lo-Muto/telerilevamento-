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
