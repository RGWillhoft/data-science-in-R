# Exercise 1: creating data frames
# RG Willhoft, 2019

# Create a vector of the number of points the Seahawks scored in the first 4 games
# of the season (google "Seahawks" for the scores!)
# from: https://en.wikipedia.org/wiki/2018_Seattle_Seahawks_season
scored <- c(24, 17, 24, 20) #, 31, 27, 28, 17, 31, 27, 30, 43, 21, 23, 38, 27)

# Create a vector of the number of points the Seahwaks have allowed to be scored
# against them in each of the first 4 games of the season
allowed <- c(27, 24, 13, 17) #, 33, 3, 14, 25, 36, 24, 27, 16, 7, 26, 31, 24)

# Combine your two vectors into a dataframe called `games`
games <- data.frame( scored, allowed )

# Create a new column "diff" that is the difference in points between the teams
# Hint: recall the syntax for assigning new elements (which in this case will be
# a vector) to a list!
diff <- abs(scored-allowed)
games[,"diff"] <- diff

# Create a new column "won" which is TRUE if the Seahawks won the game
won = scored > allowed
games[,"won"] <- won

# Create a vector of the opponent names corresponding to the games played
opponent <- c('Broncos', 'Bears', 'Cowboys', 'Cardinals')

# Assign your dataframe rownames of their opponents
rownames(games) <- opponent

# View your data frame to see how it has changed!
