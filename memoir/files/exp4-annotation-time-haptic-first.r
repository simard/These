#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

dat = dat.exp4
bp = boxplot(dat$annotation.time ~ dat$haptic.first, plot=FALSE)
colnames(bp$stats) = c("Sans/Avec","Avec/Sans")
write.table(bp$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)

wilcox = wilcox.test( dat$annotation.time ~ dat$haptic.first, na.action = "na.pass" )
out.anova = wilcox2tex(wilcox)
out.file.anova = gsub(".csv", "-anova.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
pop.a = dat[ dat$haptic.first == "False", ]$annotation.time
pop.b = dat[ dat$haptic.first == "True", ]$annotation.time
out.ratio = evolution2tex(pop.a, pop.b)
out.file.ratio = gsub(".csv", "-ratio.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )
