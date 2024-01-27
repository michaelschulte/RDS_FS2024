# Competition Analysis
# MSM
# Oct 2020

# load packages
library(googlesheets4)
library(tidyverse)
library(patchwork)
library(lubridate)

caption <- 'Datascience mit R 2022'
  

# read in data 
raw <- read_sheet(ss = '1qODIQcqM8VrWeEyGl2bCfqFqRE9MBtkJyMXiksSzYVU') %>%
  filter(!is.na(Timestamp))

# generate tibble for each group ----
graph1 <- 
  raw %>%
  select(2:4) %>%
  summarise(across(where(is.numeric), ~mean(.x, na.rm = TRUE))) %>%
  mutate(graph = 'RGo')

graph2 <- 
  raw %>%
  select(5:7) %>%
  summarise(across(where(is.numeric), ~mean(.x, na.rm = TRUE))) %>%
  mutate(graph = 'Data_Pirates')

graph3 <- 
  raw %>%
  select(8:10) %>%
  summarise(across(where(is.numeric), ~mean(.x, na.rm = TRUE))) %>%
  mutate(graph = 'U_R_QL')

graph4 <- 
  raw %>%
  select(11:13) %>%
  summarise(across(where(is.numeric), ~mean(.x, na.rm = TRUE))) %>%
  mutate(graph = 'We_R_Nerds')

# bind together, make long ----
result <- 
bind_rows(graph1, graph2, graph3, graph4) %>%
  rename('Ästhetik' = 'Ist die Grafik ästhetisch ansprechend?', 
         'Überzeugend' = 'Überzeugen dich die dargestellten Datenmuster (unabhängig von der Fragestellung)?', 
         'Relevant' = 'Findest du die dargestellten Datenmuster entscheidungsrelevant in Bezug auf die Fragestellung?') %>%
  pivot_longer(cols = 1:3, names_to = 'Frage')

# plot single result ----
single <- ggplot(result, aes(Frage, value)) +
 geom_point(stat = 'identity') + 
 facet_wrap(~graph, nrow = 1) +
  ylim(1,5) +
  labs(y = 'Bewertung',
       x = 'Bereich',
       caption = caption,
       title = 'Ergebnisse Plotting Competition') +
  theme_bw()

# plot overall ----
overall_result <- 
  result %>%
    group_by(graph) %>%
    summarise(overall = mean(value),
              ci = sd(value))
  
overall_graph <- ggplot(overall_result, aes(reorder(graph, -overall), overall)) +
  geom_point() +
  geom_errorbar(aes(ymin=overall-ci, ymax=overall+ci), colour="black", width=.1) +
  
  labs(y = 'Bewertung Across',
       x = 'Gruppe',
       caption = caption,
       title = 'Ergebnisse Plotting Competition') +
  ylim(1,5) +
  theme_bw()
# show next to each other
overall_graph / single



# Dump ----

# graph4 <- 
#   raw %>%
#   select(11:13) %>%
#   summarise(across(where(is.numeric), ~mean(.x, na.rm = TRUE))) %>%
#   mutate(graph = 'R-Pandemi')