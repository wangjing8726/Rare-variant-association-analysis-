## Pearson correlation analysis

### purpose: Calculate the Pearson correlation coefficient between visual acuity, baseline visual acuity and time in the example dataset.


library(tidyverse) # Tidyverse
library(Hmisc) # for correlation analysis



# Load data

armd <- read_delim("example.data.armd.txt")

head(armd)


df_corr = armd %>%
  select(visual, visual0, time)

head(df_corr)

###### Do not modify the code between the pound signs ################

cors <- function(df) {
  # turn all three matrices (r, n, and P into a data frame)
  M <- Hmisc::rcorr(as.matrix(df), type='pearson') #spearman,pearson
  # return the three data frames in a list return(Mdf)
  Mdf <- map(M, ~data.frame(.x))
  return(Mdf)
}

Mdf = cors(df_corr)

res = lapply(Mdf, function(x){
  x %>%
    rownames_to_column("measure1") %>%  
  pivot_longer(-measure1, names_to = "measure2")
}) %>%
  bind_rows(.id = "id") %>%
  pivot_wider(names_from = id, values_from = value) %>%
  #mutate(P_adj = p.adjust(P, "BH")) %>%
  mutate(P_adj = p.adjust(P))


###### Do not modify the code between the pound signs ################

head(res)


write.table(res, file = "pearson.corr.result.txt", col.names=TRUE, row.names=FALSE, sep = "\t", quote = F )

