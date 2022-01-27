### R_code.r ###

library("raster")
library("rasterVis")
library("knitr")
library("ncdf4")
# install.packages("XML") # per aprire file .xml, da tutorial
# library("XML") # comunque non apre il file prova

setwd("C:/lab_telerilevamento/esame")

### cerca info su immagini caricate

WB_EU20<-brick("g2_BIOPAR_WB-QUAL_QL_202006210000_EURO_PROBAV_V2.0.1.png") 
WB_EU20 # dice che ha 4 bande
# class      : RasterBrick 
# dimensions : 150, 270, 40500, 4  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 270, 0, 150  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : g2_BIOPAR_WB-QUAL_QL_202006210000_EURO_PROBAV_V2.0.1.png 
# names      : g2_BIOPAR_WB.QUAL_QL_202006210000_EURO_PROBAV_V2.0.1.1, g2_BIOPAR_WB.QUAL_QL_202006210000_EURO_PROBAV_V2.0.1.2, g2_BIOPAR_WB.QUAL_QL_202006210000_EURO_PROBAV_V2.0.1.3, g2_BIOPAR_WB.QUAL_QL_202006210000_EURO_PROBAV_V2.0.1.4 
# min values :                                                      0,                                                      0,                                                      0,                                                      0 
# max values :                                                    255,                                                    255,                                                    255,                                                    255 
plotRGB(WB_EU20,r=1,g=2,b=3,stretch="lin") 

WB_GL14<-brick("g2_BIOPAR_WB_201401010000_PROBAV_V2.0.1.png")
plotRGB(WB_GL14,r=1,g=2,b=3,stretch="lin")

par(mfrow=c(2,1))
plotRGB(WB_EU20,r=1,g=2,b=3,stretch="lin")
plotRGB(WB_GL14,r=1,g=2,b=3,stretch="lin")
# le due immagini non mi dicono nulla
 
### SOIL WATER IDENX, europeo
SWI22<-raster("c_gls_SWI1km_QL_202201091200_CEURO_SCATSAR_V1.0.1.png")
cl<-colorRampPalette(c('yellow','light blue','blue'))(100)
plot(SWI22,col=cl)
SWI22
# class      : RasterLayer 
# dimensions : 151, 250, 37750  (nrow, ncol, ncell)
# resolution : 1, 1  (x, y)
# extent     : 0, 250, 0, 151  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : c_gls_SWI1km_QL_202201091200_CEURO_SCATSAR_V1.0.1.png 
# names      : c_gls_SWI1km_QL_202201091200_CEURO_SCATSAR_V1.0.1 
# values     : 0, 255  (min, max)

SWI20<-raster("c_gls_SWI1km_QL_202001221200_CEURO_SCATSAR_V1.0.1.png")
SWI18<-raster("c_gls_SWI1km_QL_201811031200_CEURO_SCATSAR_V1.0.1.png")
SWI15<-raster("c_gls_SWI1km_QL_201502111200_CEURO_SCATSAR_V1.0.1.png")

cl<-colorRampPalette(c('yellow','light blue','blue'))(100)
# par(mfrow=c(2,2))
# plot(SWI22,col=cl,main='SWI_2022')
# plot(SWI20,col=cl,main='SWI_2020')
# plot(SWI18,col=cl,main='SWI_2018')
# plot(SWI15,col=cl,main='SWI_2015')

## unione dei 4 file -> molto meglio di plot
list<-list.files(pattern="SWI")
list
import<-lapply(list,raster)
import
SWI<-stack(import)
SWI
# class      : RasterStack 
# dimensions : 151, 250, 37750, 4  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 250, 0, 151  (xmin, xmax, ymin, ymax)
# crs        : NA 
# names      : c_gls_SWI1km_QL_201502111200_CEURO_SCATSAR_V1.0.1, c_gls_SWI1km_QL_201811031200_CEURO_SCATSAR_V1.0.1, c_gls_SWI1km_QL_202001221200_CEURO_SCATSAR_V1.0.1, c_gls_SWI1km_QL_202201091200_CEURO_SCATSAR_V1.0.1 
# min values :                                                 0,                                                 0,                                                 0,                                                 0 
# max values :                                               255,                                               255,                                               255,                                               255 
levelplot(SWI,col.regions=cl,main='Soil water index',names.attr=c("2015","2018","2020","2022"))
# sembra evidenziare un aumento dell'indice SWI dal 2015 al 2022
# sottrazione dei livelli
diffSWI2215<-(SWI$c_gls_SWI1km_QL_202201091200_CEURO_SCATSAR_V1.0.1-SWI$c_gls_SWI1km_QL_201502111200_CEURO_SCATSAR_V1.0.1)
diff2215
# class      : RasterLayer 
# dimensions : 151, 250, 37750  (nrow, ncol, ncell)
# resolution : 1, 1  (x, y)
# extent     : 0, 250, 0, 151  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : memory
# names      : layer 
# values     : -145, 140  (min, max)
levelplot(diffSWI2215,col.regions=cl,main='differenza in SWI tra il 2022 e il 2015')
plot(diffSWI2215,col=cl,main='differenza in SWI tra il 2022 e il 2015')
# la differenza è 2022-2015, 

### LAND SURFACE TEMPERATURE, globale
LST22<-raster("c_gls_LST10-TCI_202201010000_GLOBE_GEO_V2.1.1.nc") 
plot(LST22)
LST20<-raster("c_gls_LST10-TCI_202001010000_GLOBE_GEO_V1.2.1.nc")
# i due plot danno scale diverse, la più sensata sembra quella relativa al 2020
LST18<-raster("c_gls_LST10-TCI_201801010000_GLOBE_GEO_V1.2.1.nc")
# LST15<-raster("c_gls_LST_201501291100_GLOBE_GEO_V1.2.1.nc") # 2015 non c'era ogni 10-giorni
list<-list.files(pattern="LST")
list
import<-lapply(list,raster)
import
LST<-stack(import)
LST
levelplot(LST,col.regions=cl,main='Land surface temperature',names.attr=c("2018","2020","2022"))
# in alcune zone la temperatura è dminuita mentre in altre è aumentata
# differenza dei livelli
diffLST2218<-(LST$Fraction.of.Valid.Observations.3-LST$Fraction.of.Valid.Observations.1)
levelplot(diffLST2218,col.regions=cl,main='differenza in LST tra il 2022 e il 2018')
plot(diffLST2218,col=cl,main='differenza in SWI tra il 2022 e il 2018')
# le LST si sono abbassate

par(mfrow=c(2,1))
plot(diffSWI2215,col=cl,main='differenza in SWI tra il 2022 e il 2015')
plot(diffLST2218,col=cl,main='differenza in SWI tra il 2022 e il 2018')
# non si capisce perchè una è europea e l'altra globale
