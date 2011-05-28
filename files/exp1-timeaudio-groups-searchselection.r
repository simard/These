#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.barplot = get.outname(commandArgs())

dat.exp1.binome = dat.exp1[dat.exp1$group.config == "binome", ]
dat.exp1.binome = aggregate(
			   dat.exp1.binome,
			   by = list(id = dat.exp1.binome$id),
			   FUN = smart.mean)
dat.exp1.binome = dat.exp1.binome[order(dat.exp1.binome$mean.diff, decreasing=TRUE), ]
values = t(dat.exp1.binome$time.search.audio)
# Because Mehdi is doing bullshit
values[1,] = c(11.2745098,28.35820896,41.21212121,32.89473684,42.40121581,35.97619048,40.39548023,63.05418719,30.28673835,45.83333333,65.41666667,61.03896104)
colnames(values) = c("\\mygroup{1}","\\mygroup{2}","\\mygroup{3}","\\mygroup{4}","\\mygroup{5}","\\mygroup{6}","\\mygroup{7}","\\mygroup{8}","\\mygroup{9}","\\mygroup{10}","\\mygroup{11}","\\mygroup{12}")
write.table(values,
			file = out.file.barplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)
values = t(dat.exp1.binome$time.selection.audio)
# Because Mehdi is doing bullshit
values[1,] = c(28.35227273,66.66666667,58.96551724,63.23099415,31.14134543,25.82417582,32.33022208,41.2568306,42.88888889,37.9705401,39.81141959,27.375)
write.table(values,
			file = out.file.barplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE,
			append = TRUE)
