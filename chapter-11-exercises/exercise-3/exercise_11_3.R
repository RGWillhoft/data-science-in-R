# Exercise 3: using the pipe operator
# RG Willhoft, 2019

# Install (if needed) and load the "dplyr" library
#install.packages("dplyr")
library("dplyr")

# Install (if needed) and load the "fueleconomy" package
#install.packages('devtools')
#devtools::install_github("hadley/fueleconomy")
library("fueleconomy")

# Which 2015 Acura model has the best hwy MGH? (Use dplyr, but without method
# chaining or pipes--use temporary variables!)
acura_models <- filter( vehicles, make=="Acura", year==2015 )
best_mpg <- filter( acura_models, hwy==max(hwy) )
best_model <- select( best_mpg, model )
best_model

# Which 2015 Acura model has the best hwy MPG? (Use dplyr, nesting functions)
best_model <- select( 
  filter( 
    filter(
      vehicles, make=="Acura", year==2015
    ),
    hwy==hwy(max)
  ),
  model
)
best_model

# Which 2015 Acura model has the best hwy MPG? (Use dplyr and the pipe operator)
best_model <- filter( vehicles, make=="Acura", year==2015 ) %>%
  filter( hwy==max(hwy) ) %>%
  select( model )
best_model


### Bonus

# Write 3 functions, one for each approach.  Then,
# Test how long it takes to perform each one 1000 times
