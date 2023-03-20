## heatmap

### Purpose: Visualize the results of the Pearson correlation analysis.

# Load packages

library(tidyverse)
library(pheatmap)

# Load data

res <- read_delim("pearson.corr.result.txt")

head(res)


## Convert long table to wide table
cor = res %>%
  dplyr::select(measure1, measure2, r) %>%  ### 
  pivot_wider(id_cols = "measure1", names_from = "measure2", values_from = "r") %>%
  column_to_rownames(var = "measure1") %>%
  as.matrix()

cor[1:3,1:3]


### heatmap

p = pheatmap::pheatmap(cor, fontsize = 12,
                       cluster_rows = T, cluster_cols = T, 
                       color = colorRampPalette(c("blue", "white", "red"))(40),
                       main = "")

p

ggsave(filename = "pearson_corr_heatmap.pdf", p, height = 6, width = 7) 
