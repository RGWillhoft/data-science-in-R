# Exercise 2: using `*apply()` functions

# Create a *list* of 10 random numbers. Use the `runif()` function to make a 
# vector of random numbers, then use `as.list()` to convert that to a list
values <- as.list( runif( 10, 0, 100) )

# Use `lapply()` to apply the `round()` function to each number, rounding it to 
# the nearest 0.1 (one decimal place)
rounded_values <- lapply( values, round, digits=1 )

# Create a variable 'sentence' that contains a sentence of text (something 
# longish). Make the sentence lowercase; you can use a function to help.
sentence <- "The quick brown fox jumps over the lazy dog"
sentence <- tolower( sentence )

# Use the `strsplit()` function to split the sentence into a vector of letters.
# Hint: split on `""` to split every character
# Note: this will return a _list_ with 1 element (which is the vector of letters)
list_result <- strsplit( sentence, "" )

# Extract the vector of letters from the resulting list
vector_of_letters <- list_result[[1]]

# Use the `unique()` function to get a vector of unique letters
letters = unique( vector_of_letters )
letters = sort( letters )

# Define a function `count_occurrences` that takes in two parameters: a letter 
# and a vector of letters. The function should return how many times that letter
# occurs in the provided vector.
# Hint: use a filter operation!
count_occurrences <- function( ch, chars ) {
  length( chars[ chars == ch ] )
}

# Call your `count_occurrences()` function to see how many times the letter 'e'
# is in your sentence.
print( count_occurrences( 'e', vector_of_letters ) )

# Use `sapply()` to apply your `count_occurrences()` function to each unique 
# letter in the vector to determine their frequencies.
# Convert the result into a list (using `as.list()`).
vector_of_frequencies <- sapply( letters, count_occurrences, chars=vector_of_letters )
list_of_frequencies <- as.list( vector_of_frequencies, sorted = TRUE )
# sorted doesn't seem to do what I think it should, so I sorted earlier

# Print the resulting list of frequencies
print( list_of_frequencies )
