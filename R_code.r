### R_code.r ###

library("raster")
library("rasterVis")
library("RStoolbox")
library("gridExtra")
library("ggplot2")
library("viridis")


setwd("C:/lab_telerilevamento/esame")

### inserimento immagini
## Lago Powell
river00<-brick("powell_ast_2000142_lrg.jpg")
river06<-brick("powell_ast_2006126_lrg.jpg")
river17<-brick("lakepowell_oli_2017244_lrg.jpg")
river21<-brick("lakepowell_oli_2021239_lrg.jpg")
# par(mfrow=c(2,2))
# plotRGB(river00,r=1,g=2,b=3,stretch="lin")
# plotRGB(river06,r=1,g=2,b=3,stretch="lin")
# plotRGB(river17,r=1,g=2,b=3,stretch="lin") 
# plotRGB(river21,r=1,g=2,b=3,stretch="lin")
# river17
# class      : RasterBrick 
# dimensions : 1825, 2738, 4996850, 3  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 2738, 0, 1825  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : lakepowell_oli_2017244_lrg.jpg 
# names      : lakepowell_oli_2017244_lrg.1, lakepowell_oli_2017244_lrg.2, lakepowell_oli_2017244_lrg.3 
# min values :                            0,                            0,                            0 
# max values :                          255,                          255,                          255 

## ggplot
r00<-ggRGB(river00,1,2,3,stretch="lin")+ggtitle("2000")
r06<-ggRGB(river06,1,2,3,stretch="lin")+ggtitle("2006")
r17<-ggRGB(river17,1,2,3,stretch="lin")+ggtitle("2017")
r21<-ggRGB(river21,1,2,3,stretch="lin")+ggtitle("2021")
grid.arrange(r00,r06,r17,r21,nrow=2)

## classificazione
set.seed(2)
class_00<-unsuperClass(river00,nClasses=2)
class_06<-unsuperClass(river06,nClasses=2)
class_17<-unsuperClass(river17,nClasses=2) 
class_21<-unsuperClass(river21,nClasses=2)
par(mfrow=c(2,2))
plot(class_00$map,main='2000')
plot(class_06$map,main='2006')
plot(class_17$map,main='2017')
plot(class_21$map,main='2021')
# classe1= roccia
# classe2= acqua
# i valori intermedi non hanno senso, quelli reali sono 1 e 2
# class_17
# unsuperClass results
#
# *************** Map ******************
# $map
# class      : RasterLayer 
# dimensions : 1825, 2738, 4996850  (nrow, ncol, ncell)
# resolution : 1, 1  (x, y)
# extent     : 0, 2738, 0, 1825  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : memory
# names      : layer 
# values     : 1, 20  (min, max)

## NDWI
# NDWI = (r_green - r_nir) / (r_nir + r_green) 

# BANDE
# B1= NIR, B2 = red, B3 = green
NDWI00=(river00$powell_ast_2000142_lrg.3-river00$powell_ast_2000142_lrg.1)/(river00$powell_ast_2000142_lrg.1+river00$powell_ast_2000142_lrg.3)
NDWI06=(river06$powell_ast_2006126_lrg.3-river06$powell_ast_2006126_lrg.1)/(river06$powell_ast_2006126_lrg.1+river06$powell_ast_2006126_lrg.3)
NDWI17=(river17$lakepowell_oli_2017244_lrg.3-river17$lakepowell_oli_2017244_lrg.1)/(river17$lakepowell_oli_2017244_lrg.1+river17$lakepowell_oli_2017244_lrg.3)
NDWI21=(river21$lakepowell_oli_2021239_lrg.3-river21$lakepowell_oli_2021239_lrg.1)/(river21$lakepowell_oli_2021239_lrg.1+river21$lakepowell_oli_2021239_lrg.3)
# cl<-colorRampPalette(c('red','yellow','blue'))(100) # white,'red','yellow'
# par(mfrow=c(2,2))
# plot(NDWI00,col=cl,main='2000')
# plot(NDWI06,col=cl,main='2006')
# plot(NDWI17,col=cl,main='2017')
# plot(NDWI21,col=cl,main='2021')

p1<-ggplot()+geom_raster(NDWI00,mapping=aes(x=x,y=y,fill=layer))+scale_fill_viridis()+ggtitle("NDWI 2000")
p2<-ggplot()+geom_raster(NDWI06,mapping=aes(x=x,y=y,fill=layer))+scale_fill_viridis()+ggtitle("NDWI 2006")
p3<-ggplot()+geom_raster(NDWI17,mapping=aes(x=x,y=y,fill=layer))+scale_fill_viridis()+ggtitle("NDWI 2017")
p4<-ggplot()+geom_raster(NDWI21,mapping=aes(x=x,y=y,fill=layer))+scale_fill_viridis()+ggtitle("NDWI 2021")
grid.arrange(p1,p2,p3,p4,nrow=2)

## frequenza
freq00<-freq(class_00$map)
freq00
# value   count
# [1,]     1 4881693
# [2,]     2 1118307
freq06<-freq(class_06$map)
freq06
#     value   count
# [1,]     1 5191304
# [2,]     2  808696
freq17<-freq(class_17$map)
freq17
# value   count
# [1,]     1 3975656
# [2,]     2 1021194
freq21<-freq(class_21$map)
freq21
#      value   count
# [1,]     1 4283465
# [2,]     2  713385

# proporzione
sum00<-4881693+1118307
sum06<-5191304+808696
sum17<-3975656+1021194
sum21<-4283465+713385

prop00<-freq00/sum00
prop00
#             value     count
# [1,] 1.666667e-07 0.8136155
# [2,] 3.333333e-07 0.1863845
prop06<-freq06/sum06
prop06
#             value     count
# [1,] 1.666667e-07 0.8652173
# [2,] 3.333333e-07 0.1347827
prop17<-freq17/sum17
prop17
#             value     count
# [1,] 2.001261e-07 0.7956324
# [2,] 4.002522e-07 0.2043676
prop21<-freq21/sum21
prop21
#            value     count
# [1,] 2.001261e-07 0.8572331
# [2,] 4.002522e-07 0.1427669

## creazione di un dataframe
area<-c("Altro","Acqua")
p2000<-c(81,18)
p2006<-c(86,13)
p2017<-c(79,20)
p2021<-c(85,14)
perc<-data.frame(area,p2000,p2006,p2017,p2021)
perc
#      area p2000 p2006 p2017 p2021
#   1 Altro   81    86    79    85
#  2 Acqua    18    13    20    14

## grafico a barre 
# p1<-ggplot(perc,aes(x=area,y=p2000,color=area))+geom_bar(stat="identity",fill="white")
# p2<-ggplot(perc,aes(x=area,y=p2006,color=area))+geom_bar(stat="identity",fill="white")
# p3<-ggplot(perc,aes(x=area,y=p2017,color=area))+geom_bar(stat="identity",fill="white")
# p4<-ggplot(perc,aes(x=area,y=p2021,color=area))+geom_bar(stat="identity",fill="white")
# grid.arrange(p1,p2,p3,p4,nrow=2)




