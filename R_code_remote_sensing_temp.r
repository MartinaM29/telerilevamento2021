### R code ###


#install.packages("raster") #se ancora non si è installato il pacchetto
library(raster) #COSA FA RASTER, il pacchetto sp, gestisce tutti i dati all'interno del softwer, in questo caso raster
#install.packages("RStoolbox")
library(RStoolbox)

#setwd("~/lab/")#Linux
setwd("C:/lab_telerilevamento/")  # Windows
# setwd("/Users/name/lab/")#Mac


#zona di studio Riserva di Parakana
p224r63_2011 <- brick("p224r63_2011_masked.grd") #con brick si importano immagini dall'esterno, si carica l'intero blocco delle bande, le "" si usano per chiamare file fuori da R
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












