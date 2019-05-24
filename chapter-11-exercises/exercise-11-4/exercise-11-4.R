# Exercise 4: practicing with dplyr
# RG Willhoft, 2019

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
install.packages( "nycflights13")
library( "nycflights13" )
library( "dplyr" )

# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
nrow( flights )
ncol( flights )
colnames( flights )

# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
flights1 <- mutate( flights, air_delay = arr_delay - dep_delay )

# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
flights1 <- arrange( flights1, -air_delay )

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame
flights2 <- flights %>% 
  mutate( air_delay = arr_delay - dep_delay ) %>% 
  arrange( -air_delay )

# Make a histogram of the amount of time gained using the `hist()` function
hist( flights2$air_delay )

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
average_gain <- -mean( flights2$air_delay, na.rm = TRUE )


# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created
to_seatac <- flights2 %>%
  filter( dest=="SEA" ) %>%
  select( origin, dest, air_delay )

# On average, did flights to SeaTac gain or loose time?
average_seatec_gain <- -mean( to_seatac$air_delay, na.rm = TRUE )

# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!
filter( flights, origin=="JFK", dest=="SEA", !is.na( air_time ) ) %>%
  summarize( average_air = mean(air_time),
             min_air = min(air_time),
             max_air = max(air_time) )
