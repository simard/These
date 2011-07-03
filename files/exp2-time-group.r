#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

bp = boxplot(dat.exp2$time.completion~dat.exp2$group.number, plot=FALSE)
colnames(bp$stats) = c("\\myglosnl{glo-Monome}","\\myglosnl{glo-Binome}")
write.table(bp$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)

#dat.exp2$time.completion = boxplot.filter(dat.exp2$time.completion, bp$out)
shapiro = shapiro.test(dat.exp2$time.completion)
dat.exp2.levene = na.omit(data.frame(time.completion=dat.exp2$time.completion, group.number=dat.exp2$group.number))
levene = levene.test(dat.exp2.levene$time.completion, dat.exp2.levene$group.number)
kruskal = kruskal.test(dat.exp2$time.completion~dat.exp2$group.number)
grp1 = dat.exp2[dat.exp2$group.number == 1,]$time.completion
grp2 = dat.exp2[dat.exp2$group.number == 2,]$time.completion
grp = cbind(grp1, grp2)
friedman = friedman.test(grp)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
