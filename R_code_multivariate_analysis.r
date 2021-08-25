### R_code_multivariate_analysis.r ###

# per immagini con 100aia di bande, per esempio quelle provenienti dal sensore Apex, 
# per compattare questo tipo di immagini

# utilizzare una banda che "spiega" una vairanza/variabilità maggiore
# componente prinicpale = componente che fa vedere la maggior variabilità del sistema -> primo asse
# il secondo asse viene fatto passare perpendicolarmente al primo
# in questo modo, con la creazione di questi due nuovi assi, fa si che sull'asse principale ci sia la maggior variabilità (90%)
# sul secondo ci sarà la restante variabilità (10%)
# in questo modo si puù utilizzare per l'analisi solo l'asse principale perchè già ci fa vedere il 90% delle informazioni
# questo permette quindi di ridurre il sistema da 2 bande ad 1 banda
# PCA (Principal Component Analysis)

## sono utilizzati per l'analisi i dati Landsat utilizzati anche nel codice "R_code_remote_sensing_temp.r"

# install.packages("raster")
library(raster)
# install.packages("RStoolbox")
library(RStoolbox)


# setwd("~/lab_telerilevamento/") # Linux
setwd("C:/lab_telerilevamento/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac 


## caricamento file, le immagini Landsat hanno 7 bande
# Bande Landsat
# B1: blue 
# B2: green
# B3: red
# B4: NIR (NB:infrarosso vicino, vicino perchè è vicino alla parte visibile dell'occhio umano)
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

p224r63_2011<-brick("p224r63_2011_masked.grd") #brick carica tutto il set, mentre raster unn pacchetto per volta
p224r63_2011

# class      : RasterBrick 
# dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
# resolution : 30, 30  (x, y)
# extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax)
# crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
# source     : p224r63_2011_masked.grd 
# names      :       B1_sre,       B2_sre,       B3_sre,       B4_sre,       B5_sre,        B6_bt,       B7_sre 
# min values : 0.000000e+00, 0.000000e+00, 0.000000e+00, 1.196277e-02, 4.116526e-03, 2.951000e+02, 0.000000e+00 
# max values :    0.1249041,    0.2563655,    0.2591587,    0.5592193,    0.4894984,  305.2000000,    0.3692634 


plot(p224r63_2011)

## plottiamo i valori della banda 1 contro i valori della banda 2
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red",pch=19, cex=2) # pch = carattere del punto, cex è l'ingrandimento del punto
# si vede come le due bande sono correlate fra di loro (multi-correlatività)

# funzione pairs -> plotta tutte le correlazioni possibili tra tutte le variabili
# mettendo in relazioni a due a due le variabili a disposizione, nel nostro caso le bande
pairs(p224r63_2011)

# indice di correlazione di Pearson (-1:1) indice che valuta la correlazione tra due variabili (1 = correlazione perfetta)
# R da anche unna dimensione del carattere proporzionale al coefficiente di Pearson

## ricampionamento dataset (resampling)
# PCA (Principal Component Analysis), è un'analisi molto impattante, pertanto viene ricampionato il dato
# risoluzione originaria 30x30 x e y
# pixel per ogni banda =  4447533, per un totale di 4447533*7 =  31132731 pixel

p224r63_2011_res<-aggregate(p224r63_2011, fact=10) # banda per banda riduciamo la risoluzione, aumentiamo quindi la dimensione del pixel
p224r63_2011_res

# class      : RasterBrick 
# dimensions : 150, 297, 44550, 7  (nrow, ncol, ncell, nlayers)
# resolution : 300, 300  (x, y) -> da 30*30 a 300*300 (aumento fattore 10m)
# extent     : 579765, 668865, -522735, -477735  (xmin, xmax, ymin, ymax)
# crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
# source     : memory
# names      :       B1_sre,       B2_sre,       B3_sre,       B4_sre,       B5_sre,        B6_bt,       B7_sre 
# min values :   0.00670000,   0.01580000,   0.01356544,   0.01648527,   0.01500000, 295.54400513,   0.00270000 
# max values :   0.04936299,   0.08943339,   0.10513023,   0.43805822,   0.31297142, 303.57499786,   0.18649654 

# confronto tra l'immagine originale con risoluzione 30*30 e l'immagine ricampionata con risoluzione 300*300
par(mfrow=c(2,1))
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="lin")
plotRGB(p224r63_2011_res,r=4,g=3,b=2,stretch="lin")


## PCA
p224r63_2011_res_PCA<-rasterPCA(p224r63_2011_res) # prende il pacchetto di dati e lo compatta in un numero minore di bande
# la funzione fa parte del pacchetto RStoolbox
# questo file contiene la mappa, il modello, etc.
summary(p224r63_2011_res_PCA$model) # funzione generica, da un sommario, per esempio del modello

# Importance of components:
#                            Comp.1      Comp.2       Comp.3       Comp.4
# Standard deviation     1.2050671 0.046154880 0.0151509526 4.575220e-03
# Proportion of Variance 0.9983595 0.001464535 0.0001578136 1.439092e-05
# Cumulative Proportion  0.9983595 0.999824022 0.9999818357 9.999962e-01
#                              Comp.5       Comp.6       Comp.7
# Standard deviation     1.841357e-03 1.233375e-03 7.595368e-04
# Proportion of Variance 2.330990e-06 1.045814e-06 3.966086e-07
# Cumulative Proportion  9.999986e-01 9.999996e-01 1.000000e+00
# Proportion of Variance = variabilità del sistema, si vede che solo la banda 1 spiega il 99% del sistema

plot(p224r63_2011_res_PCA$map)
# da questo grafico ci aspettiamo una componente con tente informazioni ed un ultima con pochissime informazioni

p224r63_2011_res_PCA

# $call -> funzione usata infatti raster PCA come scritto sotto
# rasterPCA(img = p224r63_2011_res)
#
# $model -> modello
# Call:
# princomp(cor = spca, covmat = covMat[[1]])
#
# Standard deviations:
#       Comp.1       Comp.2       Comp.3       Comp.4       Comp.5       Comp.6 
# 1.2050671158 0.0461548804 0.0151509526 0.0045752199 0.0018413569 0.0012333745 
#       Comp.7 
# 0.0007595368 
# 
#  7  variables and  44550 observations.
#
# $map -> mappa
# class      : RasterBrick 
# dimensions : 150, 297, 44550, 7  (nrow, ncol, ncell, nlayers)
# resolution : 300, 300  (x, y)
# extent     : 579765, 668865, -522735, -477735  (xmin, xmax, ymin, ymax)
# crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
# source     : memory
# names      :         PC1,         PC2,         PC3,         PC4,         PC5,         PC6,         PC7 
# min values : -1.96808589, -0.30213565, -0.07212294, -0.02976086, -0.02695825, -0.01712903, -0.00744772 
# max values : 6.065265723, 0.142898435, 0.114509984, 0.056825372, 0.008628344, 0.010537396, 0.005594299 
#
#
# attr(,"class")
# [1] "rasterPCA" "RStoolbox"

# plottaggio delle prime 3 componenti, quelle con più informazioni
plotRGB(p224r63_2011_res_PCA$map,r=1,g=2,b=3,stretch="lin")

# le immagine di Open Data Cube hanno 100aia di bande

## plottaggio singole componenti una contro l'altra, per vedere se c'è correlazione
plot(p224r63_2011_res_PCA$map$PC1, p224r63_2011_res_PCA$map$PC2)
# in questo caso non c'è correlazione
# ci sono modelli, per esempio, che come assunto di base le variabili non devono essere correlate

# str funzione che da info dettagliate su tutto il file

