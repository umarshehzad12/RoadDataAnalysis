#install.packages("caret")
{rm(list=ls())
getwd()
setwd("G:\\Thesis\\jan 18 data")

colselector<-function(data)
{
  data<-data[,c(1,2,3)]
  names(data)<-c("time", "Latitude", "Longitude")
  data<-na.omit(data)
  return(data)
}

remoutlier<-function(data)
{
  rows<-nrow(data)
  data<-data[10:(rows-10),]
}

directori<-list.dirs()
gps_data<-list()
intmed_df<-data.frame()
new_f_dir<-list()

}
for(i in 2:length(directori))
{
  stringer<-c(directori[i],"gps_data_log.txt") 
  stringer2<-c(directori[i],"cleaned_gps_data")
  directori[i]<-paste(stringer,collapse = "/")
  new_f_dir[i]<-paste(stringer2,collapse = "/")
  #gsub("/", "\\", directori[i],ignore.case=T)
  intmed_df<-read.table(directori[i], na.strings=c("","NA", " ", "0"), sep = ",")
  intmed_df<-remoutlier(intmed_df)
  intmed_df<-colselector(intmed_df)
  
  gps_data[[i-1]]<-intmed_df
 write.csv(gps_data[i-1], file = new_f_dir[[i]])
}
