# R code using colorist's package

install.packages("colorist")
library(colorist)
library(ggplot2) # Colorist work through ggplot

# Time series field sparrow
data("fiespa_occ")
fiespa_occ 
## class      : RasterStack 
## dimensions : 193, 225, 43425, 12  (nrow, ncol, ncell, nlayers)
## resolution : 14814.03, 14814.04  (x, y)
## extent     : -1482551, 1850606, -1453281, 1405830  (xmin, xmax, ymin, ymax)
## crs        : +proj=laea +lat_0=38.7476367322638 +lon_0=-90.2379515912106 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0 
## names      :       jan,       feb,       mar,       apr,       may,       jun,       jul,       aug,       sep,       oct,       nov,       dec 
## min values :         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0 
## max values : 0.8538026, 0.8272926, 0.7993844, 0.7805922, 0.7799550, 0.7745436, 0.7626938, 0.7867995, 0.7790458, 0.7896419, 0.8158410, 0.8681034 

# The workflow using colorist package:
# 1. metrics
# 2. palettes
# 3. maps
# 4. legends


# metrics
met1 <- metrics_pull(fiespa_occ)

# palette
pal <- palette_timecycle(fiespa_occ)

# maps: 
map_multiples(met1, pal, ncol=3, labels=names(fiespa_occ))

# maps: to visualize a single layer
map_single(met1, pal, layer=6)

# Custom palette
p1_custom <- palette_timecycle(12, start_hue=60)

map_multiples(met1, p1_custom , ncol=3, labels=names(fiespa_occ))

# Creation of the distilled map
met1_distill <- metrics_distill(fiespa_occ)
map_single(met1_distill, pal)


# Using the custom palette
map_single(met1_distill,p1_custom)

# Legend
legend_timecycle(pal, origin_label="1 jan")


# Example: Pekania penna
data("fisher_ud")
met2 <- metrics_pull(fisher_ud)
pal2 <- palette_timeline(fisher_ud)
head(pal2) # colore restituito come esadecimale, per capire il colore esiste un convertitore da esadecimale a RGB e viceversa
# https://toolset.mrw.it/web-design/hex-to-rgb.html

# Multiple maps
map_multiples(met2, pal2, ncol=3, lambda_i=-12)

# Distilled map: I visualize the movements of this mammal
met2_distill <- metrics_distill(fisher_ud)
map_single(met2_distill, pal2, lambda_i=-10)

# Legend
legend_timeline(pal2)
