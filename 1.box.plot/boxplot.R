#####Box plot


library(tidyverse)
library(ggplot2)
library(cowplot)

# Load data

### Example data from Age-Related Macular Degeneration (ARMD) clinical trial. ARMD is an elderly ophthalmic disease that can gradually lead to blindness. In order to study the efficacy of a new drug, 240 patients were enrolled and randomly divided into a treatment group and a control group, and visual acuity measures were taken for each patient at enrollment, 4, 12, 24, and 52 weeks. Such data is called longitudinal data, where each patient is measured for the dependent variable at 5 different times, but these 5 times are shared. 

armd <- read_delim("example.data.armd.txt")


str(armd) # Structure of data
dim(armd) # No. of rows and cols
head(armd) # First few records

# subject: sample id.
# treat.f: These variables are plotted against each other in separate panels for different values of the treat.f factor.
# visual0:contains the value of the visual acuity measurement at baseline.
# visual: contains the value of the visual acuity measurement at the particular visit.
# time: provides the actual week, at which a particular visual-acuity measurement was taken. # time.f: a corresponding ordered factor, with levels Baseline, 4wks, 12wks, 24wks, and 52wks.
# tp: is numerical variable, which indicates the position of the particular measurement visit in the sequence of the five possible measurements.Thus, for instance, tp=0 for the baseline measurement and tp=4 for the fourth postrandomization measurement at week 52.


##### Use box plots to show the distribution of patients' visual acuity at each follow-up visit。

p = armd %>%
  ggplot(aes(x = time.f, y = visual, fill = treat.f))+
  geom_boxplot(width=1) +  
  labs(x = "Week", y = "Visual", title = "Box plot") +
  theme_cowplot() + 
  theme(plot.title = element_text(size = 14, face =  "bold", hjust = 0.5), text = element_text(size = 12), axis.title = element_text(face="bold"), axis.text.x=element_text(size = 11))  

p


ggsave(filename =  "boxplot.pdf", p, height = 3, width = 6)
