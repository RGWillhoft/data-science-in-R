# Exercise 4: external data sets: Gates Foundation Educational Grants
# RG Willhoft, 2019

# Use the `read.csv()` functoin to read the data from the `data/gates_money.csv`
# file into a variable called `grants` using the `read.csv()`
# Be sure to set your working directory in RStudio, and do NOT treat strings as 
# factors!
money <- read.csv( "chapter-10-exercises/exercise-4/data/gates_money.csv", stringsAsFactors = FALSE )

# Use the View function to look at the loaded data
View( money )

# Create a variable `organization` that contains the `organization` column of 
# the dataset
organization <- money[,'organization']

# Confirm that the "organization" column is a vector using the `is.vector()` 
# function. 
# This is a useful debugging tip if you hit errors later!
is.vector( organization )

## Now you can ask some interesting questions about the dataset

# What was the mean grant value?
mean_grant <- mean( money[,'total_amount'])

# What was the dollar amount of the largest grant?
max_grant <- max( money[,'total_amount'])

# What was the dollar amount of the smallest grant?
min_grant <- min( money[,'total_amount'])

# Which organization received the largest grant?
money[money[,'total_amount']==max_grant,'organization']

# Which organization received the smallest grant?
money[money[,'total_amount']==min_grant,'organization']

# How many grants were awarded in 2010?
nrow( money[money[,'start_year']==2010,])
