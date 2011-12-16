#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

dat = dat.exp4.coo
bp = boxplot(dat$mean.speed ~ dat$haptic, plot=FALSE)
colnames(bp$stats) = c("Sans","Avec")
write.table(bp$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)

wilcox = wilcox.test(dat$mean.speed ~ dat$haptic, paired = TRUE)
out.anova = wilcox2tex(wilcox)
out.file.anova = gsub(".csv", "-anova.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
pop.a = dat[ dat$haptic == "False", ]$mean.speed
pop.b = dat[ dat$haptic == "True", ]$mean.speed
out.ratio = evolution2tex(pop.a, pop.b)
out.file.ratio = gsub(".csv", "-ratio.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )
