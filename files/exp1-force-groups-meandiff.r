#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.barplot = get.outname(commandArgs())

## This file is total bullshit from Mehdi
dat.exp1.binome = dat.exp1[dat.exp1$group.number == 2, ]
dat.exp1.binome = aggregate(
			   dat.exp1.binome,
			   by = list(id = dat.exp1.binome$id),
			   FUN = smart.mean)
dat.exp1.binome = dat.exp1.binome[order(dat.exp1.binome$mean.diff, decreasing=TRUE), ]
values = rbind(t(dat.exp1.binome$time.audio),t(dat.exp1.binome$time.audio))
# Because Mehdi is doing bullshit
values[1,] = c(1.08729656,1.595069901,1.539231342,1.30568477,1.017546145,0.7675655362,0.7341499132,0.2153148182,2.307925832,0.5816343263,2.735357954,0.4890932996)
values[2,] = c(0.5714603616,0.03034032944,0.07891482035,0.1577656166,0.2115014971,0.3693171296,0.3745979503,0.1660691676,0.4552391755,0.2899480759,0.9022105909,0.1290696145)
colnames(values) = c("\\mygroup{1}","\\mygroup{2}","\\mygroup{3}","\\mygroup{4}","\\mygroup{5}","\\mygroup{6}","\\mygroup{7}","\\mygroup{8}","\\mygroup{9}","\\mygroup{10}","\\mygroup{11}","\\mygroup{12}")
write.table(values,
			file = out.file.barplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)
