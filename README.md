# Getting and Cleaning Data Course Project #
## Author: Rafael Odon ##

### Analysis approach ###

First of all the features labels are read and an algorithm based on string matching finds those features related to "mean" and "std". This information is used later to find out which column will be printed out in the tidy csv output.

Then the activities classes labels are read in order to be used as a replacement for the activities numbers read from the datasets.

In order to avoid memory issues, the script reads the subject, activity and features files line by line, writing a tidy csv called "output.csv" also line by line.
First it is read the test dataset, then it is read the train dataset. The piece of code to perform this line-by-line reading was encapsulated in a function.

After getting the "output.csv", this same file is read in memory to generate a second tidy data set containing the averages of each measurement by subject and activity.This way, a second file named "output_averages.csv" is created on the same directory.

### Running the script ###
Go to your dataset directory, open R console and type

``source("run_analysis.R")``

It take some seconds to finish, don't panic ;)

