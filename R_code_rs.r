# questo è il primo script che userò a lezione

# install.packages ("raster") 
library (raster)

# setting working directory within path "C"
setwd("C:/lab/") # windows

# through the brick function I can import the image from the downloaded package, then I assign "l2011" name to make subsequent work easier
l2011 <- brick ("p224r63_2011.grd")

# I plot my first picture by using plot function
plot(l2011)

# colorRampPalette () # it's a function that creates a colour scale
i <- colorRampPalette (c("black", "grey", "light grey")) (100)

# u <- c(5, 6, 10, 20, 29) # this is an array made through c function, the same thing with colorRampPalette function
i <- colorRampPalette(c("black", "grey", "light grey")) (100)

cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
plot(l2011, col=cl)

# Landsat ETM+
# b1 = blue
# b2 = green
# b3 = red
# b4 = = near infrared NIR
# I plot the blue band (B1_sre)
plot (l2011$B1_sre)
# to tie the bands to a satellite images or tie objects together I can use dollar symbol
# altro modo per fare lo stesso procedimento, si ripete plot ma invece di dare il nome si prende il primo elemento ovvero la banda del blu

# concetto di elemtno, una lista di dati. in r gli elemtni si racchiudono in doppia parentesi quandra, elementi allintenro delnostro datased dell imagine satellitare.
plot (l2011[[1]])
# secondo modo per plottre la prima banda ovvero la banda del blu. i 2 metodi sono ugaali ma ci osno dei pro e i contro ma sono la stessa cosa 
# banda con nuova legenda
plot (l2011[[1]])
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
plot (l2011$B1_sre, col= cl)
# plot b1 from dark blue to blue to light blue
clb <- colorRampPalette(c("darkblue", "blue", "light blue")) (100)
plot (l2011$B1_sre, col= clb)
# abbiamo riplottato tutto con la scala del blu, rinomincando cl in clb per indicare che si tratta di una scala di colori in blu. 
# si può esportare nella carella lab un file in pdf utilizzando la funzione pdf e nominando il file.pdf e le virgolette pe uscire da r, per choiudere le cuciture relazionati ai gravici in r si usa una funzione chimaata dev.off
pdf("banda1.pdf")
plot (l2011$B1_sre, col= clb)
# dev.off chiude la finestra, se io apro una finestra vortuale come pdf la choudo con questa funzione
dev.off()
# se volessi cambiare cartella di salvataggio cabio il path
# con la funzione png ottengo la stessa ma con una risoluzoone minore
png("banda1.pdf")
plot (l2011$B1_sre, col= clb)
dev.off()
# se vogliamo esportare un immagine e non il plot usiamo la funzione writeRaster in cui si esporta tutto il dataset
# plottiamo più immagini insieme, plottando insieme la banda del blu e del verde ma prima plottiamo la banda del verde (b2) con una nuova scala di colori.
clg <- colorRampPalette(c("darkgreen", "green", "light green")) (100)
plot (l2011$B2_sre, col= clg)
# ora mettiamo insieme le due bande del blu e del verde (b1 e b2)
# utiliazziamo la funzione par per definire il multiframe
par (mfrow= c(1,2))
plot (l2011$B1_sre, col= clb)
plot (l2011$B2_sre, col= clg)
# per chiudere la finestra non utilizzando il mouse si utilizza la funzione dev.off()
# per esportare un pdf del mio multiframe
# export multiframe plot
pdf("multiframe.pdf")
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
dev.off()
# esercizio: revert the multiframe ovvero vogliamo fare un plot con il blu sopra e il verde sotto quindi ragionando in termini di righe e colonne nel par quindi in questo caso par(mfrow=c(2,1)).
par(mfrow=c(2,1))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
# applichiamo la stessa funzione utilizzando tutte le 4 bande

# let's plot the first four bands
par(mfrow=c(2,2))
# blue
plot(l2011$B1_sre, col=clb) 
# green
plot(l2011$B2_sre, col=clg) 
# red
clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(l2011$B3_sre, col=clr)
# NIR
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011$B4_sre, col=clnir)

# installiamo il pacchetto RStoolbox
install.packages("RStoolbox")
  # plot of l2011 in the NIR channel (dove la vegetazione ha un'alta riflettanza)
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011$B4_sre, col=clnir)
# oppure posso plottare in un altro modo:
plot (l2011[[4]])
# quando plotto un immagine satellitare posso utilizzare solo tre bande per volta (in questo caso RGB)
# per costruire un immagine satellitare montiamo le tre bande del rosso verse e blu attraverso la funzione plotRGB
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
# abboamo ottenuto un immagine a colori naturali
# ora utilizziamo l'infrarosso naturale ma potendo solo utilizzare solo 3 bande insiem metteremo al posto del 3 il 4 al posto del 2 il 3 e al posto del 1 il 2, la banda del blu resta fuori e posso utilizzare la banda dell infrarosso
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")
# cosi avremo non i colori che vede l'uomo ma tutto quello che rilfette all'infrarosso vicino diventerà di colore rosso.
# tutto il rosso è vegetazione
#ora porvo a spostare l'infrarosso nella componente green
plotRGB(l2011, r=3, g=4, b=2, stretch="lin")
# tutto quello che rifletterà nell'infrarosso vicino diventrà verde fluorescente
#provo a passare l'infrarosso anche nel blu e la vegetazione diventerà blu
 plotRGB(l2011, r=3, g=2, b=4, stretch="lin")
# usiamo hist invece di lin è notiamo un alta differenzazione nelle colorazioni, ora si nota tutta la differenziazione nella foresta
plotRGB(l2011, r=3, g=4, b=2, stretch="hist")
# esercizio: build a multiframe (insieme di più immagini) with visible RGB 
# (linear stretch) on top of false colours 
# (histogram stretch)
par(mfrow=c(2,1))
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="hist")

# ora proviamo a caricare la foto del 1988 facedno la stessa operazione eseguita per caricare la foto l2011
l1988 <- brick ("p224r63_1988.grd")
plot(l1988)
# facciamo un multiframe anche per il 1988
par (mfrow=c(2,1))
plotRGB(l1988, r=4, g=3, b=2, stretch="lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")

