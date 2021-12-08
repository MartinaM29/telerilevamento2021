#R_code_land_cover.r

library(raster)
library(RStoolbox) # per la classificazione
# install.packages("ggplot2") = è una libreria che permette la visualizzazione
library(ggplot2)
# install.packages("gridExtra") = libreria che 
library(gridExtra)

# setwd("~/lab_telerilevamento/") # Linux
setwd("C:/lab_telerilevamento/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

# dati dell'Earth Observatory della foresta Amazzonica, già stati analizzati
# NIR 1, RED 2, GREEN 3
defor1<-brick("defor1.jpg") # brick per caricare l'intero dataset (tutte le bande del dataset), all'interno della libreria raster
plotRGB(defor1,r=1, g=2,b=3, stretch="lin")

## ggR function = all'interno del placchetto ggplot c'è la possibilità di plottare file raster in maniera più "accattivante"
ggRGB(defor1, r=1,g=3,b=3,stretch="lin")
# in questo modo vengono anche plottate le coordinte del raster (nel nostro caso sono semplicemente coordinate immagine)

defor2<-brick("defor2.jpg")
plotRGB(defor2,r=1, g=2,b=3, stretch="lin")
ggRGB(defor2, r=1,g=3,b=3,stretch="lin") 

par(mfrow=c(2,1))
plotRGB(defor1,r=1, g=2,b=3, stretch="lin")
plotRGB(defor2,r=1, g=2,b=3, stretch="lin")

## par con ggplot non funziona si utilizza la funzione dedicata grid.arrange (in gridExtra)
# questa funzione compone il multiframe di ggplot
# viene dato un nome a ciascun plot (es. plot1, plot2, etc.)
p1<-ggRGB(defor1, r=1,g=3,b=3,stretch="lin")
p2<-ggRGB(defor2, r=1,g=3,b=3,stretch="lin")
grid.arrange(p1,p2,nrow=2)
