# Competition Analysis
# MSM
# Mar 2024

# load packages
library(tidyverse)
library(patchwork)
library(lubridate)
library(formr)

caption <- 'Datascience mit R 2024'
  

# read in data 


formr_connect(email = 'michael.schulte@unibe.ch', 
              password = 'pitzeb-0dybqo-gapkId',
              host = 'https://formr.imucb.ch')

raw <- formr_raw_results('RDS', host = "https://formr.imucb.ch")%>%
  filter(!ended == 'NA',
         ended > ymd('2023-02-23')) %>%
  filter(!is.na(session))

df_raw <- 
raw %>%
  select(-session, -created, -modified, -ended, -expired, -starts_with('name')) %>%
  pivot_longer(cols = starts_with('name') | starts_with('schoen')| starts_with('ueberzeugend') | starts_with('relevant') | starts_with('ueberzeugen'),
                names_to = 'names',
                values_to = 'values'
               ) %>%
  mutate(student = as.numeric(gsub(".*([0-9])$", "\\1", names))) %>%
  mutate(names = gsub("[0-9]", "", names)) %>%
  mutate(student = case_when(student == 1 ~ 'Joel',
                             student == 2 ~ 'Maria',
                             student == 3 ~ 'Olivia',
                             student == 4 ~ 'Rafaela',
                             student == 5 ~ 'Jan'
                             )) %>%
na.omit() %>%
  mutate(values = as.numeric(values))

# plot single result ----
single <- ggplot(df_raw, aes(names, values)) +
 geom_point(stat = 'identity') + 
 facet_wrap(~student, nrow = 1) +

  labs(y = 'Bewertung',
       x = 'Bereich',
       caption = caption,
       title = 'Ergebnisse Plotting Competition') +
  theme_bw()

# plot overall ----
overall_result <- 
  df_raw %>%
    group_by(names) %>%
    summarise(overall = mean(values),
              ci = sd(values))
  
overall_graph <- ggplot(overall_result, aes(reorder(names, -overall), overall)) +
  geom_point() +
  geom_errorbar(aes(ymin=overall-ci, ymax=overall+ci), colour="black", width=.1) +
  
  labs(y = 'Bewertung Across',
       x = 'Studierende',
       caption = caption,
       title = 'Ergebnisse Plotting Competition') +
  ylim(1,6) +
  theme_bw()
# show next to each other
overall_graph / single