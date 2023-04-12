
## Setup


#### Tidyverse
library(tidyverse)

##### plot
library(CMplot)
library(qqman)


## workdir

setwd("C:\\Users\\jinwa42\\Desktop\\manhattan_plot")


### load data in batch

list <- list.files(path="C:/Users/jinwa42/Desktop/manhattan_plot/results",pattern = "mean.")

df_mean <- data.frame()

for(i in list){
  path <- i
  tmp <- read_delim(file = paste0("C:/Users/jinwa42/Desktop/manhattan_plot/results/",path), delim = "\t", col_names = T) %>% mutate(metabolite = i) %>% mutate(metabolite = str_split(metabolite, '[.]', simplify = T)[,2])
  
  df_mean <- rbind(df_mean,tmp)
}


head(df_mean)


d4p_mean = df_mean %>%
  rename(Chromosome = `#CHROM`, Position = POS, trait = P) %>%
  mutate(CHR = if_else(Chromosome == "X", "23", Chromosome)) %>%
  mutate(CHR = as.numeric(CHR)) %>%
  arrange(trait)  %>%
  select(Chromosome, CHR, Position, SNP, metabolite, trait)

head(d4p_mean)

##################  qqman method ##############

pdf("pQTL_manhattan.pdf", height = 7, width = 14)

manhattan(d4p_mean, chr = "CHR", bp = "Position", snp = "metabolite",  p = "trait", col = c("#4696d4", "#f7c243", "#423492","#49522c", "#d21b6d", "#e3682c","#d381b4", "#86d2ae", "#7a1a2d", "#2b755e"), cex.axis = 1.2, ylim = c(5, 18),  
          suggestiveline = -log10(5e-08), genomewideline = -log10(9.56e-11), 
          annotatePval = -log10(9.56e-11), annotateTop = T,
          main = "Manhattan Plot of all metabolites")

dev.off()


########### CMplot method #################

d4p_mean2 = d4p_mean %>%
  select(-SNP, -metabolite) 
head(d4p_mean2)

CMplot(d4p_mean2,
       plot.type = "m", LOG10 = TRUE, ylim=NULL,
       threshold = c(5e-08, 9.56e-11), threshold.lty = c(2,1), threshold.lwd = c(1,1),
       amplify = F, multracks = F, cir.legend = F,
       main = "mQTL Manhattan Plot of all metabolites",
       file="jpg", memo = "")

