P3
==

Coursera - Getting and Cleaning Data Course Project

The run_analysis.R script accesses the files available from  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip once they 
have been downloaded to your working directory.

Before performing any transformation, the script checks that the "UCI HAR Dataset" folder exists, 
otherwise it will attempt to unzip the "getdata_projectfiles_UCI HAR Dataset.zip" or else stop the 
process and display an error.

The script will then create the following data frames

    activityLabels
    features
    subjTest
    yTest
    Xtest
    subjTrain
    yTrain
    Xtrain

from these files which are located in the "UCI HAR Dataset" folder

    activity_labels.txt
    features.txt
    subject_test.txt
    y_test.txt
    X_test.txt
    subject_train.txt
    y_train.txt
    X_train.txt

The script then assigns the second column of the "features" data frame as the
column names of both the "XTest" and "Xtrain" data frames.

Next, the script creates a data frame named "Test" by column binding the
"subjTest" and "yTest" data frames.

"subject" and "activity" are then assigned as the column names of the "Test"
data frame.

The script then creates a data frame named "Train" by column binding the
"subjTrain" and "yTrain" data frames.

"subject" and "activity" are then assigned as the column names of the "Train"
data frame.
    
Subsequently, the script creates the "testData" data frame by column binding
the "Test" and "XTest" data frames.

Then the script creates the "trainData" data frame by column binding
the "Train" and "XTrain" data frames.
    
Next, the script creates the "dataT" data frame by row binding the "testData"
and "trainData" data frames, and removes any potentially incomplete data, such as NAs,
by running a complete.cases() function on the "dataT" data frame.

The script then creates two character vectors names "from" and "to" which will be used
to make changes to the dataT column names so that they comply with the following 
style guide for varaibles: 
https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml#identifiers

Basically, all hyphen and parentheses will be removed from the dataT column names, and 
replaced by dots or null strings.
    
This will be accomplished using the "gsub2" fuction which is defined as a function using 
gsub, as well as the "from" and "to" vectors.
    
Next, the script defines two variables "key" and "value" as the first and second columns 
of the activityLabels data frame respectively.

"value" will be used to replace any "key" in a column in another data frame.

Using the match() function, the second column in the "dataT" data frame then has its
"key"s replaced with "value"s. For example, 1 becomes "WALKING", and 4 becomes 
"SITTING".

Next the script checks for duplicate column names, and appends an "a" string to 
those which are duplicates. This process is repeated until there are no duplicate 
column names, and every column name in the dataT data frame is unique. This is 
achieved using the duplicated() function, the Counta counter variable, and the 
Dupe variable for number of duplicated columns.

The script then creates the "dataSubset" data frame by extracting from the "dataT" data 
frame only those columns which are pure mean or standard deviation data. That is, if the 
column name contains the following strings:

    ".mean."
    ".std."

or ends with the following strings:

    ".mean"
    ".std"
    
The script also extracts the columns which contain the following strings in the name:

    "subject"
    "activity"
    
This is achieved using the grepl() function.
    
Now the script creates a "dataSet" data frame with zero rows, and with number of 
columns equivalent to the number in the "dataSubset" data frame.
    
The script then loops through unique values of activity and subject in the "dataSubset" data 
frame, and takes means of each resultant column from column 3 to the last column. This is 
achieved using a "Countb" counter and a nested loop using variables "t" and "tt". These 
means are then assigned to the relevant column in the "dataSet" data frame.
    
The script than pastes a "avg." string to the beginning of all the column names except 
columns 1 and 2 in the "dataSubset" data frame, and assigns that to a vector names myColNames. 
This is meant to denote the means we are calculating in the "dataSet" data frame.

The myColNames vector then has "subject" and "activity" strings added to the beginning of the 
vector, and column names of teh "dataSet" now take on the values of this resultant myColNames 
character vector.

Next, the script loads the plyr package, and uses the arrange() function twice to sort the 
"dataSet" data frame twice, first by value of the "activity" column, and then by value of the 
"subject" column.

The script then writes the resultant "dataSet" data frame to a TAB delimited text file named 
"tidyData.txt" in the working directory. 

Finally, the "dataSet" data frame is printed in the console as a visual confirmation that a
calcualtion has taken place.
