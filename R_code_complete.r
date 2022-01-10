### R_code_complete.r
# contiene tutto il codice del corso di Telerilevamento geo-ecologico 2021

#------------------------------------------------------------------------------------------

## Summary
# 1. Remote sensing
# 2. Time Series Greenland
# 3. 
# 4. Use of knitr function
# 5. Multivariate analysis
# 6. Image classification
# 7. Use ggplot2 function
# 8. Vegetation indeces
# 9. Land cover: image classification and multitemporal analysis
# 10. Landscape and mineralogical variability

#----------------------------------------------------------------------------------------------------

# 1. Remote Senting

#------------------------------------------------------------------------------------------


### R_code_remote_sensing.r ###


#install.packages("raster") #se ancora non si è installato il pacchetto
library(raster) #COSA FA RASTER, il pacchetto sp, gestisce tutti i dati all'interno del softwer, in questo caso raster

#setwd("~/lab/")#Linux
setwd("C:/lab_telerilevamento/")  # Windows
# setwd("/Users/name/lab/")#Mac


#zona di studio Riserva di Parakana
p224r63_2011 <- brick("p224r63_2011_masked.grd") #con brick si importano immagini dall'esterno, si carica l'intero blocco delle bande, le "" si usano per chiamare file fuori da R
#masked indica che l'immagine è già stata ripulita da un po' di rumore
# quindi il file "p224r63_2011" contiene tutte le bande Landsat
#queste operazioni devono essere eseguite ogni volta che si apre R
plot(p224r63_2011) #plot con tutte le bande, 7 grafici
p224r63_2011 #così si vedono tutte le caratteristiche del file

###
#class      : RasterBrick                                                -> quindi formata da tanti raster nella stessa immagine
#dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
#resolution : 30, 30  (x, y)
#extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax) 
#crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs          -> sistema di riferimento, proj = proiezione, zone = fuso
#source     : p224r63_2011_masked.grd 
#names      :       B1_sre,       B2_sre,       B3_sre,       B4_sre,       B5_sre,        B6_bt,       B7_sre 
#min values : 0.000000e+00, 0.000000e+00, 0.000000e+00, 1.196277e-02, 4.116526e-03, 2.951000e+02, 0.000000e+00 
#max values :    0.1249041,    0.2563655,    0.2591587,    0.5592193,    0.4894984,  305.2000000,    0.3692634 
###


## Bande Landsat
# B1: blu 
# B2: verde
# B3: rosso
# B4: NIR (NB:infrarosso vicino, vicino perchè è vicino alla parte visibile dell'occhio umano)
# B5: infrarosso medio, SWIR (short wave infrared)
# B6: infrarosso termico (infrarosso lontano)
# B7: infrarosso medio (altro sensore per l'infrarosso medio)


## colorRampPalette, creazione colori sulla base della riflettanza
cls <- colorRampPalette(c("red","pink","orange","purple")) (200) #cambia la scala di colori, il rosso da i valori più bassi di riflettanza sul rosso e i valori più alti di riflettanza sul viole, per ogni banda
# la c() indica il vettore
plot(p224r63_2011, col=cls)
dev.off() #chiude i grafici, equivale alla 'x'

# altre opzioni di paletta colori
#cls <- colorRampPalette(c('black','grey','light grey'))(100) # cambio paletta
#plot(p224r63_2011, col=cls)
#dev.off()

#cls <- colorRampPalette(c('dark green','light green','yellow'))(100) # cambio paletta
#plot(p224r63_2011, col=cls)
#dev.off()


## plot della sola banda del blu con la color Ramp Palette predefinita
#p224r63_2011 immagine contenente tutte le bande
#B1_sre banda contenente la banda blu utilizzando $ come legante di due blocchi in questo caso l'immagine alla banda 1
plot(p224r63_2011$B1_sre) 
dev.off()

#plot(p224r63_2011$B2_sre)#plot banda verde
#dev.off()
#la stessa cosa può essere fatta con tutte le bande

## plot della banda uno con la scelta di una color ramp palette
cl <- colorRampPalette(c('dark green','light green','yellow'))(100)
plot(p224r63_2011$B1_sre, col=cl)

