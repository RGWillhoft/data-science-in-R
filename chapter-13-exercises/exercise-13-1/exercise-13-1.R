# Exercise 1: accessing a relational database

# Install and load the `dplyr`, `DBI`, and `RSQLite` packages for accessing
# databases
# install.packages("dbplyr")
library("dplyr")
library("DBI")
# install.packages("RSQLite")
library("RSQLite")

# Create a connection to the `Chinook_Sqlite.sqlite` file in the `data` folder
# Be sure to set your working directory!
chinook_sqlite <- dbConnect(SQLite(), dbname="data/chinook_sqlite.sqlite")

# Use the `dbListTables()` function (passing in the connection) to get a list
# of tables in the database.
tables <- dbListTables(chinook_sqlite)

# Use the `tbl()`function to create a reference to the table of music genres.
# Print out the the table to confirm that you've accessed it.
genre_table <- tbl(chinook_sqlite,"Genre")

# Try to use `View()` to see the contents of the table. What happened?
View(genre_table)

# Use the `collect()` function to actually load the genre table into memory
# as a data frame. View that data frame.
genre_df <- collect(genre_table)
View(genre_df)

# Use dplyr's `count()` function to see how many rows are in the genre table
count(genre_df)

# Use the `tbl()` function to create a reference the table with track data.
# Print out the the table to confirm that you've accessed it.
track_data_table <- tbl(chinook_sqlite,"Track")
print(track_data_table)

# Use dplyr functions to query for a list of artists in descending order by
# popularity in the database (e.g., the artist with the most tracks at the top)
# - Start by filting for rows that have an artist listed (use `is.na()`), then
#   group rows by the artist and count them. Finally, arrange the results.
# - Use pipes to do this all as one statement without collecting the data into
#   memory!
artist_query <- track_data_table %>%
  filter( !is.na(composer) ) %>%
  group_by( composer ) %>%
  count() %>%
  arrange(-n)
artist_query_data <- collect( artist_query )

# Use dplyr functions to query for the most popular _genre_ in the library.
# You will need to count the number of occurrences of each genre, and join the
# two tables together in order to also access the genre name.
# Collect the resulting data into memory in order to access the specific row of
# interest
popular_genre <- track_data_table %>%
  group_by(GenreId) %>%
  count() %>%
  arrange(-n) %>%
  left_join( genre_df, copy = TRUE )
most_popular_genre <- collect(popular_genre)$Name[1]
most_popular_genre

# Bonus: Query for a list of the most popular artist for each genre in the
# library (a "representative" artist for each).
# Consider using multiple grouping operations. Note that you can only filter
# for a `max()` value if you've collected the data into memory.
genre_artist <- track_data_table %>%
  filter( !is.na(composer) ) %>%
  group_by(GenreId,composer) %>% 
  count() %>% 
  collect() # %>%
  group_by(GenreId) %>%
  select( n == max(n) )
  arrange(-n)

# Remember to disconnect from the database once you are done with it!
dbDisconnect( chinook_sqlite )
