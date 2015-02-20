library(reshape2)

#read raw data to variables
subject.test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
x.test<-read.table("./UCI HAR Dataset/test/X_test.txt")
y.test<-read.table("./UCI HAR Dataset/test/y_test.txt")

subject.train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
x.train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y.train<-read.table("./UCI HAR Dataset/train/y_train.txt")

feature<-read.table("./UCI HAR Dataset/features.txt")
activity<-read.table("./UCI HAR Dataset/activity_labels.txt")

#merge datasets
X<- rbind(x.test,x.train)
y<- rbind(y.test,y.train)
subject<-rbind(subject.test,subject.train)

#replace lable names
label<-merge(y,activity,by=1)[,2]

#give column names
colnames(X)<-feature[,2]
colnames(subject)<-"subject"

#merge a complete dataset
data<-cbind(subject,label,X)

#subset the data
search<-grep("-mean|-std",colnames(data))
data.sub<-data[,c(1,2,search)]

#generate data.mean
data.melt<-melt(data.sub,id.var=c("subject","label"))
data.mean<-dcast(data.melt,subject+label~variable,mean)

write.table(data.mean,file="tidy_data.txt",row.name=FALSE)









