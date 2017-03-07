{
rm(list=ls())
keylog_f_dir<-list()
merged_f_dir<-list()
events_f_dir<-list()
options(digits.secs=2)
}
  
  
{
  setwd("G:\\Thesis\\jan 18 data")
  cd<-getwd()
  directori<-list.dirs()
  f_dir<-list()
}


{
stringer<-c(directori[2],"keylog.txt")
stringer2<-c(directori[2],"merged_data")
stringer3<-c(directori[2],"event_data.csv")

keylog_f_dir[2]<-paste(stringer,collapse = "/")
merged_f_dir[2]<-paste(stringer2,collapse = "/")
events_f_dir[2]<-paste(stringer3,collapse = "/")
intmed_f_keylog<-read.csv(keylog_f_dir[[2]], na.strings=c("","NA", " ", "0"), sep = "\t",header = FALSE)
#intmed_f_keylog_minus<-intmed_f_keylog
#intmed_f_keylog_plus<-intmed_f_keylog

intmed_f_merged<-read.csv(merged_f_dir[[2]], na.strings=c("","NA", " ", "0"), sep = ",")
intmed_f_events<-data.frame()

}



{
  names(intmed_f_keylog)<-c("Event #", "Event Type", "time")
  
  intmed_f_keylog[[1]]<-sub("Event # ", "", intmed_f_keylog[[1]])
  intmed_f_keylog[[1]]<-sub(" ", "", intmed_f_keylog[[1]])
  intmed_f_keylog[[1]]<-as.integer(intmed_f_keylog[[1]])
  
  intmed_f_keylog[[2]]<-sub("Event Type ", "", intmed_f_keylog[[2]])
  intmed_f_keylog[[2]]<-sub(" ", "", intmed_f_keylog[[2]])
  intmed_f_keylog[[2]]<-as.factor(intmed_f_keylog[[2]])
  
  intmed_f_keylog[[3]]<-sub("time ", "", intmed_f_keylog[[3]])
  intmed_f_keylog[[3]]<-sub("2017 1 18", "2017 03 02", intmed_f_keylog[[3]])
  intmed_f_keylog[[3]]<-as.POSIXct(intmed_f_keylog$time,format="%Y %m %d %H %M %OS", tz="GMT")
  intmed_f_keylog[[3]]<-intmed_f_keylog[[3]]-18020
}


{
  
  intmed_f_2<-intmed_f_keylog
  for(j in 2:length(intmed_f_keylog[,1]))
  {
    if((intmed_f_keylog[[3]][[j]]-intmed_f_keylog[[3]][[j-1]])<1.5)
      intmed_f_2<-intmed_f_keylog[-c(j),]
  }
}

{
  intmed_f_keylog<-intmed_f_2
  
  
  intmed_f_keylog_minus<-intmed_f_keylog
  intmed_f_keylog_plus<-intmed_f_keylog
  intmed_f_keylog_minus[[3]]<-intmed_f_keylog[[3]]-1
  intmed_f_keylog_plus[[3]]<-intmed_f_keylog[[3]]+1
  intmed_f_keylog_minus<-intmed_f_keylog_minus[rep(1:nrow(intmed_f_keylog_minus),each=100),]
  intmed_f_keylog_plus<-intmed_f_keylog_plus[rep(1:nrow(intmed_f_keylog_plus),each=100),]
  for(j in 1:length(intmed_f_keylog_minus[,1]))
  {
    intmed_f_keylog_minus[[3]][[j]]<-(intmed_f_keylog_minus[[3]][[j]]+(0.01*(j%%(100))))
    intmed_f_keylog_plus[[3]][[j]]<-(intmed_f_keylog_plus[[3]][[j]]-(0.01*(j%%(100))))
  }
intmed_f_keylog<-rbind.data.frame(intmed_f_keylog_minus,intmed_f_keylog_plus)
intmed_f_keylog<-intmed_f_keylog[order(intmed_f_keylog$time),] 
    
}

intmed_f_keylog$time_f<-as.factor(intmed_f_keylog$time)
intmed_f_merged$time_f<-as.factor(intmed_f_merged$time_f)
intmed_f_events<-merge(intmed_f_keylog,intmed_f_merged, "time_f")

