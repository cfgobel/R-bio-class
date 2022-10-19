# UM POUCO DE GGPLOT2

# download.file("http://r-bio.github.io/data/surveys_complete.csv",
#               "surveys_complete.csv")
surveys_complete <- read.csv(file = "surveys_complete.csv", stringsAsFactors=T)

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

# handling shape property
ggplot(surveys_complete, aes(x = weight, y = hindfoot_length, colour = species_id, shape = as.factor(plot_id))) +
  geom_point(alpha = 0.3,  position = position_jitter())


# ggplot2 also allows you to calculate directly some statistical
ggplot(surveys_complete, aes(x = weight, y = hindfoot_length, colour = species_id)) +
  geom_point(alpha = 0.3,  position = position_jitter()) + stat_smooth(method = "lm")

ggplot(subset(surveys_complete,  species_id == "DS"), aes(x = weight, y = hindfoot_length, colour = species_id)) +
  geom_point(alpha = 0.3,  position = position_jitter()) + stat_smooth(method = "lm") +
  ylim(c(0,60))

### ???
# por algum motivo subset do ylim setado por outra função
ggplot(surveys_complete,
       aes(x = weight, y = hindfoot_length, colour = species_id)) +
  geom_point(alpha = 0.3,  position = position_jitter()) + stat_smooth(method = "lm") +
  ##ylim(c(40, 60))
  coord_cartesian(ylim = c(40, 60))


# BOXPLOT -----------------------------------------------------------------

# Visualising the distribution of weight within each species.
ggplot(surveys_complete, aes(x = species_id, y = weight)) +
  geom_boxplot()

# By adding points to boxplot, we can see particular measurements and the
#abundance of measurements.
ggplot(surveys_complete, aes(species_id, weight)) +
  geom_point(alpha=0.3, color="tomato", position = "jitter") +
  geom_boxplot(alpha=0) + coord_flip()

# Challenge
# Create boxplot for hindfoot_length, and change the color of the points.
#Replace the boxplot by a violin plot Add the layer coord_flip()
ggplot(surveys_complete, aes(species_id, hindfoot_length)) +
  geom_point(alpha=0.3,color="tomato", position = "jitter") +
  geom_violin(alpha=0) + coord_flip()



# FACETING ----------------------------------------------------------------

ggplot(surveys_complete, aes(species_id, weight)) +
  geom_point(alpha=0.3, color="tomato", position = "jitter") +
  geom_boxplot(alpha=0) + coord_flip() + facet_wrap( ~ sex)


###Challenge
# Modify the data frame so we only look at males and females Change the colors
#so points for males and females are different Change the data frame to only
#plot three species of your choosing
ggplot(subset(surveys_complete, species_id %in% c("DO", "DM", "DS") & sex %in% c("F", "M")),
       aes(x = sex, y = weight,  colour = interaction(sex, species_id))) +
  facet_wrap( ~ species_id) +
  geom_point(alpha = 0.3, position = "jitter") +
  geom_boxplot(alpha = 0, colour = "black")

ggplot(subset(surveys_complete, species_id %in% c("DO", "DM", "DS") & sex %in% c("F", "M")),
       aes(x = sex, y = weight,  colour = sex)) +
  facet_wrap( ~ species_id) +
  geom_point(alpha = 0.3, position = "jitter") +
  geom_boxplot(alpha = 0, colour = "black")



# BARPLOT -----------------------------------------------------------------

ggplot(surveys_complete, aes(species_id)) + geom_bar(stat = "identity")


surveys_weights <- with(surveys_complete, tapply(surveys_complete$weight,
                                                 surveys_complete$species_id, mean))
surveys_weights <- data.frame(species_id = levels(surveys_complete$species_id),
                              weight = surveys_weights)
# surveys_weights <- surveys_weights[complete.cases(surveys_weights),  ]

ggplot(surveys_weights, aes(x = species_id, y = weight)) + geom_bar(stat = "identity")



surveys_hindfoot <- with(surveys_complete, tapply(surveys_complete$hindfoot_length,
                                                 surveys_complete$species_id, mean))
surveys_hindfoot <- data.frame(species_id = levels(surveys_complete$species_id),
                              hindfoot = surveys_hindfoot)
# surveys_hindfoot <- surveys_hindfoot[complete.cases(surveys_hindfoot),  ]

ggplot(surveys_hindfoot, aes(x = species_id, y = hindfoot)) + geom_bar(stat = "identity")
