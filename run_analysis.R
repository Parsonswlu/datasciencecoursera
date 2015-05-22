library(dplyr)

#Read in and merge the datasets by adding the Test data as rows under the Training data
#This completes the requirement for part 1
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt",colClasses="numeric")
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt",colClasses="numeric")
dataTable<-rbind(X_train,X_test)

#Read in the Features data and find and extract the columns associates with "mean()" and "std()"
#This completes the requirement for part 2
features<-read.table("./UCI HAR Dataset/features.txt") 
neededCols<-grepl("mean()",features[,2]) | grepl("std()",features[,2])
dataTable<-dataTable[,neededCols]

#Read in the Activity number associated with each observation and combine training and testing  
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt",colClasses="factor")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt",colClasses="factor")
activityData<-rbind(y_train,y_test)

activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
levels(activityData$V1)<-activity_labels[,2]

#Read in the Subject number associated with each observation and combine training and testing 
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt",colClasses="factor")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt",colClasses="factor")
subjectData<-rbind(subject_train,subject_test)

#Combine extracted data columns with the type of activity and subject 
#This completes the requirement for part 3
dataTable<-cbind(activityData,subjectData,dataTable)

#Rename column headings to reflect the Activity, Subject, and relevent variable
#This completes the requirement for part 4
colnames(dataTable)=c("Activity","Subject",as.character(features[neededCols,2]))

#Create a second independent tidy data set with the average of each variable for each activity
#and each subject
#This completes the requirement for part 5
data<-tbl_df(dataTable) %>% group_by(Activity,Subject)
data<-data %>% summarise_each(funs(mean))
data<-arrange(data,as.numeric(as.character(Subject)))

#Writes the second data set to a txt file "tidy_data.txt"
write.table(data,file="tidy_data.txt", row.names=FALSE)