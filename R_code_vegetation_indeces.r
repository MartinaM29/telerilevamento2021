### R_code_vegetation_indeces.r ###

# una pianta riflette molto nell'infrasso vicino mentre assorbe molto la radiazione rossa

library(raster) # require(raster)
library(RStoolbox) # for vegetation indices calculation
# install.packages("rasterdiv")
library(rasterdiv) # for the worldwise NDVI
# install.packages("rasterVis")
library(rasterVis)


#setwd("~/lab_telerilevamento/") # Linux
setwd("C:/lab_telerilevamento/") # Windows
#setwd("/Users/name/Desktop/lab/") # Mac


# immagini dall'Eart Observatory della NASA, immagine già processate

## caricamento delle immagini (caricamento dell'intero pacco dei dati)
defor1<-brick("defor1.jpg")
defor2<-brick("defor2.jpg")

## B1 = NIR, B2 = red, B3 = green

par(mfrow=c(2,1))
plotRGB(defor1,r=1,g=2,b=3,stretch="lin")
plotRGB(defor2,r=1,g=2,b=3,stretch="lin")

