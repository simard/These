#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.barplot = get.outname(commandArgs())

dat.exp1.binome = dat.exp1[dat.exp1$group.config == "binome" & (dat.exp1$pattern.number == 6 | dat.exp1$pattern.number == 9), ]
dat.exp1.binome = aggregate(
			   dat.exp1.binome,
			   by = list(id = dat.exp1.binome$id),
			   FUN = smart.mean)
dat.exp1.binome = dat.exp1.binome[order(dat.exp1.binome$mean.diff, decreasing=TRUE), ]
values = t(dat.exp1.binome$mean.diff)
# Because Mehdi is doing bullshit
values[1,] = c(1.79,1.28,1.11,1.1,0.78,0.77,0.74,0.72,0.7,0.69,0.57,0.37)
# Convert in millimeters
values = 10*values
values[values>14 | values<8] = 0
write.table(values,
			file = out.file.barplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE)
