#Global data
featureNames<-read.table("features.txt",stringsAsFactors=FALSE)[,2]
featureNamesClean<-gsub("\\-|\\(|\\)","",featureNames) #Remove special characters
activityLabels<-read.table("activity_labels.txt",stringsAsFactors=FALSE,col.names=c("label","activity"))
#Train data
subjectsTrain<-read.table("train/subject_train.txt",col.names="subject")
featuresTrain<-read.table("train/X_train.txt",col.names=featureNamesClean)
activityTrain<-read.table("train/y_train.txt",col.names="label")
activityTrain$activity<-activityLabels$activity[activityTrain$label] #Keep the label, not the number
trainData<-data.frame(subjectsTrain,activity=activityTrain$activity,featuresTrain)
#Test data
subjectsTest<-read.table("test/subject_test.txt",col.names="subject")
featuresTest<-read.table("test/X_test.txt",col.names=featureNamesClean)
activityTest<-read.table("test/y_test.txt",col.names="label")
activityTest$activity<-activityLabels$activity[activityTest$label]
testData<-data.frame(subjectsTest,activity=activityTest$activity,featuresTest)
#Merge data
data<-rbind(trainData,testData)
#Keep only mean- and std-related features
dataSmall<-data[,c(1,2,grep("meanX|meanY|meanZ|mean$|stdX|stdY|stdZ|std$",colnames(data)))]
featureNamesSmall<-colnames(dataSmall)[3:ncol(dataSmall)]
#Create tidy data
subjectsTidy<-rep(1:30,each=6)
activityTidy<-rep(sort(activityLabels$activity),6)
featuresTidy<-data.frame(matrix(ncol=length(featureNamesSmall),nrow=length(subjectsTidy)))
colnames(featuresTidy)<-featureNamesSmall
dataTidy<-data.frame(subject=subjectsTidy,activity=activityTidy,featuresTidy)
for(i in 3:ncol(dataSmall)) #For each feature (except subject and activity)
{
  for(j in 1:length(unique(dataSmall$subject))) #For each subject
  {
    dataAux<-subset(dataSmall,dataSmall$subject==j)
    dataTidy[c((j*6-5):(j*6)),i]<-tapply(dataAux[,i],dataAux$activity,mean) #Get and store average per activity
  }
}
#Write tidy dataset
write.table(dataTidy,"dataTidy.txt",row.name=FALSE)