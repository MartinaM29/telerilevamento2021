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










