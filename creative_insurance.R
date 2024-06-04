---
  title: "lund_generative_art"
format: html
---
  
  Choose Your Own Assignment - Generative Art

Part 2a: Workshop (structured only)

{r, message=FALSE}
#load in necessary packages 
library(tidyverse)
library(tibble)

Art is theft

Creating first figure from guidance document

{r}
#load in mpg dataset from ggplot2 package
mpg |> 
  #draw random plot using data from mpg and change color of points
  ggplot(aes(displ, hwy, colour = drv)) + 
  #show data as points and set size of points
  geom_point(show.legend = FALSE, size = 4) + 
  #add additional points within the existing ones and make them smaller and black
  geom_point(show.legend = FALSE, size = 1, colour = "#222222") +
  #move points to be in the shape of a circle
  coord_polar() +
  #set theme to be more blank space
  theme_void() + 
  #set color gradient of points
  scale_color_brewer()

Exercise: Try it yourself! Using nothing other than ggplot2 and the mpg data set, create your own artwork. Don’t take too long: 3 minutes at the absolute most! See what you can come up with in that time!
  
  {r}
#load in mpg data and set up ggplot
ggplot(data = mpg, 
       #set aesthetics and select data
       aes(x=hwy, y=drv, colour = drv)) + 
  #select dotplot to show data and set size and color of dots
  geom_dotplot(show.legend = FALSE, size = 3, color = "skyblue") + 
  #select another dotplot data and make size smaller and transparent
  geom_dotplot(show.legend = FALSE, size = 0.5, color = "transparent") + 
  #change orientaion 
  coord_quickmap() + 
  #set color scale
  scale_color_brewer()

Trying uniformly distributed random numbers

{r}
#create tibble using generated random data 
set.seed(1)
#set number of rows for tibble
n <- 50 
#set x and y standards for tibble using runif function
dat <- tibble(
  #set x values 
  x0 = runif(n), 
  #set y values
  y0 = runif(n), 
  #set min and max values for x columns
  x1 = x0 + runif(n, min = -.2, max = .2), 
  #set min and max values for y columns
  y1 = y0 + runif(n, min = -.2, max = .2), 
  #change shading
  shade = runif(n), 
  #set size of dat
  size = runif(n)
)
#print output data
dat

Figure showing that the key point is that the input is garbage...

{r}
#identify data
dat |> 
  #use ggplot function and set x and y aesthetics
  ggplot(aes(x = x0, y = y0,xend = x1,yend = y1,
             #change color of the plot
             colour = shade,
             #assign size of figure elements
             size = size
  )) +
  #add segement of data to ggplt and make sure legend does not show up 
  geom_segment(show.legend = FALSE) +
  #set figure to show data in a spiral shape
  coord_polar() +
  #set y axis scale
  scale_y_continuous(expand = c(0, 0)) +
  #set x axis scale
  scale_x_continuous(expand = c(0, 0)) + 
  #change color of ggplot 
  scale_color_viridis_c() + 
  #set range for size of shapes
  scale_size(range = c(0, 10)) + 
  #set theme to get rid of background
  theme_void()

Technique

Creating reusable art

{r}
#wrap code in function named polar_art 

