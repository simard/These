#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

bp = boxplot(dat.exp2$time.completion~dat.exp2$group.try, plot=FALSE)
colnames(bp$stats) = c("1","2","3")
write.table(bp$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)

shapiro = shapiro.test(dat.exp2$time.completion)
levene = levene.test(dat.exp2$time.completion, dat.exp2$group.try)
grp1 = dat.exp2[ dat.exp2$group.try == 1, ]$time.completion
grp2 = dat.exp2[ dat.exp2$group.try == 2, ]$time.completion
grp3 = dat.exp2[ dat.exp2$group.try == 3, ]$time.completion
grp = cbind(grp1, grp2, grp3)
friedman = friedman.test(grp)
wilcox = pairwise.wilcox.test(dat.exp2$time.completion, dat.exp2$group.try, p.adj="holm", exact=FALSE, pair=FALSE)
out.anova = friedman2tex(friedman)
out.file.anova = gsub(".csv", "-anova.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
