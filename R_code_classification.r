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
sunc <- unsuperClass(sun, nClasses=20)
plot(sunc$map)







