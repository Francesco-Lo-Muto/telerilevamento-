# questo è il primo script che userò a lezione

# install.packages ("raster")
library (raster)

# settaggio cartella di lavoro all'interno del percorso "C"
setwd("C:/lab/") # windows

# tramine la funzione brick importiamo la nostra immagine dal paccheto che abbiamo scaricato. la rinominiamo l2011 per facilitare il lavoro successivo
l2011 <- brick ("p224r63_2011.grd")
