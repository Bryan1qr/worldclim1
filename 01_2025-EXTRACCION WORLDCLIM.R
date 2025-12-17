
#D:\GRTACNA\2025\DEPOSITO_BOT\FROM_BRYAN

# Extraccion de informacion de Rasters WORLDCLIM en R ---------------------------------
#DATOS CARZO2024
rm(list=ls()) #limpa o ambiente de trabalho

library(tidyverse)
library(raster)
library(sp)
#library(rgdal)
library(readr)


xy <-read.csv("D:/GRTACNA/2025/DEPOSITO_BOT/FROM_BRYAN/Worldclim_actual/xy_anual_carzo2024.csv", sep = ";")

rownames(xy) <- xy$CODE
xy <- xy[,c(2,3)]
names(xy) <- c('x','y')

#FORMA A1:
library(geodata)
library(tidyr)
library(terra)

climate <- getData('worldclim', var='bio', res=0.5, lon=xy$x, lat=xy$y)

Data_frame <- cbind(raster::extract(climate, xy, df = T),xy)
str(Data_frame)
write.csv (Data_frame, "C:/Users/Usuario/Desktop/cafe/world_clim_cafe1.csv")


#FORMA A2:
install.packages("dismo") # o "raster"
library(dismo)
# Luego intenta tu código
climate <- getData("worldclim", var = "bio", res = 0.5, lon = xy$x, lat = xy$y)


#FORMA A3

clima_carzo <- worldclim_global(var= "bio", res= 0.5, path= geodata_path(), version="2.1")


#FORMA A4)
install.packages("worldclim2") # Instala el paquete
library(worldclim2) # Cárgalo

# Para variables bio (temperatura, precipitación)
# Usa wc_data() para descargar y acceder a los datos
# Ejemplo: descargar datos de temperatura media anual (bio1)
bio1_data <- wc_data(type = "bio", version = "2.1", res = 0.5, lon = xy$x, lat = xy$y)

# Para extraer valores en un punto (si 'xy' es un sf/SpatialPoints)
# Si 'xy' ya tiene coordenadas (x, y):
# bio1_point <- wc_data(type = "bio", version = "2.1", res = 0.5, lon = xy$x, lat = xy$y)
# O si tienes un objeto SpatialPoints/sf:
# bio1_sf <- wc_data(type = "bio", version = "2.1", res = 0.5, sp = your_spatial_object)