## funzione par: multiframe (mf)
#par fa un settaggio dei parametri grafici
#vogliamo impostare un grafico con sole 2 bande una accanto all'altra
par(mfrow=c(1,2)) #1 riga e 2 colonne
#vediamo che il sistema è a più blocchi, pertanto viene chiamato vettore
plot(p224r63_2011$B1_sre) 
plot(p224r63_2011$B2_sre) 

#2 righe e 1 colonna
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre) 
plot(p224r63_2011$B2_sre)

# par(mfcol...)
par(mfcol=c(1,2)) #1 riga, 2 colonne
plot(p224r63_2011$B1_sre) 
plot(p224r63_2011$B2_sre)


## plot delle prime 4 bande di Landsat
par(mfrow=c(4,1)) #4 righe, 1 colonna
plot(p224r63_2011$B1_sre) 
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre) 
plot(p224r63_2011$B4_sre)

#2 righe, 2 colonne
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre) 
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre) 
plot(p224r63_2011$B4_sre)


## per ogni banda inserire la relativa color ramp palette
par(mfrow=c(2,2))
clb<-colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(p224r63_2011$B1_sre, col=clb)
clg<-colorRampPalette(c('dark green','light green','yellow'))(100)
plot(p224r63_2011$B2_sre, col=clg)
clr<-colorRampPalette(c('dark red','red','pink'))(100)
plot(p224r63_2011$B3_sre, col=clr)
cln<-colorRampPalette(c('red','orange','yellow'))(100)
plot(p224r63_2011$B4_sre, col=cln)


### visualizzazione dati tramite plot RGB (Red, Green, Blue)
## Bande Landsat (lunghezze d'onda a cui vengono registrate le immagini Landsat)
# B1: blu 
# B2: verde
# B3: rosso
# B4: NIR (NB:infrarosso vicino, vicino perchè è vicino alla parte visibile dell'occhio umano)
# B5: infrarosso medio, SWIR (short wave infrared)
# B6: infrarosso termico (infrarosso lontano)
# B7: infrarosso medio (altro sensore per l'infrarosso medio)

#le bande avranno dei valori per ogni pixel compresi fra 0 e 1, 0 per la banda che assorbe molto 1 per la banda che riflette molto

## schema RGB = ogni schermo ha uno schema fisso per mostrare i colori, chiamato appunto RGB
# per vedere quindi un'immagine come se fosse a colori naturali, si monta R con la banda 3, G con la banda 2 e B con la banda 1 (schema 3,2,1)
# funzione: plotRGB

plotRGB(p224r63_2011,r=3,g=2,b=1, stretch="Lin")
#stretch prende i valori delle singole bande (quindi la riflettanza delle singole bande) e li tira per fare in modo che non ci sia schiacciamento in una sola parte del colore
#Lin = lineare
#hist = histogram stretch, non lineare
#stretch è solo per scopi di visualizzazione non cambia i valori
#l'immagine creata quindi si chiama immagine a colori naturali
#in questo caso non si usano i nomi delle bande perchè la funzione è pensata per il numero del layer


# cambio di colori
plotRGB(p224r63_2011,r=4,g=3,b=2, stretch="Lin") #NIR=red,rosso=green,verde=blue
#NB: la vegetazione assorbe la banda blu e rossa e rifletta la banda verde e tantissimo la banda NIR
#visualizzazione in falsi colori = falsi rispetto al nostro occhio
plotRGB(p224r63_2011,r=3,g=4,b=2, stretch="Lin")
#la parte viola rappresenta il suolo nudo
plotRGB(p224r63_2011,r=3,g=2,b=4, stretch="Lin")
#il suolo nudo in questo caso è giallo


# multiframe 2x2
par(mfrow=c(2,2))
plotRGB(p224r63_2011,r=3,g=2,b=1, stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2, stretch="Lin")
plotRGB(p224r63_2011,r=3,g=4,b=2, stretch="Lin")
plotRGB(p224r63_2011,r=3,g=2,b=4, stretch="Lin")


