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





