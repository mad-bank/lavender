library(tidyverse)
library(dplyr)

#load county data 
washington <- read.csv("https://www.dropbox.com/s/coso69uej3gpiwq/washington.csv?dl=1")
anoka <- read.csv("https://www.dropbox.com/s/pu49qdbhrh6vcyu/anoka.csv?dl=1")
carver <- read.csv("https://www.dropbox.com/s/s68iynpsjcdxbuv/carver.csv?dl=1")
dakota <- read.csv("https://www.dropbox.com/s/h99u9fne31hg73j/dakota.csv?dl=1")
hennepin <- read.csv("https://www.dropbox.com/s/0gydy3ae4sqw1hn/hennepin.csv?dl=1")
ramsey <- read.csv("https://www.dropbox.com/s/6argx98bl3bby0d/ramsey.csv?dl=1")
scott <- read.csv("https://www.dropbox.com/s/k2l2nzlzv1kkeha/scott.csv?dl=1")

# relevant columns where keywords may be located: "OWNER_NAME", "OWNER_MORE", "OWN_ADD_L1",
#"OWN_ADD_L2", "OWN_ADD_L3","OWN_ADD_L4", "TAX_NAME", "TAX_ADD_L1", 
#"TAX_ADD_L2", "TAX_ADD_L3","TAX_ADD_L4")

#filter out records where one or more of these columns contains a key word
#this is probably done better with a function but idk how to do that
washington_fil <- washington %>% 
  dplyr::filter(if_any(contains(c("OWN","TAX")), 
                       ~grepl('SCOTTSDALE|3505 KOGER|DULUTH GA|DULUTH, GA|
                              FYR SFR|VYR SFR|HOME SFR|MN EQUITABLE|HAVENBROOK|
                              7500 N DOBSON|ALTISOURCE|RESI ', .)))

anoka_fil <- anoka %>% 
  dplyr::filter(if_any(contains(c("OWN","TAX")), 
                       ~grepl('SCOTTSDALE|3505 KOGER|DULUTH GA|DULUTH, GA|
                              FYR SFR|VYR SFR|HOME SFR|MN EQUITABLE|HAVENBROOK|
                              7500 N DOBSON|ALTISOURCE|RESI ', .)))

carver_fil <- carver %>% 
  dplyr::filter(if_any(contains(c("OWN","TAX")), 
                       ~grepl('SCOTTSDALE|3505 KOGER|DULUTH GA|DULUTH, GA|
                              FYR SFR|VYR SFR|HOME SFR|MN EQUITABLE|HAVENBROOK|
                              7500 N DOBSON|ALTISOURCE|RESI ', .)))

scott_fil <- scott %>% 
  dplyr::filter(if_any(contains(c("OWN","TAX")), 
                       ~grepl('SCOTTSDALE|3505 KOGER|DULUTH GA|DULUTH, GA|
                              FYR SFR|VYR SFR|HOME SFR|MN EQUITABLE|HAVENBROOK|
                              7500 N DOBSON|ALTISOURCE|RESI ', .)))

ramsey_fil <- ramsey %>% 
  dplyr::filter(if_any(contains(c("OWN","TAX")), 
                       ~grepl('SCOTTSDALE|3505 KOGER|DULUTH GA|DULUTH, GA|
                              FYR SFR|VYR SFR|HOME SFR|MN EQUITABLE|HAVENBROOK|
                              7500 N DOBSON|ALTISOURCE|RESI ', .)))

hennepin_fil <- hennepin %>% 
  dplyr::filter(if_any(contains(c("OWN","TAX")), 
                       ~grepl('SCOTTSDALE|3505 KOGER|DULUTH GA|DULUTH, GA|
                              FYR SFR|VYR SFR|HOME SFR|MN EQUITABLE|HAVENBROOK|
                              7500 N DOBSON|ALTISOURCE|RESI ', .)))

dakota_fil <- dakota %>% 
  dplyr::filter(if_any(contains(c("OWN","TAX")), 
                       ~grepl('SCOTTSDALE|3505 KOGER|DULUTH GA|DULUTH, GA|
                              FYR SFR|VYR SFR|HOME SFR|MN EQUITABLE|HAVENBROOK|
                              7500 N DOBSON|ALTISOURCE|RESI ', .)))


#merge dataframes
all <- rbind(washington_fil, carver_fil, anoka_fil, ramsey_fil, 
              hennepin_fil, scott_fil, dakota_fil)

#write to new file
write.csv(all, "./progress_props_unchecked.csv", row.names = T)

       