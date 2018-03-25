# Getting-and-Cleaning-Data-Project

## Course Project
This is the course project to create a R script called `run_analysis.R` that does the following:
1. Download the dataset to a local working directory
2. Load both the training and test datasets, and extract only the data on mean and standard deviation
3. Load the activity and subject data for each dataset, and merges those columns with the dataset
4. Merge the two datasets and convert the activity and subject columns into factors
6. Create a new file called `tiny_data.txt` in the working directory

## Dependencies
The script uses R libraries of `data.table` and `reshape2`, which need to be installed:
