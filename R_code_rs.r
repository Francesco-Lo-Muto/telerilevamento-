# This is my first script

# Install.packages ("raster") 
library (raster)

# Setting working directory within path "C"
setwd("C:/lab/") # windows

# Through the brick function I can import the image from the downloaded package, then I assign "l2011" name to make subsequent work easier
l2011 <- brick ("p224r63_2011.grd") 

# I plot my first picture by using plot function
plot(l2011)

# ColorRampPalette () # it's a function that creates a colour scale
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
# To tie the bands to a satellite images or tie objects together I can use dollar symbol
# Another way to do the same is writing the position of the elements. each number matches a colour band, in this case the blue band matches the first element "[[1]]"
# The element is a list of data. The elements in R, are enclosed in double square brackets, for example "[[3]], [[1]]".
plot (l2011[[1]])
# The two methods are the same, but there are pros and cons. the advantage of writing the name is that i can see what I'm plotting
plot (l2011[[1]])
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
plot (l2011$B1_sre, col= cl)
# Plot b1 from dark blue to blue to light blue
clb <- colorRampPalette(c("darkblue", "blue", "light blue")) (100)
plot (l2011$B1_sre, col= clb)
# Plot b1 with a blue scale, I renamed cl in clb to indicate that is it a blue scale. 
# I can export a pdf in a lab folder through pdf function, for example "file.pdf". I will use double quotes to indicate that I am exiting from R
pdf("banda1.pdf")
plot (l2011$B1_sre, col= clb)
# To close a virtual window i can use dev.off() function. In this case i can close my pdf file with this function.
dev.off()
# I will change the path if I want to save the file elsewhere
# Through png function i will get the same result but with a lower resolution
png("banda1.pdf")
plot (l2011$B1_sre, col= clb)
dev.off()
# To export full dataset I can use writeRaster fuction.
# I can plot more bands together but first I will plot the green band (b2) in a new colours scale.
# Plot b2 from darkgreen to green to light green
clg <- colorRampPalette(c("darkgreen", "green", "light green")) (100)
plot (l2011$B2_sre, col= clg)
# Now I can tie the blue(b1) and the green(b2) band together
# To define a multiframe i can use par fuction
par (mfrow= c(1,2))
plot (l2011$B1_sre, col= clb)
plot (l2011$B2_sre, col= clg)
# To close the window without using the mouse I will use dev.off() function
# Through pdf function I can export multiframe plot
pdf("multiframe.pdf")
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
dev.off()
# Exercice: revert the multiframe. In this case: par(mfrow=c(2,1)).
par(mfrow=c(2,1))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
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

# Install RStoolbox package
install.packages("RStoolbox")
# Plot of l2011 in the NIR channel (here vegetation has high riflectance)
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011$B4_sre, col=clnir)
# Another way to plot:
plot (l2011[[4]])
# When I plot a satellite image i can only use three images at a time.
# To build a satellite image I have to mount the three bands (red, green, blue) through plotRGB function
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
# I got a natural color image
# Now I use natural infrared but i can utilize only three band at a time. I will put in the place of red band the natural infrared, in the place of green band the red band and in the place of blue band the green band.
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")
# I dont'have the colours that a man usually see but everything that reflects in the near infrared will become red
# Everything that is red is vegetation
# I try to move the infrared in the place of green
plotRGB(l2011, r=3, g=4, b=2, stretch="lin")
# Everything reflects near infrared will become fluorescent green
# In this case I try to move the infrared in the place of blue and vegetation will become blue
 plotRGB(l2011, r=3, g=2, b=4, stretch="lin")
# I use hist in the place of lin to note an high differentation in the forest
plotRGB(l2011, r=3, g=4, b=2, stretch="hist")
# Exercise: build a multiframe with visible RGB 
# (linear stretch) on top of false colours 
# (histogram stretch)
par(mfrow=c(2,1))
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="hist")

# Now I upload the 1988 photo using the same procedure performed to upload 2011 photo
l1988 <- brick ("p224r63_1988.grd")
plot(l1988)
# build multiframe for 1988
par (mfrow=c(2,1))
plotRGB(l1988, r=4, g=3, b=2, stretch="lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")

