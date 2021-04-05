# Getting and cleaning data project assignment

### Project description

The following is my understanding of the project.

* The project is a machine learning data set from an experiment where users performed variety of physical activities while wearing a Samsung smartphone that collected measurement on those movements.

* The data came split into training and test set, each containing subject, ID's and activity codes that corresponded to the collected data.

The goal of the project was to merge all data into a single data set, align user ID's, activity codes with the measurement data, and combine training and test data set into one data set. 
Subsequently, out of all measured variables, extract out variables that were mean and standard deviations of measurements and then calculate average of these variables  organized by subject ID and activity type into a single data frame that follows tidy data principles.

### Reading and understanding of data

In tackling this assignment, I decided to use the `tidyverse` package, containing `dplyr`, `tidyr`, `stringr` packages that might be useful in this assignment.
I read all data into R using `read.table` function.
Although not explicitly stated in supporting documents, upon examining the data I came to following understanding of the data set structure:

* *X_....txt* is the data. These are the values of different variables. There is a table for training and testing data. These need to be merged into one

* Number of columns in *X_...* is the same as number of rows in *features.txt* indicating that the columns contain different features from the *features.txt* data

* Number of rows is the same as number of rows in *y_...txt* data and *subject_....txt* data, indicating that these need to be merged to the corresponding *X_...* table by column

* *y_....txt* only contains six unique values, 1-6, corresponding to activity codes and descriptions shown in *activity_labels.txt* data. Therefore, this is a factor level for the activity that each subject did

* Similarly, *subject_....txt*, only contains numeric values 1-30, that correspond to the subject ID. This is the subject ID that performed the activity.

In summary, each row in the merged table should contain the **subject ID**, **activity code**, followed by a 561-element vector of measurement of different variables. Variables in rows should be renamed according to *features*, and activity codes should be changed to their respective **activity names**.

### Merging and renaming data

*subject_...* (subject ID's) and *y_...* (activity codes) data were merged with the corresponding *X_...* data by `cbind()` function to generate complete data frames for *train* and *test* data sets.
These were then merged by `rbind()` function to generate one full data set named *full_df*.

Next, columns were renamed with descriptive names to indicate which one shows the *subject*, *activity*, and the rest of the columns were renamed using the features list from the *features.txt* data set.  
NOTE on the intent of the assignment: Since no information was provided on meaning of the actual variable names in any supporting information, it was my understanding that the assignment intended for us to demonstrate we can map the features list to the columns and rename those columns to have feature names rather than V1, V2 etc. Although it is possible to further rename these variables with more human-readable names, I did not further rename these variables as their interpretation was not provided and any further name parsing would be purely "guesswork" and unlikely correct.  
Next, activity codes are changed to activity descriptive names. 
The final data set is now combined, includes descriptive variable names and activity names. 

This satisfies requirements 1, 3, and 4. 

### Extracting mean and standard deviation data for each measurement

The *features_info.txt* file that came with the data set describes what measurements were taken and their names. There were several variables derived from these measurements including *mean()*, *std()* and others. 
The assignment calls fo extracting variables containing only 'mean and standard deviation for each measurement'. As such, I extracted all variables that contained *mean()* or *std()* in the variable names using the `grep(..., value = TRUE)` function embedded in the `select` function of the `dplyr` package. *activity*, and *subject* were also selected.  
Note: There are additional variables that contain word *(M)mean* in the variable names. However, they do not appear to be 'mean of each measurement' but rather a descriptor of another variable type. As such, I decided to omit those from the analysis. However, if the user wants to include thes also in the analysis, I included the code that will do that in comments in the script.
This satisfies the requirement #2 of the assignment.

### Calculating average of each variable for each activity for each subject

I contemplated for a while on how to do this efficiently. One can do this using `base`, `data.table`, or `dplyr` package. I'm sure there are other ways. I did not want to create too many intermediate data frames in the process and perform too many operations to achieve the goal.  
Continuing with using `dplyr` theme in this assignment, that's what I decided to use.  
Even within `dplyr` there are number of ways to do it. Initially, as taught in the course, I thought I would use `pivot_longer()` to pivot to long format, `group_by()` desired variables, then `summarize()` by `mean()` to get means and then use `pivot_wider()` to get the data into tidy wide format.  
It seems like a lot of steps and pivoting the data frame back and forth between different formats. Is there a more efficient option?  
I came across the `across()` function in `dplyr`. It is a new function, only recently introduced and it allows using `dplyr` 'verb' functions in a 'column-wise' manner without pivoting the data frames to long format. It is more recent than the age of this course and it appears to be very powerful. It does work on grouped data frame but it does not include grouping variables. The idea was to leave the data frame as is, and calculate what we need.  
For a nice tutorial on this function see this link. ['across()' tutorial](https://www.r4epi.com/column-wise-operations-in-dplyr.html).  
Lastly, because now the variables have changed their meaning, I decided to rename them to include `Avg_of_` before each variable name. Conveniently, the `across()` function allows us to do that in a single step. Cool! Only two lines of code do everything that is needed.  
Finally, this satisfies the requirement #5 of the assignment.

### Is the data 'tidy'?

I believe the final data frame `df_tidy` is tidy because of the following:  
1. Each variable has its own column  
2. Each observation is in its own separate row. In this case, the observation is a 68-element long vector containing the *subject* ID, *activity* name, folowed by averages of measurements as discussed above.  
3. Each value is in its own cell  

These principles are discussed at length by Hadley Wickham in *Tidy Data* paper that can be accessed by this link: [Tidy Data by Hadley Wickham](https://vita.had.co.nz/papers/tidy-data.pdf)  

As instructed, both long and wide format are acceptable 'tidy' formats for this assignment, depending on subsequent analysis that will be performed with the data. I decided to use the wide format as it is easier to look at and requires less code to achieve. If a longer format is needed, one can simply follow the `df_tidy` code with an `%>%` operator into the `pivot_longer()` function to achieve that format.  
I hope you enjoyed my script.  












