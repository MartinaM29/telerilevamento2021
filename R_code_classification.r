### R_code_classification.r ###


# install.packages("raster")
library(raster)
# install.packages("RStoolbox")
library(RStoolbox)


# setwd("~/lab_telerilevamento/") # Linux
setwd("C:/lab_telerilevamento/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac


# download file di esercizio
# Solar Orbiter Data
# https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(sortBy)/view_count/(result_type)/images
# l'immagine è a bande RGB (immagine già elaborata)
# caricamneto in R dell'immagine attraverso la funzione brick, interna alla libreria raster
# brick richiama il pacchetto di dati in R e crea un "rasterbrick" un insieme di dati di riferimento
SO<-brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
SO
# visualizzazione livelli RGB dell'immagine
plotRGB(SO,r=1,g=2,b=3,stretch="lin") # plot RGB originale


### classificazione dell'immagine
# il valore di un pixel di vegetazione (ponendo 3 assi, del blu, del verde e del rosso), 
# assorbe nel blu e nel rosso quindi nei loro rispettivi assi avrà un valore molto basso, mentre nel verde, che riflette, avrà un valore molto alto
# incrociando questi tre valori si otterrà il valore del pixel considerato (P1)
# la stessa cosa andrà fatta per gli altri pixel dell'immagine (P2, P3, P4, etc.), anche attraverso le distanze tra i vari pixel -> creazione di un training set
# processo di maximum likelihood (somiglianza massima)
# il software dividerà l'immagine in classi in funzione di quanto detto sopra (al training set), associerà poi ogni classe ad un'etichetta

## unsupervised classificazion (classificazione non supervisionata)
# il training set li prende il software
# la funzione che utilizziamo è "unsuperClass" interna ad RStoolbox, ed opera proprio la classificazione non supervisionata
SOC<-unsuperClass(SO,nClasses=3) # nClasses= numero di classi che il softwar dovrà creare
# creazione di un modello e di una mappa che può essere visualizzata in uscita
plot(SOC$map) # plot della sola mappa all'interno dell'oggetto SOC creato
# in questo caso il software crea le classi a piacere, con la funzione "set.seed" si settano le classi, impedendone la variazione


## aumento del numero di classi
SOC_20<-unsuperClass(SO,nClasses=20) 
plot(SOC_20$map)

# altro tipo di classificazione è la supervised classification (classificazione supervisionata)
# la classificazione potrebbe fallire con un volto

# è possibile cambiare la ColorRampPalette


## download di una nuova immagine:
# https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
sun <- brick("sun.png")
sun
plotRGB(sun, 1, 2, 3, stretch="lin")
sunc <- unsuperClass(sun, nClasses=3)
# sunc <- unsuperClass(sun, nClasses=20)
plot(sunc$map)

# per sapere quanto è accurata l'immagine bisogna fare un controllo a posteriori
# un problema delle immagine è il "noise", il rumre, che può derivare dalle ombre ad esempio, altri rumori sono le nuvole
# ci sono 3 metodi per le nuvole:
# 1 esistono degli strati chiamati mask, che si possono tranquillamente togliere, sono dei file a parte con i quali si possono fare delle sottrazioni
# 2 lo si inserisce nella classificazione ma si dichiara quali zone sono nuvole
# 3 usare un altro tipo di sensore (i sensori fin ora usati sono sensori passivi), per esempio con il segnale RADAR le nuvole vengono oltrepassate


## classificazione del Grand Canyon

GC<-brick("dolansprings_oli_2013088_canyon_lrg.jpg") # copiando ed incollando su Browser il nome dell'immagine si trova il sito di download e le relative caratteristiche
par(mfrow=c(2,1)) # plot in RGB con stretch lineare e histogram
plotRGB(GC, r=1, g=2, b=3, stretch="lin")
plotRGB(GC, r=1, g=2, b=3, stretch="hist")
# i pixel Landsat hanno risoluzione 30 m

GCc2<-unsuperClass(GC,nClasses=2) # classificazione con due classi
plot(GCc2$map)
GCc2
#unsuperClass results
#
#*************** Map ******************
#$map
#class      : RasterLayer 
#dimensions : 6222, 9334, 58076148  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 9334, 0, 6222  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : r_tmp_2021-08-20_084832_7760_43713.grd 
#names      : layer 
#values     : 1, 2  (min, max) -> classi 1 e classe 2


GCc4 <- unsuperClass(GC, nClasses=4) # classificazione con 4 classi
plot(GCc4$map)
GCc4

##unsuperClass results
#
#*************** Map ******************
#$map
#class      : RasterLayer 
#dimensions : 6222, 9334, 58076148  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 9334, 0, 6222  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : r_tmp_2021-08-20_084949_7760_38156.grd 
#names      : layer 
#values     : 1, 4  (min, max) -> classi 1,2,3 e 4

par(mfrow=c(2,1))
plotRGB(GC, r=1, g=2, b=3, stretch="lin")
plot(GCc4$map)







