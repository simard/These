#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

dat = dat.exp4
bp = boxplot(dat$annotation.time ~ dat$haptic, plot=FALSE)
colnames(bp$stats) = c("Sans","Avec")
write.table(bp$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)

a = dat[ dat$haptic == "True", ]$annotation.time
b = dat[ dat$haptic == "False", ]$annotation.time
wilcox = wilcox.test( dat$annotation.time ~ dat$haptic, paired = TRUE )
out.anova = wilcox2tex(wilcox)
out.file.anova = gsub(".csv", "-anova.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
