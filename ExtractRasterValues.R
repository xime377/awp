
#This script extracts raster values to a csv file with x and y coordinates
#The inputs (PRE_rasters folder and csv file ***SHOW THIS FILE***) must be in the same directory 
# Author: Yunuen Reygadas

############################################################################
#Set the user-define parameters
#Working directory (where the PRE_rasters folder and csv file are located)
dir<-"D:/Yunuen/2Job/ASU_Colombia/Workshop"
#Name of csv file with x and y coordinates
points<-"Pre_points_gcs.csv"
#Name of the output csv file that will contain coordinates and raster values
output<- "AnnualPrecipitation_2000_2020.csv"
############################################################################

#Load the raster packages needed
library(raster)
library(rgdal)

#Set the directory where the rasters are located
setwd(paste0(dir,"/PRE_rasters"))

#Creates a list with all desired rasters 
rasterlist <- list.files(pattern =".tif$")
print(rasterlist)

#Stack the rasters of the list
rasterStack = stack(rasterlist)

#Read the x and y coordinates, used to extract the raster values, and convert them into a spatial points data frame
points_coor=read.csv(paste0(dir,"/",points))
coordinates(points_coor)= ~ POINT_X+ POINT_Y

#Extract  raster value using the spatial points data frame
ras_value=extract(rasterStack, points_coor)

#Combine raster values with the spatial points data frame 
coor_value=cbind(points_coor,ras_value)

#Save the combination as csv file 
write.table(coor_value,file=paste0(dir,"/",output), append=FALSE, sep= ",", row.names = FALSE, col.names=TRUE)
