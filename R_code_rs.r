# questo è il primo script che userò a lezione

# install.packages ("raster")
library (raster)

# settaggio cartella di lavoro all'interno del percorso "C"
setwd("C:/lab/") # windows

# import 
l2011 <- brick ("p224r63_2011.grd")
