#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

dat.g1 = dat.exp3[ dat.exp3$id == "DavidQuentinPierrePierre", ]
dat.g1.filter = aggregate(
								   dat.g1,
								   by = list(id = dat.g1$id, subject.surname = dat.g1$subject.surname, subject.name = dat.g1$subject.name),
								   FUN = smart.mean)
stats = t(dat.g1.filter$mean.speed)
colnames(stats) = c("\\mysubject{1}","\\mysubject{2}","\\mysubject{3}","\\mysubject{4}")
write.table(stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)

out.mean = 1 - mean(stats) / max(stats)
out.analysis = mean2tex(100 * out.mean)
out.file.analysis = gsub(".csv", "-analysis.tex", out.file.boxplot)
write(
	  out.analysis,
	  file = out.file.analysis
	  )
