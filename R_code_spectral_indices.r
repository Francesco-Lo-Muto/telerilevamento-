library(raster)
install.packages("rgdal")
library(rgdal)
# Recall library raster
# Setting my windows working directory
setwd("C:/lab/")

# Import the first file -> defor1_1.jpg -> give it the name l1992
l1992 <- brick("defor1_.jpg")
# Plot the image to understand what bands are contained
plotRGB(l1992, r=1, g=2, b=3, stretch= "lin")
# The vegetation reflects the infrared very much, the first band is NIR
# layer 1= NIR
# layer 2= red
# layer 3= green

# I replay the same procedure to import the second file -> defor2_.jpg -> give it the name l2006. 
l2006 <- brick("defor2_.jpg")
plotRGB(l2006, r=1, g=2, b=3, stretch= "lin")
# Excercise: plot in a multiframe the two images

par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# DVI differecne vegetation index, is the difference between near infrared and red
dvi1992 = l1992 [[1]] - l1992 [[2]]

# Plot 1992 image
dvi1992
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot (dvi1992, col =cl)
# Same procedure for 2006
dvi2006 = l2006[[1]] - l2006[[2]]

# Plot 2006 image
dvi2006
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot (dvi2006, col =cl)

# DVI difference between 1992-2006
dvi_dif = dvi1992 - dvi2006
cld <- ColorRampPalette(c('blue', 'white', 'red'))(100)
# I use dev.off() to close previous window
dev.off()
#Plot dvi_diff with new ColorRampPaeltte
plot (dvi_dif, col =cld)
# Another way to calculate dvi index is by name

# NDVI is done to standardize the index
# Range DVI (8 bit): -255 a 255                                                                      
# Range NDVI (8 bit): -1 a 1 
# In an 8 bit image I have 256 values while in a 16 bit image I have 65535
# Range DVI (16 bit): -65535 a 65535                                                                       
# Range NDVI (16 bit) : - 1 a 1
# In both photos NDVI range is the same so if I have the same value I can make comparisons. It can be used with images with different radiometric resolution (how many bits are available within an image).
# Upload through brick function (which loads a whole block of bands) the 1992 photo                                                                        
l1992 <- brick("defor1_.jpg")     
# With the same procedure I upload the 2006 photo
l2006 <- brick("defor2_.jpg")                                                                        
# To calcolate DVI index I can use name o elements
dvi1992 = l1992[[1]] - l1992[[2]]
# Now I calculate NDVI index:
ndvi1992 = dvi1992 / (l1992[[1]] + l1992[[2]])
# or
ndvi1992 = (l1992[[1]] - l1992[[2]] / (l1992[[1]] + l1992[[2]])
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
# Plot ndvi1992            
plot (ndvi1992, col =cl) 
# Multiframe with plotRGB on top of the NDVI image
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin") 
plot (ndvi1992, col =cl)                                                                         
# The same procedure to 2006 photo                                                                      
dvi2006 = l2006[[1]] - l2006[[2]]                                                                   
ndvi2006 = dvi2006 / (l2006[[1]] + l2006[[2]])   
# Multiframe with NDVI1992 on top of the NDVI2006 image            
par(mfrow=c(2,1))
plot (ndvi2006, col =cl)   
plot (ndvi1992, col =cl)                                                                         

library (RStoolbox)      
# Inside RStoolbox there is an important function: spectralIndices 
# SpectralIndices: Calculate a suite of multispectral indices such as NDVI, SAVI etc.            
si1992 <- spectralIndices(l1992, green=3, red=2, nir=1)
plot(si1992,col=cl)                                                                      
# It gives us all possible computable indices for an image.                                                                     
# Same procedure to 2006
si2006 <- spectralIndices(l1992, green=3, red=2, nir=1)
plot(si2006,col=cl)                                                                        
install.packages("rasterdiv")                                                                        
library(rasterdiv)                                                                       
plot (copNDVI)                                                                        
                                                                        
