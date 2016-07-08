# Peer Graded Assignment: Getting and Cleaning Data Course Project

This project is submitted as the final course project for **Getting and Cleaning Data** of Data science specialization. 

Files included in the repository:

- run_analysis.R : This file contains the R code for all the analytics done for the project.
- tidy.txt : The tidy dataset after running the R script on the raw dataset provided in the project.
- CodeBook.md : Codebook for the tidy dataset.

## Run instructions

- You must have the **dplyr** package installed. If not, please install it using command **install.packages("dplyr")** from RStudio.
- Put **run_analysis.R** in your working directory and run command **source("run_analysis.R")** which will generate the file **tidy.txt** in your working directory.

## Steps taken to generate the tidy dataset from the raw data provided

1. Download the zip file from the URL and unzip it to get the raw data.
2. Merge the training and the test sets (for *X*, *Y* and *subject*) to create one data set.
3. Read all the features from **features.txt** and filter everything related to mean and standard deviation measurements.
4. Perform some cleaning of the feature name columns to make it more readable.
5. Subset the complete *X* data to only extract all measurements related to mean and standard deviation measurements.
6. Column bind all the processed datasets to generate one complete activity dataset. This dataset should contain actusl activity names instead of the ids.
7. Using **group_by** and **summarise_each** functions, generate the desired tidy dataset containing the mean values per group.