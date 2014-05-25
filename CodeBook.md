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
