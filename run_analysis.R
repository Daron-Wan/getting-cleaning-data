fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="UCIdata.zip")
unzip("UCIdata.zip")
trainID <- read.table("./UCI HAR Dataset/train/subject_train.txt")
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainType<- read.table("./UCI HAR Dataset/train/y_train.txt")
trainComplete <- cbind(trainID,trainType,trainData)
testID <- read.table("./UCI HAR Dataset/test/subject_test.txt")
testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
testType <- read.table("./UCI HAR Dataset/test/y_test.txt")
testComplete <- cbind(testID,testType,testData) 
mergeData <- rbind(trainComplete,testComplete)
features <- read.table("./UCI HAR Dataset/features.txt")
colnames(mergeData) <- c("id","type",as.character(features[[2]]))
completeData <- mergeData [order(mergeData$id,mergeData$type),]
feat <- grep("*-mean[^a-zA-Z]|-std*", colnames(completeData))
tidydata1 <- completeData[c("id","type",colnames(completeData[feat]))]
tidydata1["type"][tidydata1["type"]==1] <- "walking"
tidydata1["type"][tidydata1["type"]==2] <- "walkingUp"
tidydata1["type"][tidydata1["type"]==3] <- "walkingDown"
tidydata1["type"][tidydata1["type"]==4] <- "sitting"
tidydata1["type"][tidydata1["type"]==5] <- "standing"
tidydata1["type"][tidydata1["type"]==6] <- "laying"
tidydata2 <- aggregate(tidydata1[3:68], by=list(tidydata1$id,tidydata1$type), FUN=mean, na.rm=TRUE)
colnames(tidydata2)[1] <- "id"
colnames(tidydata2)[2] <- "type"
write.table(tidydata2,file="tidydata2.txt")
