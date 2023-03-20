### line plot


library(tidyverse)
library(ggplot2)
library(cowplot)

# Load data

armd <- read_delim("example.data.armd.txt")

head(armd)

##### Use line plot to show the change in visual acuity for each subject over multiple follow-up visits and add the average lines according to treatment group.


## Calculate the average
df_mean = armd %>%
  group_by(treat.f, time.f) %>%
  summarise(visual = mean(visual, na.rm = T))


## plot
p = armd %>% 
  ggplot(aes(x = time.f, y = visual, colour = treat.f)) +
  geom_line(aes(group = subject),  linetype = 2, alpha = .7, size = .5) +
  geom_point(size=2) +
  scale_color_manual(values = c("#0073C2FF",  "#EFC000FF")) + 
  labs(x = "Week", y = "Visual", title = "Line plot") +
  
  geom_line(data = df_mean, aes(group = treat.f), linetype = 1,  alpha = 2, size = 2) +  ## add the average line
  theme_cowplot() +
  theme(plot.title = element_text(size = 14, face =  "bold", hjust = 0.5), text = element_text(size = 12), 
        axis.title = element_text(face="bold"), axis.text.x=element_text(size = 11))

p


ggsave(filename = "line.plot.pdf", p, height = 6, width = 7) 