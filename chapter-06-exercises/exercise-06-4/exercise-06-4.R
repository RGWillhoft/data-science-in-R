# Exercise 4: functions and conditionals
# RG Willhoft, 2019

# Define a function `is_twice_as_long` that takes in two character strings, and 
# returns whether or not (e.g., a boolean) the length of one argument is greater
# than or equal to twice the length of the other.
# Hint: compare the length difference to the length of the smaller string
is_twice_as_long <- function( str1, str2 ) {
  min(nchar(str1),nchar(str2))*2 <= max(nchar(str1),nchar(str2))
}

# Call your `is_twice_as_long` function by passing it different length strings
# to confirm that it works. Make sure to check when _either_ argument is twice
# as long, as well as when neither are!
is_twice_as_long( "Robert", "Willhoft")
is_twice_as_long( "Rob", "Willhoft")
is_twice_as_long( "12", "123" )
is_twice_as_long( "12", "1234" )
is_twice_as_long( "12345", "123" )
is_twice_as_long( "123456", "123" )

# Define a function `describe_difference` that takes in two strings. The
# function should return one of the following sentences as appropriate
#   "Your first string is longer by N characters"
#   "Your second string is longer by N characters"
#   "Your strings are the same length!"
describe_difference <- function( str1, str2 ) {
  n1 <- nchar(str1)
  n2 <- nchar(str2)
  if( n1 > n2 ) {
    result <- paste( "Your first string is longer by", (n1-n2), "characters" )
  } else if( n1 < n2 ) {
    result <- paste( "Your second string is longer by", (n2-n1), "characters" )
  } else {
    result <- "Your strings are the same length!"
  }
  result
}

# Call your `describe_difference` function by passing it different length strings
# to confirm that it works. Make sure to check all 3 conditions1
describe_difference( "Rob", "Willhoft" )
describe_difference( "Robert", "Gordon" )
describe_difference( "Masters", "Ph.D." )
