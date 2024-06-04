polar_art <- function(seed, n, palette) {
  #set the seed to get random numbers for data
  set.seed(seed)
  #create new dataframe with the random values 
  dat <- tibble(x0 = runif(n), y0 = runif(n), 
                #CHANGED - alter min and max values to be greater
                x1 = x0 + runif(n, min = -.10, max = .10),
                y1 = y0 + runif(n, min = -.10, max = .10), 
                #set shading for future figures
                shade = runif(n), 
                #set size of shapes for figure
                size = runif(n)
  ) 
  #identify plot segments and denote them in different colors 
  dat |> 
    #set plot aesthetics and x and y values
    ggplot(aes(x = x0,y = y0,xend = x1,yend = y1,
               #change color and size for figures
               colour = shade, size = size)) + 
    #set geom type as segment and make sure legend does not show
    geom_segment(show.legend = FALSE) +
    #CHANGED - change to coord_flip to alter orientation of data
    coord_flip() +
    #set y axis range
    scale_y_continuous(expand = c(0, 0)) +
    #set x axis range
    scale_x_continuous(expand = c(0, 0)) + 
    #set color gradient scale using pallette feature
    scale_colour_gradientn(colours = palette) + 
    #CHANGED - alter size of scale to be larger
    scale_size(range = c(0, 50)) + 
    #CHANGED - set theme to different theme than theme_void
    theme_minimal()
}

#NOTE - this code has been changed as per the exercise instructions to alter the palette, seed, and n values
#change the seed to get different random data
polar_art(seed = 81, 
          #set the sample size to 65
          n = 65, 
          #change the colors of the plot to be shades of pink
          palette = c("hotpink", "pink3", "lightpink"))

