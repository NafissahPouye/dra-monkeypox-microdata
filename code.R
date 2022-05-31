library(readxl)      #for excel, csv sheets manipulation
library(sdcMicro)    #sdcMicro package with functions for the SDC process 
library(tidyverse)   #optional #for data cleaning

#Import data
setwd("C:/Users/LENOVO T46OS/Desktop/dra-monkeypox-microdata")
data <- read_excel("monkeypox-microdata.xlsx", 
                   col_types = c("numeric", "text", "text", 
                                 "text", "text", "text", "text", "date", 
                                 "date", "text", "text", "date", "text", 
                                 "date", "numeric", "text", "numeric", 
                                 "text", "text", "numeric", "text", 
                                 "text", "text", "text", "text", "text", 
                                 "text", "text", "date", "date", "text"))
selectedKeyVars <- c('Location', 'City', 'Gender', 'Hospitalised',
                     'Date_hospitalisation', 'Travel_history_location')


#Convert variables into factors
cols =  c('Location', 'City', 'Gender', 'Hospitalised',
          'Date_hospitalisation', 'Travel_history_location')

data[,cols] <- lapply(data[,cols], factor)

#Convert the sub file into dataframe
subVars <- c(selectedKeyVars)
fileRes<-data[,subVars]
fileRes <- as.data.frame(fileRes)

objSDC <- createSdcObj(dat = fileRes, 
                       keyVars = selectedKeyVars)

print(objSDC, "risk")

#Generate an internal report
report(objSDC, filename = "index",internal = T, verbose = TRUE) 
