## R code


#install.packages("raster")
library(raster) #COSA FA RASTER

#setwd("~/lab/")#Linux
setwd("C:/lab_telerilevamento/")  # Windows
# setwd("/Users/name/lab/")#Mac

p224r63_2011 <- brick("p224r63_2011_masked.grd") #con brick si carica l'intero blocco delle bande
#queste operazioni devono essere eseguite ogni volta che si apre R
plot(p224r63_2011) #plot con tutte le bande, 7 grafici
p224r63_2011 #così si vedono tutte le caratteristiche del file

##Bande Landsat
# B1: blue 
# B2: green
# B3: red
# B4: NIR (NB:infrarosso vicino, vicino perchè è vicino alla parte visibile dell'occhio umano)
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio


##colorRampPalette
cls <- colorRampPalette(c("red","pink","orange","purple")) (200) #cambia la paletta di colori
plot(p224r63_2011, col=cls)
dev.off() #chiude i grafici, equivale alla 'x'

#facciamo ora il plot della banda del blu
#p224r63_2011 immagine contenente tutte le bande
#B1_sre banda contenente la banda blu utilizzando $ come legante di due blocchi in questo caso l'immagine alla banda_1
plot(p224r63_2011$B1_sre)#plot banda del blu

#plot(p224r63_2011$B2_sre)#plot banda verde
dev.off()

cl <- colorRampPalette(c('black','grey','light grey'))(100) # cambio paletta
plot(p224r63_2011, col=cl)
dev.off()

cl <- colorRampPalette(c('dark green','light green','yellow'))(100) # cambio paletta
plot(p224r63_2011, col=cl)
