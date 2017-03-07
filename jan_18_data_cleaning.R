#install.packages("caret")
rm(list=ls())
getwd()
setwd("G:\\Thesis\\jan 18 data")

colselector<-function(data)
{
  names(data)<-c("x", "x_normalized", "y", "y_normalized", "z", "z_normalized", "time")
  data<-na.omit(data)
  data<-data[,c(1,3,5,7)]
  return(data)
}

remoutlier<-function(data)
{
  cols<-ncol(data)-1
  for(i in cols)
  {
    quants<-quantile(data[,cols])
    IQR<-quants[2]-quants[4]
    minoutlier<-1.5*IQR+quants[2]
    maxoutlier<-1.5*IQR-quants[4]
    inliers<-(data[,cols]>minoutlier&data[,cols]<maxoutlier)
    table(inliers)["TRUE"]
    data[,cols][!inliers]<-NA
    return(data)
  }
}

directori<-list.dirs()
gyro_data<-list()
intmed_df<-data.frame()
new_f_dir<-list()
for(i in 2:length(directori))
{
 stringer<-c(directori[i],"gyro_data_p6_3.txt") 
 stringer2<-c(directori[i],"cleaned_gyro_data")
 directori[i]<-paste(stringer,collapse = "/")
 new_f_dir[i]<-paste(stringer2,collapse = "/")
 gsub("/", "\\", directori[i],ignore.case=T)
 intmed_df<-read.table(directori[i], na.strings=c("","NA", " ", "0"), sep = ",")
 intmed_df<-colselector(intmed_df)
 gyro_data[[i-1]]<-intmed_df
 write.csv(gyro_data[i-1], file = new_f_dir[[i]])
}

#bcat_1<-read.table("jan 18 data\\bcat_1\\gyro_data_p6_3.txt", na.strings=c("","NA", " ", "0"), sep = ",")
#bcat_2<-read.table("jan 18 data\\bcat_2\\gyro_data_p6_3.txt", na.strings=c("","NA", " ", "0"), sep = ",")

#View(gyro)

# 
# bcat_1<-colselector(bcat_1)

#bcat_1<-remoutlier(bcat_1)

#bcat_1<-na.omit(bcat_1)
#quants<-quantile(gyro[,1])
#quants<-quantile(gyro$x)
#IQR<-quants[2]-quants[4]
#minoutlier<-1.5*IQR+quants[2]
#maxoutlier<-1.5*IQR-quants[4]
#gyro2<-(gyro$x>minoutlier&gyro$x<maxoutlier)
#table(gyro2)["TRUE"]
#gyro$x[!gyro2]<-NA