### R_code.r ###

library("raster")
library("ncdf4")
install.packages("XML") # per aprire file .xml, da tutorial
library("XML") # comunque non apre il file prova

setwd("C:/lab_telerilevamento/esame")


WB_EU<-brick("g2_BIOPAR_WB-QUAL_QL_202006210000_EURO_PROBAV_V2.0.1.png") # prova con brick
WB_EU # dice che ha 4 bande
# class      : RasterBrick 
# dimensions : 150, 270, 40500, 4  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 270, 0, 150  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : g2_BIOPAR_WB-QUAL_QL_202006210000_EURO_PROBAV_V2.0.1.png 
# names      : g2_BIOPAR_WB.QUAL_QL_202006210000_EURO_PROBAV_V2.0.1.1, g2_BIOPAR_WB.QUAL_QL_202006210000_EURO_PROBAV_V2.0.1.2, g2_BIOPAR_WB.QUAL_QL_202006210000_EURO_PROBAV_V2.0.1.3, g2_BIOPAR_WB.QUAL_QL_202006210000_EURO_PROBAV_V2.0.1.4 
# min values :                                                      0,                                                      0,                                                      0,                                                      0 
# max values :                                                    255,                                                    255,                                                    255,                                                    255 

plotRGB(WB_EU,r=1,g=2,b=3,stretch="lin") # funziona

WB_GL14<-brick("g2_BIOPAR_WB_201401010000_PROBAV_V2.0.1.png")
plotRGB(WB_GL14,r=1,g=2,b=3,stretch="lin")

SWI22<-raster("c_gls_SWI1km_QL_202201091200_CEURO_SCATSAR_V1.0.1.png") # perchè 1 solo layer
cl<-colorRampPalette(c('blue','white','yellow','red'))(100)
plot(SWI22,col=cl)

SWI15<-raster("c_gls_SWI1km_QL_201501011200_CEURO_SCATSAR_V1.0.1.png")
plot(SWI15,col=cl)

## inserire altre due immagini di SWI

par(mfrow=c(2,1))
plot(SWI22,col=cl)
plot(SWI15,col=cl)


