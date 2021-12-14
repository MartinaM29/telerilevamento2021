#R_code_land_cover.r

library(raster)
library(RStoolbox)
#install.packages("ggplot2")
library(ggplot2)
#install.packages("gridExtra")
library(gridExtra)

#setwd("~/lab_telerilevamento/") # Linux
setwd("C:/lab_telerilevamento/") # Windows
#setwd("/Users/name/Desktop/lab/") # Mac


defor1<-brick("defor1.jpg") #brick carica l'intero dataset
plotRGB(defor1,r=1,g=2,b=3,stretch="lin")
ggRGB(defor1,r=1,g=2,b=3,stretch="lin")

defor2<-brick("defor2.jpg")
plotRGB(defor2,r=1,g=2,b=3,stretch="lin")
ggRGB(defor2,r=1,g=2,b=3,stretch="lin")

par(mfrow=c(1,2))
plotRGB(defor1,r=1,g=2,b=3,stretch="lin")
plotRGB(defor2,r=1,g=2,b=3,stretch="lin")

#grafici multipli per ggplot (multiframe with ggplot2 and grid extra)
p1<-ggRGB(defor1,r=1,g=2,b=3,stretch="lin")
p2<-ggRGB(defor2,r=1,g=2,b=3,stretch="lin")
grid.arrange(p1,p2,nrow=2)


#classificazione, unsupervised
#classi: un paio per facilitare l'esercizio, ma sono a libera scelta
#una per la foresta amazzonica e una agricola
d1c<-unsuperClass(defor1,nClasses=2)
#set.seed() would allow you to attain the same results
d1c
plot(d1c$map)

d2c<-unsuperClass(defor2,nClasses=2)
d2c
plot(d2c$map)
#3 classes
d2c3<-unsuperClass(defor2,nClasses=3)
d2c3
plot(d2c3$map)

# quanta foresta è stata persa?
# quanti pixel ci sono in u na classe (frequenza)
freq(d1c$map)
# value  count
#[1,]     1 305615
#[2,]     2  35677

# sommavalori
sum1<-305615+35677
# proporzione
prop1<-freq(d1c$map)/sum1#freq precedente/tot
# value     count
#[1,] 2.930042e-06 0.8954649
#[2,] 5.860085e-06 0.1045351

#seconda mappa
defor2
freq(d2c$map)
sum2<-342726
prop2<-freq(d2c$map)/sum2
# value     count
#[1,] 2.917783e-06 0.4780145
#[2,] 5.835565e-06 0.5219855

#per fare le % basta moltiplicare la prop *100

#generazione di un dataframe
#prima colonna di fattori, cover (forest and agriculture)
#% iniziale di inizio (anni 92-06) -> % 1992
#% 2006
cover<-c("Forest","Agriculture")
percent_1992<-c(89.54,10.45)
percent_2006<-c(47.80,52.19)
percentages<-data.frame(cover,percent_1992,percent_2006)
percentages

p1<-ggplot(percentages,aes(x=cover,y=percent_1992,color=cover))+geom_bar(stat="identity",fill="white")
p2<-ggplot(percentages,aes(x=cover,y=percent_2006,color=cover))+geom_bar(stat="identity",fill="white")
grid.arrange(p1,p2,nrow=1) #dal pacchetto gridExtra


### classificazione unsupervised (non supervisionata da noi, fa il software in automatico)
# se si vogliono fare analisi specifiche sulla vegetazione bisogna utilizzare immagini a più bande
# questo perchè le diverse specie riflettono le bande in modo diverso
# formmando dei picchi nella lunghezza della banda che più riflettono
# ottenendo un grafico x-y con vari punti che identificano le proprie riflettanze, che possono essere così classificate

# iniziamo con 2 classi
d1c<-unsuperClass(defor1,nClasses=2)
d1c
# unsuperClass results
# 
# *************** Map ******************
# $map
# class      : RasterLayer 
# dimensions : 478, 714, 341292  (nrow, ncol, ncell)
# resolution : 1, 1  (x, y)
# extent     : 0, 714, 0, 478  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : memory
# names      : layer 
# values     : 1, 2  (min, max)
plot(d1c$map)
# i valori intermedi che escono in legenda in realtà non hanno senso, i valori reali sono chiaramente 1 e 2 ad indicare le due classi
d2c<-unsuperClass(defor2,nClasses=2)
plot(d2c$map)
# 3 classi
d1c<-unsuperClass(defor1,nClasses=3)
plot(d1c$map)
d2c<-unsuperClass(defor2,nClasses=3)
plot(d2c$map)
# set.seed() è una funzione che aiuta ad ottenre lo stesso risultato per la classificazione

par(mfrow=c(2,2))
plotRGB(defor1,r=1,g=2,b=3,stretch="lin")
plot(d1c$map)
plotRGB(defor2,r=1,g=2,b=3,stretch="lin")
plot(d2c$map)

## frequenza pixel di ogni classe, con funzione freq
freq(d1c$map)
#  value  count
# [1,]     1  41594 -> agricolo
# [2,]     2 288332 -> foresta
# [3,]     3  11366 -> fiume
freq(d2c$map)
# value  count
# [1,]     1 104885 -> agricolo
# [2,]     2  84116 -> fiume+foresta
# [3,]     3 153725 -> foresta
# NB: le classi segnate possono variare
## proporzione
somma1<- 41594+288332+11366 # somma pixel, NB: info contenuta anche nelle info dell'immagine originale
prop1<-freq(d1c$map)/somma1
# value      count           -> non considerare value
# [1,] 2.930042e-06 0.12187218
# [2,] 5.860085e-06 0.84482496
# [3,] 8.790127e-06 0.03330286
somma2<-104885+84116+153725
prop2<-freq(d2c$map)/somma2
#  value     count
# [1,] 2.917783e-06 0.3060316
# [2,] 5.835565e-06 0.2454322
# [3,] 8.753348e-06 0.4485361

# # percentuali
perc1<-prop1*100
perc2<-prop2*100

### generazione di un dataset, in R chiamato dataframe
# in una prima colonna mettiamo i fattori (variabili categoriche) = la foresta e l'agricoltura -> cover
# nella 2colonna mettiamo la percentuale di pixel nel 1992
# nella 3 i valori % nel 2006
cover<-c("forest","agriculture","river")
percent_1992<-c(84.48,12.18,3.33)
percent_2006<-c(44.8,30.60,24.54)
data<-data.frame(cover,percent_1992,percent_2006) # funzione di creazione del dataframe
# plot con funzione ggplot
# aes = estetiche
# color = discriminazione oggetti (legenda)
# geom_bar = da grafiche a barre
# stat="identity" = statistica identica, già quella li
plot1<-ggplot(data,aes(x=cover,y=percent_1992,color=cover))+geom_bar(stat="identity",fill="white")
plot2<-ggplot(data,aes(x=cover,y=percent_2006,color=cover))+geom_bar(stat="identity",fill="white")
grid.arrange(plot1,plot2,nrow=1)
