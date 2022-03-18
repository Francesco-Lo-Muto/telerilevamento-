# questo è il primo script che userò a lezione

# install.packages ("raster")
library (raster)

# settaggio cartella di lavoro all'interno del percorso "C"
setwd("C:/lab/") # windows

# tramine la funzione brick importiamo la nostra immagine dal paccheto che abbiamo scaricato. la rinominiamo l2011 per facilitare il lavoro successivo
l2011 <- brick ("p224r63_2011.grd")

# plottiamo la nostra prima immagine usando la funzione plot
plot(l2011)

# colorRampPalette () # funzione che serve per creare una scala
# i<- colorRampPalette (c("black", "grey", "light grey")) (100)

# u <- c (5, 6, 10, 20, 29) # sono una serie di caratteri e li indico con una c, faccio la stessa cosa con la funzione colorRampPalette
# i <- colorRampPalette(c("black", "grey", "light grey")) (100)

cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
plot(l2011, col=cl)

# Landsat ETM+
# b1 = blu
# b2 = verde
# b3 = rosso
# b4 = = infrarosso vicino NIR