# salvare immagine come pdf tramite codice
pdf("il_mio_primo_pdf_2.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011,r=3,g=2,b=1, stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2, stretch="Lin")
plotRGB(p224r63_2011,r=3,g=4,b=2, stretch="Lin")
plotRGB(p224r63_2011,r=3,g=2,b=4, stretch="Lin")
dev.off() #per chiudere bene la funzione pdf()


# salva come jpeg
jpeg("il_mio_primo_jpeg_con_R_2.jpeg")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()


# stretch non lineare
#confronto tra 3 immagini
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") #immagine a colori naturali
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") #falsi colori, NIR sul verde
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist") #falsi colori, con stretch hist
#le zone viola all'interno della foresta potrebbero proprio rapprsentare le zone più umide

#con RGB non c'è la legenda perchè i colori derivano dalle riflettanze, non le decidiamo noi


## set multitemporale
# come è cambiata l'area nel corso degli anni sfruttando i dati Landsat e le funzioni appena usate
# inserimento immagine 1988_masked
p224r63_1988<-brick("p224r63_1988_masked.grd") #importazione dell'intera immagine
p224r63_1988
plot(p224r63_1988) #plot dell'intera immagine, con visualizzazionne delle singole bande

plotRGB(p224r63_1988,r=3,g=2,b=1,stretch="Lin") #plot in colori naturali, stretch lineare
plotRGB(p224r63_1988,r=4,g=3,b=2,stretch="Lin") #falsi colori, con la componente NIR nel rosso

#multiframe 1988-2011 in falsi colori con componente NIR nel rosso
#stretch lineare e non lineare
par(mfrow=c(2,2))
plotRGB(p224r63_1988,r=4,g=3,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="Lin")
plotRGB(p224r63_1988,r=4,g=3,b=2,stretch="hist")
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="hist")
#1988:passaggio graduale tra componente naturale ed antropica
#2011:soglia netta tra la foresta pluviale e l'impatto naturale

# salva come pdf
pdf("1988_Vs_2011_Lin_hist_2.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988,r=4,g=3,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="Lin")
plotRGB(p224r63_1988,r=4,g=3,b=2,stretch="hist")
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="hist")
dev.off()

# unione pdf
pdf("unione_pdf.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Hist")
dev.off()
# con il secondo par crea una seconda pagina di pdf



#-----------------------------------------------------------------------------------------------------

# 2. Time Series Greenland

#---------------------------------------------------------------------------------------------------


### R code ###


### Time series analysis (serie multitemporale da satellite) ###
### Greenland increase of temperature ###
### Data and code from Emanuela Cosma ###

# install.packages("raster")
library(raster)
# install.packages("rasterVis")
library(rasterVis) #visualizzazione di dati raster
# install.packages("knitr")
library(knitr)

##c reazione cartella "greenland" all'interno della working directory "lab_telerilevamento"
setwd ("C:/lab_telerilevamento/greenland") #windows
# setwd("~/lab_telerilevamento/greenland") # Linux
# setwd("/Users/name/Desktop/lab_telerilevamento/greenland") # Mac

# lst = land surface temperature (temperatura misurata al suolo)

# in questo caso non abbiamo un unico file ma 4 file separati e non si può usare brick
# i file rappresentano la temperatura e derivano al programma Copernicus (https://land.copernicus.vgt.vito.be/PDF/portal/Application.html#Home)
# funzione raster = crea un oggetto da un file raster, sempre dentro il pacchetto raster
lst_2000<-raster("lst_2000.tif")
plot(lst_2000)
lst_2005<-raster("lst_2005.tif")
plot(lst_2005)
lst_2010<-raster("lst_2010.tif")
plot(lst_2010)
lst_2015<-raster("lst_2015.tif")
plot(lst_2015)
# la scala graduata in legenda rappresenta i bit rappresentativi dell'immagine

## apreire un multiframe con le 4 immagini
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)


### metodo alternativo per importare le immagini insieme
# lapply = funzione che si usa, si applica pertanto una data funzione (per noi qui raster) ad una lista di file
# creare quindi prima la lista dei file desiderata con la funzione list.files
rlist<-list.files(pattern="lst")
rlist # fa vedere i file all'interno della lista
# applichiamo mediante questa funzione la funzione raster a tutta la lista appena creata
import<-lapply(rlist,raster) 
import

# traformare i singoli 4 file in uno unico (creare un unico pacchetto di file)
# creazione di uno stack (importazione di un blocco di dati raster), funzione stack, all'interno del pacchetto raster
TGr<-stack(import)
plot(TGr) # in questo modo non importa più fare par()
TGr

