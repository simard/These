#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

bp = boxplot(dat.exp3$time.completion~dat.exp3$brainstorm, plot=FALSE)
colnames(bp$stats) = c("sans","avec")
write.table(bp$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)

shapiro = shapiro.test(dat.exp3$time.completion)
levene = levene.test(dat.exp3$time.completion, dat.exp3$brainstorm)
kruskal = kruskal.test(dat.exp3$time.completion~dat.exp3$brainstorm)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
