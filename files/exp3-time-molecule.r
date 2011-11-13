#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

bp = boxplot(dat.exp3$time.completion~dat.exp3$molecule, plot=FALSE)
colnames(bp$stats) = c("Prion","Ubiquitin")
write.table(bp$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)

shapiro = shapiro.test(dat.exp3$time.completion)
levene = levene.test(dat.exp3$time.completion, dat.exp3$molecule)
grp1 = dat.exp3[ dat.exp3$molecule == "prion", ]$time.completion
grp2 = dat.exp3[ dat.exp3$molecule == "ubiquitin", ]$time.completion
grp = cbind(grp1, grp2)
friedman = friedman.test(grp)
out.anova = friedman2tex(friedman)
out.file.anova = gsub(".csv", "-anova.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
out.ratio = evolution2tex(grp1, grp2)
out.file.ratio = gsub(".csv", "-ratio.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )
