#* Extracción de valores puntuales de variables bio-worldClim V2.1
library(tidyverse)
library(terra)
library(geodata)

#* Cargamos la tabla de coordenadas EPSG 4326:
xy <- read.csv("xy_anual_carzo2024.csv", sep = ";")

#* Renombramos
rownames(xy) <- xy$CODE
xy <- xy[,c(2,3)]
names(xy) <- c('x','y')

#* Seleccionamos las imágenes y las ponemos en stack:
data1 <- list.files(
  path = "bio_clim",
  pattern = "*.asc",
  full.names = TRUE
)

climate <- terra::rast(data1)

#* Integramos la data en un dataframe:
Data_frame <- cbind(
  raster::extract(
    climate, xy, df = T),xy
  )

str(Data_frame)

#* Guardamos
write.csv (Data_frame, "world_clim_data_frame.csv")

#? Si los valoes salen NA es porque las imágenes no coinciden con la ubicación
#? de las coordenadas
