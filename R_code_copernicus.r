### R_code_copernicus.r ###

## visualizzazione dati da Copernicus, file 1: Water Lavel, V2, data 12/10/1992
# file 2: Soil Water Index
# file 3: Lake Water Quality, 300 m, data 11/07/21

#install.packages("raster")
library(raster)
#install.packages("ncdf4")
library(ncdf4)

#setwd("~/lab_telerilevamento/") # Linux
setwd("C:/lab_telerilevamento/") # Windows
#setwd("/Users/name/Desktop/lab_telerilevamento/") # Mac

# inserimento file scaricato, funzione raster perchè è un solo layer
WL<-raster("c_gls_WL_202108020049_0000000000000_ALTI_V2.1.0.json")
# il formato .json da errore -> deve essere.nc !!!!

# quindi si è usato il file
SWI<-raster("c_gls_SWI_202104131200_GLOBE_ASCAT_V3.1.1.nc")
SWI
# gli warnings sono prinicpalmente dovuti al sistema di riferimento non impostato, ma R si riasseta da solo

# possiamo scegliere noi la scala di colori
cl<-colorRampPalette(c('blue','green','red','yellow'))(100)
plot(SWI, col=cl, main="Soil Water Index")

# il dato può essere ricampionato (diminuendo la risoluzione dei pixel)
# funzione aggregate
# il fattore è il determinante dell'aggregazione
SWI_aggr<-aggregate(SWI,fact=100,main="SWI aggregato") # linearmente si prendono 100*100 pixel e si uniscono in uno solo
plot(SWI_aggr,col=cl) #ricampionamento molto pesante!






















