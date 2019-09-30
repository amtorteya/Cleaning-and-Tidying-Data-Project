==================================================================
Cleaning and Tidying Data Project
Version 1.0
==================================================================

The code takes the Human Activity Recognition Using Smartphones Dataset and processes it to build a tidy dataset.
The tidy dataset consists of 180 observations across 30 subjects, one per each of six different activities, and 563 features.
The original dataset has much more features, for the tidy dataset, only features estimated from mean values and stardard deviation were considered.


The dataset includes the following files:
=========================================

- 'README.txt'

- 'CodeBook.pdf': Description of the features.

- 'features_info.txt': Additional description of the features, taken directly from the original dataset.

- 'runAnalysis.R': Code that generated the tidy dataset.


Description of the code:
========================

First, the names of the features are retrieved from 'features.txt' and special characters (i.e. '-', '(', and ')') are removed.
Activity labels are retrieved from áctivity_labels.txt')
The train data is obtained from three different files:
	- 'train/subject_train.txt' gives the ID of the subject for each observation
	- 'train_X_train.txt' has all the features obtained directly from the sensors and post-processed
	- 'train_y_train.txt' gives the activity being performed for each observation.
The test data is obtained from three different files:
	- 'test/subject_test.txt' gives the ID of the subject for each observation
	- 'test_X_test.txt' has all the features obtained directly from the sensors and post-processed
	- 'test_y_test.txt' gives the activity being performed for each observation.
Train and test data is merged.
All features not related to mean value or standard deviation were eliminated.
A tidy dataset is created by obtaining the average value of all observations related to a subject and an activity.
The tidy dataset is written as 'dataTidy.txt'

*For an easy read in R, try: 'read.table("dataTidy.txt",header=TRUE)'
