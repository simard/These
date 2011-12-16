#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.barplot = get.outname(commandArgs())

dat.exp1.binome = dat.exp1[dat.exp1$group.number == 2, ]
dat.exp1.binome = aggregate(
			   dat.exp1.binome,
			   by = list(id = dat.exp1.binome$id),
			   FUN = smart.mean)
dat.exp1.binome = dat.exp1.binome[order(dat.exp1.binome$mean.diff, decreasing=TRUE), ]
values = t(dat.exp1.binome$group.affinity)
# Because Mehdi is doing bullshit
values[1,] = c(0,2,2,2,2,3,3,4,2,3,3,4)
# To have notes between 1 and 5 (instead of 0 to 4)
values = values+1
colnames(values) = c("\\mygroup{1}","\\mygroup{2}","\\mygroup{3}","\\mygroup{4}","\\mygroup{5}","\\mygroup{6}","\\mygroup{7}","\\mygroup{8}","\\mygroup{9}","\\mygroup{10}","\\mygroup{11}","\\mygroup{12}")
write.table(values,
			file = out.file.barplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)
