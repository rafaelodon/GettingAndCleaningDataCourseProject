# Getting and Cleaning Data Course Project #
## Author: Rafael Odon ##

### Script approach ###

In order to avoid memory issues, the script reads the subject, activity and features files line by line, writing a tidy csv called "output.csv" also line by line.

### Script Description ###

First the script checks if it is running in the correct directory (shuld exist train and test sub-directories).

Then, it creates the header of the tidy output by selecting only the mean and std features.

The core of the solution is the line-by-line file reading. With each line, it rplaces the activity number by the activity class label. Then it selects only the mean and std features to be written in the tidy csv.

### How to run it? ###
Go to your dataset directory, open R console and type
``source("run_analysis.R")``


