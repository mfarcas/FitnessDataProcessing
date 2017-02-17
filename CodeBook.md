DATA. There are three sets of data: (1) the 'meta-data', (2) the training data and (3) the
test data.
  (1) the meta-data consists of two files, one with descriptive names for the six
  types of activity(SITTING, STANDING, WALKING, etc.) Activity types appear as 
  numbers 1 through 6 in the data files and at some point (to address item 3 in the
  assignment) we are convering them to words based on one of the two meta-data files.
  The second meta-data file has the column names for the 561 data columns in the meain data files.
  
  (2) the training data consists of three files, the main data file containing all the measurements (X_train.txt), a file with associated subject ID's (subject_train.txt), one for each record in the measurement file and an activity file (Y_train.txt). The script reads the three files one by one in three separate data frames and combines them with cbind(). the "readData()" function does this job.
  
  (3) the test data consists of three files, the main data file containing all the measurements (X_test.txt), a file with associated subject ID's (subject_test.txt), one for each record in the measurement file and an activity file (Y_test.txt). The script reads the three files one by one in three separate data frames and combines them with cbind(). the "readData()" function does this job. Note that the structure of these files is identical to the structure of the traing files. That will make it straightforward to combine to address point 1 in the assignment.
  
  DATA PROCESSING. The script perfroms the following actions:
  (1) read the raw data (as described above)
  (2) create a "training_data" and a "testing_data" data frame, identical in structure, with the first two columns containing subject id and activity id respectively, then 561 data columns
  (3) assign column names to the measurements, based on the meta-data file "factors.txt"
  (4) Combine the training and testing data sets with rbind() - This addresses the first item in the assignment. The "data" data frame is created
  (5) from the super-set of column names, select the ones that contain either "-mean()" or "-std()" patterns to get all the means and standard deviations. Use grep() for this purpose
  (6) subset from the "data" data frame to create the "sub_data" data frame; we go from 561 measuremnt columns to 81 columns - this addresses item 3 in the assignment
  (7) use a simple assignment to give activities a name rather than just an ID - this addresses item 3. It's of the form "levels(x)<-levels(y)"
  (8) clean up the names of the 81 columns by assigning less cryptic names - the cleanupNames() function is utilized for this purpose - this addresses item 4 in the assignment
  (9) use the "dplyr" package to group (group_by() function) and then calculate means for each data column with summarize(each) - the "tidy_data" data frame is created, one record for each combination of subject(30 subjects in total) and activity (6 activities).
  (10) write the tidy data results into a file tidy_data.txt that will be submitted with the script
  (10) 
   
