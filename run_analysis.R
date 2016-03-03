run_analysis <- function() {

	############
	# You should create one R script called run_analysis.R that does the following.
	#
	# 1. Merges the training and the test sets to create one data set.
	# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
	# 3. Uses descriptive activity names to name the activities in the data set
	# 4. Appropriately labels the data set with descriptive variable names.
	# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

	library(knitr)
	library(plyr)

	### 1. Merges the training and the test sets to create one data set.

	# Check if the directory exists
	if (!file.exists("data")) {
		dir.create("data")
	}

	# Download the dataset only if it not exists:
	if (!file.exists("./data/dataset.zip")) {
		fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
		download.file(fileURL, "./data/dataset.zip", method="curl")
	}

	# Unzip the file only if directory "UCI HAR Dataset" does not exists
	if (!file.exists("./data/UCI HAR Dataset")) {
		unzip("./data/dataset.zip", exdir="./data/")
	}

	# Load the datasets and merge
	subTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
	xTrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
	yTrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

	subTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header=FALSE)
	xTest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
	yTest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

	# Creating cols Sub, Features and Activity with meanfull names
	colSub <- rbind(subTrain, subTest)
	names(colSub) <- c("Subject")

	colActivity <- rbind(yTrain, yTest)
	names(colActivity)<- c("Activity")

	colFeatures <- rbind(xTrain, xTest)
	# reading features for the names
	featuresNames <- read.table("./data/UCI HAR Dataset/features.txt")
	names(colFeatures) <- featuresNames$V2

	# Creating the dataset
	data <- cbind(colSub, colActivity, colFeatures)

	### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

	# grep rows with mean and std
	valNames <- grep("mean|std", featuresNames$V2, value=TRUE)

	# list for the names to select
	names <- c(as.character(valNames), "Activity", "Subject")
	data <- subset(data, select=names)

	### 3. Uses descriptive activity names to name the activities in the data set
	activityNames <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
	data$Activity <- activityNames[data$Activity, 2]

	### 4. Appropriately labels the data set with descriptive variable names.
	names(data)<-gsub("^t", "time", names(data))
	names(data)<-gsub("^f", "frequency", names(data))
	names(data)<-gsub("Acc", "Accelerometer", names(data))
	names(data)<-gsub("Gyro", "Gyroscope", names(data))
	names(data)<-gsub("Mag", "Magnitude", names(data))
	names(data)<-gsub("BodyBody", "Body", names(data))

	# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

	data2<-aggregate(. ~Subject + Activity, data, mean)
	data2<-data2[order(data2$Subject,data2$Activity),]
	write.table(data2, file = "tidydata.txt",row.name=FALSE)

}
