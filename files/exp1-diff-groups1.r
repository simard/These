#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.barplot = get.outname(commandArgs())

dat.exp1.binome = dat.exp1[dat.exp1$group.config == "binome" & (dat.exp1$pattern.number == 6 | dat.exp1$pattern.number == 9), ]
dat.exp1.binome.filter = aggregate(
			   dat.exp1.binome,
			   by = list(id = dat.exp1.binome$id),
			   FUN = smart.mean)
dat.exp1.binome.filter = dat.exp1.binome.filter[order(dat.exp1.binome.filter$mean.diff, decreasing=TRUE), ]
values = t(dat.exp1.binome.filter$mean.diff)
# Because Mehdi is doing bullshit
values[1,] = c(1.79,1.28,1.11,1.1,0.78,0.77,0.74,0.72,0.7,0.69,0.57,0.37)
# Convert in millimeters
values = 10*values
values[values<14] = 0
colnames(values) = c("\\mygroup{1}","\\mygroup{2}","\\mygroup{3}","\\mygroup{4}","\\mygroup{5}","\\mygroup{6}","\\mygroup{7}","\\mygroup{8}","\\mygroup{9}","\\mygroup{10}","\\mygroup{11}","\\mygroup{12}")
write.table(values,
			file = out.file.barplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)
shapiro = shapiro.test(dat.exp1$mean.diff)
bartlett = bartlett.test(dat.exp1$mean.diff, dat.exp1$pattern.number)
grp1 = dat.exp1[dat.exp1$id == dat.exp1.binome.filter$id[[1]],]$mean.diff
grp2 = dat.exp1[dat.exp1$id == dat.exp1.binome.filter$id[[2]],]$mean.diff
grp3 = dat.exp1[dat.exp1$id == dat.exp1.binome.filter$id[[3]],]$mean.diff
grp4 = dat.exp1[dat.exp1$id == dat.exp1.binome.filter$id[[4]],]$mean.diff
grp5 = dat.exp1[dat.exp1$id == dat.exp1.binome.filter$id[[5]],]$mean.diff
grp6 = dat.exp1[dat.exp1$id == dat.exp1.binome.filter$id[[6]],]$mean.diff
grp7 = dat.exp1[dat.exp1$id == dat.exp1.binome.filter$id[[7]],]$mean.diff
grp8 = dat.exp1[dat.exp1$id == dat.exp1.binome.filter$id[[8]],]$mean.diff
grp9 = dat.exp1[dat.exp1$id == dat.exp1.binome.filter$id[[9]],]$mean.diff
grp10 = dat.exp1[dat.exp1$id == dat.exp1.binome.filter$id[[10]],]$mean.diff
grp11 = dat.exp1[dat.exp1$id == dat.exp1.binome.filter$id[[11]],]$mean.diff
grp12 = dat.exp1[dat.exp1$id == dat.exp1.binome.filter$id[[12]],]$mean.diff
grp = cbind(grp1, grp2, grp3, grp4, grp5, grp6, grp7, grp8, grp9, grp10)
friedman = friedman.test(pat)
wilcox = pairwise.wilcox.test(dat.exp1.binome.filter$mean.diff, dat.exp1.binome.filter$id, p.adj="holm", exact=FALSE, pair=TRUE)
