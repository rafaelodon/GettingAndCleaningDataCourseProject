testDir <- "test"
trainDir <- "train"

if (!file.exists(testDir) || !file.exists(trainDir)){
	print("Can't find test and train directories on the current directory. Run the script from the dataset directory.")
}else{

	# splits a string in a vector of strings with the same size
	splitBySize <- function(x,n) {
		substring(x, seq(1, nchar(x)-n, n), seq(n, nchar(x)-n, n)) 
	}

	outputFile <- "output.csv"
	if (file.exists(outputFile)) {
		file.remove(outputFile)
	}

	# creates the header of the tidy output by selecting only the mean and std features
	featuresDescription <- read.table("features.txt", sep=" ")
	isMeanFeature <- grepl("mean()", featuresDescription$V2)
	isStdFeature <- grepl("std()", featuresDescription$V2)

	selectedFeaturesDescription <- featuresDescription$V2[isMeanFeature | isStdFeature]
	numCols <- 2 + length(selectedFeaturesDescription)

	header <- matrix(c("subjectId", "activity", as.character(selectedFeaturesDescription)), nrow = 1, ncol = numCols)
	write.table(header, outputFile, sep = ",", append = TRUE, row.names = FALSE, col.names = FALSE)

	activityClasses <- read.table("activity_labels.txt", sep=" ")

	# reads line by line of the subject, activity and features files and writes to a tidy csv output
	readLineByLine <- function (subjectFile, activityFile, featuresFile){

		conSubject <- file(subjectFile, open = "r")
		conActivity <- file(activityFile, open = "r")
		conFeatures <- file(featuresFile, open = "r")

		while (TRUE) {
			subjectLine <- readLines(conSubject, n = 1, warn = FALSE)
			activityLine <- readLines(conActivity, n = 1, warn = FALSE)
			featuresLine <- readLines(conFeatures, n = 1, warn = FALSE)

			if (length(subjectLine) > 0){
				# replaces the activity number by the activity class label
				activityClass <- activityClasses$V2[as.numeric(activityLine)]

				# select only the mean and std features to be written in the tidy csv
				splittedFeatures <- as.numeric(splitBySize(featuresLine, 16))
				selectedFeatures <- splittedFeatures[isMeanFeature | isStdFeature]

				data <- matrix(c(subjectLine, as.character(activityClass), selectedFeatures), nrow = 1, ncol = numCols)
				write.table(data, outputFile, sep = ",", append = TRUE, row.names = FALSE, col.names = FALSE)
			}else{
				break
			}
		} 

		close(conSubject)
		close(conActivity)
		close(conFeatures)
	}

	# reads from the test set and writes to the tidy csv output
	readLineByLine("test/subject_test.txt", "test/y_test.txt", "test/X_test.txt")

	# reads from the train set and writes to the tidy csv output
	readLineByLine("train/subject_train.txt", "train/y_train.txt", "train/X_train.txt")

	# generates the second tidy dataset with the means by subject+activity
	data <- read.csv("output.csv")
	dataAverage <- aggregate(. ~ data$activity + data$subjectId, data=data, mean)
	dataAverage$activity <- NULL
	dataAverage$subjectId <- NULL
	names(dataAverage)[1] <- "activity"
	names(dataAverage)[2] <- "subjectId"

	write.table(dataAverage, "output_averages.csv", sep = ",", row.names = FALSE)
}


