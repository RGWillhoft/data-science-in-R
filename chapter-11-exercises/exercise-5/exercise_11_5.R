# Exercise 5: dplyr grouped operations
# RG Willhoft

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

# What was the average departure delay in each month?
# Save this as a data frame `dep_delay_by_month`
# Hint: you'll have to perform a grouping operation then summarizing your data
dep_delay_by_month <- flights %>% 
  group_by( month ) %>%
  summarize( delay = mean( dep_delay, na.rm = TRUE ) )

# Which month had the greatest average departure delay?
worst_month <- dep_delay_by_month %>%
  filter( delay == max(delay) ) %>%
  select( month )

# If your above data frame contains just two columns (e.g., "month", and "delay"
# in that order), you can create a scatterplot by passing that data frame to the
# `plot()` function
plot( dep_delay_by_month )

# To which destinations were the average arrival delays the highest?
# Hint: you'll have to perform a grouping operation then summarize your data
# You can use the `head()` function to view just the first few rows
average_arrival_delays <- flights %>%
  group_by( dest ) %>%
  summarize( delay = mean( arr_delay, na.rm = TRUE ) ) %>%
  arrange( -delay )
head( average_arrival_delays )

# You can look up these airports in the `airports` data frame!
head( left_join( average_arrival_delays, airports, by = c("dest" = "faa") ) ) %>%
  select( name, delay )

# Which city was flown to with the highest average speed?
flights %>%
  group_by( dest ) %>%
  summarize( speed = mean( 60 * distance / air_time, na.rm = TRUE ) ) %>%  # MPH
  arrange( -speed ) %>%
  left_join( airports, by = c("dest" = "faa") ) %>%
  select( dest, name, speed )
