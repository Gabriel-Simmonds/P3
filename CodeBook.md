## CodeBook

    activityLabels: A data frame created from the activity_labels.txt file
    "activity" and "activityName": Column names of the activityLabels data frame
    features: A data frame created from the features.txt file
    
    subjTest: A data frame created from the subject_test.txt file
    yTest: A data frame created from the y_test.txt file
    Xtest: A data frame created from the X_test.txt file
    
    subjTrain: A data frame created from the subject_train.txt file
    yTrain: A data frame created from the y_train.txt file
    XTrain: A data frame created from the X_train.txt file
    
        Assign second column of the features data frame as the column names of the XTest data frame
        Assign second column of the features data frame as the column names of the XTrain data frame
    
    Test: A data frame created as the column bind of the subjTest and yTest data frames
    "subject" and "activity": Column names of the Test data frame
    
    Train: A data frame created as the column bind of the subjTrain and yTrain data frames
    "subject" and "activity": Column names of the Train data frame
    
    testData: A data frame created as the column bind of the Test and XTest data frames
    trainData: A data frame created as the column bind of the Train and XTrain data frames
    
    dataT: A data frame created as the row bind of the testData and trainData data frames

    from: A character vector created as a basis for editing column names so that they will comply with
    a style where there are no parentheses, no underscores and no hyphens

    to: A character vector created as a basis for editing column names so that they will comply with
    a style where dots replace characters which were noted in the "from" character vector
    
        "-a" is replaced by ".a"
        "-b" is toreplaced by ".b"
        "-c" is replaced by ".c"
        "-e" is replaced by ".e"
        "-i" is replaced by ".i"
        "-k" is replaced by ".k"
        "-m" is replaced by ".m"
        "-o" is replaced by ".o"
        "-s" is replaced by ".s"
        "()-" is replaced by "."
        "()" is replaced by ""
        "(" is replaced by "."
        ")" is replaced by ""
        "," is replaced by "."
        "-" is replaced by ""
    
    gsub2: A function which loops through the length of a vector, and replaces characters in a data frame 
    using the gsub function
    
    key: The first column of the activityLabels data frame
    value: The second column of the activityLabels data frame
    
    ## substitute the second column of the dataT data frame by matching the 
    ## current values with key, and then substituting value into this column
    dataT[, 2] <- value[match(dataT[, 2], key)]
    
    Counta: A loop counter variable used in checking if column names are duplicated in the
    dataT data frame.
    Dupe: A variable used to denote the number of duplicated column names in the dataT 
    data frame
    
    dataSubset: A data frame created by extracting those columns which contain
    the following strings from the dataT data frame
    
        "subject"
        "activity"
        ".mean."
        ".std."
        
    or those columns which end with the following strings
    
        ".mean"
        ".std"
    
    Countb: A loop counter variable used for creating the dataSet data frame, by
    looping through the dataSubset columns, and taking their means
    t: A loop counter to extract the subject from the dataSubset data frame
    tt: A loop counter to extract the activity from the dataSubset data frame
    dataSet: A data frame created from the dataSubset, containing the column means
    of the dataSubset
    
    myColNames: A column vector creted by adding "avg." to each of the dataSubset
    column names, and then adding "subject" and "activity" to the start of that vector.
    This column vector is then used to name the columns in the dataSet data frame
