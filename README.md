Getting_Cleaning_Data
=====================

Coursera Course Project for Getting and Cleaning Data

Preparation
1.  The data located at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip was downloaded and unzipped manually into a data directory located in the RStudio working direcory.  
2.  Script Functions 
	a.  Data retrieval functions -THE getTidyData function IS THE ONLY FUNCTION THAT NEEDS TO BE RUN.
		1.  getTrain - this function retrieves the training data and merges it with the activity names and subject identifier.
		2.  getTest - this function retrieves the test data and merges it with the activity names and subject identifier.
		3.  getAllData - this function runs both getTest and getTrain to retieve the data and then transforms it to show only the correct variables for the first tidy data set.  As described in the assignment only the standard deviation and mean variable are show.  Activity names and variable labels are shown.  This function returns the first tidy data set.
		4.  getAvgData - this function calculated the average from the return of getAllData for all data variables.  It is grouped by Activity and Subject.  The final tidy data set is returned.
		5.  getTidyData - this function runs getAllData and getAvgData to return the final tidy data and write it to the text file TidyData.txt.  The file is comma delimited.   THIS IS THE ONLY FUNCTION THAT NEEDS TO BE RUN.   
