#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

bp = boxplot(dat.exp1$time.completion~dat.exp1$pattern.number, range=2, plot=FALSE)
colnames(bp$stats) = c("\\myresidue{1}","\\myresidue{2}","\\myresidue{3}","\\myresidue{4}","\\myresidue{5}","\\myresidue{6}","\\myresidue{7}","\\myresidue{8}","\\myresidue{9}","\\myresidue{10}")
write.table(bp$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)

shap = shapiro.test(dat.exp1$time.completion)
lev = levene.test(dat.exp1$time.completion,dat.exp1$pattern.number)
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
wilcox = pairwise.wilcox.test(dat.exp1$time.completion, dat.exp1$pattern.number, p.adj="bonferroni", exact=FALSE, pair=TRUE)
out.anova = "$\\chi^2(<df>) = <chi>$, $p = <p>$"
out.anova = set.df(out.anova, friedman$parameter)
out.anova = set.chi(out.anova, friedman$statistic)
out.anova = set.p(out.anova, friedman$p.value)
out.file.anova = gsub(".csv", "-anova.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
