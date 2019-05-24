# Exercise 3: vector practice
# RG Willhoft, 2019

# Create a vector `words` of 6 (or more) words.
# You can Google for a "random word generator" if you wish!
words <- c('one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten')
test <- c('a', 'aa', 'abc', 'b', 'c', 'f', 'g', 'ga', 'm', 'mzz', 'n', '' )

# Create a vector `words_of_the_day` that is your `words` vector with the string
# "is the word of the day!" pasted on to the end.
# BONUS: Surround the word in quotes (e.g., `'data' is the word of the day!`)
# Note that the results are more obviously correct with single quotes.
words_of_the_day <- paste( paste( '\'', words, sep='' ), '\' is the word of the day!', sep='' )

# Create a vector `a_f_words` which are the elements in `words` that start with 
# "a" through "f"
# Hint: use a comparison operator to see if the word comes before "f" alphabetically!
# Tip: make sure all the words are lower-case, and only consider the first letter
# of the word!
words_beg <- substr( words, 1, 1 )
a_f_words <- words[ words_beg <= 'f' ]
test_beg <- substr( test, 1, 1 )
a_f_test <- test[ test <= 'f' ]

# Create a vector `g_m_words` which are the elements in `words` that start with 
# "g" through "m"
first_letter <- substr( words, 1, 1 )
g_m_words <- words[ 'g' <= words_beg & words_beg < 'm' ]
g_m_test <- test[ 'g' <= test_beg & test_beg <= 'm' ]

# Define a function `word_bin` that takes in three arguments: a vector of words, 
# and two letters. The function should return a vector of words that go between 
# those letters alphabetically.
word_bin <- function( words_arg, start_arg, end_arg ) {
  words_beg <- substr( words_arg, 1, 1 )
  words_arg[ start_arg <= words_beg & words_beg <= end_arg ]
}

# Use your `word_bin` function to determine which of your words start with "e" 
# through "q"
word_bin( words, 'e', 'q' )
test <- c( test, 'o', 'p', 'programming', 'q', 'quit', 'r', 'ready' ) 
word_bin( test, 'e', 'q' )

