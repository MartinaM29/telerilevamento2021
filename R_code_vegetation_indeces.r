### R_code_vegetation_indeces.r ###

# una pianta riflette molto nell'infrasso vicino mentre assorbe molto la radiazione rossa

library(raster) # require(raster), funzione require fa la sessa cosa di library
library(RStoolbox) # for vegetation indices calculation
# install.packages("rasterdiv")
library(rasterdiv) # for the worldwise NDVI
# install.packages("rasterVis")
library(rasterVis)


#setwd("~/lab_telerilevamento/") # Linux
setwd("C:/lab_telerilevamento/") # Windows
#setwd("/Users/name/Desktop/lab/") # Mac


# immagini dall'Eart Observatory della NASA, immagine già processate
#  https://earthobservatory.nasa.gov/

## caricamento delle immagini (caricamento dell'intero pacco dei dati)
## B1 = NIR, B2 = red, B3 = green
defor1<-brick("defor1.jpg")
# class      : RasterBrick 
# dimensions : 478, 714, 341292, 3  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 714, 0, 478  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : defor1.jpg 
# names      : defor1.1, defor1.2, defor1.3 
# min values :        0,        0,        0 
# max values :      255,      255,      255 
defor2<-brick("defor2.jpg")
# class      : RasterBrick 
# dimensions : 478, 717, 342726, 3  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 717, 0, 478  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : defor2.jpg 
# names      : defor2.1, defor2.2, defor2.3 
# min values :        0,        0,        0 
# max values :      255,      255,      255 

par(mfrow=c(2,1))
plotRGB(defor1,r=1,g=2,b=3,stretch="lin")
plotRGB(defor2,r=1,g=2,b=3,stretch="lin")

# anche il fiume se ha colori diversi indica probabilmente una differente quantità di solidi disciolti


## DVI (difference vegetation index) : -255 <= DVI <= 255 (per immagine a 8 bit => da 2^8=256, range 0;255)
## il DVI è la differenza tra la riflettanza del NIR e la riflettanza del RED ad esempio (DVI=NIR-RED)
## NDVI normalizza questo indice dividento il DVI per NIR+RED (NDVI=DVI/(NIR+RED))
# DVI per defor1
DVI1<-defor1$defor1.1-defor1$defor1.2 #b1-b2-> DVI=NIR-RED
plot(DVI1)
cl<-colorRampPalette(c('darkblue','yellow','red','black'))(100) #specifying a color scheme
plot(DVI1,col=cl,main="DVI in time 1")
# DVI per defor2
DVI2<-defor2$defor2.1-defor2$defor2.2 #b1-b2-> DVI=NIR-red
plot(DVI2)
plot(DVI2,col=cl,main="DVI in time 2")
par(mfrow=c(2,1))
plot(DVI1,col=cl,main="DVI in time 1")
plot(DVI2,col=cl,main="DVI in time 2")
# NB: all'occhio umano risalta molto il colore giallo

# per ogni pixel DVI1-DVCI2
# 
difDVI<-DVI1-DVI2 #warning:Raster objects have different extents
cld<-colorRampPalette(c('blue','white','red'))(100)
plot(difDVI,col=cld)
#identifichiamo in che aree c'è stata sofferenza (nel nostro cosa deforestazione)






