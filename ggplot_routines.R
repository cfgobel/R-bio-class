# UM POUCO DE GGPLOT2

# download.file("http://r-bio.github.io/data/surveys_complete.csv",
#               "surveys_complete.csv")
# surveys_complete <- read.csv(file = "surveys_complete.csv")

library(ggplot2)
# To build a ggplot we need to bind plot to a specific data frame
ggplot(surveys_complete)

# define aestetics (aes), that maps variables in the data to axes
#on the plot or to plotting size, shape color, etc.,
ggplot(surveys_complete, aes(x = weight, y = hindfoot_length))

# add geoms – graphical representation of the data in the plot
#(points, lines, bars). To add a geom to the plot use + operator:
ggplot(surveys_complete, aes(x = weight, y = hindfoot_length)) +
  geom_point()

# We can reduce over-plotting by adding some jitter:
ggplot(surveys_complete, aes(x = weight, y = hindfoot_length)) +
  geom_point(position = position_jitter(0,0))


# We can add additional aesthetic values according to other properties
#color points differently depending on the species.
ggplot(surveys_complete, aes(x = weight, y = hindfoot_length, colour = species_id)) +
  geom_point(position = position_jitter())

# We can also change the transparency
ggplot(surveys_complete, aes(x = weight, y = hindfoot_length, colour = species_id)) +
  geom_point(alpha = 0.3,  position = position_jitter())