polar_art <- function(seed, n, palette) {
  #set the seed to get random numbers for data
  set.seed(seed)
  #create new dataframe with the random values 
  dat <- tibble(x0 = runif(n), y0 = runif(n), 
                #set x and y min and max values for figures
                x1 = x0 + runif(n, min = -.2, max = .2),
                y1 = y0 + runif(n, min = -.2, max = .2), 
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
    #set orientation of figure as circular
    coord_polar() +
    #set y axis range
    scale_y_continuous(expand = c(0, 0)) +
    #set x axis range
    scale_x_continuous(expand = c(0, 0)) + 
    #set color gradient scale using pallette feature
    scale_colour_gradientn(colours = palette) + 
    #change size of scale 
    scale_size(range = c(0, 10)) + 
    #set theme to get rid of background information
    theme_void()
}

Create new pieces using the various seed arguments to change segments and color schemes

{r}
#create figure with lots of the data showing and make the figure light and dark orange colors only
polar_art(seed = 1, n = 500, palette = c("antiquewhite", "orange", "bisque"))
#create alternative figure where the colors are instead red, black and white not shades of orange
polar_art(seed = 1, n = 500, palette = c("red", "black", "white"))
#create another alternative figure where colors are red, black and white still but the data is different from different seed number
polar_art(seed = 2, n = 50, palette = c("red", "black", "white"))

Exercises: 
  
  In the materials folder there is a file called polar_art.R that contains a copy of the polar_art() function. Open it and use the polar_art() function to generate your own pieces. Try changing the seed, n, and the palette to create a variety of different pieces.

{r}
#altered code to change the palette, seed, and n values

#change the seed to get different random data
polar_art(seed = 81, 
          #set the sample size to 65
          n = 65, 
          #change the colors of the plot to be shades of pink
          palette = c("hotpink", "pink3", "lightpink"))

Create a new file called polar_art_02.R that contains the polar_art() function. In the new file, try modifying the polar_art() function itself to see if you can create your own new system.

{r}
#changing the actual polar_art to polar_art_02 to change this aspect of the original code

#change object name to identify between the two 
polar_art_02 <- function(seed, n, palette) {
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
polar_art_02(seed = 81, 
             #set the sample size to 65
             n = 65, 
             #change the colors of the plot to be shades of pink
             palette = c("hotpink", "pink3", "lightpink"))



Something to think about: Usually in data science we try to avoid naming our files my_file_version_1, my_file_version_2, etc, and instead we place files under version control using git. Yet here I am in an art context, apparently giving the advice to fall back on the old-fashioned system of naming files with version numbers. Why might I be doing that?
  
  {r}
#The artist could want to be able to name their files the old-fashioned way in order to keep track of their work and be able to reproduce what they have created and/or add onto their work in the future. Additionally, the files could be named this way in order to represent where they were created from, so the audience knows that the figures are originally from data wrangling in R. 

Color Exercises

In the materials folder there is a file called palette-generators.R that contains a copy of the sample_canva() function. Take a look and try calling the function a few times to see what kind of output it produces. You may find it handy to use show_col() to visualise the results.

{r}
#load in necessary package
library(ggthemes)

#the original function from the first session
sample_canva <- function(seed = NULL) {
  #setting random number seeds
  if(!is.null(seed)) set.seed(seed)
  #setting palettes
  sample(ggthemes::canva_palettes, 2)[[5]]
}

#the extended function used in later sessions
sample_canva2 <- function(seed = NULL, n = 10) {
  #setting random number seeds
  if(!is.null(seed)) set.seed(seed)
  #setting canva palettes
  sample(ggthemes::canva_palettes, 10)[[10]] |>
    (\(x) colorRampPalette(x)(n))()  
}

#show the colors to visualize results
canva_palettes[[70]]
#printing results
show_col(canva_palettes[[70]])

Try writing your own random palette generator. A simple (and occasionally useful) approach is to construct a palette consisting of distinct but otherwise randomly selected named colours in R. There is a set of 502 colour names generated by calling colours() with distinct = TRUE). Write a function called sample_named_colours() that takes n as an input argument, and then returns a sample of n of these colour. Try using it with the polar_art() function.

I CANNOT DO THIS ONE OMFG

{r}
#call this to see all the possible colors... commented out so not all show up in rendered document
#colours(distinct = TRUE)

#select color palette of colors I like
n_colors <- c("azure2", "aliceblue", "aquamarine3", "cadetblue", "lightsteelblue")

#show all of these colors printed
show_col(pal)

#create figure 
polar_art(seed = 5, n = 100, palette = pal)



sample_named_colors <- function(n_colors) {
  colors <- sample_named_colors(n_colors) }

polar_art(palette = sample_named_colors)

idk im crying...


The sample_canva() function, as I’ve written it, preserves the original structure of the 150 palettes in ggthemes::canva_palettes, so that the 4 colours returned all belong to the same palette on the Canva website originally. Try breaking this constraint. If you call unlist(ggthemes::canva_palettes) you get a vector of 600 distinct colours. Write a palette generating function that samples colours randomly from that set of 600 colours.

{r}
#use code for setting up seed for sample_canva function 
sample_canva <- function(seed = NULL) {
  if(!is.null(seed)) set.seed(seed)
  #change from just ggthemes to unlist to get vector of 600 colors to sample from
  sample(unlist(ggthemes::canva_palettes), 1)[[1]]
}

#create polar_art figure using random color from sample_canva with seed set to 659
polar_art(seed = 659, n = 600, palette = sample_canva(seed = 659))

Composition

In the materials folder there is a file called polar-styled-plots.R that contains a copy of the sample_canva(), sample_data() and polar_styled_plot() functions. Without modifying any of these three functions, explore how much flexibility you have to make different pieces in which (1) data are generated with sample_data(), (2) the plot is initialised by calling polar_styled_plot(), and (3) the piece is created by adding ggplot2 geoms. Data manipulation with dplyr is allowed!
  
  {r}
#load in necessary packages
library(ggplot2)
library(tibble)
library(dplyr)

#not modified
sample_canva <- function(seed = NULL) {
  if(!is.null(seed)) set.seed(seed)
  sample(ggthemes::canva_palettes, 1)[[1]]
}

#not modified
sample_data <- function(seed = NULL, n = 100){
  if(!is.null(seed)) set.seed(seed)
  dat <- tibble(
    x0 = runif(n),
    y0 = runif(n),
    x1 = x0 + runif(n, min = -.2, max = .2),
    y1 = y0 + runif(n, min = -.2, max = .2),
    shade = runif(n), 
    size = runif(n),
    shape = factor(sample(0:22, size = n, replace = TRUE))
  )
}

#not modified
polar_styled_plot <- function(data = NULL, palette) {
  ggplot(
    data = data,
    mapping = aes(
      x = x0,
      y = y0,
      xend = x1,
      yend = y1,
      colour = shade,
      size = size
    )) + 
    coord_polar(clip = "off") +
    scale_y_continuous(
      expand = c(0, 0),
      limits = c(0, 1), 
      oob = scales::oob_keep
    ) +
    scale_x_continuous(
      expand = c(0, 0), 
      limits = c(0, 1), 
      oob = scales::oob_keep
    ) + 
    scale_colour_gradientn(colours = palette) + 
    scale_size(range = c(0, 10)) + 
    theme_void() + 
    guides(
      colour = guide_none(),
      size = guide_none(),
      fill = guide_none(),
      shape = guide_none()
    )
}

#change the sample data called by changing the number of datapoints and changing the seed number
dat <- sample_data(n = 96, seed = 45) |>
  #mutate to change size by dividing by two 
  mutate(y1 = y0, size = size/2)
#change seed number (same as new seed number in above line of code) 
pal <- sample_canva(seed = 45)

#create new plot of this alternative data 
polar_styled_plot(data = dat, palette = pal) + 
  #use geom_segment to create image and change size to be smaller
  geom_segment(size = 1) + 
  #create second geom of different lines and make these much larger
  geom_path(size = 5)

In the examples above and the previous exercise you saw that the polar_styled_plot() function plays the role of defining an overarching “style” for possible art pieces, but it doesn’t completely constrain artistic freedom. Your task in this exercise is to try to write a my_styled_plot() that does something similar… but creates a different style that you can explore

{r}
#sample palete a random using seed 
sample_canva <- function(seed = NULL) {
  #set seed and restrictions
  if(!is.null(seed)) set.seed(seed)
  #select palette to use
  sample(ggthemes::canva_palettes, 1)[[1]]}

#generate random numbers using tibble and set seed and number of samples
sample_data <- function(seed = NULL, n = 100){
  #determine seeds setting
  if(!is.null(seed)) set.seed(seed)
  #set restrictions for tibble for x and y
  dat <- tibble(x0 = runif(n),y0 = runif(n),
                #set min and max x values
                x1 = x0 + runif(n, min = -.2, max = .2),
                #set min and max y values
                y1 = y0 + runif(n, min = -.2, max = .2),
                #assign shading and size for samples
                shade = runif(n), size = runif(n),
                #assign shape and size for data
                shape = factor(sample(0:22, size = n, replace = TRUE)))}

#modified version of polar_styled_plots to be my_styled_plots
my_styled_plot <- function(data = NULL, palette) {
  ggplot(data = data,mapping = aes(x = x0,y = y0,
                                   xend = x1,yend = y1,
                                   colour = shade, size = size)) + 
    #CHANGED - switched to coord_fixed and ratio set at 100
    coord_fixed(ratio = 100) +
    #CHANGED - made limits greater 
    scale_y_continuous(expand = c(0, 0),limits = c(0, 50),oob = scales::oob_keep) +
    #CHANGED - made limits greater
    scale_x_continuous(expand = c(0, 0), limits = c(0, 50),oob = scales::oob_keep) + 
    #set color gradient to palette we chose
    scale_colour_gradientn(colours = palette) + 
    #CHANGED - change size of scale range to be larger
    scale_size(range = c(0, 85)) + 
    #CHANGED - altered theme to have more background
    theme_light() + 
    #set color guides to none
    guides(colour = guide_none(),
           #set size, fill, and shape arguments for guides function
           size = guide_none(), fill = guide_none(), shape = guide_none())}

#changed the sample data called by changing the number of datapoints and changing the seed number
dat <- sample_data(n = 96, seed = 45) |>
  #mutate to change size by dividing by two 
  mutate(y1 = y0, size = size/2)
#change seed number (same as new seed number in above line of code) 
pal <- sample_canva(seed = 45)

#create new plot of this alternative data 
polar_styled_plot(data = dat, palette = pal) + 
  #CHANGED - enlarge data to make it unrecognizable from before
  geom_segment(size = 500) + 
  #create second geom of different lines and make these much larger
  geom_path(size = 5) + 
  #create blue line as curve of data
  geom_smooth(aes(group = 1), method = "loess", se = FALSE)


