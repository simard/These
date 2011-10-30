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
dat.nohaptic = dat[dat$haptic == "False", ]
bp = boxplot(dat.nohaptic$min.rmsd.time~dat.nohaptic$molecule, plot=FALSE)
bp$stats = bp$stats[,c(2,1)]
colnames(bp$stats) = c("1","2")
write.table(bp$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)

dat.haptic = dat[dat$haptic == "True", ]
bp = boxplot(dat.haptic$min.rmsd.time~dat.haptic$molecule, plot=FALSE)
bp$stats = bp$stats[,c(2,1)]
write.table(bp$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			append = TRUE,
			row.names = FALSE,
			col.names = FALSE)

dat.u = dat[dat$molecule == "ubiquitin", ]
wilcox = wilcox.test(dat.u$min.rmsd.time ~ dat.u$haptic, paired = TRUE)
out.anova = wilcox2tex(wilcox)
out.file.anova = gsub(".csv", "-ubiquitin-anova.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )

dat.n = dat[dat$molecule == "nuse", ]
wilcox = wilcox.test(dat.n$min.rmsd.time ~ dat.n$haptic, paired = TRUE)
out.anova = wilcox2tex(wilcox)
out.file.anova = gsub(".csv", "-nuse-anova.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
