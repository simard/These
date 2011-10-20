#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

dat = aggregate(
				dat.exp4,
				by = list(
						  id = dat.exp4$id,
						  molecule = dat.exp4$molecule,
						  haptic = dat.exp4$haptic
						  ),
				smart.mean
				)
bp = boxplot(dat$min.rmsd.time~dat$haptic, plot=FALSE)
colnames(bp$stats) = c("Sans","Avec")
write.table(bp$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)

wilcox = wilcox.test(dat$min.rmsd.time ~ dat$haptic)
out.anova = wilcox2tex(wilcox)
out.file.anova = gsub(".csv", "-anova.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
