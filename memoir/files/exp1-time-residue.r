#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

bp = boxplot(dat.exp1$time.completion~dat.exp1$pattern.number, plot=FALSE)
#dat.exp1$time.completion = boxplot.filter(dat.exp1$time.completion, bp$out)
colnames(bp$stats) = c("\\myresidue{1}","\\myresidue{2}","\\myresidue{3}","\\myresidue{4}","\\myresidue{5}","\\myresidue{6}","\\myresidue{7}","\\myresidue{8}","\\myresidue{9}","\\myresidue{10}")
write.table(bp$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)

shapiro = shapiro.test(dat.exp1$time.completion)
dat.exp1.levene = na.omit(data.frame(time.completion=dat.exp1$time.completion, pattern.number=dat.exp1$pattern.number))
levene = levene.test(dat.exp1.levene$time.completion,dat.exp1.levene$pattern.number)
pat1 = dat.exp1[dat.exp1$pattern.number == 1,]$time.completion
pat2 = dat.exp1[dat.exp1$pattern.number == 2,]$time.completion
pat3 = dat.exp1[dat.exp1$pattern.number == 3,]$time.completion
pat4 = dat.exp1[dat.exp1$pattern.number == 4,]$time.completion
pat5 = dat.exp1[dat.exp1$pattern.number == 5,]$time.completion
pat6 = dat.exp1[dat.exp1$pattern.number == 6,]$time.completion
pat7 = dat.exp1[dat.exp1$pattern.number == 7,]$time.completion
pat8 = dat.exp1[dat.exp1$pattern.number == 8,]$time.completion
pat9 = dat.exp1[dat.exp1$pattern.number == 9,]$time.completion
pat10 = dat.exp1[dat.exp1$pattern.number == 10,]$time.completion
pat = cbind(pat1, pat2, pat3, pat4, pat5, pat6, pat7, pat8, pat9, pat10)
friedman = friedman.test(pat)
wilcox = pairwise.wilcox.test(dat.exp1$time.completion, dat.exp1$pattern.number, p.adj="holm", exact=TRUE, pair=TRUE)
out.anova = friedman2tex(friedman)
out.file.anova = gsub(".csv", "-anova.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )

dat = dat.exp1
pop.a = dat[ dat$pattern.number == 1 | dat$pattern.number == 2 | dat$pattern.number == 3 | dat$pattern.number == 4 | dat$pattern.number == 5 | dat$pattern.number == 7 | dat$pattern.number == 8, ]$time.completion
pop.b = dat[ dat$pattern.number == 6 | dat$pattern.number == 9 | dat$pattern.number == 10, ]$time.completion
out.ratio = evolution2tex(pop.a, pop.b)
out.file.ratio = gsub(".csv", "-ratio.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )
