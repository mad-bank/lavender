############PT 1: CLEANING ADDRESSES#############

library(tidyverse)
library(tidyr)

#Load Real Property CSV from Dropbox
properties <- read.csv("DROPBOX-URL-HERE", header=TRUE)

#Separate address column into street address and city/ZIP
properties <- separate(properties, col=Property.Address, into=c('Address', 'City'), sep='\n') 

#Remove records with no address listed
properties <- properties %>% filter(Address!='')

#Separate combined city/ZIP column into two columns
properties <- separate(properties, col=City, into=c('City', 'ZIP'), sep=',') 

#Remove non-numeric characters from APN for easier matching
properties$APN <- gsub("-", "", properties$APN)

#Write cleaned addresses csv (no geometry attached)
write.csv(properties,'progress_props_nc_fixed.csv') 

############PT. 2: GEOCODE ADDRESSES ##################
#If you are working primarily in QGIS it may be easier to just do this in QGIS.
#Alternatively, you could use the sf package to write a shapefile. 

library(censusxy)
names(properties)

#Match fields to censusxy geocoder inputs
props_geom <- censusxy::cxy_geocode(properties, street = "Address", 
                     city = "City", 
                     state = "State", 
                     zip = "ZIP", 
                     class = "dataframe")


#Write csv of cleaned addresses with geometry attached
write.csv(props_geom,'progress_props_nc_geometry.csv')
