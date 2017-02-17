
readData<-function(main, labels, subject, column_names)
  
{
  # this function takes the three files (main data, suberct ID and activity id
  # and combines them into once data frame
  # call the function once for training data and once for testing data
  data<-read.table(main)
  subject_id<-read.table(subject)
  subject_id<-as.factor(subject_id$V1)
  
  activity<-read.table(labels)
  activity<-as.factor(activity$V1)
  
  names(data)<-column_names
  data<-cbind(activity, data)
  data<-cbind(subject_id, data)
  
  return(data)
}

cleanupNames<-function(names)
{
  for(i in 1:length(names)) names[i]<-gsub("Acc", ".Accelerometer", names[i])
  for(i in 1:length(names)) names[i]<-gsub("Gyro", ".Gyroscope", names[i])
  for(i in 1:length(names)) names[i]<-gsub("Mag", ".Magnitude", names[i])
  for(i in 1:length(names)) names[i]<-gsub("Jerk", ".Jerk", names[i])
  for(i in 1:length(names)) 
  {
    if(substring(names[i],1,1)=="t") 
      names[i]<-sub("t", "Time.", names[i])
  }
  for(i in 1:length(names)) 
  {
    if(substring(names[i],1,1) =="f")
      names[i]<-sub("f", "Frequency.", names[i])
  }
  return(names)
}

# set working directory to be UCI HAR Dataset

# read the 'meta-data' files
activity_labels<-read.table("activity_labels.txt")
column_names<-read.table("features.txt")
column_names<-column_names$V2

#then read the actual data
#starting with the traing data, "X_train.txt"."Y_train.txt", and "subject_train.txt"

training_data<-readData("./train/X_train.txt","./train/Y_train.txt", 
                        "./train/subject_train.txt", column_names)
testing_data<-readData("./test/X_test.txt","./test/Y_test.txt", 
                       "./test/subject_test.txt", column_names)

# and then combine the two data frames using rbind - this answers point 1

data<-rbind(training_data, testing_data)


# extract measurements on mean and standard deviation only...

select_cols1<-grep("-mean()", names(data), ignore.case = TRUE)
select_cols2<-grep("-std()", names(data), ignore.case = TRUE)
select_cols<-c(1,2,select_cols1, select_cols2)
sub_data<-data[,select_cols]

# this addresses item 2 in the assignment

#assign descriptive names to activity labels - item 3

levels(sub_data$activity)<-levels(activity_labels$V2)

# then run cleanupNames to assign more descriptive column names

names(sub_data)<-cleanupNames(names(sub_data))

# this addressed point 4

#finally, create the "tidy" data
# remember to have the "dplyr" package installed for this step

group<-group_by(sub_data, subject_id, activity)
tidy_data<-summarize_each(group, funs(mean))

# the data frame erquested at point 5 is in the "tidy_data" data frame
# as a last step, write the data to a csv file
write.csv(tidy_data, "tidy_data.csv")

