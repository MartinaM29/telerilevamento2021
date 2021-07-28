## R code


#install.packages("raster")
library(raster) #COSA FA RASTER

#setwd("~/lab/")#Linux
setwd("C:/lab_telerilevamento/")  # Windows
# setwd("/Users/name/lab/")#Mac


#zona di studio Riserva di Parakana
p224r63_2011 <- brick("p224r63_2011_masked.grd") #con brick si carica l'intero blocco delle bande
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


##Bande Landsat
# B1: blue 
# B2: green
# B3: red
# B4: NIR (NB:infrarosso vicino, vicino perchè è vicino alla parte visibile dell'occhio umano)
# B5: infrarosso medio, SWIR (short wave infrared)
# B6: infrarosso termico
# B7: infrarosso medio


##colorRampPalette, creazione colori sulla base della riflettanza
cls <- colorRampPalette(c("red","pink","orange","purple")) (200) #cambia la paletta di colori
plot(p224r63_2011, col=cls)
dev.off() #chiude i grafici, equivale alla 'x'

#facciamo ora il plot della banda del blu
#p224r63_2011 immagine contenente tutte le bande
#B1_sre banda contenente la banda blu utilizzando $ come legante di due blocchi in questo caso l'immagine alla banda_1
plot(p224r63_2011$B1_sre)#plot solo della banda del blu

#plot(p224r63_2011$B2_sre)#plot banda verde
dev.off()

cl <- colorRampPalette(c('black','grey','light grey'))(100) # cambio paletta
plot(p224r63_2011, col=cl)
dev.off()

cl <- colorRampPalette(c('dark green','light green','yellow'))(100) # cambio paletta
plot(p224r63_2011, col=cl)