plotRGB(TGr,r=1, g=2, b=3, stretch="Lin") #1=2000, 2=2005, 3=2010
#plot dei valori dei vari anni
#plot rosso = valori alti in 2000, verde = valori alti 2005, blu = valori alti in 2010
plotRGB(TGr,r=1, g=2, b=3, stretch="hist")
plotRGB(TGr,r=2, g=3, b=4, stretch="Lin")
plotRGB(TGr,r=2, g=3, b=4, stretch="hist")


## levelplot
levelplot(TGr)
levelplot(TGr$lst_2000) # grafico media valori di temperatura
# sommatoria pixel di ogni colonna per il numero di pixel si ha la media di ogni colonna

# cambio colorRampPalette (cambio colori grafico)
cl<-colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr,col.regions=cl)
# levelplot da grafici più potenti rispetto al plot
# arricchimento levelplot mediante l'uso dei suoi attributi
levelplot(TGr,col.regions=cl,main="land surface temperature",names.attr=c("July_2000","July_2005","July_2010","July_2015"))
# main = titolo
# c() perchè sono 4 blocchi


### utlizzo dei dati relativi allo scioglimento
## creare una lista con questi secondi dati
meltlist<-list.files(pattern="melt")
meltlist
melt<-lapply(meltlist,raster) 
MG<-stack(melt) # MG = melt Greenland
levelplot(MG$X1979annual_melt)
MG

cl<-colorRampPalette(c("white","green","yellow","red"))(100)
levelplot(MG$X1979annual_melt,col.regions=cl)

## sottrazione tra i livelli (sempre in bit)
# più è alto questo valore, in questo caso, più è alto lo scioglimento
totmelt<-(MG$X2007annual_melt-MG$X1979annual_melt)
clm<-colorRampPalette(c("blue","white","red"))(100)
levelplot(totmelt,col.regions=clm)
totmelt # per vedere anche i valori min e max di scioglimento


#-------------------------------------------------------------------------------------------------

# 3. Use of Copernicus data

#-------------------------------------------------------------------------------------------------


### R_code_copernicus.r ###


## visualizzazione dati da Copernicus, file 1: Water Lavel, V2, data 12/10/1992
# file 2: Soil Water Index
# file 3: Lake Water Quality, 300 m, data 11/07/21

#install.packages("raster")
library(raster)
#install.packages("ncdf4")
library(ncdf4) # all'interno del pacchetto CRAN, possono essere aperti e letti facilmente dei datasets, permette anche la compressione dei file
# CRAN è una rete di server in tutto il mondo che memorizza le versioni aggiornate di codici e documentazioni di R

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


#----------------------------------------------------------------------------------------------------------------------

# 4. Use of knitr function

#---------------------------------------------------------------------------------------------------


### R_code_knitr_temp ###


library(knitr) # il pacchetto può utilizzare un codice esterno per creare un report in R
# funzione stitch 

