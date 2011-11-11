#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

dat = dat.exp4
bp = boxplot(dat$annotation.time ~ dat$haptic.last, plot=FALSE)
colnames(bp$stats) = c("Sans/Avec","Avec/Sans")
write.table(bp$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)

a = dat[ dat$haptic.last == "True", ]$annotation.time
b = dat[ dat$haptic.last == "False", ]$annotation.time
wilcox = wilcox.test( dat$annotation.time ~ dat$haptic.last, na.action = "na.pass" )
out.anova = wilcox2tex(wilcox)
out.file.anova = gsub(".csv", "-anova.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
