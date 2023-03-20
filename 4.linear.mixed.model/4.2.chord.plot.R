#### Chord diagram

### install packages
# install.packages("circlize")


## Load packages
library(tidyverse)
library(circlize)


df <- read_delim("example.data.for.chord.plot.txt")

head(df)


chordDiagram(df, annotationTrack = "grid", preAllocateTracks = 1)
circos.trackPlotRegion(track.index = 1, panel.fun = function(x, y) {
  xlim = get.cell.meta.data("xlim")
  ylim = get.cell.meta.data("ylim")
  sector.name = get.cell.meta.data("sector.index")
  circos.text(mean(xlim), ylim[1] + .1, sector.name, facing = "clockwise", niceFacing = TRUE, adj = c(0, 0.5))
  circos.axis(h = "top", labels.cex = 0.5, major.tick.percentage = 0.2,     sector.index = sector.name, track.index = 2)
}, bg.border = NA)




## save plot

pdf('chordplot.pdf', height = 6, width = 6)

chordDiagram(df, annotationTrack = "grid", preAllocateTracks = 1)
circos.trackPlotRegion(track.index = 1, panel.fun = function(x, y) {
  xlim = get.cell.meta.data("xlim")
  ylim = get.cell.meta.data("ylim")
  sector.name = get.cell.meta.data("sector.index")
  circos.text(mean(xlim), ylim[1] + .1, sector.name, facing = "clockwise", niceFacing = TRUE, adj = c(0, 0.5))
  circos.axis(h = "top", labels.cex = 0.5, major.tick.percentage = 0.2,     sector.index = sector.name, track.index = 2)
}, bg.border = NA)


dev.off()
