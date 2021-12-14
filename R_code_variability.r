### R_code_variability.r


library(raster)
library(RStoolbox)

# setwd("~/lab/") # Linux
setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

## funzioni per caricare le immagini
# raster per catturare solo il primo strato
# brick per caricare tutto il pacchetto
# l'immagine che useremo ha 3 livelli
# NIR=1, RED=2, GREEN=3
sentinel<-brick("sentinel.png")
plotRGB(sentinel,r=1,g=2,b=3,stretch="lin")
# plotRGB(sentinel,stretch="lin") # si possono omettere le bande perchè uguali al default in questo caso
plotRGB(sentinel,r=2,g=1,b=3,stretch="lin")

## dobbiamo inserire la moving window 3x3 nel livello dell'immagine
# per individuare la deviazione standard
# la deviazione standard viene inserita nel pixel centrale della moving windows, dopo di che si sposta di pixel e ricalcola 
# si ottiene una nuova mappa così creata 
# cambiando le dimensioni della finestra più la deviazione risulterà diversa

## bisogna compattare il set di dati in un solo strato
# uno per esempio di un indice di vegetazione (NDVI)
sentinel
# class      : RasterBrick 
# dimensions : 794, 798, 633612, 4  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 798, 0, 794  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : sentinel.png 
# names      : sentinel.1, sentinel.2, sentinel.3, sentinel.4 -> lo strato 4 l'ha creato al momento dell'inserimento in R
# min values :          0,          0,          0,          0 
# max values :        255,        255,        255,        255 

nir<-sentinel$sentinel.1
red<-sentinel$sentinel.2
ndvi<-(nir-red)/(nir+red)
plot(ndvi)

cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) 
plot(ndvi,col=cl)

## calcolo variabilità
# funzione focal, all'interno del pacchetto raster, nell'intorno della moving window calcola le statistiche
ndvisd3<-focal(ndvi,w=matrix(1/9,nrow=3,ncol=3),fun=sd) #l'argomento w è la window, in questo caso
# matrix perchè la finestra è una matrice, con 1/9 si indicano i pixel, in questo caso 9 e vengono considerati ogni pixel, per questo 1
# sd = deviazione standard
plot(ndvisd3)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)  
plot(ndvisd3, col=clsd)

# la dev_stand è più bassa nella roccia nuda dove infatti c'è più omogeneità

## calcolo media
ndvimean3<-focal(ndvi,w=matrix(1/9,nrow=3,ncol=3),fun=mean)
plot(ndvimean3)
plot(ndvimean3, col=clsd)
# valori alti nelle praterie di alta quota, nei boschi
# valori bassi nella roccia nuda

## cambio dimensione finestre, importante che sia di numero dispari
ndvisd15<-focal(ndvi,w=matrix(1/225,nrow=15,ncol=15),fun=sd)
plot(ndvisd15, col=clsd)

## altra tecnica per compattare i dati
# utilizzo delle principal component -> analisi multivariata
# funzione rasterPCA, nel pacchetto RStoolbox
sentpca<-rasterPCA(sentinel)
plot(sentpca$map) # ricorda che il 4 livello non ha senso
summary(sentpca$map) # per vedere quanta variabilità spiegano le singole componenti
# è ovvio che la prima componente spieghi di più perchè è proprio quella nell'asse con più variabilità, gli altri assi sono ortogonali ad esso
#                 [,1]        [,2]        [,3] [,4]
# Min.    -227.112386 -106.486268 -74.6047951    0
# 1st Qu.  -46.986159  -38.491732  -2.8424694    0
# Median    -3.031515   -7.414764   0.4003749    0
# 3rd Qu.   57.386021   31.877757   3.4832835    0
# Max.     133.487197  155.879910  51.5674399    0
# NA's       0.000000    0.000000   0.0000000    0







