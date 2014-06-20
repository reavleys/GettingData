##setwd("d:/R_examples/project_cleaning_data") 

library(data.table)
##create directory labels
datadir      <-"./UCI HAR Dataset"
traindatadir <-"./UCI HAR Dataset/train"
testdatadir  <-"./UCI HAR Dataset/test"

##extract list of feature names from the features file
features <-read.table(paste(datadir,"/","features.txt",sep=""),stringsAsFactors=FALSE)

##extract a list of activity_lables from the labels file
labels <-read.table(paste(datadir,"/","activity_labels.txt",sep=""), stringsAsFactors=FALSE)

## extract a list corresponding to variables which contain Standard Deviation measurements
std<-grep("std",features[,2])
## extract a list corresponding to variables which contain mean measurements to a list
mean<-grep("mean",features[,2])
##remove special characters (-) from the names
features[,2]<-gsub("[\\(\\)\\-]","",features[,2])

##pull in test data
test <-read.table(paste(testdatadir,"/X_test.txt",sep=""), row.names=NULL)
## name the xtest df columns from features file
colnames(test)<-features[,2]


##add column giving the datasource
test$source<-"test"

##pull in train data
train <-read.table(paste(traindatadir,"/X_train.txt",sep=""), row.names=NULL)
## add column names from features
colnames(train)<-features[,2]

##add column giving the datasource
train$source<-"train"

## merge the train and test datasets
ttdata<-rbind(train,test)

## pull in the activity label information.
trainactivitylabel <-read.table(paste(traindatadir,"/Y_train.txt",sep=""), row.names=NULL)
testactivitylabel <-read.table(paste(testdatadir,"/Y_test.txt",sep=""), row.names=NULL)
## merge datasets
ttactivitylabel<- rbind(trainactivitylabel,testactivitylabel)

## pull in the subject information.

trainsubject <-read.table(paste(traindatadir,"/subject_train.txt",sep=""), row.names=NULL)
testsubject <-read.table(paste(testdatadir,"/subject_test.txt",sep=""), row.names=NULL)
## merge datasets
ttsubject <-rbind(trainsubject,testsubject)

output<-ttdata[,c(std,mean,562)]
output$subject <-ttsubject$V1
output$activity_label<-ttactivitylabel$V1
output$activity<-labels[output$activity_label,2]
##Reorder columns
output<-output[,c(80,81,83,1:79)]

write.table(output,file= "tidydata1.txt")

##create average for each variable
average<-lapply(output[,4:82],mean)
average<-data.frame(c(label="average",average),stringsAsFactors=FALSE)

##average for each by subject
averagebysubject<-with(output,aggregate(output[,4:82],by = list(subject),FUN=mean))
averagebysubject$label<-"bysubject"
averagebysubject<-averagebysubject[,c(81,2:80)]

##average for each by activity
averagebyactivity<-with(output,aggregate(output[,4:82],by = list(activity),FUN=mean))
averagebyactivity$label<-"byactivity"
averagebyactivity<-averagebyactivity[,c(81,2:80)]


## create single table
averages<-rbind(average,averagebysubject,averagebyactivity)

write.table(averages,file= "tidydata2.txt")          

