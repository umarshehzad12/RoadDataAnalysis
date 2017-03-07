{rm(list=ls())
getwd()
setwd("G:\\Thesis\\jan 19 data")
directori<-list.dirs()
gyro_data<-list()
gps_data<-list()
combined_data<-list()
intmed_df_gyro<-data.frame()
intmed_df_gps<-data.frame()
intmed_df_gps_odd<-data.frame()
intmed_df_gps_even<-data.frame()
intmed_df_gps_combined<-data.frame()
merged<-data.frame
gyro_f_dir<-list()
gps_f_dir<-list()
merged_f_dir<-list()
gps_time<-list()
gyro_time<-list()

options(digits.secs=2)

colselector<-function(data)
{
  data<-na.omit(data)
  data<-data[,c(3,4,5,6)]
  return(data)
}

colselector2<-function(data)
{
  data<-na.omit(data)
  data<-data[,c(1,2,3,4,8,9)]
  return(data)
  
}
}


# for(i in 2:length(directori))
# {
#   
#   stringer<-c(directori[i],"gyro_data_w_posix.csv")
#   stringer2<-c(directori[i],"gps_data_w_posix.csv")
#   stringer3<-c(directori[i],"merged_data")
#   
#   gyro_f_dir[i]<-paste(stringer,collapse = "/")
#   gps_f_dir[i]<-paste(stringer2,collapse = "/")
#   merged_f_dir[i]<-paste(stringer3,collapse = "/")
#   intmed_df_gyro<-read.csv(gyro_f_dir[[i]], na.strings=c("","NA", " ", "0"), sep = ",")
#   intmed_df_gps<-read.csv(gps_f_dir[[i]], na.strings=c("","NA", " ", "0"), sep = ",")
#   intmed_df_gyro<-colselector(intmed_df_gyro)
#   intmed_df_gyro[[4]]=as.POSIXct(intmed_df_gyro[[4]])
#   intmed_df_gps[[2]]=as.POSIXct(intmed_df_gps[[2]])
#   intmed_df_gps<-intmed_df_gps[rep(1:nrow(intmed_df_gps),each=70),]
#   for(j in 1:length(intmed_df_gps[[2]]))
#   {
#     intmed_df_gps[[2]][[j]]<-(intmed_df_gps[[2]][[j]]+(0.001*(j%%71)))
#   }
#   merged<-merge(intmed_df_gyro,intmed_df_gps, "time")
#   gyro_data[[i-1]]<-intmed_df_gyro
#   gps_data[[i-1]]<-intmed_df_gps
#   combined_data[[i-1]]<-merged
#   write.csv(combined_data[i-1], file = merged_f_dir[[i]])
# }


for(i in 2:length(directori))
{
{
  stringer<-c(directori[i],"gyro_data_w_posix.csv")
stringer2<-c(directori[i],"gps_data_w_posix.csv")
stringer3<-c(directori[i],"merged_data")

gyro_f_dir[i]<-paste(stringer,collapse = "/")
gps_f_dir[i]<-paste(stringer2,collapse = "/")
merged_f_dir[i]<-paste(stringer3,collapse = "/")
intmed_df_gyro<-read.csv(gyro_f_dir[[i]], na.strings=c("","NA", " ", "0"), sep = ",")
intmed_df_gps<-read.csv(gps_f_dir[[i]], na.strings=c("","NA", " ", "0"), sep = ",")
intmed_df_gyro<-colselector(intmed_df_gyro)


intmed_df_gps[[2]]=as.POSIXct(intmed_df_gps[[2]])
intmed_df_gps_odd<-intmed_df_gps[c(TRUE,FALSE),]
intmed_df_gps_even<-intmed_df_gps[c(FALSE, TRUE),]
#intmed_df_gps_combined<-merge(intmed_df_gps_odd, intmed_df_gps_even,by = "X")
}


{
odd_d<-as.integer(((intmed_df_gps[[2]][[2]]-intmed_df_gps[[2]][[1]]))*100)
even_d<-as.integer(((intmed_df_gps[[2]][[3]]-intmed_df_gps[[2]][[2]]))*100)


intmed_df_gps_even<-intmed_df_gps_even[rep(1:nrow(intmed_df_gps_even),each=even_d),]
intmed_df_gps_odd<-intmed_df_gps_odd[rep(1:nrow(intmed_df_gps_odd),each=odd_d),]
}
{
for(j in 1:length(intmed_df_gps_even[,1]))
{
  intmed_df_gps_even[[2]][[j]]<-(intmed_df_gps_even[[2]][[j]]+(0.01*(j%%(even_d+1))))
}
for(j in 1:length(intmed_df_gps_odd[,1]))
{
  intmed_df_gps_odd[[2]][[j]]<-(intmed_df_gps_odd[[2]][[j]]+(0.01*(j%%(odd_d+1))))
}

  }

intmed_df_gps_combined<-rbind.data.frame(intmed_df_gps_even,intmed_df_gps_odd)
intmed_df_gps_combined<-intmed_df_gps_combined[order(intmed_df_gps_combined),]
intmed_df_gps_combined<-na.omit(intmed_df_gps_combined)

options(digits.secs=2)
intmed_df_gyro[[4]]=as.POSIXct(intmed_df_gyro[[4]])
intmed_df_gps_combined$time_f<-as.factor(intmed_df_gps_combined[[2]])
intmed_df_gyro$time_f<-as.factor(intmed_df_gyro$time)
merged<-merge(intmed_df_gyro,intmed_df_gps_combined, "time_f")
merged<-colselector2(merged)

combined_data[[i-1]]<-merged
write.csv(combined_data[i-1], file = merged_f_dir[[i]])
}

#intmed_df_gps_combined$int_time<-as.integer(intmed_df_gps_combined$time)
# 
# if(even_d>odd_d)
# {
# intmed_df_gps_even<-intmed_df_gps_even[rep(1:nrow(intmed_df_gps),each=(as.integer(even_d*100))),]
# intmed_df_gps_odd<-intmed_df_gps_odd[rep(1:nrow(intmed_df_gps),each=(as.integer(odd_d*100))),]
# 
# for(j in 1:length(intmed_df_gps_even[,1]))
# {
#   intmed_df_gps_even[[2]][[j]]<-(intmed_df_gps_even[[2]][[j]]+(0.01*(j%%even_d)))
# }
# for(j in 1:length(intmed_df_gps_odd[,1]))
# {
#   intmed_df_gps_odd[[2]][[j]]<-(intmed_df_gps_odd[[2]][[j]]+(0.01*(j%%odd_d)))
# }
# }else {intmed_df_gps_even<-intmed_df_gps_even[rep(1:nrow(intmed_df_gps),each=odd_d),]
# intmed_df_gps_odd<-intmed_df_gps_odd[rep(1:nrow(intmed_df_gps),each=even_d),]
# for(j in 1:length(intmed_df_gps_even[,1]))
# {
#   intmed_df_gps_even[[2]][[j]]<-(intmed_df_gps_even[[2]][[j]]+(0.01*(j%%13)))
# }
# for(j in 1:length(intmed_df_gps_odd[,1]))
# {
#   intmed_df_gps_odd[[2]][[j]]<-(intmed_df_gps_odd[[2]][[j]]+(0.01*(j%%81)))
# }
# }
# 
# 


# for(j in 1:length(intmed_df_gps_combined[,1]))
# {
#   intmed_df_gps_combined[[2]][[j]]<-(intmed_df_gps_combined[[2]][[j]]+(0.01*(j%%92)))
# }

#merged<-merge(intmed_df_gyro,intmed_df_gps, "time")

