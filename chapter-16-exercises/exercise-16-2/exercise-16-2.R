# Exercise 2: advanced ggplot2 practice
# RG Willhoft, 2019

# Install and load the `ggplot2` package
#install.packages('ggplot2')
library("ggplot2")

# For this exercise you will again be working with the `diamonds` data set.
# Use `?diamonds` to review details about this data set
?diamonds

## Position Adjustments

# a) Draw a column (bar) chart of diamonds cuts by price, with each bar filled by 
#    clarity. You should see a 'stacked' bar chart.
ggplot( diamonds ) +
  geom_col( 
    mapping = aes( x = cut, y = price, fill = clarity ) 
  )

# b) Draw the same chart again, but with each element positioned to "fill" the y axis
ggplot( diamonds ) +
  geom_col( 
    mapping = aes( x = cut, y = price, fill = clarity ),
    position = 'fill' 
  )

# c) Draw the same chart again, but with each element positioned to "dodge" each other
ggplot( diamonds ) +
  geom_col( 
    mapping = aes( x = cut, y = price, fill = clarity ),
    position = 'dodge' 
  )

# d) Draw a plot with point geometry with the x-position mapped to `cut` and the 
#    y-position mapped to `clarity`
#    This creates a "grid" grouping the points
ggplot( diamonds ) +
  geom_point(
    mapping = aes( x = cut, y = clarity )
  )

# e) Use the "jitter" position adjustment to keep the points from all overlapping!
#    (This works a little better with a sample of diamond data, such as from the 
#    previous exercise).
ggplot( diamonds ) +
  geom_point(
    mapping = aes( x = cut, y = clarity ),
    position = 'jitter'
  )

## Scales

# f) Draw a "boxplot" (with `geom_boxplot`) for the diamond's price (y) by color (x)
ggplot( diamonds ) +
  geom_boxplot( 
    mapping = aes( x = color, y = price ) 
  )

# g) This has a lot of outliers, making it harder to read. To fix this, draw the 
#    same plot but with a _logarithmic_ scale for the y axis.
ggplot( diamonds ) +
  geom_boxplot( 
    mapping = aes( x = color, y = price )
  ) +
  scale_y_continuous( trans = 'log10' )

# h) For another version, draw the same plot but with 'violin' geometry instead of 
#    'boxplot' geometry!
ggplot( diamonds ) +
  geom_violin( 
    mapping = aes( x = color, y = price )
  )

#    How does the logarithmic scale change the data presentation?
ggplot( diamonds ) +
  geom_violin( 
    mapping = aes( x = color, y = price )
  ) +
  scale_y_continuous( trans = 'log10' )

# i) Another interesting plot: draw a plot of the diamonds price (y) by carat (x), 
#    using a heatmap of 2d bins (geom_bin2d)
ggplot( diamonds ) +
  geom_bin2d(
    mapping = aes( x = carat, y = price )
  )

#   What happens when you make the x and y channels scale logarithmically?
ggplot( diamonds ) +
  geom_bin2d(
    mapping = aes( x = carat, y = price )
  ) +
  scale_x_continuous( trans = 'log10' ) +
  scale_y_continuous( trans = 'log10' )

# j) Draw a scatter plot for the diamonds price (y) by carat (x). Color each point
#    by the clarity (Remember, this will take a while. Use a sample of the diamonds 
#    for faster results)
ggplot( diamonds ) +
  geom_point( mapping = aes( x = carat, y = price, color = clarity ) )

# k) Change the color of the previous plot using a ColorBrewer scale of your choice. 
#    What looks nice?
ggplot( diamonds ) +
  geom_point( mapping = aes( x = carat, y = price, color = clarity ) ) +
  scale_color_brewer( palette = 'Spectral' )

## Coordinate Systems

# l) Draw a bar chart with x-position and fill color BOTH mapped to cut
#    For best results, SET the `width` of the geometry to be 1 (fill plot, no space
#    between)
#    TIP: You can save the plot to a variable for easier modifications
bar_chart <- ggplot( diamonds ) +
  geom_bar( 
    mapping = aes( x = cut, fill = cut ),
    width = 1 
  )
bar_chart

# m) Draw the same chart, but with the coordinate system flipped
bar_chart + coord_flip()

# n) Draw the same chart, but in a polar coordinate system. It's a Coxcomb chart!
bar_chart + coord_polar()

## Facets

# o) Take the scatter plot of price by carat data (colored by clarity) and add 
#    'facets' based on the diamond's 'color'
ggplot( diamonds ) +
  geom_point( 
    mapping = aes( x = carat, y = price, color = clarity ) 
  ) +
  facet_wrap( ~color ) +
  scale_color_brewer( palette = 'Spectral' )

## Saving Plots

# Use the `ggsave()` function to save the current (recent) plot to disk.
# Name the output file "my-plot.png".
# Make sure you've set the working directory!!

