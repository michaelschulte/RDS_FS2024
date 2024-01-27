# Recaps

# Recap

## Create Project
## Console as calculator

## Open and save new script
- generate vector
- add stuff
- overwrite
- average 
- Use na.rm argument

## load and save data
- packages!
- sleep
- sleep$age[age]
- which(sleep$age > 50)
- mean(sleep$alchohol[which(sleep$age > 50)], na.rm = TRUE)


# Session 1 Intro + Data

- vector with numbers and assignment
- calculate mean, sd, sum
- add NA
- calc mean - na.rm()
- character vector
- class()
- load tidyverse 

- generate vector c()
- generate data.frame with tibble()

- show mpg
- extract cyl
- add 10 to cyl

- load dataset Europa.csv

# Session 2 Wrangling 1+2

- load tidyverse
- mpg dataset

- rename displ in Hubraum
- show number of cyl in the mpg dataset
- recode drv into new variable 
- filter all 4-wheel drive
- new dataset only 4-wheel and manufacturer and drive
- get distribution of manufacturers 

- new tibble with 
cyl = 4 5 6 8 
co2 = 2.3 2.8 3 4.5 g/liter

- left_join
- remove one item in co2
- left_join
- right_join / anti_join

- median verbrauch pro manufacturer
- pull()

# Session 3 Plotting

data()
simple geom_bar() with 

star %>% ggplot(aes(x = species)) + 
geom_bar() +

  theme(axis.text.x = element_text(angle = -90, vjust = 0.5, hjust=1))


geom_point(mass / height)
geom_smooth(method = 'lm')
which.max()

library(ggthemes)
 theme_fivethirtyeight()

facet_grid(gender ~ .)
patchwork

# Session 4 Linear Models

library(tidyverse)

mpg
cor(mpg$cty, mpg$hwy)
cor(mpg$cyl, mpg$hwy)
cor.test(mpg$cyl, mpg$hwy)

model <- 
mpg %>%
  select_if(is.numeric) %>%
lm(cty ~ ., data = .)

summary(model)

ggplot(aes(cty, hwy), data = mpg) + 
  geom_point() +
  geom_smooth(method = 'lm')

predict(model)
resid(model)

t.test(cty ~ year, data = mpg)