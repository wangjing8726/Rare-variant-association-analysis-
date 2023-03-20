
# Install packages

# install.packages("tidyverse")
# install.packages("lme4")
# install.packages('pbkrtest')
# install.packages("broom.mixed")

# Load packages

library(tidyverse) # needed for data manipulation.
library(lme4) # for the linear mixed model analysis
library(lmerTest) # for lmerTest package
library(broom.mixed) # Turn an object into a tidy tibble



# Load data

armd <- read_delim("example.data.armd.txt")

head(armd) # First few records


# subject: sample id.
# treat.f: These variables are plotted against each other in separate panels for different values of the treat.f factor.
# visual0:contains the value of the visual acuity measurement at baseline.
# visual: contains the value of the visual acuity measurement at the particular visit.
# time: provides the actual week, at which a particular visual-acuity measurement was taken. # time.f: a corresponding ordered factor, with levels Baseline, 4wks, 12wks, 24wks, and 52wks.
# tp: is numerical variable, which indicates the position of the particular measurement visit in the sequence of the five possible measurements.Thus, for instance, tp=0 for the baseline measurement and tp=4 for the fourth postrandomization measurement at week 52.


# In this dataset, 240 patients with ARMD (Age-related Macular Degeneration) were randomly divided into a treatment group and a control group, and visual acuity measures were taken for each patient at enrollment, 4, 12, 24, and 52 weeks. Such data is called longitudinal data. Using a linear mixed-models to investigate the effectiveness of treatment and the changing patterns of the disease over time. In the model, using the 4 measurements of visual acuity taken after enrollment (visual) as the dependent variable, treatment group (treat.f) and baseline measurement (visual0) as fixed effects, the different patients (subject) and times(time) as random effects.

fit <- lmer(visual ~ treat.f + visual0 + (1 | time) + (1 | subject), armd) ## linear mixed model

summary(fit) ## results

res = tidy(fit)

res

## output
write.table(res, file = "lmm.result.txt", col.names=TRUE, row.names=FALSE, sep = "\t", quote = F )

