library(remotes)
remotes::install_github("slu-openGIS/postmastr")
library(tidyverse)
library(skimr)

progress <- read.csv("https://www.dropbox.com/s/xkizpnpyvsjiog9/progress_NC_properties.csv?dl=1", header=TRUE)

progress <- separate(progress, col=Property.Address, into=c('Address', 'City'), sep='\n') 

progress <- progress %>% filter(Address!='')

progress <- separate(progress, col=City, into=c('City', 'ZIP'), sep=',') 

getwd()

write.csv(progress,'progress_props_nc_fixed.csv') 

progressfixed <- read.csv("https://www.dropbox.com/s/ewuudbeic7upfdc/progress_props_nc_fixed.csv?dl=1", header=TRUE)

library(censusxy)
names(progress)
progressgeom <- censusxy::cxy_geocode(progressfixed, street = "Address", 
                     city = "City", 
                     state = "State", 
                     zip = "ZIP", 
                     class = "dataframe")
rm(test)

write.csv(progressgeom,'progress_props_nc_geometry.csv') 
getwd()

#load updated progress property spreadsheet with county column attached
#progpropcounty <- read.csv("https://www.dropbox.com/s/m2o66yp2tpps2o5/nc_progress_w_county.csv?dl=1")

#filter to mecklenburg county progress properties only
meckprop <- progpropcounty %>% filter(CO_NAME=='MECKLENBURG')
#remove hyphens from APN
meckprop$APN <- gsub("-", "", meckprop$APN)

#load mecklenburg code violations
viol <- read.csv("https://www.dropbox.com/s/vvvz6unww2334c8/mecklenburg_code_viol.csv?dl=1")

#change name to match APN in other dataset prior to joining
viol$APN <- viol$ParcelId

#join
progress_props_viol <- inner_join(meckprop, viol, by='APN')

write.csv(progress_props_viol,'progress_props_viol.csv') 

#geocode landmark property address points
properties <- read.csv("https://www.dropbox.com/s/ewuudbeic7upfdc/progress_props_nc_fixed.csv?dl=1", header=TRUE)

library(censusxy)
names(properties)
properties <- censusxy::cxy_geocode(properties, street = "Address", 
                                      city = "City", 
                                      state = "State", 
                                      zip = "ZIP", 
                                      class = "dataframe")
