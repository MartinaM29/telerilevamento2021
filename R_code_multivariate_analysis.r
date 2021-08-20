### R_code_multivariate_analysis.r ###

# per immagini con 100aia di bande, per esempio quelle provenienti dal sensore Apex, 
# per compattare questo tipo di immagini

# utilizzare una banda che "spiega" una vairanza/variabilità maggiore
# componente prinicpale = componente che fa vedere la maggior variabilità del sistema -> primo asse
# il secondo asse viene fatto passare perpendicolarmente al primo
# in questo modo, con la creazione di questi due nuovi assi, fa si che sull'asse principale ci sia la maggior variabilità (90%)
# sul secondo ci sarà la restante variabilità (10%)
# in questo modo si puù utilizzare per l'analisi solo l'asse principale perchè già ci fa vedere il 90% delle informazioni

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
plot(p224r63_2011)

## plottiamo i valori della banda 1 contro i valori della banda 2
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red",pch=19, cex=2) # pch = carattere del punto, cex è l'ingrandimento del punto
# si vede come le due bande sono correlate fra di loro (multi-correlatività)

# funzione pairs -> plotta tutte le correlazioni possibili tra tutte le variabili
# mettendo in relazioni a due a due le variabili a disposizione, nel nostro caso le bande
pairs(p224r63_2011)

# indice di correlazione di Pearson (-1:1) indice che valuta la correlazione tra due variabili (1 = correlazione perfetta)
# R da anche unna dimensione del carattere proporzionale al coefficiente di Pearson






























