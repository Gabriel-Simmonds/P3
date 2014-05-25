run_analysis <- function() {
    ## Check to see input data files exist in working directory. If not, then
    ## either Unzip files, or else stop process and display error message.
    if (!file.exists("UCI HAR Dataset")) {
        if (!file.exists("getdata_projectfiles_UCI HAR Dataset.zip")) {
            stop("Process expected to find UCI HAR Dataset folder or Zip file, 
                 but neither is avalable")
            } else {
                unzip("getdata_projectfiles_UCI HAR Dataset.zip")
        }
    }

    ## Create activityLabels data frame from activity_labels.txt file
    activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
    ## Define column names of activityLabels data frame as "activity" and 
    ## "activityName"
    colnames(activityLabels) <- c("activity", "activityName")
    ## Create features data frame from features.txt file
    features <- read.table("UCI HAR Dataset/features.txt")
    
    ## Create subjTest data frame from subject_test.txt file
    subjTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
    ## Create yTest data frame from y_test.txt file
    yTest <- read.table("UCI HAR Dataset/test/y_test.txt")
    ## Create Xtest data frame from X_test.txt file
    XTest <- read.table("UCI HAR Dataset/test/X_test.txt")
    
    ## Create subjTrain data frame from subject_train.txt file
    subjTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
    ## Create yTrain data frame from y_train.txt file
    yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
    ## Create XTrain data frame from X_train.txt file
    XTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
    
    ## Assign second column of the features data frame as the column names of 
    ## the XTest data frame
    colnames(XTest) <- features[, 2]
    ## Assign second column of the features data frame as the column names of 
    ## the XTrain data frame
    colnames(XTrain) <- features[, 2]
    
    ## Create Test data frame as the column bind of the subjTest and yTest
    ## data frames
    Test <- cbind(subjTest, yTest)
    ## Define column names of Test data frame as "subject" and "activity"
    colnames(Test) <- c("subject", "activity")
    
    ## Create Train data frame as the column bind of the subjTrain and yTrain
    ## data frames
    Train <- cbind(subjTrain, yTrain)
    ## Define column names of Train data frame as "subject" and "activity"
    colnames(Train) <- c("subject", "activity")
    
    ## Create testData data frame as the column bind of the Test and XTest
    ## data frames
    testData <- cbind(Test, XTest)
    ## Create trainData data frame as the column bind of the Train and XTrain
    ## data frames
    trainData <- cbind(Train, XTrain)
    
    ## Create dataT data frame as the row bind of the testData and trainData
    ## data frames
    dataT <- rbind(testData, trainData)
    ## Remove any rows from dataT data frame which may be incomplete, for 
    ## example NA
    dataT <- dataT[complete.cases(dataT),]
    
    ## Create from as a character vector
    from <- c("-a", "-b", "-c", "-e", "-i", "-k", "-m", "-o", "-s", "\\(\\)-", 
          "\\(\\)", "\\(", "\\)", "\\,", "-")
    ## Create to as a character vector
    to <- c(".a", ".b", ".c", ".e", ".i", ".k", ".m", ".o", ".s", ".", 
        "", ".", "", ".", "")
    
    ## Define gsub2 as a function which loops through the length of a vector, 
    ## and replaces characters in a data frame using the gsub function.
    gsub2 <- function(pattern, replacement, x, ...) {
        for(i in 1:length(pattern))
            x <- gsub(pattern[i], replacement[i], x, ...)
        x
    }
    
    ## Edit the column names of the dataT data frame using the gsub2 function
    ## and the from and to character vectors
    colnames(dataT) <- gsub2(from, to, colnames(dataT))
    
    ## Define key as the first column of the activityLabels data frame
    ## Define value as the second column of the activityLabels data frame
    set.seed(1)
    key = activityLabels[, 1]
    value <- activityLabels[, 2]
    
    ## substitute the second column of the dataT data frame by matching the 
    ## current values with key, and then substituting value into this column
    dataT[, 2] <- value[match(dataT[, 2], key)]
    
    ## Define Counta variable as equal to 1
    Counta <- 1
    ## Loop while Counta does not equal to zero
    while(Counta != 0) { 
        ## Define Dupe as the logical vector of duplicated column names in the
        ## dataT data frame
        Dupe <- duplicated(colnames(dataT))
        ## Set Counta as the sum of Dupe
        Counta <- sum(Dupe)
        ## Paste an "a" character to the end of all column names which are 
        ## duplicated 
        colnames(dataT)[Dupe] <- paste(colnames(dataT)[Dupe], "a", sep = "")
        ## Loop will repeat this process until there are no duplicated column
        ## names
    }
    
    ## Create dataSubset data frame by extracting only those columns which 
    ## contain the following strings "subject", "activity", ".mean.", ".std.", 
    ## or end with the following strings ".mean" or ".std" in the dataT 
    ## data frame
    dataSubset <- 
    dataT[, grepl("subject|activity|\\.mean$|\\.std$|\\.mean\\.|\\.std\\.", 
                 colnames(dataT))]
    
    ## Create a dataSet data frame with zero rows and the same number of columns
    ## as the dataSubset data frame
    dataSet <- data.frame(matrix(0, ncol = ncol(dataSubset), nrow = 0))
    
    ## Create a Countb variable and set equal to 1
    Countb <- 1
    ## Loop through the subject column in the dataSubset data frame
    for (t in unique(dataSubset$subject)){
        ## Loop through the activity column in the dataSubset data frame
        for (tt in unique(dataSubset$activity)){
            ## Assign the column means from the dataSubset data frame to the 
            ## dataSet dataframe from column 3 onwards
            dataSet[Countb, 3:ncol(dataSubset)] <- colMeans(dataSubset[(
            dataSubset$subject == t & dataSubset$activity == tt), 3:ncol(
                dataSubset)])
            ## Use the subject value and assign to column 1 of dataSet data 
            ## frame, row by row
            dataSet[Countb, 1] <- t
            ## Use the activity value and assign to column 2 of dataSet data 
            ## frame, row by row
            dataSet[Countb, 2] <- tt
            ## Increase the value of the Countb counter by 1 as part of the
            ## loop process
            Countb <- Countb + 1
        }
    }
    
    ## Take the column names vector from the dataSubset data frame and paste 
    ## "avg" with a "." separator to the beginning of each column name
    myColNames <- paste("avg", colnames(dataSubset[3:ncol(dataSubset)]), 
                        sep = ".")
    
    ## Add "subject" and "activity" as the first two members of the myColNames
    ## vector
    myColNames <- c("subject", "activity", myColNames)
    
    ## Assign the myColNames vector to the column names of the dataSet data 
    ## frame
    colnames(dataSet) <- myColNames
    
    ## Load the plyr package
    library(plyr)
    ## Use arrange function to sort the dataSet data frame according to the 
    ## activity column
    dataSet <- arrange(dataSet, activity)
    ## Now use arrange function to sort the dataSet data frame according to the 
    ## subject column
    dataSet <- arrange(dataSet, subject)
    
    ## Write the resulting dataSet data frame to a TAB delimited text file 
    ## named tidyData.txt
    write.table(dataSet, "tidyData.txt", sep="\t")
    
    ## Print the dataSet data frame in the RStudio console
    dataSet
}