# setwd("~/lab_telerilevamento/") # Linux
setwd("C:/lab_telerilevamento/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac


## R_code_remote_sensing_temp file su cui si lavora.r
# con Ctrl A selezionare tutto il testo e copiarlo su un file di testo
# togliere i dev.off()
# ovviamente nella cartella lab_telerilevamento ci devono essere tutti i dati presenti e utilizzati all'interno del codice
# salvare dentro la cartella lab_telerilevamento ("R_code_remote_sensing_temp.r")


stitch("R_code_remote_sensing_temp.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
# errore con LaTeX, ma creazione di file .tex
# per errore su windows per tinitext
# tinytex::install_tinytex()
# tinytex::tlmgr_update()


#----------------------------------------------------------------------------------------------------

# 5. Multivariate analysis

#----------------------------------------------------------------------------------------------------


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


#------------------------------------------------------------------------------------------------------

# 6. Image classification

#-----------------------------------------------------------------------------------------------------


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


#------------------------------------------------------------------------------------------------------

# 7. Use ggplot2 function

#----------------------------------------------------------------------------------------------------


### R_code_ggplot2.r ###

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("~/lab/")

p224r63 <- brick("p224r63_2011_masked.grd")

ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")

p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")

grid.arrange(p1, p2, nrow = 2) # this needs gridExtra


#-----------------------------------------------------------------------------------------------------

# 8. Vegetation indeces

#----------------------------------------------------------------------------------------------------

### R_code_vegetation_indeces.r ###

# una pianta riflette molto nell'infrasso vicino mentre assorbe molto la radiazione rossa

library(raster) # require(raster), funzione require fa la sessa cosa di library
library(RStoolbox) # for vegetation indices calculation
# install.packages("rasterdiv")
library(rasterdiv) # for the worldwise NDVI
# raster diversity
# si può trovare un dataset gratuito derivato direttamente da copernicus
# l'input data-set è NDVI
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
# identifichiamo in che aree c'è stata sofferenza (nel nostro cosa deforestazione)
# dice quali sono i punti in cui c'è stata una sofferenza nella vegetazione nel tempo

## calcolo NDVI
# l'NDVI nasce per poter paragonare immagini con risoluzione radiometrica differente
# a questo punto il range dei valori che l'NDVI può assumere è -1;1
# NB: alcuni software ragionano in maniera sequenziale, quindi inserire sempre le parentesi
# NDVI<-(NIR-RED)/(NIR+RED)
NDVI1<- (defor1$defor1.1-defor1$defor1.2)/(defor1$defor1.1+defor1$defor1.2)
# NDVI1<- DVI1/(defor1$defor1.1+defor1$defor1.2)
plot(NDVI1, col=cl, main="NDVI in time 1")

# sul pacchetto RStoolbox sono presenti diverse funzioni, ad esempio spectral indices, che calcola diversi indici come NDVI o SAVI (che si usa con diversi tipi di suolo)
# argomento = indices

NDVI2<-(defor2$defor2.1-defor2$defor2.2)/(defor2$defor2.1+defor2$defor2.2)
# NDVI2<-DVI2/(defor2$defor2.1+defor2$defor2.2)
par(mfrow=c(2,1))
plot(NDVI1, col=cl, main="NDVI in time 1")
plot(NDVI2, col=cl, main="NDVI in time 2")

difNDVI<-NDVI1-NDVI2
plot(difNDVI,col=cld)

## test spectral indices
# RStoolbox::spectralIndices
VI1<-spectralIndices(defor1,green=3,red=2,nir=1)
plot(VI1,col=cl)
VI2<-spectralIndices(defor2,green=3,red=2,nir=1)
plot(VI2,col=cl)

# NDWI = indice relativo all'acqua

# NB: la varianza è, in statistica, la variabilità dei dati
# i disastri naturali aumentano quindi la varianza dei pixel
## copNDVI è un dataset presente in rasterdiv (worldwise NDVI)
plot(copNDVI)
# non ci interessano i valori che vanno a rappresentare l'acqua e quindi li togliamo
# funzione reclassify, trasformandoli in non valore (NA)
copNDVI<-raster::reclassify(copNDVI, cbind(253:255,NA))
# :: lega la funzione, per capire da dove viene la funzione
# i valori da 253 a 255 sono quelli rappresentativi dell'acqua

## levelplot è all'interno del pacchetto rasterVis
levelplot(copNDVI)
# dal 1999 al 2017
# i valori più alti infatti sono relativi alla foresta amazzonica, e di tutte le grandi foreste mondiali
# i valori bassi rappresentano i deserti o le grandi distese di nevi
# si può esare levelplot per paragonare l'NDVI della stessa zona nel tempo
# NDVI scaricabile da Copernicus

# robisco = enzima che cattura la CO2 trasformandola in zucchero
# anni '80 crisi delle piogge acide, le conifere che hanno le foglie ad ago sono già acide, e questa forte acidità ha creato gravi malattie alle piante


#-----------------------------------------------------------------------------------------------------------------

# 9. Land cover: image classification and multitemporal analysis

#--------------------------------------------------------------------------------------------------------


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


#----------------------------------------------------------------------------------------------------

# 10. Landscape and mineralogical variability

#---------------------------------------------------------------------------------------------------


### R_code_variability.r


library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra) # mette insieme tanti plot di ggplot (con la funzione grid.arrange)
# install.packages("viridis")
library(viridis) # serve per i colori

# setwd("~/lab/") # Linux
setwd("C:/lab_telerilevamento/") # Windows
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
sentpca
# $call
# rasterPCA(img = sentinel)
#
# $model
# Call:
# princomp(cor = spca, covmat = covMat[[1]])
#
# Standard deviations:
#   Comp.1   Comp.2   Comp.3   Comp.4 
# 77.33628 53.51455  5.76560  0.00000 
#
#  4  variables and  633612 observations.
#
# $map
# class      : RasterBrick 
# dimensions : 794, 798, 633612, 4  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 798, 0, 794  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : memory
# names      :       PC1,       PC2,       PC3,       PC4 
# min values : -227.1124, -106.4863,  -74.6048,    0.0000 
# max values : 133.48720, 155.87991,  51.56744,   0.00000 
#
#
# attr(,"class")
# [1] "rasterPCA" "RStoolbox"

plot(sentpca$map) # ricorda che il 4 livello non ha senso
summary(sentpca$map) # per vedere quanta variabilità spiegano le singole componenti
# è ovvio che la prima componente spieghi di più perchè è proprio quella nell'asse con più variabilità, gli altri assi sono ortogonali ad esso
#                 [,1]        [,2]        [,3] [,4] -> numero componente
# Min.    -227.112386 -106.486268 -74.6047951    0
# 1st Qu.  -46.986159  -38.491732  -2.8424694    0
# Median    -3.031515   -7.414764   0.4003749    0
# 3rd Qu.   57.386021   31.877757   3.4832835    0
# Max.     133.487197  155.879910  51.5674399    0
# NA's       0.000000    0.000000   0.0000000    0

## misurazione variabilità attraverso la funzione focal
# sulla prima componente
pc1<-sentpca$map$PC1
pc1_15<-focal(pc1,w=matrix(1/225,nrow=15,ncol=15),fun=sd)
plot(pc1_15, col=clsd)

## con la funzione source, si può richiamare un pezzo di codice già creato
# prima si deve scaricare il file come link da internet
source("source_test_lezione.r")
# alta sd alte variazioni geomorfologiche
# secondo esempio con source
source("source_ggplot.r")
## analisi dello script "source_ggplot.r"
ggplot() + # creazione di una finestra vuota, il + aggiunge un altro blocco a ggplot
geom_raster(pc1_15,mapping=aes(x=x,y=y,fill=layer)) # creazione del blocco geometria (es: geom_point, geom_line), nel nostro caso stiamo usando dei pixel, quindi un raster
# aes = estetiche, quindi che cosa si plotta, tramite la funzione mapping
# questo metodo è importantissimo per mappare le discontinuità geografiche
# a livello geologico serve ad individuare qualsiasi variabilità geomorfologica
# a livello ecologico serve ad individuare qualsiasi variabilità ecologica (es. ecotoni)

## viridis
# permette di creare colori che siano visibili a tutti
# viridis è di default, poi propone 5 alternative (inferno, plasma, cividis, magma, mako, rocket)
# la funzione scale_fill_viridis nel pacchetto viridis per la scelta

p1<-ggplot() + 
geom_raster(pc1_15,mapping=aes(x=x,y=y,fill=layer)) +
scale_fill_viridis() + # default
ggtitle("deviazione standard con utilizzo di viridis") # ggtitle = per inserire titolo
# cambio legenda
p2<-ggplot() + 
geom_raster(pc1_15,mapping=aes(x=x,y=y,fill=layer)) +
scale_fill_viridis(option="magma") + 
ggtitle("deviazione standard con utilizzo di magma") 
# tutto ciò che ha un'alta deviazione standard si vede molto bene
# cambio legenda
p3<-ggplot() + 
geom_raster(pc1_15,mapping=aes(x=x,y=y,fill=layer)) +
scale_fill_viridis(option="inferno") + 
ggtitle("deviazione standard con utilizzo di inferno")
# cambio legenda
p4<-ggplot() + 
geom_raster(pc1_15,mapping=aes(x=x,y=y,fill=layer)) +
scale_fill_viridis(option="turbo") + # questa però i daltonici non la vedono
ggtitle("deviazione standard con utilizzo di turbo")

# unione con grid.arrange
grid.arrange(p1,p2,p3,p4,nrow=2,ncol=2)


#----------------------------------------------------------------------------------------------------

#----------------------------------------------------------------------------------------------------






























