README
========================================================

## create directory labels to be used to locate the files
## extract a dataframe of activity_lables from the "labels"" file
## extract a dataframe of feature names from the "features" file
## extract a list std corresponding to variables which contain Standard Deviation measurements
## extract a list mean corresponding to variables which contain mean measurements to a list
## remove special characters "(","-",")" from variable names in the features list
## read in the x_test data file
## name the columns using the features list
## add column giving the datasource
## repeat this for the x_train data file
## merge the train and test datasets into one data frame
## read in the activity label information from the y_train ans y_test files to a data frame
## merge the test and train activity label dataframes
## read in the subject information from the test and train files to a data frame
## merge the test and train subject dataframes
## select the columns fron the data file which have sdt() or mean() in the variable names 
## output these columns to an output data frame plus a colun to show the data source (test or train)
## add a subject column using the subjects dataframe
## add an activity_label column using the activity lables dataframe
## add an activity column by looking up the activity names against the activity labels
## Reorder columns and remove the Activity_lable column.
## Write the output to a file "tidydata1.txt"

##create a data frame for the average for each variable
##create a dataframe for the average for each variable by subject
##create a dataframe for the average for each variable by activity
## create single dataframe by binding these frames together
## Write the output to a file "tidydata2.txt"        
